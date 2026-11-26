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

CSV_URL = ("https://www.tesourotransparente.gov.br/ckan/dataset/df56aa42-484a-4a59-8184-7676580c81e3/"
           "resource/796d2059-14e9-44e3-80c9-2d9e30b405c1/download/PrecoTaxaTesouroDireto.csv")
PREFIXADOS = {"Tesouro Prefixado", "Tesouro Prefixado com Juros Semestrais"}
TENORS = [0.5, 1, 2, 3, 5, 7, 10]            # anos p/ grade comum
TENOR_LABELS = {0.5:"6M",1:"1A",2:"2A",3:"3A",5:"5A",7:"7A",10:"10A"}
JANELAS = {"hoje":0, "semana":7, "mes":30, "ano":365}
WINDOW_BACK = 8                               # recua até N dias p/ achar dia útil

def pdate(s): return datetime.strptime(s.strip(), "%d/%m/%Y").date()
def pnum(s):  return float(s.strip().replace(".", "").replace(",", "."))

def baixar_linhas():
    req = Request(CSV_URL, headers={"User-Agent": "Mozilla/5.0"})
    r = urlopen(req, timeout=120)
    return io.TextIOWrapper(r, encoding="latin-1", newline="")

def coletar(alvos):
    """Lê o CSV uma vez; guarda, por data-base dentro das janelas-alvo, os pontos prefixados."""
    low = min(a - timedelta(days=WINDOW_BACK) for a in alvos.values())
    high = max(alvos.values())
    porbase = {}  # date -> list[(ttm_anos, venc, taxa)]
    reader = csv.reader(baixar_linhas(), delimiter=";")
    header = next(reader, None)
    for row in reader:
        if len(row) < 4: continue
        tipo = row[0].strip()
        if tipo not in PREFIXADOS: continue
        try:
            venc = pdate(row[1]); base = pdate(row[2]); taxa = pnum(row[3])  # Taxa Compra Manhã
        except (ValueError, IndexError):
            continue
        if base < low or base > high: continue
        ttm = (venc - base).days / 365.25
        if ttm <= 0 or not (0 < taxa < 100): continue
        porbase.setdefault(base, []).append((ttm, venc.isoformat(), taxa))
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
