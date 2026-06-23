---
layout: project
title: "Plataforma de Backtest"
subtitle: "Engine de backtesting para estratégias quantitativas multi-ativo"
description: "Plataforma modular para backtesting de estratégias quantitativas com suporte a renda variável, renda fixa e derivativos brasileiros."
category: "Engenharia Financeira"
stack: ["Python", "FastAPI", "PostgreSQL", "Pandas", "Plotly", "Docker"]
status: "Em desenvolvimento"
image: assets/images/bloomberg1.jpg
github_url: ""
live_url: ""
paper_url: ""
show_tile: true
nav-menu: false
date: 2025-04-01
---

## Visão Geral

Engine de backtesting modular com foco no mercado brasileiro, com suporte a estratégias em renda variável (ações, ETFs, BDRs), renda fixa (Tesouro Direto, CDBs, debêntures) e derivativos listados na B3.

## Funcionalidades

- Importação automática de séries históricas via B3 e BCB
- Motor de execução com controle de custos de transação e slippage
- Métricas de risco: VaR, CVaR, Sharpe, Sortino, Calmar, Drawdown
- Relatórios em HTML interativo com Plotly
- API REST para integração com sistemas externos

## Arquitetura

```
Strategy → Signal Generator → Risk Manager → Execution Engine → Portfolio → Report
```

Cada módulo é independente e intercambiável, permitindo composição de estratégias complexas sem reescrita da engine base.
