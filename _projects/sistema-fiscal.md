---
layout: project
title: "Sistema Fiscal B3"
subtitle: "Calculadora de IR para investimentos com engine de otimização tributária"
description: "SaaS de cálculo de Imposto de Renda para todos os ativos B3, com compensação de perdas, geração de DARF e módulo de otimização fiscal (Trade Fiscal)."
category: "Engenharia de Software / Fintech"
stack: ["Python", "FastAPI", "PostgreSQL", "Docker", "LGPD", "Jinja2"]
status: "Concluído"
image: assets/images/cafe.png
github_url: ""
live_url: ""
paper_url: ""
show_tile: true
nav-menu: false
date: 2024-08-01
---

## Visão Geral

Engine completa de cálculo de Imposto de Renda sobre investimentos B3, cobrindo todas as classes de ativos com as bases legais corretas e suporte a estratégias de otimização tributária.

## Classes de Ativos Suportadas

- Ações (swing trade e day trade, alíquotas distintas)
- ETFs nacionais e internacionais (BDRs)
- FIIs — Fundos de Investimento Imobiliário
- Opções (calls e puts, prêmio e exercício)
- Renda fixa (CDB, LCI, LCA, Tesouro Direto)

## Funcionalidades

- Compensação automática de prejuízos entre classes compatíveis
- Aplicação correta da isenção para vendas de ações ≤ R$ 20.000/mês
- Geração de DARF em PDF com código de barras
- Módulo Trade Fiscal: sugestão de operações para compensação de ganhos
- Conformidade LGPD com anonimização de dados sensíveis

## Arquitetura

API REST (FastAPI) + banco de dados PostgreSQL + geração de documentos PDF. Projetado para escala SaaS com multi-tenancy.
