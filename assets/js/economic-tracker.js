/**
 * Economic Tracker — marcioventura.com.br
 * Fontes: BCB SGS (SELIC, CDI, IPCA, IGP-M, USD/BRL) | Yahoo Finance via proxy público (IBOV, S&P500, Nasdaq)
 * Cache: SessionStorage com TTL configurável por tipo de dado
 * Autor: Marcio Ventura
 */

(function () {
  'use strict';

  // ─── Configuração de TTL de cache (em milissegundos) ───────────────────────
  const CACHE_TTL = {
    bcb_daily:   5 * 60 * 1000,   // 5 min — dólar (atualiza intraday)
    bcb_monthly: 60 * 60 * 1000,  // 1 hora — IPCA, IGP-M (mensais)
    bcb_rate:    60 * 60 * 1000,  // 1 hora — SELIC, CDI (raramente mudam)
    market:      10 * 60 * 1000,  // 10 min — bolsas (intraday com delay)
  };

  // ─── IDs das séries BCB SGS ────────────────────────────────────────────────
  const BCB_SERIES = {
    USD_BRL: 1,    // Dólar Comercial - Venda
    SELIC:   432,  // Taxa SELIC acumulada no mês
    CDI:     4389, // CDI acumulado no mês
    IPCA:    433,  // IPCA - variação mensal
    IGPM:    189,  // IGP-M - variação mensal
  };

  // ─── Proxy para Yahoo Finance (evita CORS sem backend) ────────────────────
  // allorigins.win é um proxy CORS público e gratuito
  const YAHOO_PROXY = 'https://query1.finance.yahoo.com/v8/finance/chart/';

  // ─── Utilitários de Cache ──────────────────────────────────────────────────
  function cacheSet(key, data) {
    try {
      sessionStorage.setItem('ind_' + key, JSON.stringify({
        ts: Date.now(),
        data: data,
      }));
    } catch (e) { /* sessionStorage indisponível — sem cache */ }
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

  // ─── Fetch Yahoo Finance via proxy ─────────────────────────────────────────
  async function fetchYahoo(ticker, cacheKey) {
    const cached = cacheGet(cacheKey, CACHE_TTL.market);
    if (cached) return cached;

    // Yahoo Finance aceita requisição direta no browser (sem autenticação)
    const url = `${YAHOO_PROXY}${ticker}?interval=1d&range=2d`;
    try {
      const res = await fetch(url);
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const json = await res.json();
      const result = json?.chart?.result?.[0];
      if (!result) throw new Error('Sem dados');

      const meta = result.meta;
      const data = {
        current: meta.regularMarketPrice,
        previous: meta.chartPreviousClose,
        change: ((meta.regularMarketPrice - meta.chartPreviousClose) / meta.chartPreviousClose) * 100,
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
    // Remove skeleton da tag filha se existir
    const skeleton = el.querySelector('.ind-skeleton');
    if (skeleton) skeleton.classList.remove('ind-skeleton');
    el.textContent = text;
  }

  function setChange(selector, pct) {
    const el = document.querySelector(selector);
    if (!el) return;
    const skeleton = el.querySelector
      ? el.querySelector('.ind-skeleton') : null;
    if (skeleton) skeleton.classList.remove('ind-skeleton');
    const formatted = (pct >= 0 ? '+' : '') + pct.toFixed(2).replace('.', ',') + '%';
    el.textContent = formatted;
    el.className = el.className.replace(/\b(positive|negative|ind-skeleton)\b/g, '').trim();
    el.classList.add(pct >= 0 ? 'positive' : 'negative');
  }

  function setError(selector, msg) {
    const el = document.querySelector(selector);
    if (!el) return;
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

  async function updateSelic() {
    const data = await fetchBCB(BCB_SERIES.SELIC, 1, 'bcb_rate');
    if (data && data.length > 0) {
      const latest = parseFloat(data[0].valor.replace(',', '.'));
      const date   = data[0].data; // DD/MM/YYYY
      setVal('#selic-data .selic-current-value', latest.toFixed(2).replace('.', ','));
      setVal('#selic-data .selic-ref-date', date.substring(3)); // MM/YYYY
    } else {
      setError('#selic-data .selic-current-value', 'N/D');
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
    const data = await fetchBCB(BCB_SERIES.IPCA, 1, 'bcb_monthly');
    if (data && data.length > 0) {
      const latest = parseFloat(data[0].valor.replace(',', '.'));
      const date   = data[0].data;
      setVal('#ipca-data .ipca-current-value', latest.toFixed(2).replace('.', ','));
      setVal('#ipca-data .ipca-ref-date', date.substring(3));
    } else {
      setError('#ipca-data .ipca-current-value', 'N/D');
    }
  }

  async function updateIGPM() {
    const data = await fetchBCB(BCB_SERIES.IGPM, 1, 'bcb_monthly');
    if (data && data.length > 0) {
      const latest = parseFloat(data[0].valor.replace(',', '.'));
      const date   = data[0].data;
      setVal('#igpm-data .igpm-current-value', latest.toFixed(2).replace('.', ','));
      setVal('#igpm-data .igpm-ref-date', date.substring(3));
    } else {
      setError('#igpm-data .igpm-current-value', 'N/D');
    }
  }

  async function updateIbovespa() {
    const data = await fetchYahoo('^BVSP', 'yahoo_ibov');
    if (data) {
      setVal('#ibovespa-data .ibov-current-value', Math.round(data.current).toLocaleString('pt-BR'));
      setChange('#ibovespa-data .ibov-daily-change', data.change);
    } else {
      setError('#ibovespa-data .ibov-current-value', 'N/D');
      setError('#ibovespa-data .ibov-daily-change', '');
    }
  }

  async function updateSP500() {
    const data = await fetchYahoo('^GSPC', 'yahoo_sp500');
    if (data) {
      setVal('#sp500-data .sp500-current-value', Math.round(data.current).toLocaleString('pt-BR'));
      setChange('#sp500-data .sp500-daily-change', data.change);
    } else {
      setError('#sp500-data .sp500-current-value', 'N/D');
      setError('#sp500-data .sp500-daily-change', '');
    }
  }

  async function updateNasdaq() {
    const data = await fetchYahoo('^IXIC', 'yahoo_nasdaq');
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
    // Roda em paralelo — BCB e Yahoo independentes
    await Promise.allSettled([
      updateDolar(),
      updateSelic(),
      updateCDI(),
      updateIPCA(),
      updateIGPM(),
      updateIbovespa(),
      updateSP500(),
      updateNasdaq(),
    ]);
    updateTimestamp();
  }

  // Dispara quando o DOM estiver pronto
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', loadAll);
  } else {
    loadAll();
  }

  // Atualização periódica: dólar + bolsas a cada 10 minutos
  setInterval(function () {
    updateDolar();
    updateIbovespa();
    updateSP500();
    updateNasdaq();
    updateTimestamp();
  }, 10 * 60 * 1000);

})();
