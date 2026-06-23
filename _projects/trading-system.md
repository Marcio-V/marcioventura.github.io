---
layout: project
title: "Trading System BOVA11"
subtitle: "Modelo ARIMA com sinais long/short sistemáticos sem stop por tempo"
description: "Sistema de trading quantitativo baseado em ARIMA para geração de sinais long/short no BOVA11, com backtest histórico e análise de risco."
category: "Finanças Quantitativas"
stack: ["Python", "Pandas", "Statsmodels", "Matplotlib", "NumPy", "Excel"]
status: "Em desenvolvimento"
image: assets/images/market.jpg
github_url: ""
live_url: ""
paper_url: ""
show_tile: true
nav-menu: false
date: 2025-01-01
---

## Visão Geral

Sistema de trading sistemático desenvolvido para o BOVA11 (ETF do Ibovespa), com foco em geração de sinais baseados em modelo ARIMA calibrado sobre retornos históricos.

## Metodologia

O modelo utiliza a estrutura ARIMA(p,d,q) para capturar padrões de autocorrelação na série de retornos do BOVA11. Os sinais são gerados quando a previsão do modelo supera limiares definidos pela volatilidade histórica.

- **Sinal Long:** previsão de retorno superior a +1σ
- **Sinal Short:** previsão de retorno inferior a −1σ
- **Saída:** baseada exclusivamente em sinal inverso (sem stop temporal)

## Arquitetura Técnica

- Pipeline de dados: `yfinance` para série histórica diária
- Seleção de parâmetros: critério AIC com grid search
- Backtest: engine própria com log de trades e curva de capital
- Relatório: exportação para Excel com gráficos e métricas de risco

## Métricas Monitoradas

Sharpe Ratio, Drawdown Máximo, Taxa de Acerto, Profit Factor e Exposição Líquida.
