---
layout: project
title: "Data Lake Econômico"
subtitle: "Infraestrutura de dados macroeconômicos e financeiros integrada"
description: "Data lake de séries econômicas brasileiras e internacionais com pipelines de ingestão automatizados, armazenamento estruturado e camada analítica."
category: "Ciência de Dados / Engenharia de Dados"
stack: ["Python", "PostgreSQL", "BCB SGS API", "IBGE API", "FRED API", "Pandas", "Docker"]
status: "Em desenvolvimento"
image: assets/images/blur.jpg
github_url: ""
live_url: ""
paper_url: ""
show_tile: true
nav-menu: false
date: 2025-02-01
---

## Visão Geral

Infraestrutura centralizada de dados macroeconômicos e financeiros com pipelines de ingestão automatizados das principais fontes públicas brasileiras e internacionais.

## Fontes de Dados Integradas

- **BCB SGS:** 500+ séries de política monetária, câmbio, crédito e atividade
- **IBGE SIDRA:** PIB, IPCA, PNAD, produção industrial
- **FRED (Federal Reserve):** variáveis internacionais e indicadores dos EUA
- **ANBIMA:** fundos, debêntures, NTN-B
- **B3:** séries históricas de preços e volumes

## Arquitetura

```
Ingestão (APIs) → Staging (raw) → Transformação (cleaned) → Analítica (mart)
```

Cada camada tem schema versionado e log de auditoria para rastreabilidade da cadeia de dados.

## Casos de Uso

Alimenta os modelos de inflação (TCC), o dashboard de curva de juros e o sistema de indicadores econômicos do portfólio.
