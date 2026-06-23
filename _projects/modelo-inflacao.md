---
layout: project
title: "Modelo de Inflação"
subtitle: "TCC — Modelagem preditiva do IPCA com variáveis macroeconômicas"
description: "Trabalho de Conclusão de Curso em Economia (UERJ): modelo econométrico para previsão do IPCA utilizando expectativas Focus, câmbio, preços de commodities e hiato do produto."
category: "Economia Aplicada / Econometria"
stack: ["Python", "R", "Statsmodels", "scikit-learn", "LaTeX", "IBGE API", "BCB SGS"]
status: "Em desenvolvimento"
image: assets/images/bloomberg.jpg
github_url: ""
live_url: ""
paper_url: ""
show_tile: true
nav-menu: false
date: 2025-03-01
---

## Visão Geral

Trabalho de Conclusão de Curso (TCC) do bacharelado em Economia pela UERJ, com foco em modelagem preditiva da inflação brasileira medida pelo IPCA.

## Problema de Pesquisa

Qual é o poder preditivo de modelos econométricos clássicos (VAR, ARIMA) versus modelos de machine learning (Random Forest, XGBoost) na previsão do IPCA no horizonte de 3 e 6 meses?

## Variáveis do Modelo

- Expectativas Focus (BCB) — IPCA 12 meses à frente
- Taxa de câmbio USD/BRL
- Preços de commodities (petróleo, soja, minério)
- Taxa Selic e hiato do produto estimado
- Índices de preços ao produtor (IPA-DI)

## Metodologia Comparativa

O trabalho compara a capacidade preditiva fora da amostra (out-of-sample) utilizando RMSE e MAPE como métricas de avaliação, com janela rolante de estimação.
