#!/usr/bin/env bash
# Curva de Juros (modulo 10): baixa o CSV do Tesouro VIA SEU WORKER (contorna bloqueio de IP do
# GitHub Actions no servidor do Tesouro) e sobrepoe hoje x 1 semana/mes/ano.
# Uso: bash curva-tesouro.sh https://SEU-WORKER.workers.dev/   (ou sem URL)
set -e
if [ ! -f _config.yml ]; then echo "ERRO: rode na raiz do repo."; exit 1; fi
mkdir -p scripts assets/js
cat > scripts/atualizar_curva_di.py <<'PY_EOF'
#!/usr/bin/env python3
"""
Atualiza a curva prefixada (Tesouro Direto) a partir do CSV oficial do
Tesouro Transparente, com as curvas de hoje, 1 semana, 1 mês e 1 ano atrás.
Executado pelo GitHub Action diariamente. Fonte (dataset público):
https://www.tesourotransparente.gov.br/ckan/dataset/taxas-dos-titulos-ofertados-pelo-tesouro-direto
Falha com exit!=0 se não conseguir dados frescos (para o Action ficar VERMELHO
e a defasagem ser visível, em vez de congelar em silêncio).
"""
import csv, io, json, sys
from datetime import datetime, timedelta
from urllib.request import urlopen, Request

# Fonte: o CSV é baixado via proxy no Cloudflare Worker (os IPs do GitHub Actions
# são bloqueados pelo servidor do Tesouro). Reserva: download direto.
WORKER_CSV = "https://round-dawn-e84d.m-matheus-baptista.workers.dev/csv"
TESOURO_DIRETO = ("https://www.tesourotransparente.gov.br/ckan/dataset/df56aa42-484a-4a59-8184-7676580c81e3/"
                  "resource/796d2059-14e9-44e3-80c9-2d9e30b405c1/download/PrecoTaxaTesouroDireto.csv")
BROWSER_HDRS = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/122.0 Safari/537.36",
                "Accept":"text/csv,text/plain,*/*", "Referer":"https://www.tesourotransparente.gov.br/"}

PREFIXADOS = {"Tesouro Prefixado", "Tesouro Prefixado com Juros Semestrais"}
TENORS = [0.5, 1, 2, 3, 5, 7, 10]            # anos p/ grade comum
TENOR_LABELS = {0.5:"6M",1:"1A",2:"2A",3:"3A",5:"5A",7:"7A",10:"10A"}
JANELAS = {"hoje":0, "semana":7, "mes":30, "ano":365}
WINDOW_BACK = 8                               # recua até N dias p/ achar dia útil

def pdate(s): return datetime.strptime(s.strip(), "%d/%m/%Y").date()
def pnum(s):  return float(s.strip().replace(".", "").replace(",", "."))

import time
def _tentar(url, tentativas=3):
    for i in range(tentativas):
        try:
            req = Request(url, headers=BROWSER_HDRS)
            r = urlopen(req, timeout=180)
            print(f"  OK {url} — HTTP {getattr(r,'status','?')} ({r.headers.get('Content-Type')})", file=sys.stderr)
            return io.TextIOWrapper(r, encoding="latin-1", newline="")
        except Exception as e:
            print(f"  tentativa {i+1} falhou em {url}: {e}", file=sys.stderr)
            time.sleep(3*(i+1))
    return None

def baixar_linhas():
    for url in (WORKER_CSV, TESOURO_DIRETO):
        print(f"  Baixando CSV de: {url}", file=sys.stderr)
        stream = _tentar(url)
        if stream is not None:
            return stream
    raise RuntimeError("nao foi possivel baixar o CSV (Worker e Tesouro direto falharam)")

def coletar(alvos):
    """Lê o CSV uma vez; guarda, por data-base dentro das janelas-alvo, os pontos prefixados."""
    low = min(a - timedelta(days=WINDOW_BACK) for a in alvos.values())
    high = max(alvos.values())
    porbase = {}  # date -> list[(ttm_anos, venc, taxa)]
    reader = csv.reader(baixar_linhas(), delimiter=";")
    header = next(reader, None)
    print(f"  Cabecalho CSV: {header}", file=sys.stderr)
    nlin = 0; npre = 0
    for row in reader:
        nlin += 1
        if len(row) < 4: continue
        tipo = row[0].strip()
        if tipo not in PREFIXADOS: continue
        npre += 1
        try:
            venc = pdate(row[1]); base = pdate(row[2]); taxa = pnum(row[3])  # Taxa Compra Manhã
        except (ValueError, IndexError):
            continue
        if base < low or base > high: continue
        ttm = (venc - base).days / 365.25
        if ttm <= 0 or not (0 < taxa < 100): continue
        porbase.setdefault(base, []).append((ttm, venc.isoformat(), taxa))
    print(f"  Linhas lidas: {nlin} · prefixados: {npre} · datas-base na janela: {len(porbase)}", file=sys.stderr)
    return porbase

def interp(pts, tenor):
    """Interpola linearmente a taxa no prazo 'tenor' (anos). pts ordenado por ttm."""
    xs = [p[0] for p in pts]; ys = [p[2] for p in pts]
    if tenor <= xs[0]:  return ys[0]
    if tenor >= xs[-1]: return ys[-1]
    for i in range(1, len(xs)):
        if tenor <= xs[i]:
            x0,x1,y0,y1 = xs[i-1],xs[i],ys[i-1],ys[i]
            return y0 + (y1-y0)*(tenor-x0)/(x1-x0)
    return ys[-1]

def curva_para(porbase, alvo):
    """Pega a data-base disponível <= alvo mais recente e monta a curva na grade de tenores."""
    bases = sorted([b for b in porbase if b <= alvo], reverse=True)
    if not bases: return None
    base = bases[0]
    pts = sorted(porbase[base], key=lambda x: x[0])
    if len(pts) < 2: return None
    grade = [{"tenor": t, "label": TENOR_LABELS[t], "taxa": round(interp(pts, t), 4)} for t in TENORS]
    return {"refdate": base.strftime("%d/%m/%Y"), "pts": grade}

def main():
    hoje = datetime.now().date()
    alvos = {k: hoje - timedelta(days=d) for k, d in JANELAS.items()}
    try:
        porbase = coletar(alvos)
    except Exception as e:
        print(f"ERRO: falha ao baixar/ler o CSV do Tesouro ({e})", file=sys.stderr)
        sys.exit(1)
    curvas = {}
    for k, alvo in alvos.items():
        c = curva_para(porbase, alvo)
        if c: curvas[k] = c
    if "hoje" not in curvas:
        print("ERRO: sem curva recente (hoje) — não atualiza.", file=sys.stderr)
        sys.exit(1)
    saida = {
        "refdate": datetime.strptime(curvas["hoje"]["refdate"], "%d/%m/%Y").strftime("%Y-%m-%d"),
        "fonte": "Tesouro Direto — prefixados (LTN/NTN-F), via Tesouro Transparente",
        "atualizado_em": hoje.strftime("%Y-%m-%d"),
        "curvas": curvas,
    }
    with open("assets/data/curva-di.json", "w", encoding="utf-8") as f:
        json.dump(saida, f, ensure_ascii=False, indent=2)
    print(f"✓ Curva atualizada: ref {saida['refdate']} · janelas: {', '.join(curvas.keys())}")

if __name__ == "__main__":
    main()
PY_EOF
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
  async function focusAnual(ind, year){
    var yr=year||new Date().getFullYear(), ck='fa_'+ind+'_'+yr, c=cg(ck,TTL.focus); if(c) return c;
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

  function paintFallback(arts, selic, infE, usd, jr){
    if(arts[0] && selic!=null && arts[0].getAttribute('data-ia')!=='1'){
      paintInsight(arts[0], 'Selic em '+nf(selic,2)+'% e o juro real ex-ante'+(jr!=null?' de ~'+nf(jr,1)+'%':''),
        'Com a Selic em '+nf(selic,2)+'% a.a. e a inflação esperada (Focus) em '+(infE!=null?nf(infE,2)+'%':'—')+', o juro real ex-ante segue'+(jr!=null?' em torno de <strong>'+nf(jr,1)+'%</strong>':'')+' — patamar historicamente alto. O posicionamento em prefixados e NTN-Bs longas depende da convicção sobre o ritmo do ciclo de corte, que a curva DI ainda precifica de forma conservadora.', false);
    }
    if(arts[1] && usd!=null && arts[1].getAttribute('data-ia')!=='1'){
      paintInsight(arts[1], 'Câmbio em R$ '+nf(usd,2)+' e o diferencial de juros',
        'Com o USD/BRL em <strong>R$ '+nf(usd,2)+'</strong> e a Selic em '+(selic!=null?nf(selic,2)+'%':'—')+', o real segue sensível ao diferencial de juros Brasil–EUA e ao apetite global por risco. O carry elevado sustenta o fluxo, mas a assimetria fiscal doméstica mantém o prêmio de risco como principal vetor de volatilidade.', false);
    }
  }

  async function renderInsights(){
    var box=document.getElementById('insights'); if(!box) return;
    var arts=box.querySelectorAll('.term-insight');
    var selD=await bcb(SGS.SELIC,140,TTL.rate,1), f=await focus12m(), usdD=await bcb(SGS.USD,30,TTL.daily,1);
    var selic=selD?v(selD[selD.length-1]):null, infE=f?f.Mediana:null, usd=usdD?v(usdD[usdD.length-1]):null;
    var jr = (selic!=null&&infE!=null) ? ((1+selic/100)/(1+infE/100)-1)*100 : null;

    // 1) Pinta JÁ o fallback ao vivo (nunca fica vazio)
    paintFallback(arts, selic, infE, usd, jr);

    // 2) Em paralelo, tenta a IA e substitui quando chegar
    if(RESEARCH_URL){
      var cards=null;
      try{ cards=await fetchResearch(buildSnapshot(selic, infE, usd, jr)); }catch(e){ cards=null; }
      if(cards && cards.length){
        for(var i=0;i<arts.length;i++){ if(cards[i]) paintInsight(arts[i], cards[i].title, (''+cards[i].body).replace(/</g,'&lt;'), true); }
        var capA=box.querySelector('.term-prose');
        if(capA) capA.innerHTML='Research gerado por IA (Claude) a partir dos indicadores ao vivo (BCB/Focus) · '+mesAno()+'. Conteúdo informativo, não é recomendação de investimento.';
      }
    }
    return (selic!=null||usd!=null);
  }

  // ═══════════ 04 · POLÍTICA MONETÁRIA (Selic · IPCA 12M · meta/bandas · Taylor · forecast) ═══════════
  async function bcbHist(id, monthsBack){
    var ck='h'+id+'_'+monthsBack, c=cg(ck,TTL.monthly); if(c) return c;
    var hoje=new Date(), ini=new Date(); ini.setMonth(ini.getMonth()-monthsBack);
    function fmt(d){ return String(d.getDate()).padStart(2,'0')+'/'+String(d.getMonth()+1).padStart(2,'0')+'/'+d.getFullYear(); }
    var url='https://api.bcb.gov.br/dados/serie/bcdata.sgs.'+id+'/dados?formato=json&dataInicial='+fmt(ini)+'&dataFinal='+fmt(hoje);
    for(var i=0;i<3;i++){ try{ var r=await fetch(url); if(r.ok){ var d=await r.json(); if(Array.isArray(d)&&d.length){ cs(ck,d); return d; } } }catch(e){} await sleep(600*(i+1)); }
    return null;
  }
  // Meta e bandas de tolerância oficiais (CMN) por ano
  function metaInfl(year){
    var y=parseInt(year,10);
    var meta = y<=2016?4.5 : y===2017?4.5 : y===2018?4.5 : y===2019?4.25 : y===2020?4.0 : y===2021?3.75 : y===2022?3.5 : y===2023?3.25 : 3.0;
    var band = y<=2016?2.0 : 1.5;
    return { meta:meta, lo:meta-band, hi:meta+band };
  }
  var monChart=null, monHist=null;
  function taylorP(){ function g(id,def){ var e=document.getElementById(id); return e?parseFloat(e.value):def; }
    return { r:g('tr-rstar',4.5), pi:g('tr-pistar',3.0), a:g('tr-alpha',0.5), b:g('tr-beta',0.5), h:g('tr-hiato',0.0) }; }
  function taylorLine(){ if(!monHist) return []; var p=taylorP();
    return monHist.ipca.map(function(pi){ return (pi==null)?null:(p.r+pi+p.a*(pi-p.pi)+p.b*p.h); }); }

  // Busca intervalo [fromM..toM] meses atrás (série diária -> <=10 anos por chamada)
  async function bcbRange(id, fromM, toM){
    var hoje=new Date();
    var ini=new Date(); ini.setMonth(ini.getMonth()-fromM);
    var fim=new Date(); fim.setMonth(fim.getMonth()-toM);
    function fmt(d){ return String(d.getDate()).padStart(2,'0')+'/'+String(d.getMonth()+1).padStart(2,'0')+'/'+d.getFullYear(); }
    var url='https://api.bcb.gov.br/dados/serie/bcdata.sgs.'+id+'/dados?formato=json&dataInicial='+fmt(ini)+'&dataFinal='+fmt(fim);
    for(var i=0;i<3;i++){ try{ var r=await fetch(url); if(r.ok){ var d=await r.json(); if(Array.isArray(d)&&d.length) return d; } }catch(e){} await sleep(600*(i+1)); }
    return null;
  }
  // Selic diária desde ~2015 em duas janelas (contorna o limite de 10 anos)
  async function selicDaily(){
    var ck='selicD', c=cg(ck,TTL.rate); if(c) return c;
    var a=await bcbRange(SGS.SELIC,135,16), b=await bcbRange(SGS.SELIC,16,0);
    var out=(a||[]).concat(b||[]);
    if(out.length){ cs(ck,out); return out; }
    return null;
  }

  async function buildMonHist(){
    var selicRaw=await selicDaily(), ipcaRaw=await bcbHist(SGS.IPCA,135);
    if(!selicRaw||!ipcaRaw) return false;
    var selicByMonth={}; selicRaw.forEach(function(d){ selicByMonth[d.data.substring(3)]=parseFloat(String(d.valor).replace(',','.')); });
    var iv=ipcaRaw.map(function(x){ return { mk:x.data.substring(3), v:parseFloat(String(x.valor).replace(',','.')) }; });
    var ipca12={}; for(var i=11;i<iv.length;i++){ var w=iv.slice(i-11,i+1); ipca12[iv[i].mk]=+(((w.reduce(function(s,x){return s*(1+x.v/100);},1))-1)*100).toFixed(2); }
    var labels=[],selic=[],ipca=[];
    Object.keys(selicByMonth).forEach(function(mk){ if(ipca12[mk]!==undefined){ labels.push(mk); selic.push(selicByMonth[mk]); ipca.push(ipca12[mk]); } });
    var ord=labels.map(function(mk,idx){ return {mk:mk,idx:idx,key:mk.substring(3)+mk.substring(0,2)}; }).sort(function(a,b){ return a.key.localeCompare(b.key); });
    labels=ord.map(function(o){return o.mk;}); var selic2=ord.map(function(o){return selic[o.idx];}); var ipca2=ord.map(function(o){return ipca[o.idx];});
    var meta=labels.map(function(l){return metaInfl(l.substring(3)).meta;});
    var lo=labels.map(function(l){return metaInfl(l.substring(3)).lo;});
    var hi=labels.map(function(l){return metaInfl(l.substring(3)).hi;});
    monHist={ labels:labels, selic:selic2, ipca:ipca2, meta:meta, lo:lo, hi:hi, nHist:labels.length,
              fcSelic:labels.map(function(){return null;}), fcIpca:labels.map(function(){return null;}) };
    // conecta o forecast ao último ponto real
    var n=monHist.nHist; monHist.fcSelic[n-1]=monHist.selic[n-1]; monHist.fcIpca[n-1]=monHist.ipca[n-1];
    // forecast Focus: fim do ano atual e do próximo
    try{
      var yNow=new Date().getFullYear(), anos=[yNow, yNow+1];
      for(var k=0;k<anos.length;k++){
        var yy=anos[k], lbl='dez/'+String(yy).slice(2);
        if(monHist.labels.indexOf(lbl)!==-1) continue;
        var fs=await focusAnual('Selic', yy), fi=await focusAnual('IPCA', yy);
        var sVal=fs&&typeof fs.Mediana==='number'?fs.Mediana:null, iVal=fi&&typeof fi.Mediana==='number'?fi.Mediana:null;
        if(sVal==null && iVal==null) continue;
        monHist.labels.push(lbl);
        monHist.selic.push(null); monHist.ipca.push(null);
        var m=metaInfl(yy); monHist.meta.push(m.meta); monHist.lo.push(m.lo); monHist.hi.push(m.hi);
        monHist.fcSelic.push(sVal); monHist.fcIpca.push(iVal);
      }
    }catch(e){}
    return true;
  }

  function drawMon(canvas){
    var H=monHist;
    var dsTaylor={ label:'Taylor (regra)', data:taylorLine(), borderColor:'#f0a830', backgroundColor:'transparent', borderWidth:2, borderDash:[5,4], fill:false, tension:0.2, pointRadius:0, pointHoverRadius:4 };
    var cfg={ type:'line',
      data:{ labels:H.labels, datasets:[
        { label:'_lo', data:H.lo, borderColor:'rgba(139,152,165,0.25)', borderWidth:1, borderDash:[2,3], fill:false, pointRadius:0, tension:0.1 },
        { label:'Banda de tolerância', data:H.hi, borderColor:'rgba(139,152,165,0.25)', backgroundColor:'rgba(139,152,165,0.06)', borderWidth:1, borderDash:[2,3], fill:'-1', pointRadius:0, tension:0.1 },
        { label:'Meta de inflação', data:H.meta, borderColor:'#8b98a5', borderWidth:1.5, borderDash:[6,4], fill:false, pointRadius:0, tension:0.1 },
        { label:'Selic', data:H.selic, borderColor:'#4da3ff', backgroundColor:'rgba(77,163,255,0.08)', borderWidth:2, fill:true, tension:0.2, pointRadius:0, pointHoverRadius:4, spanGaps:false },
        { label:'IPCA 12M', data:H.ipca, borderColor:'#e6edf3', borderWidth:2.4, fill:false, tension:0.2, pointRadius:0, pointHoverRadius:4, spanGaps:false },
        dsTaylor,
        { label:'Selic (Focus)', data:H.fcSelic, borderColor:'#4da3ff', borderWidth:2, borderDash:[2,2], fill:false, tension:0.2, pointRadius:0, pointHoverRadius:4, spanGaps:true },
        { label:'IPCA proj. (Focus)', data:H.fcIpca, borderColor:'#e6edf3', borderWidth:2, borderDash:[2,2], fill:false, tension:0.2, pointRadius:0, pointHoverRadius:4, spanGaps:true }
      ]},
      options:{ responsive:true, maintainAspectRatio:false, interaction:{intersect:false,mode:'index'},
        plugins:{ legend:{ display:true, labels:{ color:'#8b98a5', font:{size:10}, usePointStyle:true, boxWidth:8, padding:8,
            filter:function(it){ return it.text && it.text.charAt(0)!=='_'; } } },
          tooltip:{ backgroundColor:'#161c21', borderColor:'#2a3138', borderWidth:1, titleColor:'#e6e6e6', bodyColor:'#e6e6e6',
            filter:function(it){ return it.dataset.label && it.dataset.label.charAt(0)!=='_'; },
            callbacks:{ label:function(c){ return c.dataset.label+': '+(c.parsed.y!=null?c.parsed.y.toFixed(2).replace('.',',')+'%':'—'); } } } },
        scales:{ x:{ grid:{color:'rgba(255,255,255,0.06)'}, ticks:{color:'#8b98a5', maxTicksLimit:10, font:{size:9}} },
          y:{ grid:{color:'rgba(255,255,255,0.06)'}, ticks:{color:'#8b98a5', font:{size:9}, callback:function(v){return v+'%';}} } } } };
    var prev=(window.Chart&&Chart.getChart)?Chart.getChart(canvas):null; if(prev) prev.destroy();
    monChart=new Chart(canvas, cfg);
  }

  function updateTaylorReadout(){
    var el=document.getElementById('tr-current'); if(!el||!monHist) return;
    var i=monHist.nHist-1, s=monHist.selic[i], tl=taylorLine()[i];
    if(s==null||tl==null) return; var gap=s-tl, sinal=gap>=0?'acima':'abaixo';
    el.innerHTML='Hoje: Selic '+s.toFixed(2).replace('.',',')+'% vs Taylor '+tl.toFixed(2).replace('.',',')+'% → política <strong style="color:'+(gap>=0?'#3fb950':'#f85149')+'">'+Math.abs(gap).toFixed(2).replace('.',',')+' p.p. '+sinal+'</strong>';
  }
  function bindTaylor(){
    var map=[['tr-rstar','tr-rstar-v',1],['tr-pistar','tr-pistar-v',1],['tr-alpha','tr-alpha-v',2],['tr-beta','tr-beta-v',2],['tr-hiato','tr-hiato-v',1]];
    map.forEach(function(m){
      var old=document.getElementById(m[0]); if(!old) return;
      var inp=old.cloneNode(true); old.parentNode.replaceChild(inp, old); // remove listeners antigos
      var out=document.getElementById(m[1]);
      inp.addEventListener('input', function(){
        if(out) out.textContent=parseFloat(inp.value).toFixed(m[2]).replace('.',',');
        if(monChart){ var ds=monChart.data.datasets.filter(function(d){return d.label==='Taylor (regra)';})[0]; if(ds){ ds.data=taylorLine(); monChart.update('none'); } }
        updateTaylorReadout();
      });
    });
  }

  async function renderMonetaria(){
    var canvas=document.querySelector('canvas[data-chart="taylor"]'); if(!canvas||typeof Chart==='undefined') return;
    if(!monHist){ var ok=await buildMonHist(); if(!ok) return; }
    drawMon(canvas); bindTaylor(); updateTaylorReadout();
    var ti=document.querySelector('#monetaria .term-chart-title');
    if(ti) ti.textContent='Selic · IPCA 12M · meta e bandas · Regra de Taylor — desde 2016 (forecast Focus)';
    return true;
  }

  // ═══════════ 21 · COMPARADOR DE ATIVOS (renda fixa) ═══════════
  function initComparador(){
    var sec=document.getElementById('comparador'); if(!sec) return;
    var canvas=sec.querySelector('canvas[data-chart="comparador"]');
    function g(id){ return document.getElementById(id); }
    function num(id){ var e=g(id); return e?parseFloat(e.value)||0:0; }
    function sval(id){ var e=g(id); return e?e.value:''; }
    function brl(x){ return 'R$ '+Number(x).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2}); }
    function pct(x){ return (x*100).toFixed(2).replace('.',',')+'%'; }
    function aliqRF(dias){ return dias<=180?22.5:dias<=360?20:dias<=720?17.5:15; }
    function rAnual(idx,taxa,cdi,ipca){ if(idx==='pre')return taxa/100; if(idx==='cdi')return (cdi/100)*(taxa/100); return (1+ipca/100)*(1+taxa/100)-1; }
    function serie(pv,r,meses,isento){ var a=[]; for(var m=0;m<=meses;m++){ var fv=pv*Math.pow(1+r,m/12), gain=fv-pv, al=isento?0:aliqRF(m*30); a.push(+(pv+gain*(1-al/100)).toFixed(2)); } return a; }
    function asset(p){
      var cdi=num('cmp-cdi'), ipca=num('cmp-ipca');
      var idx=sval('cmp-'+p+'-idx'), taxa=num('cmp-'+p+'-taxa'), meses=Math.max(1,Math.round(num('cmp-'+p+'-prazo'))), pv=Math.max(0,num('cmp-'+p+'-pv')), isento=sval('cmp-'+p+'-trib')==='isento';
      var r=rAnual(idx,taxa,cdi,ipca), sr=serie(pv,r,meses,isento), netFV=sr[sr.length-1], aliq=isento?0:aliqRF(meses*30);
      var liqAA=pv>0?Math.pow(netFV/pv,12/meses)-1:0;
      return {idx:idx,taxa:taxa,meses:meses,pv:pv,isento:isento,r:r,serie:sr,netFV:netFV,aliq:aliq,liqAA:liqAA,brutoAA:r};
    }
    var chart=null;
    function draw(A,B){
      if(!canvas||typeof Chart==='undefined') return;
      var maxM=Math.max(A.meses,B.meses), labels=[]; for(var m=0;m<=maxM;m++) labels.push(m);
      function pad(sr){ var o=sr.slice(); while(o.length<=maxM) o.push(null); return o; }
      var cfg={ type:'line', data:{ labels:labels, datasets:[
          { label:'Ativo A (líquido)', data:pad(A.serie), borderColor:'#4da3ff', backgroundColor:'rgba(77,163,255,0.08)', borderWidth:2, fill:true, tension:0.15, pointRadius:0, pointHoverRadius:4, spanGaps:false },
          { label:'Ativo B (líquido)', data:pad(B.serie), borderColor:'#f0a830', backgroundColor:'transparent', borderWidth:2, fill:false, tension:0.15, pointRadius:0, pointHoverRadius:4, spanGaps:false }
        ]},
        options:{ responsive:true, maintainAspectRatio:false, interaction:{intersect:false,mode:'index'},
          plugins:{ legend:{ display:true, labels:{ color:'#8b98a5', font:{size:10}, usePointStyle:true, boxWidth:8 } },
            tooltip:{ backgroundColor:'#161c21', borderColor:'#2a3138', borderWidth:1, titleColor:'#e6e6e6', bodyColor:'#e6e6e6',
              callbacks:{ title:function(it){ return 'Mês '+it[0].label; }, label:function(c){ return c.dataset.label+': '+(c.parsed.y!=null?'R$ '+c.parsed.y.toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2}):'—'); } } } },
          scales:{ x:{ title:{display:true,text:'Meses',color:'#8b98a5',font:{size:10}}, grid:{color:'rgba(255,255,255,0.06)'}, ticks:{color:'#8b98a5',font:{size:9},maxTicksLimit:12} },
            y:{ grid:{color:'rgba(255,255,255,0.06)'}, ticks:{color:'#8b98a5',font:{size:9},callback:function(v){return 'R$ '+(v>=1000?(v/1000).toFixed(1)+'k':v);}} } } } };
      var prev=(window.Chart&&Chart.getChart)?Chart.getChart(canvas):null; if(prev)prev.destroy();
      chart=new Chart(canvas,cfg);
    }
    function fmtOut(x){
      var ind = x.idx==='pre'?'Pré '+x.taxa.toFixed(2).replace('.',',')+'%' : x.idx==='cdi'?x.taxa.toFixed(0)+'% CDI' : 'IPCA+'+x.taxa.toFixed(2).replace('.',',')+'%';
      return '<div class="cmp-line">Bruto: <b>'+pct(x.brutoAA)+' a.a.</b> ('+ind+')</div>'+
             '<div class="cmp-line">IR no vencimento: <b>'+(x.isento?'isento':x.aliq.toFixed(1).replace('.',',')+'%')+'</b></div>'+
             '<div class="cmp-line">Líquido a.a.: <b class="cmp-hl">'+pct(x.liqAA)+'</b></div>'+
             '<div class="cmp-line">Montante líq. ('+x.meses+'m): <b>'+brl(x.netFV)+'</b></div>';
    }
    function verdict(A,B){
      var el=g('cmp-verdict'); if(!el) return;
      var dAA=(A.liqAA-B.liqAA)*100;
      var win = Math.abs(dAA)<0.01 ? null : (A.liqAA>B.liqAA?'A':'B');
      var txt;
      if(!win){ txt='Os dois ativos empatam em rentabilidade líquida (~'+pct(A.liqAA)+' a.a.).'; }
      else{
        var w=win==='A'?A:B, l=win==='A'?B:A, cor=win==='A'?'#4da3ff':'#f0a830';
        txt='<b style="color:'+cor+'">Ativo '+win+' rende mais</b>: '+pct(w.liqAA)+' a.a. líquido vs '+pct(l.liqAA)+' do Ativo '+(win==='A'?'B':'A')+' (Δ '+Math.abs(dAA).toFixed(2).replace('.',',')+' p.p.).';
        // gross-up quando um é isento e o outro tributado
        if(w.isento && !l.isento){ txt+=' Para empatar, o tributado precisaria render ~'+pct(w.liqAA/(1-l.aliq/100))+' a.a. líquido equivalente bruto.'; }
        if(!w.isento && l.isento){ txt+=' Mesmo pagando IR, o Ativo '+win+' supera o isento neste prazo.'; }
      }
      el.innerHTML=txt;
    }
    function recompute(){ var A=asset('a'), B=asset('b'); var ao=g('cmp-a-out'),bo=g('cmp-b-out'); if(ao)ao.innerHTML=fmtOut(A); if(bo)bo.innerHTML=fmtOut(B); draw(A,B); verdict(A,B); }
    // pré-preenche CDI com o valor ao vivo, se houver
    var cdiLive=document.querySelector('[data-macro="cdi"]'); if(cdiLive){ var v=parseFloat((cdiLive.textContent||'').replace('%','').replace(',','.')); if(isFinite(v)&&v>0&&g('cmp-cdi')) g('cmp-cdi').value=v.toFixed(2); }
    sec.querySelectorAll('input,select').forEach(function(e){ e.addEventListener('input',recompute); e.addEventListener('change',recompute); });
    recompute();
  }

  // ═══════════ 10 · CURVA DE JUROS (prefixada Tesouro, hoje vs 1s/1m/1a) ═══════════
  async function renderCurva(){
    var canvas=document.querySelector('canvas[data-chart="curva"]');
    var J=null; try{ J=await fetch('/assets/data/curva-di.json?v='+Math.floor(Date.now()/3e5)).then(function(r){return r.ok?r.json():null;}); }catch(e){}
    if(!J||!J.curvas||!J.curvas.hoje) return;
    var C=J.curvas, H=C.hoje;
    function mb(sel,txt,cls){ var e=document.querySelector('[data-macro="'+sel+'"]'); if(e){ e.textContent=txt; if(cls){ e.classList.remove('up','down'); e.classList.add(cls); } } }
    function tn(c,t){ if(!c)return null; var p=c.pts.filter(function(x){return x.tenor===t;})[0]; return p?p.taxa:null; }
    var c1=tn(H,1), c10=tn(H,10);
    if(c1!=null) mb('curva-curto', nf(c1,2)+'%');
    if(c10!=null) mb('curva-longo', nf(c10,2)+'%');
    if(c1!=null&&c10!=null){ var incl=(c10-c1)*100; mb('curva-incl',(incl>=0?'+':'')+incl.toFixed(0)+' bps', incl>=0?'up':'down');
      var d=document.querySelector('[data-macro="curva-incl-desc"]'); if(d) d.textContent=incl>=0?'curva normal (positiva)':'curva invertida'; }
    mb('curva-data', H.refdate);
    if(canvas&&typeof Chart!=='undefined'){
      var labels=H.pts.map(function(p){return p.label;});
      function ds(c,label,color,dash,fill){ if(!c)return null; return {label:label,data:c.pts.map(function(p){return p.taxa;}),borderColor:color,backgroundColor:fill||'transparent',borderWidth:dash?1.4:2.4,borderDash:dash||[],fill:!!fill,tension:0.3,pointRadius:0,pointHoverRadius:4}; }
      var datasets=[ds(C.ano,'1 ano atrás','rgba(139,152,165,0.55)',[2,3]),ds(C.mes,'1 mês atrás','#f0a830',[5,4]),ds(C.semana,'1 semana atrás','#a371f7',[4,3]),ds(H,'Hoje','#4da3ff',null,'rgba(77,163,255,0.08)')].filter(Boolean);
      var prev=(window.Chart&&Chart.getChart)?Chart.getChart(canvas):null; if(prev)prev.destroy();
      var opt={ responsive:true, maintainAspectRatio:false, interaction:{intersect:false,mode:'index'},
        plugins:{ legend:{display:true,labels:{color:'#8b98a5',font:{size:10},usePointStyle:true,boxWidth:8}},
          tooltip:{backgroundColor:'#161c21',borderColor:'#2a3138',borderWidth:1,titleColor:'#e6e6e6',bodyColor:'#e6e6e6',
            callbacks:{label:function(x){return x.dataset.label+': '+(x.parsed.y!=null?nf(x.parsed.y,2)+'%':'—');}}} },
        scales:{ x:{grid:{color:'rgba(255,255,255,0.06)'},ticks:{color:'#8b98a5',font:{size:9}}},
          y:{grid:{color:'rgba(255,255,255,0.06)'},ticks:{color:'#8b98a5',font:{size:9},callback:function(v){return v+'%';}}} } };
      new Chart(canvas, {type:'line', data:{labels:labels, datasets:datasets}, options:opt});
    }
    var cap=document.querySelector('#curva .term-prose');
    if(cap && c1!=null && c10!=null){
      function cmp(nome,c){ if(!c)return null; var o10=tn(c,10),o1=tn(c,1); if(o10==null||o1==null)return null;
        var d10=(c10-o10)*100, dsl=((c10-c1)-(o10-o1))*100, mov=d10>5?'abrindo':d10<-5?'fechando':'estável', st=dsl>3?'inclinando':dsl<-3?'achatando':'';
        return 'vs '+nome+': '+(d10>=0?'+':'')+d10.toFixed(0)+' bps no 10A ('+mov+(st?', '+st:'')+')'; }
      var parts=[cmp('1 sem',C.semana),cmp('1 mês',C.mes),cmp('1 ano',C.ano)].filter(Boolean);
      cap.innerHTML='Curva prefixada do Tesouro (LTN/NTN-F) · ref '+H.refdate+'. '+parts.join(' · ')+'. <span style="color:#5a6570;">Fonte: Tesouro Transparente (GitHub Action).</span>';
    }
    return true;
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
    var res=await Promise.allSettled([renderHeat(),renderCenarios(),renderRegime(),renderInsights(),renderMonetaria(),renderCurva()]);
    var ok=res.some(function(r){return r.status==='fulfilled' && r.value!==false && r.value!==undefined;});
    stamp(true);
  }
  function boot(){
    setLoading();
    initComparador();
    [500,1500,3500,8000].forEach(function(ms){ setTimeout(runAll, ms); });
    setInterval(runAll, 5*60*1000);
  }
  if(document.readyState==='loading') document.addEventListener('DOMContentLoaded', boot); else boot();

  // hooks de teste
  if(typeof window!=='undefined') window.__ML={renderCurva:renderCurva,trend:trend, accum12:accum12, HEAT:HEAT, renderHeat:renderHeat, renderCenarios:renderCenarios, renderRegime:renderRegime, renderInsights:renderInsights, runAll:runAll};
})();
MLJS_EOF
if [ -n "$1" ]; then python3 -I - "$1" <<'PY2'
import sys; url=sys.argv[1].replace(chr(39),"")
p="assets/js/macro-live.js"; s=open(p,encoding="utf-8").read(); s=s.replace("var RESEARCH_URL = '';","var RESEARCH_URL = '"+url+"';",1); open(p,"w",encoding="utf-8").write(s); print("  - RESEARCH_URL = "+url)
PY2
else echo "  - sem URL do Worker"; fi
echo ""
echo "==> 1) git add -A && git commit -m \"fix: curva via Worker\" && git push"
echo "    2) GitHub > Actions > Atualizar Curva DI (ANBIMA) > Run workflow (main)"
