---
layout: project
title: "Curva de Juros"
subtitle: "Dashboard analítico da estrutura a termo das taxas de juros brasileira"
description: "Dashboard interativo para análise da ETTJ brasileira com cálculo de forwards, breakevens inflacionários, carry & rolldown e DV01 por vértice."
category: "Renda Fixa / Engenharia Financeira"
stack: ["Python", "HTML", "JavaScript", "BCB API", "ANBIMA API", "Plotly"]
status: "Concluído"
image: assets/images/luz.jpg
github_url: ""
live_url: ""
paper_url: ""
show_tile: true
nav-menu: false
date: 2024-10-01
---

## Visão Geral

Dashboard analítico de renda fixa com conexão em tempo real às APIs do Banco Central e ANBIMA para construção e análise da Estrutura a Termo das Taxas de Juros (ETTJ) brasileira.

## Funcionalidades Implementadas

- Curva spot DI e Pré extraída das taxas de mercado (ANBIMA ETTJ)
- Cálculo de taxas forward implícitas por vértice
- Breakeven inflacionário (NTN-B vs LTN)
- Análise de carry & rolldown para estratégias de duration
- DV01 (Dollar Value of a Basis Point) e P&L de cenário por movimento paralelo e não-paralelo
- Comparativo histórico da inclinação da curva (spread 2s10s, 5s10s)

## Relevância Profissional

Ferramenta utilizada como apoio analítico para recomendações de alocação em renda fixa para clientes da Arbitrium Capital / BX Investimentos.
