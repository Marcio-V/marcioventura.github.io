---
layout: terminal
title: Economia
description: Terminal macroeconômico — indicadores em tempo real, conjuntura e modelos.
image: assets/images/bloomberg1.jpg
nav-menu: true
tile-category: Terminal
tile-order: 1
tile-position: center center
menu-order: 1
---

<div class="term-layout">

<!-- ═══════════ SIDEBAR DE NAVEGAÇÃO ═══════════ -->
<nav class="term-nav">
	<div class="term-nav-title">Terminal Macro</div>
	<a href="#dashboard"><span class="term-nav-num">01</span> Dashboard</a>
	<a href="#panorama"><span class="term-nav-num">02</span> Panorama</a>
	<a href="#ciclo"><span class="term-nav-num">03</span> Ciclo Econômico</a>
	<a href="#monetaria"><span class="term-nav-num">04</span> Política Monetária</a>
	<a href="#inflacao"><span class="term-nav-num">05</span> Inflação</a>
	<a href="#atividade"><span class="term-nav-num">06</span> Atividade</a>
	<a href="#trabalho"><span class="term-nav-num">07</span> Trabalho</a>
	<a href="#fiscal"><span class="term-nav-num">08</span> Fiscal</a>
	<a href="#juros-reais"><span class="term-nav-num">09</span> Juros Reais</a>
	<a href="#curva"><span class="term-nav-num">10</span> Curva de Juros</a>
	<a href="#cambio"><span class="term-nav-num">11</span> Câmbio</a>
	<a href="#commodities"><span class="term-nav-num">12</span> Commodities</a>
	<a href="#mundo"><span class="term-nav-num">13</span> Mundo</a>
	<a href="#calendario"><span class="term-nav-num">14</span> Calendário</a>
	<a href="#heatmap"><span class="term-nav-num">15</span> Heatmap</a>
	<a href="#cenarios"><span class="term-nav-num">16</span> Cenários</a>
	<a href="#impacto"><span class="term-nav-num">17</span> Impacto Ativos</a>
	<a href="#insights"><span class="term-nav-num">18</span> Insights</a>
	<a href="#modelos"><span class="term-nav-num">19</span> Modelos</a>
	<a href="#ferramentas"><span class="term-nav-num">20</span> Ferramentas</a>
</nav>

<!-- ═══════════ CONTEÚDO ═══════════ -->
<div class="term-content">

<!-- 01 DASHBOARD -->
<section class="term-module" id="dashboard">
	<div class="term-module-header">
		<span class="term-module-num">01</span>
		<h2>Macro Dashboard</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">Selic Meta</div><div class="term-card-value" data-macro="selic"><span class="term-skeleton"></span></div><div class="term-card-sub">% a.a.</div></div>
		<div class="term-card"><div class="term-card-label">IPCA 12M</div><div class="term-card-value" data-macro="ipca12m"><span class="term-skeleton"></span></div><div class="term-card-sub">acumulado</div></div>
		<div class="term-card"><div class="term-card-label">CDI</div><div class="term-card-value" data-macro="cdi"><span class="term-skeleton"></span></div><div class="term-card-sub">% a.a.</div></div>
		<div class="term-card"><div class="term-card-label">Dólar</div><div class="term-card-value" data-macro="dolar"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="dolar-chg"></div></div>
		<div class="term-card"><div class="term-card-label">Euro</div><div class="term-card-value" data-macro="euro"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="euro-chg"></div></div>
		<div class="term-card"><div class="term-card-label">Ibovespa</div><div class="term-card-value" data-macro="ibov"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="ibov-chg"></div></div>
		<div class="term-card"><div class="term-card-label">S&amp;P 500</div><div class="term-card-value" data-macro="sp500"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="sp500-chg"></div></div>
		<div class="term-card"><div class="term-card-label">Desemprego</div><div class="term-card-value" data-macro="desemprego"><span class="term-skeleton"></span></div><div class="term-card-sub">PNAD</div></div>
	</div>
</section>

<!-- 02 PANORAMA -->
<section class="term-module" id="panorama">
	<div class="term-module-header">
		<span class="term-module-num">02</span>
		<h2>Panorama Econômico</h2>
	</div>
	<p class="term-prose">
		A economia se move em <strong>ciclos</strong>. Nesta seção acompanho os principais indicadores brasileiros e internacionais, relacionando política monetária, inflação, atividade e mercados financeiros. O objetivo não é apenas apresentar dados — é <strong>interpretar como eles impactam diferentes classes de ativos</strong> e informar decisões de alocação e operação na mesa.
	</p>
</section>

<!-- 03 CICLO ECONÔMICO -->
<section class="term-module" id="ciclo">
	<div class="term-module-header">
		<span class="term-module-num">03</span>
		<h2>Ciclo Econômico</h2>
		<span class="term-module-tag model">Leitura</span>
	</div>
	<div class="term-cycle" style="margin-bottom:1.5em;">
		<span class="cycle-phase">Recessão</span>
		<span class="cycle-arrow">→</span>
		<span class="cycle-phase">Recuperação</span>
		<span class="cycle-arrow">→</span>
		<span class="cycle-phase">Expansão</span>
		<span class="cycle-arrow">→</span>
		<span class="cycle-phase active">Desaceleração</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">Status Brasil</div><div class="term-card-value" style="font-size:1rem;">Desaceleração</div><div class="term-card-sub">leitura qualitativa</div></div>
		<div class="term-card"><div class="term-card-label">Selic</div><div class="term-card-value" style="font-size:1rem;">Elevada</div><div class="term-card-sub">contracionista</div></div>
		<div class="term-card"><div class="term-card-label">Crédito</div><div class="term-card-value" style="font-size:1rem;">Desacelerando</div><div class="term-card-sub">tendência</div></div>
	</div>
</section>

<!-- 04 POLÍTICA MONETÁRIA -->
<section class="term-module" id="monetaria">
	<div class="term-module-header">
		<span class="term-module-num">04</span>
		<h2>Política Monetária</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">Selic Atual</div><div class="term-card-value" data-macro="selic"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="selic-copom">último COPOM</div></div>
		<div class="term-card"><div class="term-card-label">CDI</div><div class="term-card-value" data-macro="cdi"><span class="term-skeleton"></span></div><div class="term-card-sub">% a.a.</div></div>
	</div>
	<div class="term-chart-wrap" style="margin-top:1em;">
		<div class="term-chart-title">Selic efetiva × Regra de Taylor — desde 2015</div>
		<div class="term-taylor-controls">
			<label>r* — juro real neutro (%)<input type="range" id="tr-rstar" min="0" max="8" step="0.25" value="4.5"><output id="tr-rstar-v">4,5</output></label>
			<label>π* — meta de inflação (%)<input type="range" id="tr-pistar" min="2" max="6" step="0.25" value="3.0"><output id="tr-pistar-v">3,0</output></label>
			<label>α — peso da inflação<input type="range" id="tr-alpha" min="0" max="2" step="0.05" value="0.5"><output id="tr-alpha-v">0,50</output></label>
			<label>β — peso do hiato<input type="range" id="tr-beta" min="0" max="2" step="0.05" value="0.5"><output id="tr-beta-v">0,50</output></label>
			<label>Hiato do produto (%)<input type="range" id="tr-hiato" min="-5" max="5" step="0.25" value="0"><output id="tr-hiato-v">0,0</output></label>
		</div>
		<div class="term-chart-box" style="height:340px;"><canvas data-chart="taylor"></canvas></div>
		<div class="term-taylor-formula">i<sub>Taylor</sub> = r* + π + α(π − π*) + β·hiato &nbsp;|&nbsp; <span id="tr-current"></span></div>
	</div>
</section>

<!-- 05 INFLAÇÃO -->
<section class="term-module" id="inflacao">
	<div class="term-module-header">
		<span class="term-module-num">05</span>
		<h2>Inflação</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">IPCA Mês</div><div class="term-card-value" data-macro="ipca"><span class="term-skeleton"></span></div><div class="term-card-sub">variação mensal</div></div>
		<div class="term-card"><div class="term-card-label">IPCA 12M</div><div class="term-card-value" data-macro="ipca12m"><span class="term-skeleton"></span></div><div class="term-card-sub">acumulado</div></div>
		<div class="term-card"><div class="term-card-label">IGP-M Mês</div><div class="term-card-value" data-macro="igpm"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="igpm-ref">FGV</div></div>
		<div class="term-card"><div class="term-card-label">INPC Mês</div><div class="term-card-value" data-macro="inpc"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="inpc-ref">IBGE</div></div>
	</div>
	<div class="term-chart-wrap" style="margin-top:1em;">
		<div class="term-chart-title">IPCA acumulado em 12 meses — últimos 24 meses</div>
		<div class="term-chart-box"><canvas data-chart="ipca12m"></canvas></div>
	</div>
</section>

<!-- 06 ATIVIDADE -->
<section class="term-module" id="atividade">
	<div class="term-module-header">
		<span class="term-module-num">06</span>
		<h2>Atividade Econômica</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">IBC-Br</div><div class="term-card-value" data-macro="ibcbr"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="ibcbr-ref">proxy mensal do PIB</div></div>
		<div class="term-card"><div class="term-card-label">IBC-Br 12M</div><div class="term-card-value" data-macro="ibcbr-var"><span class="term-skeleton"></span></div><div class="term-card-sub">variação acumulada</div></div>
	</div>
	<div class="term-chart-wrap" style="margin-top:1em;">
		<div class="term-chart-title">IBC-Br — Índice de Atividade Econômica do BCB (24 meses)</div>
		<div class="term-chart-box"><canvas data-chart="ibcbr"></canvas></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">O IBC-Br é o indicador mensal de atividade do Banco Central, usado como proxy de alta frequência do PIB (divulgado trimestralmente).</p>
</section>

<!-- 07 TRABALHO -->
<section class="term-module" id="trabalho">
	<div class="term-module-header">
		<span class="term-module-num">07</span>
		<h2>Mercado de Trabalho</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">Desemprego</div><div class="term-card-value" data-macro="desemprego"><span class="term-skeleton"></span></div><div class="term-card-sub">PNAD Contínua</div></div>
	</div>
	<div class="term-chart-wrap" style="margin-top:1em;">
		<div class="term-chart-title">Taxa de Desocupação (PNAD Contínua) — últimos 24 meses</div>
		<div class="term-chart-box"><canvas data-chart="desemprego"></canvas></div>
	</div>
</section>

<!-- 08 FISCAL -->
<section class="term-module" id="fiscal">
	<div class="term-module-header">
		<span class="term-module-num">08</span>
		<h2>Contas Públicas</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">Dívida Bruta</div><div class="term-card-value" data-macro="divida-bruta"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="divida-bruta-chg">% do PIB</div></div>
		<div class="term-card"><div class="term-card-label">Dívida Líquida</div><div class="term-card-value" data-macro="divida-liquida"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="divida-liquida-chg">% do PIB</div></div>
	</div>
	<div class="term-chart-wrap" style="margin-top:1em;">
		<div class="term-chart-title">Dívida Bruta do Governo Geral — % do PIB (36 meses)</div>
		<div class="term-chart-box"><canvas data-chart="divida-bruta"></canvas></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Dívida bruta do governo geral (metodologia 2008+) e dívida líquida, em % do PIB. Indicadores-chave de sustentabilidade fiscal e prêmio de risco soberano.</p>
</section>

<!-- 09 JUROS REAIS -->
<section class="term-module" id="juros-reais">
	<div class="term-module-header">
		<span class="term-module-num">09</span>
		<h2>Juros Reais</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<p class="term-prose" style="margin-bottom:1.2em;">
		O <strong>juro real ex-ante</strong> mede o retorno acima da inflação <em>esperada</em>, sendo o indicador central para posicionamento em renda fixa. Calculado pela equação de Fisher a partir da Selic atual e da expectativa de inflação 12 meses da Pesquisa Focus.
	</p>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">Selic Meta</div><div class="term-card-value" data-macro="selic-jr"><span class="term-skeleton"></span></div><div class="term-card-sub">% a.a. (nominal)</div></div>
		<div class="term-card"><div class="term-card-label">Inflação Esperada 12M</div><div class="term-card-value" data-macro="focus-inf"><span class="term-skeleton"></span></div><div class="term-card-sub">mediana Focus suavizada</div></div>
		<div class="term-card"><div class="term-card-label">Juro Real Ex-Ante</div><div class="term-card-value" data-macro="juro-real"><span class="term-skeleton"></span></div><div class="term-card-sub">Fisher: (1+i)/(1+π)−1</div></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Fonte: Selic (BCB SGS 432) e expectativas de inflação 12M (Pesquisa Focus / API Olinda). Atualização automática.</p>
</section>

<!-- 10 CURVA DE JUROS -->
<section class="term-module" id="curva">
	<div class="term-module-header">
		<span class="term-module-num">10</span>
		<h2>Curva de Juros</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid" style="margin-bottom:1em;">
		<div class="term-card"><div class="term-card-label">Curto (1A)</div><div class="term-card-value" data-macro="curva-curto" style="font-size:1.2rem;"><span class="term-skeleton"></span></div><div class="term-card-sub">vértice 252 du</div></div>
		<div class="term-card"><div class="term-card-label">Longo (10A)</div><div class="term-card-value" data-macro="curva-longo" style="font-size:1.2rem;"><span class="term-skeleton"></span></div><div class="term-card-sub">vértice 2520 du</div></div>
		<div class="term-card"><div class="term-card-label">Inclinação 1s10s</div><div class="term-card-value" data-macro="curva-incl" style="font-size:1.2rem;"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="curva-incl-desc">spread longo − curto</div></div>
		<div class="term-card"><div class="term-card-label">Referência</div><div class="term-card-value" data-macro="curva-data" style="font-size:1.2rem;"><span class="term-skeleton"></span></div><div class="term-card-sub">data da curva</div></div>
	</div>
	<div class="term-chart-wrap">
		<div class="term-chart-title">Estrutura a Termo das Taxas de Juros (ETTJ Prefixada) — ANBIMA</div>
		<div class="term-chart-box"><canvas data-chart="curva"></canvas></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Curva DI prefixada (DI x PRE) da ANBIMA, com 16 vértices de 1 mês a 10 anos. Atualizada automaticamente todo dia útil após o fechamento, via GitHub Action. Curva ascendente = mercado precifica juros maiores no longo prazo; invertida = expectativa de cortes de Selic.</p>
</section>

<!-- 11 CÂMBIO -->
<section class="term-module" id="cambio">
	<div class="term-module-header">
		<span class="term-module-num">11</span>
		<h2>Câmbio</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">USD/BRL</div><div class="term-card-value" data-macro="dolar"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="dolar-chg"></div></div>
		<div class="term-card"><div class="term-card-label">EUR/BRL</div><div class="term-card-value" data-macro="euro"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="euro-chg"></div></div>
	</div>
	<div class="term-chart-wrap" style="margin-top:1em;">
		<div class="term-chart-title">Dólar Comercial (USD/BRL) — últimos 180 dias</div>
		<div class="term-chart-box"><canvas data-chart="dolar"></canvas></div>
	</div>
</section>

<!-- 12 COMMODITIES -->
<section class="term-module" id="commodities">
	<div class="term-module-header">
		<span class="term-module-num">12</span>
		<h2>Commodities</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">Petróleo WTI</div><div class="term-card-value" data-macro="wti"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="wti-chg">US$ / barril</div></div>
		<div class="term-card"><div class="term-card-label">Petróleo Brent</div><div class="term-card-value" data-macro="brent"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="brent-chg">US$ / barril</div></div>
		<div class="term-card"><div class="term-card-label">Ouro</div><div class="term-card-value" data-macro="ouro"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="ouro-chg">US$ / oz</div></div>
		<div class="term-card"><div class="term-card-label">Cobre</div><div class="term-card-value" data-macro="cobre"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="cobre-chg">US$ / lb</div></div>
		<div class="term-card"><div class="term-card-label">Soja</div><div class="term-card-value" data-macro="soja"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="soja-chg">¢ / bushel</div></div>
		<div class="term-card"><div class="term-card-label">Milho</div><div class="term-card-value" data-macro="milho"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="milho-chg">¢ / bushel</div></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Futuros via Yahoo Finance (Cloudflare Worker). Petróleo e minério movem as exportadoras brasileiras (PETR4, VALE3) e o câmbio; grãos impactam o agronegócio e a balança comercial.</p>
</section>

<!-- 13 MUNDO -->
<section class="term-module" id="mundo">
	<div class="term-module-header">
		<span class="term-module-num">13</span>
		<h2>Cenário Internacional</h2>
		<span class="term-module-tag live">Ao vivo</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">S&amp;P 500</div><div class="term-card-value" data-macro="sp500"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="sp500-chg"></div></div>
		<div class="term-card"><div class="term-card-label">Nasdaq</div><div class="term-card-value" data-macro="nasdaq"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="nasdaq-chg"></div></div>
		<div class="term-card"><div class="term-card-label">Dow Jones</div><div class="term-card-value" data-macro="dow"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="dow-chg"></div></div>
		<div class="term-card"><div class="term-card-label">Treasury 10A</div><div class="term-card-value" data-macro="tnx"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="tnx-chg">% a.a.</div></div>
		<div class="term-card"><div class="term-card-label">VIX</div><div class="term-card-value" data-macro="vix"><span class="term-skeleton"></span></div><div class="term-card-sub" data-macro="vix-chg">índice de medo</div></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Índices e juros dos EUA via Yahoo Finance (Worker). O Treasury de 10 anos (^TNX) é o juro livre de risco global — sua alta pressiona emergentes; o VIX mede a aversão a risco do mercado.</p>
</section>

<!-- 14 CALENDÁRIO -->
<section class="term-module" id="calendario">
	<div class="term-module-header">
		<span class="term-module-num">14</span>
		<h2>Calendário Econômico</h2>
		<span class="term-module-tag model">Agenda</span>
	</div>
	<table class="term-table">
		<thead>
			<tr><th>Evento</th><th>Periodicidade</th><th>Fonte</th><th>Impacto</th></tr>
		</thead>
		<tbody>
			<tr><td>Reunião do COPOM</td><td>a cada 45 dias</td><td>BCB</td><td><span class="down">Alto</span></td></tr>
			<tr><td>IPCA</td><td>mensal</td><td>IBGE</td><td><span class="down">Alto</span></td></tr>
			<tr><td>Ata do COPOM</td><td>semanal pós-reunião</td><td>BCB</td><td><span style="color:#d29922">Médio</span></td></tr>
			<tr><td>Boletim Focus</td><td>semanal (segundas)</td><td>BCB</td><td><span style="color:#d29922">Médio</span></td></tr>
			<tr><td>FOMC (Fed)</td><td>a cada 6 semanas</td><td>Federal Reserve</td><td><span class="down">Alto</span></td></tr>
			<tr><td>Payroll (EUA)</td><td>mensal (1ª sexta)</td><td>BLS</td><td><span class="down">Alto</span></td></tr>
			<tr><td>PIB</td><td>trimestral</td><td>IBGE</td><td><span class="down">Alto</span></td></tr>
		</tbody>
	</table>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Principais divulgações macroeconômicas e sua periodicidade. As datas exatas de cada mês seguem o cronograma oficial dos órgãos divulgadores.</p>
</section>

<!-- 15 HEATMAP -->
<section class="term-module" id="heatmap">
	<div class="term-module-header">
		<span class="term-module-num">15</span>
		<h2>Heatmap de Indicadores</h2>
		<span class="term-module-tag model" data-live-tag="Leitura">Leitura</span>
		<span id="live-updated" class="term-live-updated"></span>
	</div>
	<div class="term-heatmap">
		<div class="heat-cell heat-flat" data-dim="inflacao"><div class="heat-label">Inflação</div><div class="heat-arrow">→</div><div class="heat-val">—</div></div>
		<div class="heat-cell heat-flat" data-dim="atividade"><div class="heat-label">Atividade</div><div class="heat-arrow">→</div><div class="heat-val">—</div></div>
		<div class="heat-cell heat-flat" data-dim="emprego"><div class="heat-label">Emprego</div><div class="heat-arrow">→</div><div class="heat-val">—</div></div>
		<div class="heat-cell heat-flat" data-dim="fiscal"><div class="heat-label">Fiscal</div><div class="heat-arrow">→</div><div class="heat-val">—</div></div>
		<div class="heat-cell heat-flat" data-dim="juros"><div class="heat-label">Juros</div><div class="heat-arrow">→</div><div class="heat-val">—</div></div>
		<div class="heat-cell heat-flat" data-dim="cambio"><div class="heat-label">Câmbio</div><div class="heat-arrow">→</div><div class="heat-val">—</div></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Seta = direção recente da série · cor = leitura favorável (verde) ou desfavorável (vermelho) para ativos de risco. Fontes: BCB/SGS e IBGE, ao vivo.</p>
</section>

<!-- 16 CENÁRIOS -->
<section class="term-module" id="cenarios">
	<div class="term-module-header">
		<span class="term-module-num">16</span>
		<h2>Cenários Projetados</h2>
		<span class="term-module-tag model" data-live-tag="Projeção">Projeção</span>
	</div>
	<div class="term-grid">
		<div class="term-card" data-cen="base"><div class="term-card-label">Base · PIB</div><div class="term-card-value" style="font-size:1.2rem;">2,2%</div><div class="term-card-sub">IPCA 5,0% · Selic 13,5%</div></div>
		<div class="term-card" data-cen="otim"><div class="term-card-label">Otimista · PIB</div><div class="term-card-value up" style="font-size:1.2rem;">3,0%</div><div class="term-card-sub">IPCA 4,2% · Selic 12,0%</div></div>
		<div class="term-card" data-cen="pess"><div class="term-card-label">Pessimista · PIB</div><div class="term-card-value down" style="font-size:1.2rem;">0,8%</div><div class="term-card-sub">IPCA 6,5% · Selic 15,0%</div></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Valores ilustrativos. Versão futura: simulador interativo.</p>
</section>

<!-- 17 IMPACTO POR CLASSE DE ATIVOS -->
<section class="term-module" id="impacto">
	<div class="term-module-header">
		<span class="term-module-num">17</span>
		<h2>Impacto por Classe de Ativos</h2>
		<span class="term-module-tag model" data-live-tag="Matriz">Matriz</span>
	</div>
	<table class="term-table">
		<thead><tr><th>Evento</th><th>Ações</th><th>Juros (RF)</th><th>Dólar</th><th>Ouro</th><th>FIIs</th></tr></thead>
		<tbody>
			<tr><td>Alta da Selic</td><td>🔴</td><td>🟢</td><td>🟢</td><td>🟡</td><td>🔴</td></tr>
			<tr><td>Queda da Inflação</td><td>🟢</td><td>🟢</td><td>🔴</td><td>🔴</td><td>🟢</td></tr>
			<tr><td>Recessão</td><td>🔴</td><td>🟢</td><td>🟢</td><td>🟢</td><td>🔴</td></tr>
			<tr><td>Alta de Commodities</td><td>🟢</td><td>🔴</td><td>🔴</td><td>🟢</td><td>🟡</td></tr>
		</tbody>
	</table>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">🟢 favorável · 🟡 neutro/misto · 🔴 desfavorável. Leitura direcional de primeira ordem.</p>
</section>

<!-- 18 INSIGHTS -->
<section class="term-module" id="insights">
	<div class="term-module-header">
		<span class="term-module-num">18</span>
		<h2>Insights &amp; Research</h2>
		<span class="term-module-tag model" data-live-tag="Research">Research</span>
	</div>
	<div class="term-insights">
		<article class="term-insight"><div class="insight-date">Jun · 2026</div><h3 class="insight-title">Selic e o juro real ex-ante</h3><p class="insight-body">—</p></article>
		<article class="term-insight"><div class="insight-date">Jun · 2026</div><h3 class="insight-title">Câmbio e o diferencial de juros</h3><p class="insight-body">—</p></article>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Indicadores atualizados automaticamente a partir de BCB/Focus. Leitura de conjuntura.</p>
</section>

<!-- 19 MODELOS ECONÔMICOS -->
<section class="term-module" id="modelos">
	<div class="term-module-header">
		<span class="term-module-num">19</span>
		<h2>Modelos Econômicos</h2>
		<span class="term-module-tag model">Interativo</span>
	</div>
	<p class="term-prose" style="font-size:0.74rem;margin-bottom:1.1em;">Clique em um modelo para abrir teoria, equações, um gráfico dinâmico e a leitura para investimentos.</p>
	<div class="term-chips models-grid">
		<div class="term-chip clickable fam-mon" role="button" tabindex="0" data-model="taylor" aria-label="Abrir Taylor Rule"><span class="chip-family">Política monetária</span><span class="chip-name">Taylor Rule</span><span class="chip-desc">Regra de juros do banco central</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-ativ" role="button" tabindex="0" data-model="phillips" aria-label="Abrir Phillips Curve"><span class="chip-family">Inflação & atividade</span><span class="chip-name">Phillips Curve</span><span class="chip-desc">Trade-off inflação × desemprego</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-mon" role="button" tabindex="0" data-model="islm" aria-label="Abrir IS-LM"><span class="chip-family">Política monetária</span><span class="chip-name">IS-LM</span><span class="chip-desc">Equilíbrio bens × moeda</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-cambio" role="button" tabindex="0" data-model="mundell" aria-label="Abrir Mundell-Fleming"><span class="chip-family">Câmbio & externo</span><span class="chip-name">Mundell-Fleming</span><span class="chip-desc">Economia aberta</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-econ" role="button" tabindex="0" data-model="var" aria-label="Abrir VAR"><span class="chip-family">Econometria</span><span class="chip-name">VAR</span><span class="chip-desc">Vetores autorregressivos</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-econ" role="button" tabindex="0" data-model="nowcasting" aria-label="Abrir Nowcasting"><span class="chip-family">Econometria</span><span class="chip-name">Nowcasting</span><span class="chip-desc">Estimativa em tempo real</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-curva" role="button" tabindex="0" data-model="nelson" aria-label="Abrir Nelson-Siegel"><span class="chip-family">Curva de juros</span><span class="chip-name">Nelson-Siegel</span><span class="chip-desc">Modelagem da curva de juros</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-aloc" role="button" tabindex="0" data-model="blacklitt" aria-label="Abrir Black-Litterman"><span class="chip-family">Alocação</span><span class="chip-name">Black-Litterman</span><span class="chip-desc">Alocação de portfólio</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-ativ" role="button" tabindex="0" data-model="solow" aria-label="Abrir Solow"><span class="chip-family">Crescimento</span><span class="chip-name">Solow</span><span class="chip-desc">Crescimento de longo prazo</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-cambio" role="button" tabindex="0" data-model="dornbusch" aria-label="Abrir Overshooting"><span class="chip-family">Câmbio & externo</span><span class="chip-name">Overshooting</span><span class="chip-desc">Dinâmica cambial (Dornbusch)</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-aloc" role="button" tabindex="0" data-model="capm" aria-label="Abrir CAPM"><span class="chip-family">Alocação</span><span class="chip-name">CAPM</span><span class="chip-desc">Precificação de ativos</span><span class="chip-cta">abrir &rsaquo;</span></div>
		<div class="term-chip clickable fam-aloc" role="button" tabindex="0" data-model="blackscholes" aria-label="Abrir Black-Scholes-Merton"><span class="chip-family">Derivativos</span><span class="chip-name">Black-Scholes-Merton</span><span class="chip-desc">Precificação de opções</span><span class="chip-cta">abrir &rsaquo;</span></div>
	</div>

	<div id="model-details" hidden>
		<div class="model-detail" id="md-taylor" data-title="Taylor Rule" data-sub="Regra de juros do banco central">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Proposta por John Taylor (1993), descreve como um banco central deve fixar a taxa de juros nominal de curto prazo reagindo a dois desvios: a inflação em relação à meta e o produto em relação ao potencial. Funciona como <strong>benchmark</strong> para julgar se a política monetária está apertada ou frouxa.</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">i = r* + &pi; + &alpha;(&pi; &minus; &pi;*) + &beta;&middot;hiato</div>
				<div class="model-eq">i = juro nominal &middot; r* = juro real neutro &middot; &pi; = inflação corrente</div>
				<div class="model-eq">&pi;* = meta &middot; hiato = produto &minus; potencial &middot; &alpha;,&beta; = pesos (Taylor: 0,5)</div>
				<p class="model-eqnote">Princípio de Taylor: o coeficiente da inflação na taxa <em>nominal</em> deve ser &gt; 1 (&alpha; &gt; 0) para estabilizar preços.</p>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>No Brasil, compara-se a Selic efetiva do COPOM contra a Taylor estimada (r* &asymp; 4,5&ndash;5%, meta 3%). Gap positivo indica BC acima da regra (contracionista); negativo, espaço para afrouxar.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>Selic acima da Taylor &rarr; juros reais altos favorecem renda fixa e pressionam múltiplos. Gap negativo antecipa corte &rarr; alongar duration (NTN-B), montar recebedor de juros. Bússola de ciclo e timing de curva.</p></div>
		</div>
		<div class="model-detail" id="md-phillips" data-title="Phillips Curve" data-sub="Trade-off inflação × desemprego">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Relação inversa de curto prazo entre inflação e desemprego (ou hiato). A versão moderna incorpora expectativas (Friedman-Phelps) e, na forma Nova-Keynesiana, expectativas <em>forward-looking</em>. No longo prazo a curva é vertical na NAIRU &mdash; sem trade-off permanente.</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">NKPC:&nbsp; &pi;<sub>t</sub> = &beta;&middot;E<sub>t</sub>[&pi;<sub>t+1</sub>] + &kappa;&middot;hiato<sub>t</sub> + u<sub>t</sub></div>
				<div class="model-eq">Adaptativa:&nbsp; &pi;<sub>t</sub> = &pi;<sup>e</sup><sub>t</sub> &minus; &gamma;(u<sub>t</sub> &minus; u*) + &epsilon;<sub>t</sub></div>
				<div class="model-eq">&kappa; = inclinação &middot; u* = NAIRU &middot; &pi;<sup>e</sup> = inflação esperada</div>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>O BCB usa curva de Phillips no modelo semiestrutural para projetar inflação, calibrando a sensibilidade ao hiato e ao câmbio. Na prática: cruzar desemprego (PNAD) com a inflação de serviços e núcleos.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>Trabalho apertado + hiato fechando &rarr; inflação de serviços persistente &rarr; BC mais <em>hawkish</em>. Orienta a leitura da inflação implícita (breakeven das NTN-B) e do prêmio de risco. Desancoragem achata a curva e muda o jogo.</p></div>
		</div>
		<div class="model-detail" id="md-islm" data-title="IS-LM" data-sub="Equilíbrio bens × moeda">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Modelo Hicks-Hansen do equilíbrio simultâneo entre o mercado de bens (curva IS) e o mercado monetário (curva LM), em economia fechada com preços rígidos no curto prazo. Determina conjuntamente a renda (Y) e o juro (i).</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">IS:&nbsp; Y = C(Y &minus; T) + I(i) + G</div>
				<div class="model-eq">LM:&nbsp; M / P = L(Y, i)</div>
				<div class="model-eq">I cai com i (IS negativa) &middot; demanda por moeda sobe com Y e cai com i</div>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>Analisa o efeito de política fiscal (desloca a IS) e monetária (desloca a LM) sobre juro e produto. Como hoje os BCs fixam o <em>juro</em>, usa-se a versão IS-MP, em que a LM vira a regra de juros do BC.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>Expansão fiscal com BC parado &rarr; pressão de juro e <em>crowding-out</em>. Aperto monetário &rarr; juro sobe, atividade cai. Mapa mental para ler choques de política e antecipar juros, câmbio e bolsa.</p></div>
		</div>
		<div class="model-detail" id="md-mundell" data-title="Mundell-Fleming" data-sub="Economia aberta">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Extensão do IS-LM para economia aberta com mobilidade de capital; acrescenta câmbio e setor externo (curva BP). Resultado central: a <strong>trindade impossível</strong> &mdash; não se pode ter ao mesmo tempo câmbio fixo, livre mobilidade de capital e política monetária independente.</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">IS:&nbsp; Y = C + I(i) + G + NX(e, Y, Y*)</div>
				<div class="model-eq">BP:&nbsp; i = i* + E[&Delta;e] + prêmio</div>
				<div class="model-eq">e = câmbio &middot; i* = juro externo &middot; NX = exportações líquidas</div>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>O Brasil opera câmbio flutuante + conta de capital aberta &rarr; mantém política monetária independente. Sob câmbio flutuante, expansão monetária (LM&rarr;direita) eleva Y e deprecia o real, que estimula as exportações líquidas.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>O diferencial Selic &minus; Fed e o prêmio de risco-país movem o real: corte de Selic ou alta do Fed pressionam o dólar &mdash; base da tese <em>long</em> dólar / <em>short</em> bolsa. Essencial para WDO, hedge cambial e fluxo estrangeiro na B3.</p></div>
		</div>
		<div class="model-detail" id="md-var" data-title="VAR" data-sub="Vetores autorregressivos">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Modelo econométrico multivariado (Sims, 1980) em que cada variável é explicada pelos próprios lags e pelos lags das demais, sem impor estrutura teórica forte. Usado para previsão, funções de impulso-resposta e decomposição da variância.</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">Y<sub>t</sub> = c + A<sub>1</sub>Y<sub>t&minus;1</sub> + &hellip; + A<sub>p</sub>Y<sub>t&minus;p</sub> + &epsilon;<sub>t</sub></div>
				<div class="model-eq">Y<sub>t</sub> = vetor n&times;1 &middot; A<sub>i</sub> = matrizes n&times;n</div>
				<div class="model-eq">SVAR: identifica choques estruturais (Cholesky / restrições)</div>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>Prever conjuntamente Selic, inflação, câmbio e atividade; estimar a resposta da inflação a um choque de juros (IRF); e decompor de onde vem a variância da inflação.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>Quantifica <em>como</em> e em <em>quanto tempo</em> um choque se propaga &mdash; a defasagem dá o timing. A resposta da inflação a um choque cambial dimensiona o <em>pass-through</em>; o IRF de juros ajuda a posicionar a curva antes do mercado.</p></div>
		</div>
		<div class="model-detail" id="md-nowcasting" data-title="Nowcasting" data-sub="Estimativa em tempo real">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Estimar, em tempo quase real, uma variável de baixa frequência e divulgação defasada (o PIB trimestral) a partir de um fluxo de indicadores de maior frequência, à medida que são publicados. Lida com o <em>ragged edge</em> &mdash; dados que chegam em datas diferentes.</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">Fator dinâmico:&nbsp; x<sub>t</sub> = &Lambda; f<sub>t</sub> + &epsilon;<sub>t</sub></div>
				<div class="model-eq">Estado:&nbsp; f<sub>t</sub> = A f<sub>t&minus;1</sub> + u<sub>t</sub></div>
				<div class="model-eq">Filtro de Kalman atualiza a estimativa a cada divulgação (também bridge / MIDAS)</div>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>BCB (via IBC-Br) e os Feds de NY/Atlanta (GDPNow) fazem nowcast do PIB. No Brasil: combinar IBC-Br, PMC, PMS, PIM e o Focus para antecipar o PIB antes do IBGE.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>Um bom nowcast reduz a surpresa nos dados &mdash; e surpresa de atividade move juro curto e bolsa. Quem antecipa a revisão se posiciona antes da reação e lê melhor a <em>data dependence</em> do BC.</p></div>
		</div>
		<div class="model-detail" id="md-nelson" data-title="Nelson-Siegel" data-sub="Modelagem da curva de juros">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Modelo paramétrico parcimonioso que ajusta toda a estrutura a termo das taxas de juros com poucos parâmetros interpretáveis como <strong>nível, inclinação e curvatura</strong>. A extensão Svensson acrescenta uma segunda corcova; Diebold-Li o torna dinâmico.</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">y(&tau;) = &beta;<sub>0</sub> + &beta;<sub>1</sub>&middot;[(1&minus;e<sup>&minus;&lambda;&tau;</sup>)/&lambda;&tau;] + &beta;<sub>2</sub>&middot;[(1&minus;e<sup>&minus;&lambda;&tau;</sup>)/&lambda;&tau; &minus; e<sup>&minus;&lambda;&tau;</sup>]</div>
				<div class="model-eq">&beta;<sub>0</sub> = nível &middot; &beta;<sub>1</sub> = inclinação &middot; &beta;<sub>2</sub> = curvatura &middot; &lambda; = posição da corcova</div>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>Suavizar e interpolar a curva DI/pré da B3 e a ETTJ da ANBIMA; extrair taxas <em>forward</em> implícitas; precificar vértices ilíquidos; construir os fatores nível/inclinação/curvatura. É o motor do projeto de Curva de Juros.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>Decompõe a curva em fatores negociáveis: apostar em <em>steepening</em>/<em>flattening</em> (inclinação), em corcova (curvatura) ou em nível. Base para DV01 por vértice, <em>carry &amp; rolldown</em> e estruturação de operações de juros.</p></div>
		</div>
		<div class="model-detail" id="md-blacklitt" data-title="Black-Litterman" data-sub="Alocação de portfólio">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Modelo de alocação (Goldman Sachs, 1990) que combina, num arcabouço bayesiano, o equilíbrio de mercado &mdash; os retornos implícitos na carteira de mercado, via <em>reverse optimization</em> &mdash; com as <em>views</em> do investidor. Corrige a instabilidade e os pesos extremos do Markowitz puro.</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">Equilíbrio:&nbsp; &Pi; = &delta;&middot;&Sigma;&middot;w<sub>mkt</sub></div>
				<div class="model-eq">Posterior:&nbsp; E[R] = [(&tau;&Sigma;)<sup>&minus;1</sup> + P&prime;&Omega;<sup>&minus;1</sup>P]<sup>&minus;1</sup>[(&tau;&Sigma;)<sup>&minus;1</sup>&Pi; + P&prime;&Omega;<sup>&minus;1</sup>Q]</div>
				<div class="model-eq">P,Q = views &middot; &Omega; = incerteza das views &middot; &tau; = confiança no prior &middot; &delta; = aversão a risco</div>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>Construir carteiras partindo do mercado e inclinando-as conforme teses (&ldquo;bolsa BR supera o S&amp;P em X%&rdquo;), cada <em>view</em> com seu grau de confiança. Evita os cantos e o <em>overfitting</em> do otimizador clássico. Aplica-se às carteiras de ETFs e BDRs.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>Traduz uma tese macro (real deprecia, juro cai) em inclinações <em>controladas</em> e diversificadas, em vez de apostas concentradas. Gera pesos mais estáveis e explicáveis &mdash; ideal para mandato fee-based e decks de clientes UHNW.</p></div>
		</div>
		<div class="model-detail" id="md-solow" data-title="Solow" data-sub="Crescimento de longo prazo">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Modelo de crescimento neoclássico (Solow-Swan, 1956) que explica o produto por trabalhador a partir da acumulação de capital, com retornos decrescentes. A economia converge para um <strong>estado estacionário</strong> onde a poupança apenas repõe a depreciação e o crescimento populacional; no longo prazo, só o progresso tecnológico sustenta o crescimento da renda per capita.</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">&Delta;k = s&middot;f(k) &minus; (n + &delta;)k</div>
				<div class="model-eq">Estado estacionário:&nbsp; s&middot;f(k*) = (n + &delta;)k*</div>
				<div class="model-eq">f(k) = A&middot;k<sup>&alpha;</sup> &middot; s = poupança &middot; n = cresc. pop. &middot; &delta; = depreciação</div>
				<p class="model-eqnote">Regra de ouro: a poupança que maximiza o consumo no estado estacionário satisfaz f&prime;(k) = n + &delta;.</p>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>Explica por que países pobres <em>podem</em> crescer mais rápido (convergência) e por que aumentar a poupança eleva o nível de renda, mas não a taxa de crescimento de longo prazo. Enquadra o debate de produtividade (PTF) e investimento no Brasil.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>Define a <em>taxa de crescimento potencial</em> &mdash; âncora para juro neutro (r*), trajetória fiscal e retorno estrutural de ativos. Produtividade estagnada limita o PIB potencial e, com ele, o retorno de longo prazo da bolsa e o espaço fiscal.</p></div>
		</div>
		<div class="model-detail" id="md-dornbusch" data-title="Overshooting" data-sub="Dinâmica cambial (Dornbusch)">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Modelo de <em>overshooting</em> cambial (Dornbusch, 1976): como preços de bens são rígidos no curto prazo mas o câmbio é um preço de ativo que se ajusta na hora, um choque monetário faz o câmbio <strong>ultrapassar</strong> (overshoot) seu novo nível de longo prazo e só depois convergir. Une expectativas racionais, paridade de juros e rigidez de preços.</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">UIP:&nbsp; i = i* + E[&Delta;e]</div>
				<div class="model-eq">Curto prazo: preços fixos &rarr; e salta além do equilíbrio</div>
				<div class="model-eq">Longo prazo: e converge para a paridade (PPC)</div>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>Explica por que o câmbio é tão mais volátil que os fundamentos: a maior parte do movimento é o <em>overshoot</em> inicial e sua reversão. Enquadra a reação do real a surpresas de COPOM/Fed e a choques de risco.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>O overshooting é a <em>oportunidade</em> e o <em>risco</em> do trade de câmbio: o salto inicial costuma exagerar, abrindo espaço para reversão (mean-reversion) depois do choque. Fundamental para timing de WDO, estruturação de hedge e dimensionar stops em posições cambiais.</p></div>
		</div>
		<div class="model-detail" id="md-capm" data-title="CAPM" data-sub="Precificação de ativos">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Capital Asset Pricing Model (Sharpe, 1964): em equilíbrio, o retorno esperado de um ativo é o juro livre de risco mais um prêmio proporcional ao seu <strong>beta</strong> &mdash; a parcela de risco que não se elimina por diversificação (risco sistemático). A relação linear entre beta e retorno esperado é a <em>Linha do Mercado de Títulos</em> (SML).</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">E[R<sub>i</sub>] = R<sub>f</sub> + &beta;<sub>i</sub>&middot;(E[R<sub>m</sub>] &minus; R<sub>f</sub>)</div>
				<div class="model-eq">&beta;<sub>i</sub> = Cov(R<sub>i</sub>, R<sub>m</sub>) / Var(R<sub>m</sub>)</div>
				<div class="model-eq">R<sub>f</sub> = livre de risco &middot; (E[R<sub>m</sub>]&minus;R<sub>f</sub>) = prêmio de mercado</div>
				<p class="model-eqnote">Extensões (Fama-French, Carhart) acrescentam fatores de tamanho, valor e momentum ao prêmio de risco.</p>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>Base do custo de capital próprio (K<sub>e</sub>) usado em DCF e <em>valuation</em>, e referência para avaliar se um ativo entrega retorno coerente com seu risco. No Brasil, R<sub>f</sub> parte da NTN-B / Selic e o prêmio exige ajuste de risco-país.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>Separa <em>alfa</em> (retorno acima do justo pelo risco) de <em>beta</em> (exposição ao mercado) &mdash; o que justifica, ou não, a taxa de gestão. Serve para montar carteiras por beta-alvo, medir performance ajustada ao risco e dimensionar o hedge sistemático (ex.: WIN).</p></div>
		</div>
		<div class="model-detail" id="md-blackscholes" data-title="Black-Scholes-Merton" data-sub="Precificação de opções">
			<div class="model-section"><h4><span>01</span> Teoria</h4><p>Modelo de precificação de opções (Black, Scholes e Merton, 1973): sob ausência de arbitragem e <em>hedge</em> dinâmico, deriva o preço justo de uma opção europeia. Introduz a ideia de que o valor da opção depende da volatilidade do ativo, não do seu retorno esperado &mdash; e que se pode replicá-la com uma carteira de ativo e caixa (delta-hedge).</p></div>
			<div class="model-section"><h4><span>02</span> Equações</h4>
				<div class="model-eq">C = S&middot;N(d<sub>1</sub>) &minus; K&middot;e<sup>&minus;rT</sup>&middot;N(d<sub>2</sub>)</div>
				<div class="model-eq">d<sub>1</sub> = [ln(S/K) + (r + &sigma;&sup2;/2)T] / (&sigma;&radic;T)</div>
				<div class="model-eq">d<sub>2</sub> = d<sub>1</sub> &minus; &sigma;&radic;T &middot; &sigma; = volatilidade &middot; T = prazo</div>
				<p class="model-eqnote">Gregas: &part;C/&part;S = delta &middot; &part;C/&part;&sigma; = vega &middot; &part;C/&part;t = theta.</p>
			</div>
			<div class="model-section"><h4><span>03</span> Aplicação prática</h4><p>Precificar opções e, sobretudo, inverter a fórmula para extrair a <strong>volatilidade implícita</strong> &mdash; o número que o mercado realmente negocia. Base das gregas (delta, gamma, theta, vega) que governam o <em>hedge</em> e o risco de uma mesa de opções.</p></div>
			<div class="model-section invest"><h4><span>04</span> Para investimentos</h4><p>É o ferramental direto da sua tesouraria/mesa: o valor-tempo (prêmio acima do intrínseco) é o que se vende em estruturas de <em>theta</em> positivo (covered calls, travas); vega e gamma medem a exposição a mudanças de volatilidade. Ler a superfície de vol implícita separa opção cara de barata.</p></div>
		</div>
	</div>

	<div class="model-modal" id="model-modal" hidden>
		<div class="model-modal-backdrop" data-close></div>
		<div class="model-modal-panel" role="dialog" aria-modal="true" aria-labelledby="model-modal-title">
			<div class="model-modal-head">
				<div>
					<div class="model-modal-kicker">Modelo econômico</div>
					<h3 id="model-modal-title"></h3>
					<div class="model-modal-sub"></div>
				</div>
				<button type="button" class="model-modal-close" data-close aria-label="Fechar">&times;</button>
			</div>
			<div class="model-modal-body"></div>
		</div>
	</div>

	<script>
/* ===== Modelos Econômicos — gráficos dinâmicos (Chart.js v4) ===== */
(function(){
  var C = { grid:'rgba(255,255,255,0.06)', text:'#8b949e', blue:'#4da3ff', gold:'#f0a830',
            green:'#3fb950', red:'#f85149', violet:'#a371f7', panel:'#161c21', border:'#2a3138' };
  function lin(a,b,n){ var o=[],i,s=(b-a)/(n-1); for(i=0;i<n;i++) o.push(a+s*i); return o; }
  function r2(x){ return Math.round(x*100)/100; }
  function ncdf(x){ var t=1/(1+0.2316419*Math.abs(x)); var d=0.3989423*Math.exp(-x*x/2);
    var p=d*t*(0.3193815+t*(-0.3565638+t*(1.781478+t*(-1.821256+t*1.330274)))); return x>0?1-p:p; }
  function opts(xl,yl,ysuffix){ return { responsive:true, maintainAspectRatio:false,
    animation:{duration:600}, interaction:{intersect:false,mode:'index'},
    plugins:{ legend:{display:true,position:'top',labels:{color:C.text,font:{size:10},usePointStyle:true,boxWidth:7,padding:10}},
      tooltip:{backgroundColor:C.panel,borderColor:C.border,borderWidth:1,titleColor:'#e6e6e6',bodyColor:'#e6e6e6',padding:8,titleFont:{size:11},bodyFont:{size:11}} },
    scales:{ x:{ type:'linear', title:{display:!!xl,text:xl,color:C.text,font:{size:10}}, grid:{color:C.grid}, ticks:{color:C.text,font:{size:9},maxTicksLimit:9} },
      y:{ title:{display:!!yl,text:yl,color:C.text,font:{size:10}}, grid:{color:C.grid}, ticks:{color:C.text,font:{size:9}, callback:function(v){return ysuffix?(r2(v)+ysuffix):r2(v);}} } } }; }
  function xy(xs,ys){ return xs.map(function(x,i){return {x:r2(x),y:r2(ys[i])};}); }
  function ds(label,data,color,extra){ var o={label:label,data:data,borderColor:color,backgroundColor:color,
    borderWidth:2,pointRadius:0,pointHoverRadius:4,tension:0.25,fill:false}; if(extra) for(var k in extra) o[k]=extra[k]; return o; }

  var MC = {};

  // 1 Taylor
  MC.taylor = { cap:'Juro prescrito pela regra conforme a inflação corrente — a inclinação (1+α) mede a firmeza da reação. Com o gap em 0 e π=π*, i cai no juro neutro.',
    ctl:[{id:'a',label:'α — peso da inflação',min:0,max:1.5,step:0.05,val:0.5,fmt:function(v){return v.toFixed(2);}},
         {id:'h',label:'Hiato do produto (%)',min:-4,max:4,step:0.5,val:0,fmt:function(v){return v.toFixed(1);}}],
    make:function(p){ var pi=lin(0,10,41), rst=4.5, pis=3;
      var i=pi.map(function(x){return rst+x+p.a*(x-pis)+0.5*p.h;});
      return {type:'line', data:{datasets:[ds('Juro prescrito i (%)',xy(pi,i),C.gold,{fill:true,backgroundColor:'rgba(240,168,48,0.08)'}),
        ds('Meta π* = 3%',[{x:3,y:0},{x:3,y:20}],C.text,{borderDash:[4,4],borderWidth:1})]}, options:opts('Inflação π (%)','Juro i (%)','%')}; } };

  // 2 Phillips
  MC.phillips = { cap:'Curva de curto prazo: mais desemprego, menos inflação. Elevar a inflação esperada desloca a curva para cima. No longo prazo ela é vertical na NAIRU (u*=8%).',
    ctl:[{id:'pe',label:'Inflação esperada πᵉ (%)',min:0,max:8,step:0.5,val:4,fmt:function(v){return v.toFixed(1);}}],
    make:function(p){ var u=lin(3,13,41), us=8;
      var pi=u.map(function(x){return p.pe-0.8*(x-us);});
      return {type:'line', data:{datasets:[ds('Curva de curto prazo',xy(u,pi),C.blue),
        ds('Longo prazo (NAIRU)',[{x:8,y:-4},{x:8,y:12}],C.red,{borderDash:[5,4],borderWidth:1.5})]}, options:opts('Desemprego u (%)','Inflação π (%)','%')}; } };

  // 3 IS-LM
  MC.islm = { cap:'Equilíbrio onde IS (bens) encontra LM (moeda). Política fiscal desloca a IS; a monetária, a LM — e o ponto de cruzamento define juro e produto.',
    ctl:[{id:'g',label:'Política fiscal (desloca IS)',min:-3,max:3,step:0.5,val:0,fmt:function(v){return (v>=0?'+':'')+v.toFixed(1);}},
         {id:'m',label:'Política monetária (desloca LM)',min:-3,max:3,step:0.5,val:0,fmt:function(v){return (v>=0?'+':'')+v.toFixed(1);}}],
    make:function(p){ var Y=lin(0,10,41);
      var is=Y.map(function(y){return 9-0.7*y+p.g;}), lm=Y.map(function(y){return 0.8*y-2-p.m;});
      // equilíbrio: 9-0.7Y+g = 0.8Y-2-m -> Y*=(11+g+m)/1.5
      var Ye=(11+p.g+p.m)/1.5, ie=0.8*Ye-2-p.m;
      return {type:'line', data:{datasets:[ds('IS (bens)',xy(Y,is),C.blue),ds('LM (moeda)',xy(Y,lm),C.gold),
        {label:'Equilíbrio',data:[{x:r2(Ye),y:r2(ie)}],borderColor:C.green,backgroundColor:C.green,pointRadius:5,pointHoverRadius:6,showLine:false}]}, options:opts('Produto Y','Juro i','')}; } };

  // 4 Mundell-Fleming
  MC.mundell = { cap:'Câmbio flutuante + capital livre: a expansão monetária (LM→direita) eleva Y ao longo da linha BP; o juro volta a i* e o real deprecia. Mostra por que a política monetária funciona sob câmbio flutuante.',
    ctl:[{id:'m',label:'Expansão monetária',min:0,max:4,step:0.5,val:0,fmt:function(v){return '+'+v.toFixed(1);}}],
    make:function(p){ var Y=lin(0,10,41), istar=4;
      var is=Y.map(function(y){return 9-0.7*y;}), lm=Y.map(function(y){return 0.8*y-2-p.m;});
      var Ye=(11+p.m)/1.5;
      return {type:'line', data:{datasets:[ds('IS',xy(Y,is),C.blue),ds('LM',xy(Y,lm),C.gold),
        ds('BP (i = i*)',[{x:0,y:istar},{x:10,y:istar}],C.green,{borderDash:[5,4],borderWidth:1.5}),
        {label:'Equilíbrio',data:[{x:r2(Ye),y:istar}],borderColor:C.violet,backgroundColor:C.violet,pointRadius:5,showLine:false}]}, options:opts('Produto Y','Juro i','')}; } };

  // 5 VAR (IRF)
  MC.var = { cap:'Função impulso-resposta: efeito de um choque de +X bps na Selic sobre inflação e produto ao longo dos meses. A resposta é defasada e some com o tempo — o timing está na defasagem.',
    ctl:[{id:'s',label:'Choque na Selic (bps)',min:25,max:150,step:25,val:100,fmt:function(v){return v+' bps';}}],
    make:function(p){ var t=lin(0,24,25), k=p.s/100;
      var inf=t.map(function(x){return -k*0.9*(x/3)*Math.exp(-x/5);});
      var gap=t.map(function(x){return -k*1.4*(x/2.5)*Math.exp(-x/4.5);});
      return {type:'line', data:{datasets:[ds('Inflação',xy(t,inf),C.gold),ds('Produto',xy(t,gap),C.blue)]}, options:opts('Meses após o choque','Desvio (p.p.)','')}; } };

  // 6 Nowcasting
  MC.nowcasting = { cap:'A cada nova divulgação de dados de alta frequência, a estimativa do PIB (nowcast) converge para o valor oficial e sua incerteza encolhe. Deslize para incorporar mais divulgações.',
    ctl:[{id:'r',label:'Divulgações incorporadas',min:1,max:8,step:1,val:3,fmt:function(v){return v+' / 8';}}],
    make:function(p){ var rel=lin(1,8,8), actual=2.4;
      var seed=[3.6,1.3,2.9,2.0,2.6,2.3,2.45,2.4];
      var now=rel.map(function(x,i){ var w=Math.min(i+1,p.r); var frac=(w-1)/7;
        return i< p.r ? (seed[i]*(1-frac)+actual*frac) : null; });
      return {type:'line', data:{datasets:[
        ds('Nowcast do PIB (%)',xy(rel,now).filter(function(d){return d.y!==null;}),C.gold,{spanGaps:true,pointRadius:3}),
        ds('PIB oficial (%)',[{x:1,y:actual},{x:8,y:actual}],C.green,{borderDash:[5,4],borderWidth:1.5})]}, options:opts('Divulgação nº','Var. do PIB (%)','%')}; } };

  // 7 Nelson-Siegel
  MC.nelson = { cap:'Monte a curva com três fatores: nível (β₀), inclinação (β₁) e curvatura (β₂); λ posiciona a corcova. É assim que se interpola a curva DI e se negociam steepening, flattening e corcova.',
    ctl:[{id:'b1',label:'β₁ — inclinação',min:-6,max:6,step:0.5,val:-2,fmt:function(v){return v.toFixed(1);}},
         {id:'b2',label:'β₂ — curvatura',min:-6,max:6,step:0.5,val:3,fmt:function(v){return v.toFixed(1);}},
         {id:'lb',label:'λ — posição da corcova',min:0.3,max:2,step:0.1,val:0.6,fmt:function(v){return v.toFixed(1);}}],
    make:function(p){ var tau=lin(0.1,10,41), b0=10;
      var y=tau.map(function(t){ var a=(1-Math.exp(-p.lb*t))/(p.lb*t);
        return b0+p.b1*a+p.b2*(a-Math.exp(-p.lb*t)); });
      return {type:'line', data:{datasets:[ds('Curva y(τ) (% a.a.)',xy(tau,y),C.gold,{fill:true,backgroundColor:'rgba(240,168,48,0.07)'}),
        ds('Nível β₀',[{x:0,y:b0},{x:10,y:b0}],C.text,{borderDash:[4,4],borderWidth:1})]}, options:opts('Prazo τ (anos)','Taxa (% a.a.)','%')}; } };

  // 8 Black-Litterman
  MC.blacklitt = { cap:'Partindo dos pesos de mercado, a view (ex.: sobreponderar bolsa BR) inclina a carteira conforme sua confiança. Confiança baixa ≈ mercado; confiança alta puxa para a aposta — sem os extremos do Markowitz puro.',
    ctl:[{id:'c',label:'Confiança na view (%)',min:0,max:100,step:10,val:50,fmt:function(v){return v+'%';}}],
    make:function(p){ var labels=['Bolsa BR','S&P 500','Renda fixa','Caixa'];
      var mkt=[25,35,30,10], view=[45,25,25,5], c=p.c/100;
      var bl=mkt.map(function(m,i){return r2(m+(view[i]-m)*c);});
      return {type:'bar', data:{labels:labels, datasets:[
        {label:'Mercado',data:mkt,backgroundColor:'rgba(139,148,165,0.55)',borderColor:C.text,borderWidth:1},
        {label:'Black-Litterman',data:bl,backgroundColor:'rgba(240,168,48,0.7)',borderColor:C.gold,borderWidth:1}]},
        options:(function(){var o=opts('','Peso (%)','%');o.scales.x={type:'category',grid:{color:C.grid},ticks:{color:C.text,font:{size:9}}};return o;})()}; } };

  // 9 Solow
  MC.solow = { cap:'Diagrama de Solow: o estado estacionário k* está onde o investimento s·f(k) cruza a reposição (n+δ)k. Mais poupança eleva k* e a renda — mas não a taxa de crescimento de longo prazo.',
    ctl:[{id:'s',label:'Taxa de poupança s',min:0.1,max:0.5,step:0.02,val:0.25,fmt:function(v){return v.toFixed(2);}},
         {id:'d',label:'(n + δ) — reposição',min:0.02,max:0.12,step:0.01,val:0.06,fmt:function(v){return v.toFixed(2);}}],
    make:function(p){ var k=lin(0,120,61), A=1, al=0.4;
      var f=k.map(function(x){return A*Math.pow(x,al);});
      var inv=k.map(function(x){return p.s*A*Math.pow(x,al);});
      var dep=k.map(function(x){return p.d*x;});
      var kstar=Math.pow(p.s*A/p.d,1/(1-al)), ystar=A*Math.pow(kstar,al);
      return {type:'line', data:{datasets:[ds('Produto f(k)',xy(k,f),C.text,{borderWidth:1.5}),
        ds('Investimento s·f(k)',xy(k,inv),C.blue,{fill:true,backgroundColor:'rgba(77,163,255,0.06)'}),
        ds('Reposição (n+δ)k',xy(k,dep),C.red),
        {label:'k* (estacionário)',data:[{x:r2(kstar),y:r2(p.s*A*Math.pow(kstar,al))}],borderColor:C.green,backgroundColor:C.green,pointRadius:5,showLine:false}]}, options:opts('Capital por trabalhador k','Produto / investimento','')}; } };

  // 10 Dornbusch overshooting
  MC.dornbusch = { cap:'Choque monetário: o câmbio salta além do novo equilíbrio (overshooting) e só então converge, enquanto os preços sobem devagar. É por isso que o câmbio é bem mais volátil que os fundamentos.',
    ctl:[{id:'m',label:'Choque monetário (%)',min:1,max:10,step:1,val:5,fmt:function(v){return '+'+v+'%';}}],
    make:function(p){ var t=lin(0,36,49), e0=5.0, elong=e0*(1+p.m/100), ejump=elong*(1+p.m/100*0.9);
      var e=t.map(function(x){ return x===0? e0 : elong+(ejump-elong)*Math.exp(-x/8); });
      var pr=t.map(function(x){ return e0*(1+(p.m/100)*(1-Math.exp(-x/10))); }); // nível de preços (base)
      // câmbio salta em t=0+:
      e[0]=e0;
      return {type:'line', data:{datasets:[ds('Câmbio (R$/US$)',xy(t,e),C.gold,{stepped:false}),
        ds('Nível de preços (índice)',xy(t,pr),C.blue,{borderDash:[4,3]}),
        ds('Novo equilíbrio',[{x:0,y:r2(elong)},{x:36,y:r2(elong)}],C.text,{borderDash:[2,3],borderWidth:1})]}, options:opts('Meses após o choque','R$/US$ · índice','')}; } };

  // 11 CAPM
  MC.capm = { cap:'Linha do Mercado de Títulos (SML): o retorno exigido sobe linearmente com o beta. Acima da linha, o ativo está barato (alfa positivo); abaixo, caro. Ajuste o prêmio de risco de mercado.',
    ctl:[{id:'erp',label:'Prêmio de risco de mercado (%)',min:2,max:10,step:0.5,val:6,fmt:function(v){return v.toFixed(1)+'%';}}],
    make:function(p){ var b=lin(0,2,41), rf=10;
      var sml=b.map(function(x){return rf+x*p.erp;});
      var assets=[{x:0.6,y:rf+0.6*p.erp+1.5,n:'A'},{x:1.0,y:rf+1.0*p.erp,n:'M'},{x:1.4,y:rf+1.4*p.erp-2,n:'B'}];
      return {type:'line', data:{datasets:[ds('SML',xy(b,sml),C.gold),
        {label:'Ativos',data:assets,borderColor:C.blue,backgroundColor:C.blue,pointRadius:5,pointHoverRadius:6,showLine:false},
        {label:'R_f',data:[{x:0,y:rf}],borderColor:C.green,backgroundColor:C.green,pointRadius:4,showLine:false}]}, options:opts('Beta (risco sistemático)','Retorno esperado (%)','%')}; } };

  // 12 Black-Scholes
  MC.blackscholes = { cap:'Preço de uma call pelo Black-Scholes versus o valor intrínseco. A distância entre as curvas é o valor-tempo — o que a mesa vende em estruturas de theta. Ele cresce com a volatilidade e com o prazo.',
    ctl:[{id:'v',label:'Volatilidade σ (%)',min:10,max:60,step:5,val:30,fmt:function(v){return v+'%';}},
         {id:'t',label:'Prazo T (anos)',min:0.05,max:1,step:0.05,val:0.5,fmt:function(v){return v.toFixed(2);}}],
    make:function(p){ var S=lin(50,150,51), K=100, r=0.10, sig=p.v/100, T=p.t;
      var bs=S.map(function(x){ if(T<=0||sig<=0) return Math.max(x-K,0);
        var d1=(Math.log(x/K)+(r+sig*sig/2)*T)/(sig*Math.sqrt(T)); var d2=d1-sig*Math.sqrt(T);
        return x*ncdf(d1)-K*Math.exp(-r*T)*ncdf(d2); });
      var intr=S.map(function(x){return Math.max(x-K,0);});
      return {type:'line', data:{datasets:[ds('Preço BS da call',xy(S,bs),C.gold,{fill:true,backgroundColor:'rgba(240,168,48,0.08)'}),
        ds('Valor intrínseco',xy(S,intr),C.blue,{borderDash:[5,4]})]}, options:opts('Preço do ativo S (K=100)','Prêmio da opção','')}; } };

  window.__MODEL_CHARTS = MC;
})();


  (function(){
    var modal=document.getElementById('model-modal'); if(!modal) return;
    var body=modal.querySelector('.model-modal-body');
    var titleEl=modal.querySelector('#model-modal-title');
    var subEl=modal.querySelector('.model-modal-sub');
    var store=document.getElementById('model-details');
    var MC=window.__MODEL_CHARTS||{};
    var chart=null, lastFocus=null;

    function buildViz(key){
      var spec=MC[key]; if(!spec||typeof Chart==='undefined') return null;
      var wrap=document.createElement('div'); wrap.className='model-section model-viz';
      var params={}; (spec.ctl||[]).forEach(function(c){params[c.id]=c.val;});
      var ctlHTML='';
      (spec.ctl||[]).forEach(function(c){
        ctlHTML+='<label class="model-ctl"><span>'+c.label+'</span>'+
          '<input type="range" data-p="'+c.id+'" min="'+c.min+'" max="'+c.max+'" step="'+c.step+'" value="'+c.val+'">'+
          '<output>'+c.fmt(c.val)+'</output></label>';
      });
      wrap.innerHTML='<h4><span>&#9670;</span> Visualização</h4>'+
        '<div class="model-chart"><canvas></canvas></div>'+
        (ctlHTML?'<div class="model-controls">'+ctlHTML+'</div>':'')+
        '<p class="model-chart-cap">'+spec.cap+'</p>';
      // instancia depois de inserido no DOM
      setTimeout(function(){
        var cv=wrap.querySelector('canvas'); if(!cv) return;
        var cfg=spec.make(params); chart=new Chart(cv,cfg);
        wrap.querySelectorAll('input[type=range]').forEach(function(inp){
          inp.addEventListener('input',function(){
            var c=(spec.ctl||[]).filter(function(x){return x.id===inp.getAttribute('data-p');})[0];
            params[inp.getAttribute('data-p')]=parseFloat(inp.value);
            inp.parentNode.querySelector('output').textContent=c.fmt(parseFloat(inp.value));
            var nc=spec.make(params);
            chart.data.labels=nc.data.labels; chart.data.datasets=nc.data.datasets;
            chart.options=nc.options; chart.update('none');
          });
        });
      },30);
      return wrap;
    }

    function open(key){
      var src=store.querySelector('#md-'+key); if(!src) return;
      titleEl.textContent=src.getAttribute('data-title')||'';
      subEl.textContent=src.getAttribute('data-sub')||'';
      if(chart){chart.destroy();chart=null;}
      body.innerHTML='';
      var secs=src.querySelectorAll('.model-section');
      // Ordem: Teoria, Visualização, Equações, Aplicação, Investimentos
      if(secs[0]) body.appendChild(secs[0].cloneNode(true));
      var viz=buildViz(key); if(viz) body.appendChild(viz);
      for(var i=1;i<secs.length;i++) body.appendChild(secs[i].cloneNode(true));
      body.scrollTop=0;
      modal.hidden=false; document.body.style.overflow='hidden';
      requestAnimationFrame(function(){modal.classList.add('is-open');});
      lastFocus=document.activeElement; modal.querySelector('.model-modal-close').focus();
    }
    function close(){
      modal.classList.remove('is-open'); document.body.style.overflow='';
      if(chart){chart.destroy();chart=null;}
      setTimeout(function(){modal.hidden=true; body.innerHTML='';},180);
      if(lastFocus&&lastFocus.focus) lastFocus.focus();
    }
    document.querySelectorAll('.term-chip.clickable').forEach(function(c){
      c.addEventListener('click',function(){open(c.getAttribute('data-model'));});
      c.addEventListener('keydown',function(e){ if(e.key==='Enter'||e.key===' '){e.preventDefault();open(c.getAttribute('data-model'));} });
    });
    modal.addEventListener('click',function(e){ if(e.target.hasAttribute('data-close')) close(); });
    document.addEventListener('keydown',function(e){ if(e.key==='Escape'&&!modal.hidden) close(); });
  })();

	</script>
</section>

<!-- 20 FERRAMENTAS -->
<section class="term-module" id="ferramentas">
	<div class="term-module-header">
		<span class="term-module-num">20</span>
		<h2>Calculadoras &amp; Ferramentas</h2>
		<span class="term-module-tag model">Interativo</span>
	</div>
	<div class="term-calc-grid">

		<!-- Calculadora 1: Juro Real (Fisher) -->
		<div class="term-calc">
			<div class="term-calc-title">Juro Real (Fisher)</div>
			<label>Taxa nominal (% a.a.)<input type="number" id="calc-fisher-nom" value="14.25" step="0.01"></label>
			<label>Inflação esperada (% a.a.)<input type="number" id="calc-fisher-inf" value="4.50" step="0.01"></label>
			<div class="term-calc-result">Juro real: <span id="calc-fisher-out">—</span></div>
			<div class="term-calc-formula">(1+i)/(1+π) − 1</div>
		</div>

		<!-- Calculadora 2: Equivalência de Taxas -->
		<div class="term-calc">
			<div class="term-calc-title">Equivalência de Taxas</div>
			<label>Taxa (%)<input type="number" id="calc-eq-taxa" value="1.00" step="0.01"></label>
			<label>De (dias)<input type="number" id="calc-eq-de" value="30" step="1"></label>
			<label>Para (dias)<input type="number" id="calc-eq-para" value="252" step="1"></label>
			<div class="term-calc-result">Taxa equivalente: <span id="calc-eq-out">—</span></div>
			<div class="term-calc-formula">(1+i)^(np/nd) − 1</div>
		</div>

		<!-- Calculadora 3: Valor Presente -->
		<div class="term-calc">
			<div class="term-calc-title">Valor Presente</div>
			<label>Valor futuro (R$)<input type="number" id="calc-vp-vf" value="1000" step="1"></label>
			<label>Taxa (% a.a.)<input type="number" id="calc-vp-taxa" value="14.25" step="0.01"></label>
			<label>Prazo (anos)<input type="number" id="calc-vp-n" value="2" step="0.1"></label>
			<div class="term-calc-result">Valor presente: <span id="calc-vp-out">—</span></div>
			<div class="term-calc-formula">VF / (1+i)^n</div>
		</div>

		<!-- Calculadora 4: Break-even Inflation -->
		<div class="term-calc">
			<div class="term-calc-title">Break-even Inflation</div>
			<label>Taxa prefixada (% a.a.)<input type="number" id="calc-be-pre" value="14.00" step="0.01"></label>
			<label>Taxa NTN-B real (% a.a.)<input type="number" id="calc-be-real" value="7.00" step="0.01"></label>
			<div class="term-calc-result">Inflação implícita: <span id="calc-be-out">—</span></div>
			<div class="term-calc-formula">(1+pré)/(1+real) − 1</div>
		</div>

	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Calculadoras funcionais — altere os valores e o resultado recalcula automaticamente. Ferramentas do dia a dia de renda fixa e política monetária.</p>
</section>

</div><!-- .term-content -->
</div><!-- .term-layout -->
