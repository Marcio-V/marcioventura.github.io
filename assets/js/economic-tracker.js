/**
 * Economic Tracker — marcioventura.com.br
 * Fontes: BCB SGS (SELIC, CDI, IPCA, USD, EUR, Desemprego) | Yahoo Finance via proxy CORS (IBOV, S&P500, Nasdaq)
 * Cache: SessionStorage com TTL configurável por tipo de dado
 * Autor: Marcio Ventura
 */

(function () {
  'use strict';

  // ─── Configuração de TTL de cache (em milissegundos) ───────────────────────
  const CACHE_TTL = {
    bcb_daily:   5 * 60 * 1000,   // 5 min — câmbio
    bcb_monthly: 60 * 60 * 1000,  // 1 hora — IPCA, desemprego (mensais)
    bcb_rate:    60 * 60 * 1000,  // 1 hora — SELIC, CDI
    market:      10 * 60 * 1000,  // 10 min — bolsas
  };

  // ─── IDs das séries BCB SGS ────────────────────────────────────────────────
  const BCB_SERIES = {
    USD_BRL:    1,      // Dólar Comercial - Venda
    EUR_BRL:    21619,  // Euro - Venda
    SELIC_META: 432,    // Meta SELIC definida pelo COPOM (% a.a.)
    CDI:        4389,   // CDI acumulado no mês
    IPCA_MES:   433,    // IPCA - variação mensal (base p/ acum. 12M)
    DESEMPREGO: 24369,  // Taxa de desocupação - PNAD Contínua
    ICE:        4393,   // Índice de Confiança do Empresário (Fecomercio/SGS)
  };

  // ─── Proxy de cotações via Cloudflare Worker ───────────────────────────────
  // O Yahoo bloqueia requisições diretas do browser (CORS). O Worker resolve isso
  // de forma estável e sob seu controle.
  //
  // ⚠️ SUBSTITUA pela URL real do seu Worker após o deploy (ver INSTRUCOES-CLOUDFLARE.md)
  const MARKET_PROXY = 'https://market-proxy.m-matheus-baptista.workers.dev';

  // ─── Registro central de cotações (alimenta o ticker do topo) ──────────────
  // Cada updater grava aqui o que buscou; o ticker lê deste objeto.
  const tickerData = {};
  // change   = número da variação (percentual ou em pontos)
  // invert   = true p/ desemprego e IPCA (alta = ruim = vermelho)
  // chgSuffix= sufixo da variação no ticker ('%' para mercados, ' p.p.' para taxas, ' pts' para índices)
  function registerTicker(key, label, value, change, invert, chgSuffix) {
    tickerData[key] = {
      label: label, value: value, change: change,
      invert: !!invert, chgSuffix: (chgSuffix !== undefined ? chgSuffix : '%'),
    };
    renderTicker();
  }

  // ─── Utilitários de Cache ──────────────────────────────────────────────────
  function cacheSet(key, data) {
    try {
      sessionStorage.setItem('ind_' + key, JSON.stringify({ ts: Date.now(), data: data }));
    } catch (e) { /* sessionStorage indisponível */ }
  }

  function cacheGet(key, ttl) {
    try {
      const raw = sessionStorage.getItem('ind_' + key);
      if (!raw) return null;
      const entry = JSON.parse(raw);
      if (Date.now() - entry.ts > ttl) return null;
      return entry.data;
    } catch (e) { return null; }
  }

  // ─── Fetch BCB SGS ─────────────────────────────────────────────────────────
  // Usa /ultimos/N como método primário. Se falhar ou vier vazio (algumas séries
  // pouco consultadas falham nesse endpoint), tenta de novo com filtro de data.
  async function fetchBCB(seriesId, lastN, ttlKey) {
    const cacheKey = 'bcb_' + seriesId;
    const cached = cacheGet(cacheKey, CACHE_TTL[ttlKey]);
    if (cached) return cached;

    const base = `https://api.bcb.gov.br/dados/serie/bcdata.sgs.${seriesId}/dados`;

    // Método 1: últimos N valores
    try {
      const res = await fetch(`${base}/ultimos/${lastN}?formato=json`);
      if (res.ok) {
        const data = await res.json();
        if (Array.isArray(data) && data.length > 0) {
          cacheSet(cacheKey, data);
          return data;
        }
      }
    } catch (err) {
      console.warn('[BCB ' + seriesId + '] /ultimos falhou:', err.message);
    }

    // Método 2 (fallback): filtro por data — últimos ~18 meses
    try {
      const hoje = new Date();
      const inicio = new Date();
      inicio.setMonth(inicio.getMonth() - 18);
      const fmt = (d) =>
        String(d.getDate()).padStart(2, '0') + '/' +
        String(d.getMonth() + 1).padStart(2, '0') + '/' +
        d.getFullYear();
      const url = `${base}?formato=json&dataInicial=${fmt(inicio)}&dataFinal=${fmt(hoje)}`;
      const res = await fetch(url);
      if (res.ok) {
        const data = await res.json();
        if (Array.isArray(data) && data.length > 0) {
          cacheSet(cacheKey, data);
          return data;
        }
      }
    } catch (err) {
      console.warn('[BCB ' + seriesId + '] filtro de data falhou:', err.message);
    }

    return null;
  }

  // ─── Fetch cotações via Cloudflare Worker ──────────────────────────────────
  async function fetchMarket(ticker, cacheKey) {
    const cached = cacheGet(cacheKey, CACHE_TTL.market);
    if (cached) return cached;

    // Se a URL do Worker ainda não foi configurada, não tenta (evita erro no console)
    if (MARKET_PROXY.indexOf('SEU-USUARIO') !== -1) {
      console.warn('[Market] Worker da Cloudflare ainda não configurado. Veja INSTRUCOES-CLOUDFLARE.md');
      return null;
    }

    const url = MARKET_PROXY + '/?ticker=' + encodeURIComponent(ticker);
    try {
      const res = await fetch(url);
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const json = await res.json();
      if (json.error || typeof json.current !== 'number') {
        throw new Error(json.error || 'Sem dados');
      }
      const data = {
        current: json.current,
        previous: json.previous,
        change: json.change,
      };
      cacheSet(cacheKey, data);
      return data;
    } catch (err) {
      console.warn('[Market ' + ticker + '] Falha:', err.message);
      return null;
    }
  }

  // ─── Helpers de renderização ───────────────────────────────────────────────
  // Remove o skeleton tanto de um span filho quanto do próprio elemento alvo
  function clearSkeleton(el) {
    if (!el) return;
    el.classList.remove('ind-skeleton');
    const child = el.querySelector('.ind-skeleton');
    if (child) child.classList.remove('ind-skeleton');
  }

  function setVal(selector, text) {
    const el = document.querySelector(selector);
    if (!el) return;
    clearSkeleton(el);
    el.textContent = text;
  }

  function setChange(selector, pct) {
    const el = document.querySelector(selector);
    if (!el) return;
    clearSkeleton(el);
    const formatted = (pct >= 0 ? '+' : '') + pct.toFixed(2).replace('.', ',') + '%';
    el.textContent = formatted;
    el.className = el.className.replace(/\b(positive|negative|ind-skeleton)\b/g, '').trim();
    el.classList.add(pct >= 0 ? 'positive' : 'negative');
  }

  // Variação em basis points (bps) — usado na SELIC
  function setBps(selector, bps) {
    const el = document.querySelector(selector);
    if (!el) return;
    clearSkeleton(el);
    const rounded = Math.round(bps);
    const formatted = (rounded >= 0 ? '+' : '') + rounded + ' bps';
    el.textContent = formatted;
    el.className = el.className.replace(/\b(positive|negative|ind-skeleton)\b/g, '').trim();
    if (rounded > 0) el.classList.add('positive');
    else if (rounded < 0) el.classList.add('negative');
  }

  function setError(selector, msg) {
    const el = document.querySelector(selector);
    if (!el) return;
    clearSkeleton(el);
    el.textContent = msg || 'indisponível';
    el.classList.add('ind-error');
  }

  function updateTimestamp() {
    const el = document.getElementById('indicators-last-update');
    if (!el) return;
    const now = new Date();
    el.textContent = now.toLocaleString('pt-BR', {
      day: '2-digit', month: '2-digit', year: 'numeric',
      hour: '2-digit', minute: '2-digit',
    });
  }

  // ─── Updaters individuais ──────────────────────────────────────────────────

  async function updateDolar() {
    const data = await fetchBCB(BCB_SERIES.USD_BRL, 2, 'bcb_daily');
    if (data && data.length >= 2) {
      const latest   = parseFloat(data[data.length - 1].valor.replace(',', '.'));
      const previous = parseFloat(data[data.length - 2].valor.replace(',', '.'));
      const change   = ((latest - previous) / previous) * 100;
      setVal('#dolar-data .dolar-current-value', latest.toFixed(4).replace('.', ','));
      setChange('#dolar-data .dolar-daily-change', change);
      registerTicker('dolar', 'USD/BRL', 'R$ ' + latest.toFixed(4).replace('.', ','), change);
    } else {
      setError('#dolar-data .dolar-current-value', 'N/D');
      setError('#dolar-data .dolar-daily-change', '');
    }
  }

  async function updateEuro() {
    const data = await fetchBCB(BCB_SERIES.EUR_BRL, 2, 'bcb_daily');
    if (data && data.length >= 2) {
      const latest   = parseFloat(data[data.length - 1].valor.replace(',', '.'));
      const previous = parseFloat(data[data.length - 2].valor.replace(',', '.'));
      const change   = ((latest - previous) / previous) * 100;
      setVal('#euro-data .euro-current-value', latest.toFixed(4).replace('.', ','));
      setChange('#euro-data .euro-daily-change', change);
      registerTicker('euro', 'EUR/BRL', 'R$ ' + latest.toFixed(4).replace('.', ','), change);
    } else {
      setError('#euro-data .euro-current-value', 'N/D');
      setError('#euro-data .euro-daily-change', '');
    }
  }

  async function updateSelic() {
    // A meta SELIC (série 432) é diária e repete o mesmo valor entre reuniões do COPOM.
    // Buscamos o histórico recente e detectamos a ÚLTIMA mudança de patamar para
    // calcular a variação do último COPOM em bps de forma automática.
    const data = await fetchBCB(BCB_SERIES.SELIC_META, 400, 'bcb_rate');
    if (data && data.length >= 1) {
      const valores = data.map((d) => parseFloat(d.valor.replace(',', '.')));
      const atual = valores[valores.length - 1];
      setVal('#selic-data .selic-current-value', atual.toFixed(2).replace('.', ','));

      // Procura, de trás pra frente, o último valor DIFERENTE do atual
      let anterior = null;
      for (let i = valores.length - 2; i >= 0; i--) {
        if (valores[i] !== atual) { anterior = valores[i]; break; }
      }

      if (anterior !== null) {
        const bps = Math.round((atual - anterior) * 100); // 1 p.p. = 100 bps
        setBps('#selic-data .selic-copom-change', bps);
        registerTicker('selic', 'SELIC', atual.toFixed(2).replace('.', ',') + '% a.a.', atual - anterior, false, ' p.p.');
      } else {
        setVal('#selic-data .selic-copom-change', 'estável');
        registerTicker('selic', 'SELIC', atual.toFixed(2).replace('.', ',') + '% a.a.', null);
      }
    } else {
      setError('#selic-data .selic-current-value', 'N/D');
      setError('#selic-data .selic-copom-change', '');
    }
  }

  async function updateCDI() {
    const data = await fetchBCB(BCB_SERIES.CDI, 2, 'bcb_rate');
    if (data && data.length > 0) {
      const last   = data[data.length - 1];
      const latest = parseFloat(last.valor.replace(',', '.'));
      setVal('#cdi-data .cdi-current-value', latest.toFixed(2).replace('.', ','));
      setVal('#cdi-data .cdi-ref-date', last.data ? last.data.substring(3) : '—');
      let chg = null;
      if (data.length >= 2) {
        const prev = parseFloat(data[data.length - 2].valor.replace(',', '.'));
        chg = latest - prev;
      }
      registerTicker('cdi', 'CDI', latest.toFixed(2).replace('.', ',') + '% a.a.', chg, false, ' p.p.');
    } else {
      setError('#cdi-data .cdi-current-value', 'N/D');
      setError('#cdi-data .cdi-ref-date', '—');
    }
  }

  async function updateIPCA() {
    // Busca os últimos 14 valores mensais do IPCA (série 433) — 13 p/ acum + 1 p/ comparar
    const serie = await fetchBCB(BCB_SERIES.IPCA_MES, 14, 'bcb_monthly');
    if (serie && serie.length > 0) {
      // IPCA do mês = último valor
      const last = serie[serie.length - 1];
      const mes  = parseFloat(last.valor.replace(',', '.'));
      setVal('#ipca-data .ipca-current-value', mes.toFixed(2).replace('.', ','));
      // Variação do IPCA mensal vs. mês anterior (invertido: alta = ruim = vermelho)
      let mesChg = null;
      if (serie.length >= 2) {
        const mesPrev = parseFloat(serie[serie.length - 2].valor.replace(',', '.'));
        mesChg = mes - mesPrev;
      }
      registerTicker('ipca', 'IPCA', mes.toFixed(2).replace('.', ',') + '% mês', mesChg, true, ' p.p.');

      // IPCA acumulado 12 meses = produtório (1 + xi/100) - 1
      const calcAcum12 = (arr) => (arr.reduce((acc, d) => acc * (1 + parseFloat(d.valor.replace(',', '.')) / 100), 1) - 1) * 100;
      if (serie.length >= 12) {
        const pct12 = calcAcum12(serie.slice(-12));
        setVal('#ipca-data .ipca-12m-value', pct12.toFixed(2).replace('.', ',') + '%');
        // Variação do acumulado 12M vs. o acumulado 12M do mês anterior (invertido)
        let chg12 = null;
        if (serie.length >= 13) {
          const pct12Prev = calcAcum12(serie.slice(-13, -1));
          chg12 = pct12 - pct12Prev;
        }
        registerTicker('ipca12m', 'IPCA 12M', pct12.toFixed(2).replace('.', ',') + '%', chg12, true, ' p.p.');
      } else {
        setError('#ipca-data .ipca-12m-value', 'N/D');
      }
    } else {
      setError('#ipca-data .ipca-current-value', 'N/D');
      setError('#ipca-data .ipca-12m-value', '—');
    }
  }

  async function updateDesemprego() {
    const data = await fetchBCB(BCB_SERIES.DESEMPREGO, 2, 'bcb_monthly');
    if (data && data.length > 0) {
      const last   = data[data.length - 1];
      const latest = parseFloat(last.valor.replace(',', '.'));
      setVal('#desemprego-data .desemprego-current-value', latest.toFixed(1).replace('.', ','));
      setVal('#desemprego-data .desemprego-ref-date', last.data ? last.data.substring(3) : '—');
      // Variação vs. dado anterior, em pontos percentuais. invert=true: subir=ruim=vermelho
      let chg = null;
      if (data.length >= 2) {
        const prev = parseFloat(data[data.length - 2].valor.replace(',', '.'));
        chg = latest - prev;
      }
      registerTicker('desemprego', 'DESEMPREGO', latest.toFixed(1).replace('.', ',') + '%', chg, true, ' p.p.');
    } else {
      setError('#desemprego-data .desemprego-current-value', 'N/D');
      setError('#desemprego-data .desemprego-ref-date', '—');
    }
  }

  async function updateICE() {
    const data = await fetchBCB(BCB_SERIES.ICE, 2, 'bcb_monthly');
    if (data && data.length > 0) {
      const last   = data[data.length - 1];
      const latest = parseFloat(last.valor.replace(',', '.'));
      setVal('#ice-data .ice-current-value', latest.toFixed(1).replace('.', ','));
      setVal('#ice-data .ice-ref-date', last.data ? last.data.substring(3) : '—');
      // Variação vs. dado anterior, em pontos. invert=false: subir=confiança maior=verde
      let chg = null;
      if (data.length >= 2) {
        const prev = parseFloat(data[data.length - 2].valor.replace(',', '.'));
        chg = latest - prev;
      }
      registerTicker('ice', 'ICE', latest.toFixed(1).replace('.', ',') + ' pts', chg, false, ' pts');
    } else {
      setError('#ice-data .ice-current-value', 'N/D');
      setError('#ice-data .ice-ref-date', '—');
    }
  }

  async function updateIbovespa() {
    const data = await fetchMarket('^BVSP', 'mkt_ibov');
    if (data) {
      setVal('#ibovespa-data .ibov-current-value', Math.round(data.current).toLocaleString('pt-BR'));
      setChange('#ibovespa-data .ibov-daily-change', data.change);
      registerTicker('ibov', 'IBOV', Math.round(data.current).toLocaleString('pt-BR') + ' pts', data.change);
    } else {
      setError('#ibovespa-data .ibov-current-value', 'N/D');
      setError('#ibovespa-data .ibov-daily-change', '');
    }
  }

  async function updateSP500() {
    const data = await fetchMarket('^GSPC', 'mkt_sp500');
    if (data) {
      setVal('#sp500-data .sp500-current-value', Math.round(data.current).toLocaleString('pt-BR'));
      setChange('#sp500-data .sp500-daily-change', data.change);
      registerTicker('sp500', 'S&P 500', Math.round(data.current).toLocaleString('pt-BR') + ' pts', data.change);
    } else {
      setError('#sp500-data .sp500-current-value', 'N/D');
      setError('#sp500-data .sp500-daily-change', '');
    }
  }

  async function updateNasdaq() {
    const data = await fetchMarket('^IXIC', 'mkt_nasdaq');
    if (data) {
      setVal('#nasdaq-data .nasdaq-current-value', Math.round(data.current).toLocaleString('pt-BR'));
      setChange('#nasdaq-data .nasdaq-daily-change', data.change);
      registerTicker('nasdaq', 'NASDAQ', Math.round(data.current).toLocaleString('pt-BR') + ' pts', data.change);
    } else {
      setError('#nasdaq-data .nasdaq-current-value', 'N/D');
      setError('#nasdaq-data .nasdaq-daily-change', '');
    }
  }

  // ─── Ações B3 (apenas no ticker, via Worker) ───────────────────────────────
  // Cada ação usa o ticker do Yahoo com sufixo .SA
  const ACOES_B3 = [
    { key: 'petr4',  ticker: 'PETR4.SA',  label: 'PETR4' },
    { key: 'vale3',  ticker: 'VALE3.SA',  label: 'VALE3' },
    { key: 'itub4',  ticker: 'ITUB4.SA',  label: 'ITUB4' },
    { key: 'wege3',  ticker: 'WEGE3.SA',  label: 'WEGE3' },
    { key: 'ggbr4',  ticker: 'GGBR4.SA',  label: 'GGBR4' },
    { key: 'bpac11', ticker: 'BPAC11.SA', label: 'BPAC11' },
    { key: 'sbsp3',  ticker: 'SBSP3.SA',  label: 'SBSP3' },
    { key: 'csmg3',  ticker: 'CSMG3.SA',  label: 'CSMG3' },
  ];

  async function updateAcao(acao) {
    const data = await fetchMarket(acao.ticker, 'mkt_' + acao.key);
    if (data && typeof data.current === 'number') {
      const preco = 'R$ ' + data.current.toFixed(2).replace('.', ',');
      registerTicker(acao.key, acao.label, preco, data.change);
    }
    // Sem else: se falhar, a ação simplesmente não entra no ticker (sem poluir com N/D)
  }

  function updateAcoesB3() {
    return Promise.allSettled(ACOES_B3.map((a) => updateAcao(a)));
  }

  // ─── Renderização do ticker ────────────────────────────────────────────────
  // Ordem de exibição no ticker
  const TICKER_ORDER = [
    'dolar', 'euro',
    'ibov', 'sp500', 'nasdaq',
    'petr4', 'vale3', 'itub4', 'wege3', 'ggbr4', 'bpac11', 'sbsp3', 'csmg3',
    'selic', 'cdi', 'ipca', 'ipca12m', 'desemprego', 'ice',
  ];

  function renderTicker() {
    const track = document.getElementById('ticker-track');
    if (!track) return;

    const items = TICKER_ORDER
      .filter((k) => tickerData[k])
      .map((k) => {
        const d = tickerData[k];
        let changeHtml = '';
        if (typeof d.change === 'number' && !isNaN(d.change)) {
          const up = d.change >= 0;            // o valor subiu?
          const arrow = up ? '▲' : '▼';        // seta sempre reflete a direção real
          const sign = up ? '+' : '';
          // Cor: normalmente sobe=verde. Se invert=true (desemprego, IPCA),
          // sobe=vermelho porque é economicamente ruim.
          const good = d.invert ? !up : up;
          const colorClass = good ? 'up' : 'down';
          const suffix = d.chgSuffix !== undefined ? d.chgSuffix : '%';
          changeHtml =
            '<span class="ticker-change ' + colorClass + '">' +
            arrow + ' ' + sign + d.change.toFixed(2).replace('.', ',') + suffix + '</span>';
        }
        return (
          '<span class="ticker-item">' +
          '<span class="ticker-label">' + d.label + '</span>' +
          '<span class="ticker-value">' + d.value + '</span>' +
          changeHtml +
          '</span>'
        );
      });

    if (items.length === 0) return;

    // Duplica o conteúdo para o loop da animação ser contínuo (-50% no keyframe)
    const html = items.join('') + items.join('');
    track.innerHTML = html;
  }

  // ─── Inicialização ─────────────────────────────────────────────────────────
  async function loadAll() {
    await Promise.allSettled([
      updateDolar(),
      updateEuro(),
      updateSelic(),
      updateCDI(),
      updateIPCA(),
      updateDesemprego(),
      updateICE(),
      updateIbovespa(),
      updateSP500(),
      updateNasdaq(),
      updateAcoesB3(),
    ]);
    updateTimestamp();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', loadAll);
  } else {
    loadAll();
  }

  // Atualização periódica: câmbio + bolsas a cada 10 minutos
  setInterval(function () {
    updateDolar();
    updateEuro();
    updateIbovespa();
    updateSP500();
    updateNasdaq();
    updateAcoesB3();
    updateTimestamp();
  }, 10 * 60 * 1000);

})();
