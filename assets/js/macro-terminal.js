/**
 * Macro Terminal — página Economia (marcioventura.com.br)
 * Popula os cards [data-macro] com dados reais do BCB e do Cloudflare Worker.
 * Reaproveita a mesma lógica de cache do economic-tracker.
 */
(function () {
  'use strict';

  const MARKET_PROXY = 'https://market-proxy.m-matheus-baptista.workers.dev';

  const CACHE_TTL = { daily: 5*60*1000, monthly: 60*60*1000, rate: 60*60*1000, market: 10*60*1000 };
  const BCB = { USD:1, EUR:21619, SELIC:432, CDI:4389, IPCA_MES:433, DESEMPREGO:24369,
                IBCBR:24364, DIVIDA_BRUTA:13762, DIVIDA_LIQUIDA:4536, IGPM:189, INPC:188 };

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

  // ─── Expectativa de inflação 12M (Pesquisa Focus via Olinda) ───────────────
  // Retorna a mediana suavizada da inflação esperada para os próximos 12 meses.
  async function fetchFocusInflacao12m() {
    const ck = 'focus_ipca12m', c = cacheGet(ck, CACHE_TTL.monthly); if(c) return c;
    const base = 'https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoInflacao12Meses';
    const params = "?$top=1&$orderby=Data desc&$format=json&$select=Indicador,Data,Mediana,Suavizada&$filter=" + encodeURIComponent("Indicador eq 'IPCA' and Suavizada eq 'S'");
    try {
      const res = await fetch(base + params);
      if (!res.ok) throw 0;
      const j = await res.json();
      const row = j && j.value && j.value[0];
      if (!row) throw 0;
      const d = { mediana: row.Mediana, data: row.Data };
      cacheSet(ck, d);
      return d;
    } catch(e) { return null; }
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
  async function loadDow(){ const d=await fetchMarket('^DJI','mkt_dow'); if(d){
    set('dow',Math.round(d.current).toLocaleString('pt-BR')); setChg('dow-chg',d.change);} else set('dow','N/D'); }
  async function loadTreasury(){ const d=await fetchMarket('^TNX','mkt_tnx'); if(d){
    set('tnx',d.current.toFixed(2).replace('.',',')+'%'); setChg('tnx-chg',d.change);} else set('tnx','N/D'); }
  async function loadVIX(){ const d=await fetchMarket('^VIX','mkt_vix'); if(d){
    set('vix',d.current.toFixed(2).replace('.',',')); setChg('vix-chg',d.change);} else set('vix','N/D'); }

  // ─── Commodities (futuros via Worker) ──────────────────────────────────────
  // priceFmt: como formatar o valor (cada commodity tem escala diferente)
  async function loadCommodity(ticker, ck, macro, decimals){
    const d = await fetchMarket(ticker, ck);
    if (d){
      set(macro, 'US$ ' + d.current.toFixed(decimals).replace('.',','));
      setChg(macro+'-chg', d.change);
    } else {
      set(macro,'N/D');
    }
  }

  function loadCommodities(){
    return Promise.allSettled([
      loadCommodity('CL=F','mkt_wti','wti',2),
      loadCommodity('BZ=F','mkt_brent','brent',2),
      loadCommodity('GC=F','mkt_ouro','ouro',2),
      loadCommodity('HG=F','mkt_cobre','cobre',2),
      loadCommodity('ZS=F','mkt_soja','soja',2),
      loadCommodity('ZC=F','mkt_milho','milho',2),
    ]);
  }

  // ─── Juros Reais (ex-ante, via equação de Fisher) ──────────────────────────
  // juro_real = [(1 + Selic/100) / (1 + InflaçãoEsperada/100) − 1] × 100
  async function loadJurosReais(){
    const selicData = await fetchBCB(BCB.SELIC, 1, 'rate');
    const focus = await fetchFocusInflacao12m();

    if (selicData && selicData.length && focus && typeof focus.mediana === 'number') {
      const selic = parseFloat(selicData[selicData.length-1].valor.replace(',','.'));
      const infEsperada = focus.mediana;
      const juroReal = ((1 + selic/100) / (1 + infEsperada/100) - 1) * 100;

      set('selic-jr', selic.toFixed(2).replace('.',',') + '%');
      set('focus-inf', infEsperada.toFixed(2).replace('.',',') + '%');
      set('juro-real', juroReal.toFixed(2).replace('.',',') + '%', juroReal >= 0 ? 'up' : 'down');
    } else {
      set('selic-jr','N/D'); set('focus-inf','N/D'); set('juro-real','N/D');
    }
  }

  // ─── Atividade: IBC-Br ──────────────────────────────────────────────────────
  async function loadIBCBr(){
    const d = await fetchBCB(BCB.IBCBR, 13, 'monthly');
    if (d && d.length){
      const last = d[d.length-1];
      set('ibcbr', parseFloat(last.valor.replace(',','.')).toFixed(2).replace('.',','));
      set('ibcbr-ref', last.data ? last.data.substring(3) : '—');
      if (d.length >= 13){
        // variação 12M aproximada: último vs 12 meses atrás
        const atual = parseFloat(d[d.length-1].valor.replace(',','.'));
        const ano = parseFloat(d[d.length-13].valor.replace(',','.'));
        const varPct = ((atual/ano)-1)*100;
        set('ibcbr-var', (varPct>=0?'+':'')+varPct.toFixed(2).replace('.',',')+'%', varPct>=0?'up':'down');
      }
    } else { set('ibcbr','N/D'); set('ibcbr-var','N/D'); }
  }

  // ─── Fiscal: dívida bruta e líquida ─────────────────────────────────────────
  async function loadFiscal(){
    const db = await fetchBCB(BCB.DIVIDA_BRUTA, 2, 'monthly');
    if (db && db.length){
      const last = parseFloat(db[db.length-1].valor.replace(',','.'));
      set('divida-bruta', last.toFixed(1).replace('.',',')+'%');
      if (db.length>=2){ const prev=parseFloat(db[db.length-2].valor.replace(',','.'));
        const chg=last-prev; set('divida-bruta-chg',(chg>=0?'+':'')+chg.toFixed(1).replace('.',',')+' p.p. vs mês ant.', chg>=0?'down':'up'); }
    } else set('divida-bruta','N/D');
    const dl = await fetchBCB(BCB.DIVIDA_LIQUIDA, 2, 'monthly');
    if (dl && dl.length){
      const last = parseFloat(dl[dl.length-1].valor.replace(',','.'));
      set('divida-liquida', last.toFixed(1).replace('.',',')+'%');
      if (dl.length>=2){ const prev=parseFloat(dl[dl.length-2].valor.replace(',','.'));
        const chg=last-prev; set('divida-liquida-chg',(chg>=0?'+':'')+chg.toFixed(1).replace('.',',')+' p.p. vs mês ant.', chg>=0?'down':'up'); }
    } else set('divida-liquida','N/D');
  }

  // ─── Inflação: IGP-M e INPC ─────────────────────────────────────────────────
  async function loadIGPM(){
    const d = await fetchBCB(BCB.IGPM, 1, 'monthly');
    if (d && d.length){ const last=d[d.length-1];
      set('igpm', parseFloat(last.valor.replace(',','.')).toFixed(2).replace('.',',')+'%');
      set('igpm-ref', last.data?last.data.substring(3):'—');
    } else set('igpm','N/D');
  }
  async function loadINPC(){
    const d = await fetchBCB(BCB.INPC, 1, 'monthly');
    if (d && d.length){ const last=d[d.length-1];
      set('inpc', parseFloat(last.valor.replace(',','.')).toFixed(2).replace('.',',')+'%');
      set('inpc-ref', last.data?last.data.substring(3):'—');
    } else set('inpc','N/D');
  }

  // ═══════════ GRÁFICOS DE SÉRIES HISTÓRICAS (Chart.js) ═══════════

  // Busca histórico BCB por filtro de data (mais robusto que /ultimos para séries longas)
  async function fetchBCBHistory(id, monthsBack, ttlKey) {
    const ck = 'bcbhist_' + id + '_' + monthsBack;
    const c = cacheGet(ck, CACHE_TTL[ttlKey] || CACHE_TTL.monthly);
    if (c) return c;
    const base = `https://api.bcb.gov.br/dados/serie/bcdata.sgs.${id}/dados`;
    const hoje = new Date();
    const ini = new Date(); ini.setMonth(ini.getMonth() - monthsBack);
    const fmt = (d) => String(d.getDate()).padStart(2,'0') + '/' + String(d.getMonth()+1).padStart(2,'0') + '/' + d.getFullYear();
    try {
      const res = await fetch(`${base}?formato=json&dataInicial=${fmt(ini)}&dataFinal=${fmt(hoje)}`);
      if (res.ok) { const d = await res.json(); if (Array.isArray(d) && d.length) { cacheSet(ck, d); return d; } }
    } catch(e){}
    return null;
  }

  // Estilo padrão dark dos gráficos do terminal
  const CHART_COLORS = {
    line: '#4da3ff', fill: 'rgba(77,163,255,0.12)',
    grid: 'rgba(255,255,255,0.06)', text: '#8b949e',
  };

  function baseChartOptions(yLabel) {
    return {
      responsive: true,
      maintainAspectRatio: false,
      interaction: { intersect: false, mode: 'index' },
      plugins: {
        legend: { display: false },
        tooltip: {
          backgroundColor: '#161c21', borderColor: '#2a3138', borderWidth: 1,
          titleColor: '#e6e6e6', bodyColor: '#e6e6e6', padding: 10,
        },
      },
      scales: {
        x: { grid: { color: CHART_COLORS.grid }, ticks: { color: CHART_COLORS.text, maxTicksLimit: 8, font: { size: 10 } } },
        y: { grid: { color: CHART_COLORS.grid }, ticks: { color: CHART_COLORS.text, font: { size: 10 } }, title: { display: !!yLabel, text: yLabel, color: CHART_COLORS.text } },
      },
    };
  }

  // Desenha um gráfico de linha num <canvas data-chart="KEY">
  function drawLineChart(key, labels, values, yLabel) {
    const canvas = document.querySelector('canvas[data-chart="' + key + '"]');
    if (!canvas || typeof Chart === 'undefined') return;
    new Chart(canvas, {
      type: 'line',
      data: {
        labels: labels,
        datasets: [{
          data: values,
          borderColor: CHART_COLORS.line,
          backgroundColor: CHART_COLORS.fill,
          borderWidth: 2, fill: true, tension: 0.25,
          pointRadius: 0, pointHoverRadius: 4, pointHoverBackgroundColor: CHART_COLORS.line,
        }],
      },
      options: baseChartOptions(yLabel),
    });
  }

  // Helper: extrai labels (datas) e valores numéricos de uma série BCB
  function parseSeries(data) {
    const labels = data.map(d => d.data.substring(3)); // MM/YYYY (mensal) ou mantém p/ diário
    const values = data.map(d => parseFloat(d.valor.replace(',', '.')));
    return { labels, values };
  }

  // ── Selic × Regra de Taylor (desde 2015, com parâmetros editáveis) ──
  let taylorHist = null;       // { labels, selic, ipca } — guardado p/ recalcular sem re-buscar
  let taylorChart = null;      // instância Chart.js

  // Reduz série diária da Selic a 1 ponto por mês (último valor de cada mês)
  function monthlyFromDaily(data) {
    const byMonth = {};
    data.forEach(d => {
      const mk = d.data.substring(3); // MM/YYYY
      byMonth[mk] = parseFloat(d.valor.replace(',', '.')); // sobrescreve → fica o último do mês
    });
    return byMonth;
  }

  function taylorParams() {
    const g = (id, def) => { const el = document.getElementById(id); return el ? parseFloat(el.value) : def; };
    return {
      rstar: g('tr-rstar', 4.5), pistar: g('tr-pistar', 3.0),
      alpha: g('tr-alpha', 0.5), beta: g('tr-beta', 0.5), hiato: g('tr-hiato', 0.0),
    };
  }

  // Calcula a linha Taylor a partir do IPCA histórico e dos parâmetros atuais
  function computeTaylor() {
    if (!taylorHist) return [];
    const p = taylorParams();
    return taylorHist.ipca.map(pi => {
      if (pi === null) return null;
      // i = r* + π + α(π − π*) + β·hiato
      return p.rstar + pi + p.alpha * (pi - p.pistar) + p.beta * p.hiato;
    });
  }

  function renderTaylorChart() {
    const canvas = document.querySelector('canvas[data-chart="taylor"]');
    if (!canvas || typeof Chart === 'undefined' || !taylorHist) return;
    const taylorLine = computeTaylor();

    if (taylorChart) {
      taylorChart.data.datasets[1].data = taylorLine;
      taylorChart.update('none');
    } else {
      taylorChart = new Chart(canvas, {
        type: 'line',
        data: {
          labels: taylorHist.labels,
          datasets: [
            { label: 'Selic efetiva', data: taylorHist.selic, borderColor: '#4da3ff',
              backgroundColor: 'rgba(77,163,255,0.10)', borderWidth: 2, fill: true, tension: 0.2, pointRadius: 0, pointHoverRadius: 4 },
            { label: 'Taylor', data: taylorLine, borderColor: '#f0a830',
              backgroundColor: 'transparent', borderWidth: 2, borderDash: [5,4], fill: false, tension: 0.2, pointRadius: 0, pointHoverRadius: 4 },
          ],
        },
        options: {
          responsive: true, maintainAspectRatio: false,
          interaction: { intersect: false, mode: 'index' },
          plugins: {
            legend: { display: true, labels: { color: '#8b949e', font: { size: 11 }, usePointStyle: true, boxWidth: 8 } },
            tooltip: { backgroundColor: '#161c21', borderColor: '#2a3138', borderWidth: 1, titleColor: '#e6e6e6', bodyColor: '#e6e6e6',
              callbacks: { label: c => c.dataset.label + ': ' + (c.parsed.y != null ? c.parsed.y.toFixed(2).replace('.', ',') + '%' : 'N/D') } },
          },
          scales: {
            x: { grid: { color: 'rgba(255,255,255,0.06)' }, ticks: { color: '#8b949e', maxTicksLimit: 10, font: { size: 10 } } },
            y: { grid: { color: 'rgba(255,255,255,0.06)' }, ticks: { color: '#8b949e', font: { size: 10 }, callback: v => v + '%' } },
          },
        },
      });
    }
    updateTaylorReadout(taylorLine);
  }

  // Mostra o valor atual da Taylor vs Selic no rodapé
  function updateTaylorReadout(taylorLine) {
    const el = document.getElementById('tr-current');
    if (!el || !taylorHist) return;
    const i = taylorHist.selic.length - 1;
    const selicNow = taylorHist.selic[i];
    const taylorNow = taylorLine[i];
    if (selicNow == null || taylorNow == null) return;
    const gap = selicNow - taylorNow;
    const sinal = gap >= 0 ? 'acima' : 'abaixo';
    el.innerHTML = 'Hoje: Selic ' + selicNow.toFixed(2).replace('.', ',') + '% vs Taylor ' +
      taylorNow.toFixed(2).replace('.', ',') + '% → política ' +
      '<strong style="color:' + (gap >= 0 ? '#3fb950' : '#f85149') + '">' +
      Math.abs(gap).toFixed(2).replace('.', ',') + ' p.p. ' + sinal + '</strong>';
  }

  async function chartTaylor() {
    // Busca Selic (diária→mensal) e IPCA mensal desde ~2015 (135 meses)
    const [selicRaw, ipcaRaw] = await Promise.all([
      fetchBCBHistory(BCB.SELIC, 135, 'rate'),
      fetchBCBHistory(BCB.IPCA_MES, 135, 'monthly'),
    ]);
    if (!selicRaw || !ipcaRaw) return;

    const selicByMonth = monthlyFromDaily(selicRaw);

    // IPCA 12M acumulado por mês (produtório móvel)
    const ipcaVals = ipcaRaw.map(x => ({ mk: x.data.substring(3), v: parseFloat(x.valor.replace(',', '.')) }));
    const ipca12ByMonth = {};
    for (let i = 11; i < ipcaVals.length; i++) {
      const win = ipcaVals.slice(i - 11, i + 1);
      const acc = (win.reduce((s, x) => s * (1 + x.v / 100), 1) - 1) * 100;
      ipca12ByMonth[ipcaVals[i].mk] = parseFloat(acc.toFixed(2));
    }

    // Alinha as duas séries pelos meses em que AMBAS existem
    const labels = [], selic = [], ipca = [];
    Object.keys(selicByMonth).forEach(mk => {
      if (ipca12ByMonth[mk] !== undefined) {
        labels.push(mk);
        selic.push(selicByMonth[mk]);
        ipca.push(ipca12ByMonth[mk]);
      }
    });
    // Ordena cronologicamente (MM/YYYY → YYYYMM)
    const order = labels.map((mk, idx) => ({ mk, idx, key: mk.substring(3) + mk.substring(0,2) }))
                        .sort((a,b) => a.key.localeCompare(b.key));
    taylorHist = {
      labels: order.map(o => o.mk),
      selic:  order.map(o => selic[o.idx]),
      ipca:   order.map(o => ipca[o.idx]),
    };

    renderTaylorChart();
    bindTaylorControls();
  }

  // Liga os sliders ao recálculo ao vivo
  function bindTaylorControls() {
    const map = [
      ['tr-rstar', 'tr-rstar-v', 1], ['tr-pistar', 'tr-pistar-v', 1],
      ['tr-alpha', 'tr-alpha-v', 2], ['tr-beta', 'tr-beta-v', 2], ['tr-hiato', 'tr-hiato-v', 1],
    ];
    map.forEach(([inId, outId, dec]) => {
      const inp = document.getElementById(inId), out = document.getElementById(outId);
      if (!inp) return;
      const sync = () => {
        if (out) out.textContent = parseFloat(inp.value).toFixed(dec).replace('.', ',');
        renderTaylorChart();
      };
      inp.addEventListener('input', sync);
      sync();
    });
  }

  // ── Gráfico IPCA 12M (calculado a partir da série mensal 433) ──
  async function chartIPCA12m() {
    const d = await fetchBCBHistory(BCB.IPCA_MES, 36, 'monthly');
    if (!d || d.length < 12) return;
    const vals = d.map(x => parseFloat(x.valor.replace(',', '.')));
    const labels = [], series12 = [];
    for (let i = 11; i < vals.length; i++) {
      const win = vals.slice(i - 11, i + 1);
      const acc = (win.reduce((s, v) => s * (1 + v / 100), 1) - 1) * 100;
      labels.push(d[i].data.substring(3));
      series12.push(parseFloat(acc.toFixed(2)));
    }
    drawLineChart('ipca12m', labels, series12, '% 12M');
  }

  // ── Gráfico Dólar (série 1, diária) ──
  async function chartDolar() {
    const d = await fetchBCBHistory(BCB.USD, 6, 'daily');
    if (!d) return;
    const { labels, values } = parseSeries(d);
    // série diária: usa data completa
    const labelsFull = d.map(x => x.data);
    drawLineChart('dolar', labelsFull, values, 'R$');
  }

  // ── Gráfico Desemprego (série 24369, mensal) ──
  async function chartDesemprego() {
    const d = await fetchBCBHistory(BCB.DESEMPREGO, 24, 'monthly');
    if (!d) return;
    const { labels, values } = parseSeries(d);
    drawLineChart('desemprego', labels, values, '%');
  }

  // ── Gráfico IBC-Br (série 24364, mensal) ──
  async function chartIBCBr() {
    const d = await fetchBCBHistory(BCB.IBCBR, 24, 'monthly');
    if (!d) return;
    const { labels, values } = parseSeries(d);
    drawLineChart('ibcbr', labels, values, 'índice');
  }

  // ── Gráfico Dívida Bruta (série 13762, mensal, % PIB) ──
  async function chartDividaBruta() {
    const d = await fetchBCBHistory(BCB.DIVIDA_BRUTA, 36, 'monthly');
    if (!d) return;
    const { labels, values } = parseSeries(d);
    drawLineChart('divida-bruta', labels, values, '% PIB');
  }

  function loadCharts() {
    return Promise.allSettled([chartTaylor(), chartIPCA12m(), chartDolar(), chartDesemprego(), chartIBCBr(), chartDividaBruta()]);
  }

  // ═══════════ CALCULADORAS INTERATIVAS (módulo 20) ═══════════
  function initCalculators() {
    const $ = (id) => document.getElementById(id);
    const num = (id) => parseFloat(($(id) || {}).value) || 0;

    // 1. Juro Real (Fisher)
    function calcFisher() {
      const nom = num('calc-fisher-nom'), inf = num('calc-fisher-inf');
      const jr = ((1 + nom/100) / (1 + inf/100) - 1) * 100;
      const out = $('calc-fisher-out');
      if (out) { out.textContent = jr.toFixed(2).replace('.', ',') + '%';
        out.className = jr >= 0 ? 'up' : 'down'; }
    }
    // 2. Equivalência de taxas
    function calcEq() {
      const t = num('calc-eq-taxa'), de = num('calc-eq-de'), para = num('calc-eq-para');
      if (de <= 0) return;
      const eq = (Math.pow(1 + t/100, para/de) - 1) * 100;
      const out = $('calc-eq-out');
      if (out) out.textContent = eq.toFixed(4).replace('.', ',') + '%';
    }
    // 3. Valor presente
    function calcVP() {
      const vf = num('calc-vp-vf'), taxa = num('calc-vp-taxa'), n = num('calc-vp-n');
      const vp = vf / Math.pow(1 + taxa/100, n);
      const out = $('calc-vp-out');
      if (out) out.textContent = 'R$ ' + vp.toLocaleString('pt-BR', {minimumFractionDigits: 2, maximumFractionDigits: 2});
    }
    // 4. Break-even inflation
    function calcBE() {
      const pre = num('calc-be-pre'), real = num('calc-be-real');
      const be = ((1 + pre/100) / (1 + real/100) - 1) * 100;
      const out = $('calc-be-out');
      if (out) out.textContent = be.toFixed(2).replace('.', ',') + '%';
    }

    const calcs = [
      { fn: calcFisher, ids: ['calc-fisher-nom', 'calc-fisher-inf'] },
      { fn: calcEq,     ids: ['calc-eq-taxa', 'calc-eq-de', 'calc-eq-para'] },
      { fn: calcVP,     ids: ['calc-vp-vf', 'calc-vp-taxa', 'calc-vp-n'] },
      { fn: calcBE,     ids: ['calc-be-pre', 'calc-be-real'] },
    ];
    calcs.forEach(function(c) {
      c.ids.forEach(function(id) {
        const el = $(id);
        if (el) el.addEventListener('input', c.fn);
      });
      c.fn(); // calcula valor inicial
    });
  }

  // ═══════════ CURVA DE JUROS (ETTJ ANBIMA, via JSON estático) ═══════════
  async function loadCurvaDI() {
    try {
      const res = await fetch('/assets/data/curva-di.json?v=' + Date.now());
      if (!res.ok) throw new Error('HTTP ' + res.status);
      const j = await res.json();
      if (!j.vertices || !j.vertices.length) throw new Error('sem vértices');

      // Cards-resumo
      const v1 = j.vertices.find(v => v.du === 252) || j.vertices.find(v => v.anos >= 1);
      const v10 = j.vertices.find(v => v.du === 2520) || j.vertices[j.vertices.length - 1];
      if (v1) set('curva-curto', v1.taxa.toFixed(2).replace('.', ',') + '%');
      if (v10) set('curva-longo', v10.taxa.toFixed(2).replace('.', ',') + '%');
      if (v1 && v10) {
        const incl = Math.round((v10.taxa - v1.taxa) * 100); // bps
        const el = document.querySelector('[data-macro="curva-incl"]');
        if (el) {
          el.textContent = (incl >= 0 ? '+' : '') + incl + ' bps';
          el.classList.add(incl >= 0 ? 'up' : 'down');
        }
        const desc = document.querySelector('[data-macro="curva-incl-desc"]');
        if (desc) desc.textContent = incl >= 0 ? 'curva normal (positiva)' : 'curva invertida';
      }
      if (j.refdate) {
        const d = j.refdate.split('-');
        set('curva-data', d.length === 3 ? d[2] + '/' + d[1] + '/' + d[0] : j.refdate);
      }

      // Gráfico da curva
      const labels = j.vertices.map(v => v.label);
      const values = j.vertices.map(v => v.taxa);
      drawLineChart('curva', labels, values, '% a.a.');
    } catch (e) {
      console.warn('[Curva DI] falha:', e.message);
      set('curva-curto', 'N/D'); set('curva-longo', 'N/D');
      set('curva-incl', 'N/D'); set('curva-data', 'N/D');
    }
  }

  function loadAll(){
    initCalculators();
    Promise.allSettled([loadDolar(),loadEuro(),loadSelic(),loadCDI(),loadIPCA(),loadDesemprego(),loadIbov(),loadSP500(),loadNasdaq(),loadDow(),loadTreasury(),loadVIX(),loadJurosReais(),loadCommodities(),loadIBCBr(),loadFiscal(),loadIGPM(),loadINPC(),loadCurvaDI(),loadCharts()]);
  }

  if (document.readyState==='loading') document.addEventListener('DOMContentLoaded', loadAll);
  else loadAll();
})();
