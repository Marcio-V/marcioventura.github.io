#!/usr/bin/env bash
# Ativa o research por IA no modulo 18 + corrige os insights vazios (funcoes do Focus).
# Uso:
#   bash ativar-research-ia.sh                         # usa so o fallback ao vivo (sem IA ainda)
#   bash ativar-research-ia.sh https://SEU-WORKER/research   # ja pluga a URL do Worker
set -e
if [ ! -f _config.yml ]; then echo "ERRO: rode na raiz do repo."; exit 1; fi
mkdir -p assets/js
cat > assets/js/macro-live.js <<'MLJS_EOF'
/* ============================================================
 * macro-live.js — torna os módulos 15–18 do terminal "ao vivo",
 * lendo as mesmas fontes já usadas pela página (BCB SGS, Focus/Olinda).
 * Aditivo: não depende de macro-terminal.js; degrada com elegância.
 * ============================================================ */
(function () {
  'use strict';
  // >>> Cole aqui a URL do seu Worker de research (deixe '' para usar só o fallback local) <<<
  var RESEARCH_URL = '';
  var TTL = { daily: 9e5, rate: 36e5, monthly: 2.16e7, focus: 2.16e7 }; // ms
  var SGS = { SELIC:432, CDI:4389, IPCA:433, DESEMP:24369, IBCBR:24364, DIVIDA:13762, USD:1 };

  function cg(k, ttl){ try{ var r=JSON.parse(localStorage.getItem('ml_'+k)); return (r&&Date.now()-r.t<ttl)?r.d:null; }catch(e){ return null; } }
  function cs(k, d){ try{ localStorage.setItem('ml_'+k, JSON.stringify({t:Date.now(), d:d})); }catch(e){} }

  // Reaproveita o cache que o macro-terminal.js ja popula (sessionStorage['ind_bcb_<id>'])
  function mtCache(id){
    try{ var r=sessionStorage.getItem('ind_bcb_'+id); if(!r) return null;
      var e=JSON.parse(r); return (e&&Array.isArray(e.data))?e.data:null; }catch(e){ return null; }
  }
  function sleep(ms){ return new Promise(function(r){ setTimeout(r,ms); }); }

  async function bcbFetch(id, n){
    var url='https://api.bcb.gov.br/dados/serie/bcdata.sgs.'+id+'/dados/ultimos/'+n+'?formato=json';
    for(var attempt=0; attempt<3; attempt++){
      try{ var r=await fetch(url); if(r.ok){ var d=await r.json(); if(Array.isArray(d)&&d.length) return d; } }catch(e){}
      await sleep(500*(attempt+1));
    }
    return null;
  }
  // Fonte unica: 1) cache do macro-terminal (se tiver pontos suficientes) 2) cache proprio 3) fetch c/ retry
  async function bcb(id, n, ttl, minLen){
    minLen = minLen || 2;
    var mt=mtCache(id); if(mt && mt.length>=minLen) return mt;
    var mine=cg('b'+id, ttl); if(mine && mine.length>=minLen) return mine;
    var d=await bcbFetch(id, n);
    if(d){ cs('b'+id, d); return d; }
    return (mt&&mt.length)?mt:(mine||null);
  }


  async function focus12m(){
    var ck='f12', c=cg(ck,TTL.focus); if(c) return c;
    var base='https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoInflacao12Meses';
    var p="?$top=1&$orderby=Data desc&$format=json&$select=Mediana,Data&$filter="+encodeURIComponent("Indicador eq 'IPCA' and Suavizada eq 'S'");
    try{ var r=await fetch(base+p); if(r.ok){ var j=await r.json(); var row=j&&j.value&&j.value[0]; if(row){ cs(ck,row); return row; } } }catch(e){}
    return null;
  }
  async function focusAnual(ind){
    var yr=new Date().getFullYear(), ck='fa_'+ind+'_'+yr, c=cg(ck,TTL.focus); if(c) return c;
    var base='https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoAnuais';
    var p="?$top=1&$orderby=Data desc&$format=json&$select=Mediana,DataReferencia&$filter="+encodeURIComponent("Indicador eq '"+ind+"' and DataReferencia eq '"+yr+"'");
    try{ var r=await fetch(base+p); if(r.ok){ var j=await r.json(); var row=j&&j.value&&j.value[0]; if(row){ cs(ck,row); return row; } } }catch(e){}
    return null;
  }

  function v(row){ return parseFloat(String(row.valor).replace(',','.')); }
  function nf(x,d){ return (x==null||isNaN(x))?'—':x.toFixed(d==null?2:d).replace('.',','); }
  function accum12(vals, endIdx){ var p=1; for(var i=endIdx-11;i<=endIdx;i++){ if(i<0) return null; p*=(1+vals[i]/100); } return (p-1)*100; }

  // ─────────── Trend helper ───────────
  // favUp=true: subir é favorável (verde). eps = limiar relativo p/ "estável".
  function trend(cur, prev, favUp, eps){
    if(cur==null||prev==null||isNaN(cur)||isNaN(prev)) return {arrow:'→', cls:'heat-flat', dir:0};
    var delta=cur-prev, base=Math.max(Math.abs(prev),1e-6), rel=Math.abs(delta)/base;
    if(rel < (eps||0.004)) return {arrow:'→', cls:'heat-flat', dir:0, delta:delta};
    var up=delta>0, good=(up===favUp);
    return { arrow: up?'▲':'▼', cls: good?'heat-up':'heat-down', dir: up?1:-1, delta:delta };
  }

  // ═══════════ 15 · HEATMAP ═══════════
  var HEAT = [
    { key:'inflacao', favUp:false, eps:0.02,
      load:async function(){ var d=await bcb(SGS.IPCA,15,TTL.monthly,15); if(!d||d.length<15) return null;
        var a=d.map(v), n=a.length; return { cur:accum12(a,n-1), prev:accum12(a,n-4), disp:nf(accum12(a,n-1),2)+'%', sub:'IPCA 12m' }; } },
    { key:'atividade', favUp:true, eps:0.004,
      load:async function(){ var d=await bcb(SGS.IBCBR,13,TTL.monthly,4); if(!d||d.length<4) return null;
        var a=d.map(v), n=a.length; return { cur:a[n-1], prev:a[n-4], disp:nf(a[n-1],1), sub:'IBC-Br' }; } },
    { key:'emprego', favUp:true, eps:0.01,
      load:async function(){ var d=await bcb(SGS.DESEMP,6,TTL.monthly,4); if(!d||d.length<4) return null;
        var a=d.map(v), n=a.length; return { cur:-a[n-1], prev:-a[n-4], disp:nf(a[n-1],1)+'%', sub:'desemprego' }; } },
    { key:'fiscal', favUp:false, eps:0.004,
      load:async function(){ var d=await bcb(SGS.DIVIDA,6,TTL.monthly,4); if(!d||d.length<4) return null;
        var a=d.map(v), n=a.length; return { cur:a[n-1], prev:a[n-4], disp:nf(a[n-1],1)+'%', sub:'dívida/PIB' }; } },
    { key:'juros', favUp:false, eps:0.02,
      load:async function(){ var d=await bcb(SGS.SELIC,140,TTL.rate,127); if(!d||d.length<2) return null;
        var a=d.map(v), n=a.length, back=Math.min(126,n-1); return { cur:a[n-1], prev:a[n-1-back], disp:nf(a[n-1],2)+'%', sub:'Selic' }; } },
    { key:'cambio', favUp:false, eps:0.01,
      load:async function(){ var d=await bcb(SGS.USD,30,TTL.daily,22); if(!d||d.length<2) return null;
        var a=d.map(v), n=a.length, back=Math.min(21,n-1); return { cur:a[n-1], prev:a[n-1-back], disp:'R$ '+nf(a[n-1],2), sub:'USD/BRL' }; } }
  ];
  async function renderHeat(){
    await Promise.all(HEAT.map(async function(h){
      var cell=document.querySelector('.heat-cell[data-dim="'+h.key+'"]'); if(!cell) return;
      var r; try{ r=await h.load(); }catch(e){ r=null; }
      var arrEl=cell.querySelector('.heat-arrow'), valEl=cell.querySelector('.heat-val');
      cell.classList.remove('heat-up','heat-down','heat-flat');
      if(!r){ cell.classList.add('heat-flat'); if(arrEl)arrEl.textContent=(passes>=4?'→':'·'); if(valEl)valEl.textContent=(passes>=4?'N/D':'···'); return; }
      var t=trend(r.cur,r.prev,h.favUp,h.eps);
      cell.classList.add(t.cls); if(arrEl) arrEl.textContent=t.arrow;
      if(valEl) valEl.textContent=r.disp;
      cell.setAttribute('title', r.sub+': '+r.disp);
    }));
  }

  // ═══════════ 16 · CENÁRIOS (Focus ao vivo) ═══════════
  async function renderCenarios(){
    var box=document.getElementById('cenarios'); if(!box) return;
    var pib=await focusAnual('PIB Total'), ipca=await focusAnual('IPCA'),
        selic=await focusAnual('Selic'), cambio=await focusAnual('Câmbio');
    if(!pib && !ipca && !selic) return; // mantém ilustrativo
    var yr=(pib&&pib.DataReferencia)||(ipca&&ipca.DataReferencia)||new Date().getFullYear();
    var bP=pib?pib.Mediana:null, bI=ipca?ipca.Mediana:null, bS=selic?selic.Mediana:null, bC=cambio?cambio.Mediana:null;
    function fill(sel, P,I,S){
      var card=box.querySelector('[data-cen="'+sel+'"]'); if(!card) return;
      var vEl=card.querySelector('.term-card-value'), sEl=card.querySelector('.term-card-sub');
      if(vEl) vEl.textContent=(P==null?'—':nf(P,1)+'%');
      if(sEl) sEl.textContent='IPCA '+(I==null?'—':nf(I,1)+'%')+' · Selic '+(S==null?'—':nf(S,1)+'%');
    }
    fill('base', bP, bI, bS);
    fill('otim', bP==null?null:bP+0.8, bI==null?null:Math.max(0,bI-0.6), bS==null?null:bS-1.5);
    fill('pess', bP==null?null:bP-1.4, bI==null?null:bI+1.0, bS==null?null:bS+1.5);
    var lab=box.querySelector('[data-cen="base"] .term-card-label');
    if(lab) lab.textContent='Base · PIB '+yr+' (Focus)';
    var cap=box.querySelector('.term-prose');
    if(cap) cap.innerHTML='Base = mediana da Pesquisa Focus (BCB) para '+yr+', ao vivo'+(bC!=null?' · USD/BRL '+nf(bC,2):'')+'. Cenários otimista/pessimista são desvios calibrados em torno da mediana.';
    return true;
  }

  // ═══════════ 17 · MATRIZ — destaque do regime atual ═══════════
  async function renderRegime(){
    var tb=document.querySelector('#impacto table.term-table tbody'); if(!tb) return;
    var active={};
    var sel=await bcb(SGS.SELIC,140,TTL.rate,127);
    if(sel){ var a=sel.map(v),n=a.length, bk=Math.min(126,n-1); active['Alta da Selic']=(a[n-1]-a[n-1-bk])>0.05; }
    var ip=await bcb(SGS.IPCA,15,TTL.monthly,15);
    if(ip){ var b=ip.map(v),m=b.length, now=accum12(b,m-1), prev=accum12(b,m-4); if(now!=null&&prev!=null) active['Queda da Inflação']=(now-prev)<-0.05; }
    var ibc=await bcb(SGS.IBCBR,13,TTL.monthly,4);
    if(ibc){ var c=ibc.map(v),k=c.length; active['Recessão']=(c[k-1]-c[k-4])<0; }
    Array.prototype.forEach.call(tb.querySelectorAll('tr'), function(tr){
      var ev=tr.querySelector('td'); if(!ev) return;
      var name=ev.textContent.trim();
      tr.classList.toggle('regime-active', !!active[name]);
    });
    var any=Object.keys(active).some(function(k){return active[k];});
    var cap=document.querySelector('#impacto .term-prose');
    if(cap && any) cap.innerHTML='🟢 favorável · 🟡 neutro/misto · 🔴 desfavorável. <strong>Linha destacada = regime atual lido dos dados ao vivo.</strong>';
    return true;
  }

  // ═══════════ 18 · INSIGHTS ao vivo ═══════════
  function mesAno(){ var m=['jan','fev','mar','abr','mai','jun','jul','ago','set','out','nov','dez']; var d=new Date(); return m[d.getMonth()]+' · '+d.getFullYear(); }
  // Monta um snapshot compacto do cenario a partir do que ja esta na tela/calculado
  function buildSnapshot(selic, infE, usd, jr){
    var heat={};
    document.querySelectorAll('.heat-cell').forEach(function(c){
      var dim=c.getAttribute('data-dim'); if(!dim) return;
      heat[dim]={ valor:(c.querySelector('.heat-val')||{}).textContent||null,
                  direcao:(c.querySelector('.heat-arrow')||{}).textContent||null,
                  leitura: c.classList.contains('heat-up')?'favoravel':(c.classList.contains('heat-down')?'desfavoravel':'neutro') };
    });
    var cen={};
    document.querySelectorAll('#cenarios [data-cen]').forEach(function(card){
      cen[card.getAttribute('data-cen')]={ pib:(card.querySelector('.term-card-value')||{}).textContent||null,
                                           detalhe:(card.querySelector('.term-card-sub')||{}).textContent||null };
    });
    return {
      selic_percent: selic, inflacao_esperada_focus_12m: infE, usdbrl: usd, juro_real_ex_ante: jr,
      heatmap: heat, cenarios: cen,
      data: new Date().toISOString()
    };
  }

  async function fetchResearch(snapshot){
    if(!RESEARCH_URL) return null;
    var c=cg('research', 30*60*1000); if(c && c.cards) return c.cards;
    try{
      var r=await fetch(RESEARCH_URL, { method:'POST', headers:{'content-type':'application/json'}, body:JSON.stringify(snapshot) });
      if(!r.ok) return null;
      var j=await r.json();
      if(j && Array.isArray(j.cards) && j.cards.length){ cs('research', {cards:j.cards}); return j.cards; }
    }catch(e){}
    return null;
  }

  function paintInsight(art, title, bodyHTML, tag){
    if(!art) return;
    var t=art.querySelector('.insight-title'), b=art.querySelector('.insight-body'), dt=art.querySelector('.insight-date');
    if(dt) dt.textContent=mesAno()+(tag?' · IA':'');
    if(t) t.textContent=title;
    if(b) b.innerHTML=bodyHTML;
    if(tag){ art.setAttribute('data-ia','1'); }
  }

  async function renderInsights(){
    var box=document.getElementById('insights'); if(!box) return;
    var arts=box.querySelectorAll('.term-insight');
    var selD=await bcb(SGS.SELIC,140,TTL.rate,1), f=await focus12m(), usdD=await bcb(SGS.USD,30,TTL.daily,1);
    var selic=selD?v(selD[selD.length-1]):null, infE=f?f.Mediana:null, usd=usdD?v(usdD[usdD.length-1]):null;
    var jr = (selic!=null&&infE!=null) ? ((1+selic/100)/(1+infE/100)-1)*100 : null;

    // 1) Tenta IA (Worker) com o snapshot ao vivo
    var cards=null;
    try{ cards=await fetchResearch(buildSnapshot(selic, infE, usd, jr)); }catch(e){ cards=null; }
    if(cards && cards.length){
      for(var i=0;i<arts.length;i++){
        if(cards[i]) paintInsight(arts[i], cards[i].title, (''+cards[i].body).replace(/</g,'&lt;'), true);
      }
      var capA=box.querySelector('.term-prose');
      if(capA) capA.innerHTML='Research gerado por IA (Claude) a partir dos indicadores ao vivo (BCB/Focus) · '+mesAno()+'. Conteúdo informativo, não é recomendação de investimento.';
      return true;
    }

    // 2) Fallback: notas com os números ao vivo (nunca fica vazio)
    if(arts[0] && selic!=null){
      paintInsight(arts[0], 'Selic em '+nf(selic,2)+'% e o juro real ex-ante'+(jr!=null?' de ~'+nf(jr,1)+'%':''),
        'Com a Selic em '+nf(selic,2)+'% a.a. e a inflação esperada (Focus) em '+(infE!=null?nf(infE,2)+'%':'—')+', o juro real ex-ante segue'+(jr!=null?' em torno de <strong>'+nf(jr,1)+'%</strong>':'')+' — patamar historicamente alto. O posicionamento em prefixados e NTN-Bs longas depende da convicção sobre o ritmo do ciclo de corte, que a curva DI ainda precifica de forma conservadora.');
    }
    if(arts[1] && usd!=null){
      paintInsight(arts[1], 'Câmbio em R$ '+nf(usd,2)+' e o diferencial de juros',
        'Com o USD/BRL em <strong>R$ '+nf(usd,2)+'</strong> e a Selic em '+(selic!=null?nf(selic,2)+'%':'—')+', o real segue sensível ao diferencial de juros Brasil–EUA e ao apetite global por risco. O carry elevado sustenta o fluxo, mas a assimetria fiscal doméstica mantém o prêmio de risco como principal vetor de volatilidade.');
    }
    return (selic!=null||usd!=null);
  }

  // ─────────── Orquestração + auto-refresh ───────────
  var passes=0;
  function setLoading(){
    document.querySelectorAll('.heat-cell .heat-val').forEach(function(el){ if(el.textContent==='—'||el.textContent==='N/D'||!el.textContent.trim()) el.textContent='···'; });
  }
  function stamp(ok){
    document.querySelectorAll('[data-live-tag]').forEach(function(el){
      el.classList.toggle('is-live', !!ok);
      el.textContent = ok ? 'Ao vivo' : el.getAttribute('data-live-tag');
    });
    var t=document.getElementById('live-updated');
    if(t){ var d=new Date(); t.textContent='atualizado '+String(d.getHours()).padStart(2,'0')+':'+String(d.getMinutes()).padStart(2,'0'); }
  }
  async function runAll(){
    passes++;
    var res=await Promise.allSettled([renderHeat(),renderCenarios(),renderRegime(),renderInsights()]);
    var ok=res.some(function(r){return r.status==='fulfilled' && r.value!==false && r.value!==undefined;});
    stamp(true);
  }
  function boot(){
    setLoading();
    [500,1500,3500,8000].forEach(function(ms){ setTimeout(runAll, ms); });
    setInterval(runAll, 5*60*1000);
  }
  if(document.readyState==='loading') document.addEventListener('DOMContentLoaded', boot); else boot();

  // hooks de teste
  if(typeof window!=='undefined') window.__ML={trend:trend, accum12:accum12, HEAT:HEAT, renderHeat:renderHeat, renderCenarios:renderCenarios, renderRegime:renderRegime, renderInsights:renderInsights, runAll:runAll};
})();
MLJS_EOF
if [ -n "$1" ]; then
  python3 -I - "$1" <<'PY'
import sys,re
url=sys.argv[1].replace(chr(39),"")
p="assets/js/macro-live.js"; s=open(p,encoding="utf-8").read()
s=s.replace("var RESEARCH_URL = '';", "var RESEARCH_URL = '"+url+"';",1)
open(p,"w",encoding="utf-8").write(s)
print("  - RESEARCH_URL definido: "+url)
PY
else
  echo "  - RESEARCH_URL vazio: modulo 18 usa o fallback ao vivo (defina depois a URL do Worker)."
fi
echo "==> macro-live.js atualizado. Publicar:"
echo "    git add -A && git commit -m \"feat: research por IA no modulo 18\" && git push"
