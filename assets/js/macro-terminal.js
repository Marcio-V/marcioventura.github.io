/**
 * Macro Terminal — página Economia (marcioventura.com.br)
 * Popula os cards [data-macro] com dados reais do BCB e do Cloudflare Worker.
 * Reaproveita a mesma lógica de cache do economic-tracker.
 */
(function () {
  'use strict';

  const MARKET_PROXY = 'https://market-proxy.m-matheus-baptista.workers.dev';

  const CACHE_TTL = { daily: 5*60*1000, monthly: 60*60*1000, rate: 60*60*1000, market: 10*60*1000 };
  const BCB = { USD:1, EUR:21619, SELIC:432, CDI:4389, IPCA_MES:433, DESEMPREGO:24369 };

  function cacheGet(k, ttl) {
    try { const r = sessionStorage.getItem('ind_'+k); if(!r) return null;
      const e = JSON.parse(r); if(Date.now()-e.ts>ttl) return null; return e.data; } catch(e){ return null; }
  }
  function cacheSet(k, d) {
    try { sessionStorage.setItem('ind_'+k, JSON.stringify({ts:Date.now(),data:d})); } catch(e){}
  }

  async function fetchBCB(id, n, ttlKey) {
    const ck = 'bcb_'+id, c = cacheGet(ck, CACHE_TTL[ttlKey]); if(c) return c;
    const base = `https://api.bcb.gov.br/dados/serie/bcdata.sgs.${id}/dados`;
    try {
      const res = await fetch(`${base}/ultimos/${n}?formato=json`);
      if (res.ok) { const d = await res.json(); if (Array.isArray(d)&&d.length){ cacheSet(ck,d); return d; } }
    } catch(e){}
    return null;
  }

  async function fetchMarket(ticker, ck) {
    const c = cacheGet(ck, CACHE_TTL.market); if(c) return c;
    if (MARKET_PROXY.indexOf('SEU-USUARIO')!==-1) return null;
    try {
      const res = await fetch(MARKET_PROXY+'/?ticker='+encodeURIComponent(ticker));
      if(!res.ok) throw 0; const j = await res.json();
      if(j.error||typeof j.current!=='number') throw 0;
      const d = {current:j.current, change:j.change}; cacheSet(ck,d); return d;
    } catch(e){ return null; }
  }

  function set(macro, text, cls) {
    document.querySelectorAll('[data-macro="'+macro+'"]').forEach(function(el){
      const sk = el.querySelector('.term-skeleton'); if(sk) sk.remove();
      el.textContent = text;
      if (cls) { el.classList.remove('up','down'); el.classList.add(cls); }
    });
  }
  function setChg(macro, pct) {
    const cls = pct>=0?'up':'down';
    const txt = (pct>=0?'▲ +':'▼ ')+pct.toFixed(2).replace('.',',')+'%';
    document.querySelectorAll('[data-macro="'+macro+'"]').forEach(function(el){
      el.innerHTML = '<span class="'+cls+'">'+txt+'</span>';
    });
  }

  async function loadDolar(){ const d=await fetchBCB(BCB.USD,2,'daily'); if(d&&d.length>=2){
    const a=parseFloat(d[d.length-1].valor.replace(',','.')),b=parseFloat(d[d.length-2].valor.replace(',','.'));
    set('dolar','R$ '+a.toFixed(4).replace('.',',')); setChg('dolar-chg',((a-b)/b)*100);} else set('dolar','N/D'); }
  async function loadEuro(){ const d=await fetchBCB(BCB.EUR,2,'daily'); if(d&&d.length>=2){
    const a=parseFloat(d[d.length-1].valor.replace(',','.')),b=parseFloat(d[d.length-2].valor.replace(',','.'));
    set('euro','R$ '+a.toFixed(4).replace('.',',')); setChg('euro-chg',((a-b)/b)*100);} else set('euro','N/D'); }
  async function loadSelic(){ const d=await fetchBCB(BCB.SELIC,400,'rate'); if(d&&d.length){
    const v=d.map(x=>parseFloat(x.valor.replace(',','.'))),a=v[v.length-1];
    set('selic',a.toFixed(2).replace('.',',')+'%');
    let prev=null; for(let i=v.length-2;i>=0;i--){ if(v[i]!==a){prev=v[i];break;} }
    if(prev!==null){ const bps=Math.round((a-prev)*100); set('selic-copom',(bps>=0?'+':'')+bps+' bps último COPOM'); }
  } else set('selic','N/D'); }
  async function loadCDI(){ const d=await fetchBCB(BCB.CDI,1,'rate'); if(d&&d.length){
    set('cdi',parseFloat(d[d.length-1].valor.replace(',','.')).toFixed(2).replace('.',',')+'%');} else set('cdi','N/D'); }
  async function loadIPCA(){ const d=await fetchBCB(BCB.IPCA_MES,13,'monthly'); if(d&&d.length){
    set('ipca',parseFloat(d[d.length-1].valor.replace(',','.')).toFixed(2).replace('.',',')+'%');
    if(d.length>=12){ const u=d.slice(-12),ac=u.reduce((s,x)=>s*(1+parseFloat(x.valor.replace(',','.'))/100),1);
      set('ipca12m',((ac-1)*100).toFixed(2).replace('.',',')+'%'); }
  } else { set('ipca','N/D'); set('ipca12m','N/D'); } }
  async function loadDesemprego(){ const d=await fetchBCB(BCB.DESEMPREGO,1,'monthly'); if(d&&d.length){
    set('desemprego',parseFloat(d[d.length-1].valor.replace(',','.')).toFixed(1).replace('.',',')+'%');} else set('desemprego','N/D'); }
  async function loadIbov(){ const d=await fetchMarket('^BVSP','mkt_ibov'); if(d){
    set('ibov',Math.round(d.current).toLocaleString('pt-BR')); setChg('ibov-chg',d.change);} else set('ibov','N/D'); }
  async function loadSP500(){ const d=await fetchMarket('^GSPC','mkt_sp500'); if(d){
    set('sp500',Math.round(d.current).toLocaleString('pt-BR')); setChg('sp500-chg',d.change);} else set('sp500','N/D'); }
  async function loadNasdaq(){ const d=await fetchMarket('^IXIC','mkt_nasdaq'); if(d){
    set('nasdaq',Math.round(d.current).toLocaleString('pt-BR')); setChg('nasdaq-chg',d.change);} else set('nasdaq','N/D'); }

  function loadAll(){
    Promise.allSettled([loadDolar(),loadEuro(),loadSelic(),loadCDI(),loadIPCA(),loadDesemprego(),loadIbov(),loadSP500(),loadNasdaq()]);
  }

  if (document.readyState==='loading') document.addEventListener('DOMContentLoaded', loadAll);
  else loadAll();
})();
