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
    IPCA_MES:   433,    // IPCA - variação mensal
    IPCA_12M:   13522,  // IPCA - acumulado 12 meses
    DESEMPREGO: 24369,  // Taxa de desocupação - PNAD Contínua
  };

  // ─── Proxy CORS para Yahoo Finance ─────────────────────────────────────────
  // O Yahoo bloqueia requisições diretas do browser (CORS). O proxy resolve isso.
  const CORS_PROXY = 'https://api.allorigins.win/raw?url=';
  const YAHOO_BASE = 'https://query1.finance.yahoo.com/v8/finance/chart/';

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
  async function fetchBCB(seriesId, lastN, ttlKey) {
    const cacheKey = 'bcb_' + seriesId;
    const cached = cacheGet(cacheKey, CACHE_TTL[ttlKey]);
    if (cached) return cached;

    const url = `https://api.bcb.gov.br/dados/serie/bcdata.sgs.${seriesId}/dados/ultimos/${lastN}?formato=json`;
    try {
      const res = await fetch(url);
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const data = await res.json();
      cacheSet(cacheKey, data);
      return data;
    } catch (err) {
      console.warn('[BCB SGS ' + seriesId + '] Falha:', err.message);
      return null;
    }
  }

  // ─── Fetch Yahoo Finance via proxy CORS ────────────────────────────────────
  async function fetchYahoo(ticker, cacheKey) {
    const cached = cacheGet(cacheKey, CACHE_TTL.market);
    if (cached) return cached;

    const yahooUrl = `${YAHOO_BASE}${ticker}?interval=1d&range=2d`;
    const url = CORS_PROXY + encodeURIComponent(yahooUrl);
    try {
      const res = await fetch(url);
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const json = await res.json();
      const result = json?.chart?.result?.[0];
      if (!result || !result.meta) throw new Error('Sem dados');

      const meta = result.meta;
      const current = meta.regularMarketPrice;
      const previous = meta.chartPreviousClose || meta.previousClose;
      const data = {
        current: current,
        previous: previous,
        change: ((current - previous) / previous) * 100,
      };
      cacheSet(cacheKey, data);
      return data;
    } catch (err) {
      console.warn('[Yahoo ' + ticker + '] Falha:', err.message);
      return null;
    }
  }

  // ─── Helpers de renderização ───────────────────────────────────────────────
  function setVal(selector, text) {
    const el = document.querySelector(selector);
    if (!el) return;
    const skeleton = el.querySelector('.ind-skeleton');
    if (skeleton) skeleton.classList.remove('ind-skeleton');
    el.textContent = text;
  }

  function setChange(selector, pct) {
    const el = document.querySelector(selector);
    if (!el) return;
    const skeleton = el.querySelector ? el.querySelector('.ind-skeleton') : null;
    if (skeleton) skeleton.classList.remove('ind-skeleton');
    const formatted = (pct >= 0 ? '+' : '') + pct.toFixed(2).replace('.', ',') + '%';
    el.textContent = formatted;
    el.className = el.className.replace(/\b(positive|negative|ind-skeleton)\b/g, '').trim();
    el.classList.add(pct >= 0 ? 'positive' : 'negative');
  }

  // Variação em basis points (bps) — usado na SELIC
  function setBps(selector, bps) {
    const el = document.querySelector(selector);
    if (!el) return;
    const skeleton = el.querySelector ? el.querySelector('.ind-skeleton') : null;
    if (skeleton) skeleton.classList.remove('ind-skeleton');
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
    const skeleton = el.querySelector ? el.querySelector('.ind-skeleton') : null;
    if (skeleton) skeleton.classList.remove('ind-skeleton');
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
    } else {
      setError('#euro-data .euro-current-value', 'N/D');
      setError('#euro-data .euro-daily-change', '');
    }
  }

  async function updateSelic() {
    // Busca os 2 últimos valores da meta SELIC p/ calcular variação do último COPOM em bps
    const data = await fetchBCB(BCB_SERIES.SELIC_META, 2, 'bcb_rate');
    if (data && data.length >= 1) {
      const latest = parseFloat(data[data.length - 1].valor.replace(',', '.'));
      setVal('#selic-data .selic-current-value', latest.toFixed(2).replace('.', ','));
      if (data.length >= 2) {
        const previous = parseFloat(data[data.length - 2].valor.replace(',', '.'));
        const bps = (latest - previous) * 100; // 1 ponto percentual = 100 bps
        setBps('#selic-data .selic-copom-change', bps);
      } else {
        setVal('#selic-data .selic-copom-change', 'estável');
      }
    } else {
      setError('#selic-data .selic-current-value', 'N/D');
      setError('#selic-data .selic-copom-change', '');
    }
  }

  async function updateCDI() {
    const data = await fetchBCB(BCB_SERIES.CDI, 1, 'bcb_rate');
    if (data && data.length > 0) {
      const latest = parseFloat(data[0].valor.replace(',', '.'));
      const date   = data[0].data;
      setVal('#cdi-data .cdi-current-value', latest.toFixed(2).replace('.', ','));
      setVal('#cdi-data .cdi-ref-date', date.substring(3));
    } else {
      setError('#cdi-data .cdi-current-value', 'N/D');
    }
  }

  async function updateIPCA() {
    // IPCA no mês
    const mes = await fetchBCB(BCB_SERIES.IPCA_MES, 1, 'bcb_monthly');
    if (mes && mes.length > 0) {
      const latest = parseFloat(mes[0].valor.replace(',', '.'));
      setVal('#ipca-data .ipca-current-value', latest.toFixed(2).replace('.', ','));
    } else {
      setError('#ipca-data .ipca-current-value', 'N/D');
    }
    // IPCA acumulado 12 meses
    const acum = await fetchBCB(BCB_SERIES.IPCA_12M, 1, 'bcb_monthly');
    if (acum && acum.length > 0) {
      const latest12 = parseFloat(acum[0].valor.replace(',', '.'));
      setVal('#ipca-data .ipca-12m-value', latest12.toFixed(2).replace('.', ',') + '%');
    } else {
      setError('#ipca-data .ipca-12m-value', 'N/D');
    }
  }

  async function updateDesemprego() {
    const data = await fetchBCB(BCB_SERIES.DESEMPREGO, 1, 'bcb_monthly');
    if (data && data.length > 0) {
      const latest = parseFloat(data[0].valor.replace(',', '.'));
      const date   = data[0].data;
      setVal('#desemprego-data .desemprego-current-value', latest.toFixed(1).replace('.', ','));
      setVal('#desemprego-data .desemprego-ref-date', date.substring(3));
    } else {
      setError('#desemprego-data .desemprego-current-value', 'N/D');
    }
  }

  async function updateIbovespa() {
    const data = await fetchYahoo('%5EBVSP', 'yahoo_ibov');
    if (data) {
      setVal('#ibovespa-data .ibov-current-value', Math.round(data.current).toLocaleString('pt-BR'));
      setChange('#ibovespa-data .ibov-daily-change', data.change);
    } else {
      setError('#ibovespa-data .ibov-current-value', 'N/D');
      setError('#ibovespa-data .ibov-daily-change', '');
    }
  }

  async function updateSP500() {
    const data = await fetchYahoo('%5EGSPC', 'yahoo_sp500');
    if (data) {
      setVal('#sp500-data .sp500-current-value', Math.round(data.current).toLocaleString('pt-BR'));
      setChange('#sp500-data .sp500-daily-change', data.change);
    } else {
      setError('#sp500-data .sp500-current-value', 'N/D');
      setError('#sp500-data .sp500-daily-change', '');
    }
  }

  async function updateNasdaq() {
    const data = await fetchYahoo('%5EIXIC', 'yahoo_nasdaq');
    if (data) {
      setVal('#nasdaq-data .nasdaq-current-value', Math.round(data.current).toLocaleString('pt-BR'));
      setChange('#nasdaq-data .nasdaq-daily-change', data.change);
    } else {
      setError('#nasdaq-data .nasdaq-current-value', 'N/D');
      setError('#nasdaq-data .nasdaq-daily-change', '');
    }
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
      updateIbovespa(),
      updateSP500(),
      updateNasdaq(),
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
    updateTimestamp();
  }, 10 * 60 * 1000);

})();
