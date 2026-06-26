#!/usr/bin/env python3
"""
Baixa a ETTJ Prefixada (curva DI) da ANBIMA e salva como JSON.
Executado pelo GitHub Action diariamente após o fechamento.
Fonte: https://www.anbima.com.br/informacoes/est-termo/
"""
import json
import sys
from datetime import datetime
from urllib.request import urlopen, Request

# Vértices ANBIMA fixos (dias úteis) e seus rótulos
VERTICES = [
    (21, 0.08, "1M"), (42, 0.17, "2M"), (63, 0.25, "3M"),
    (126, 0.5, "6M"), (252, 1, "1A"), (378, 1.5, "1A6M"),
    (504, 2, "2A"), (630, 2.5, "2A6M"), (756, 3, "3A"),
    (1008, 4, "4A"), (1260, 5, "5A"), (1512, 6, "6A"),
    (1764, 7, "7A"), (2016, 8, "8A"), (2268, 9, "9A"),
    (2520, 10, "10A"),
]

# URL do arquivo CSV da ANBIMA (ETTJ do dia mais recente)
ANBIMA_URL = "https://www.anbima.com.br/informacoes/est-termo/CZ-down.asp"

def baixar_curva():
    """
    Baixa o CSV da ANBIMA. O endpoint CZ-down.asp aceita parâmetros POST
    com a data; sem data, retorna o pregão mais recente.
    """
    hoje = datetime.now().strftime("%d/%m/%Y")
    payload = f"Idioma=PT&Dt_Ref={hoje}&saida=csv&Escolha=1&Inicio={hoje}".encode()
    req = Request(ANBIMA_URL, data=payload, headers={
        "User-Agent": "Mozilla/5.0",
        "Content-Type": "application/x-www-form-urlencoded",
    })
    with urlopen(req, timeout=30) as r:
        return r.read().decode("latin-1")

def parse_csv(texto):
    """Extrai os pares (du, taxa) da curva PREFIXADA do CSV ANBIMA."""
    taxas = {}
    for linha in texto.splitlines():
        partes = [p.strip() for p in linha.split(";")]
        # Formato esperado: vértice(du) ; ETTJ IPCA ; ETTJ PRE ; ...
        if len(partes) >= 3:
            try:
                du = int(partes[0].replace(".", ""))
                # A coluna PRE é a 3ª (índice 2). Vírgula decimal BR.
                pre = float(partes[2].replace(".", "").replace(",", "."))
                if 0 < pre < 100:
                    taxas[du] = pre
            except (ValueError, IndexError):
                continue
    return taxas

def main():
    try:
        csv = baixar_curva()
        taxas = parse_csv(csv)
        if not taxas:
            print("AVISO: nenhuma taxa extraída. Mantendo JSON anterior.", file=sys.stderr)
            sys.exit(0)  # não falha o build; mantém dados antigos
    except Exception as e:
        print(f"AVISO: falha ao baixar ANBIMA ({e}). Mantendo JSON anterior.", file=sys.stderr)
        sys.exit(0)

    # Monta os vértices, casando os DU disponíveis
    vertices = []
    for du, anos, label in VERTICES:
        # acha a taxa mais próxima do vértice
        taxa = taxas.get(du)
        if taxa is None:
            # interpola pelo DU mais próximo disponível
            if taxas:
                du_proximo = min(taxas.keys(), key=lambda x: abs(x - du))
                if abs(du_proximo - du) <= 130:
                    taxa = taxas[du_proximo]
        if taxa is not None:
            vertices.append({"du": du, "anos": anos, "label": label, "taxa": round(taxa, 4)})

    if len(vertices) < 5:
        print("AVISO: poucos vértices válidos. Mantendo JSON anterior.", file=sys.stderr)
        sys.exit(0)

    saida = {
        "refdate": datetime.now().strftime("%Y-%m-%d"),
        "fonte": "ANBIMA — ETTJ Prefixada (DI x PRE)",
        "atualizado_em": datetime.now().strftime("%Y-%m-%d"),
        "vertices": vertices,
    }

    with open("assets/data/curva-di.json", "w", encoding="utf-8") as f:
        json.dump(saida, f, ensure_ascii=False, indent=2)
    print(f"✓ Curva DI atualizada: {len(vertices)} vértices, ref {saida['refdate']}")

if __name__ == "__main__":
    main()
