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
		<span class="term-module-tag model">Leitura</span>
	</div>
	<div class="term-heatmap">
		<div class="heat-cell heat-up"><div class="heat-label">Inflação</div><div class="heat-arrow">▲</div></div>
		<div class="heat-cell heat-down"><div class="heat-label">Atividade</div><div class="heat-arrow">▼</div></div>
		<div class="heat-cell heat-up"><div class="heat-label">Emprego</div><div class="heat-arrow">▲</div></div>
		<div class="heat-cell heat-down"><div class="heat-label">Fiscal</div><div class="heat-arrow">▼</div></div>
		<div class="heat-cell heat-down"><div class="heat-label">Crédito</div><div class="heat-arrow">▼</div></div>
		<div class="heat-cell heat-flat"><div class="heat-label">Confiança</div><div class="heat-arrow">→</div></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Leitura qualitativa ilustrativa. Versão futura calculará automaticamente a direção de cada dimensão a partir das séries.</p>
</section>

<!-- 16 CENÁRIOS -->
<section class="term-module" id="cenarios">
	<div class="term-module-header">
		<span class="term-module-num">16</span>
		<h2>Cenários Projetados</h2>
		<span class="term-module-tag model">Projeção</span>
	</div>
	<div class="term-grid">
		<div class="term-card"><div class="term-card-label">Base · PIB</div><div class="term-card-value" style="font-size:1.2rem;">2,2%</div><div class="term-card-sub">IPCA 5,0% · Selic 13,5%</div></div>
		<div class="term-card"><div class="term-card-label">Otimista · PIB</div><div class="term-card-value up" style="font-size:1.2rem;">3,0%</div><div class="term-card-sub">IPCA 4,2% · Selic 12,0%</div></div>
		<div class="term-card"><div class="term-card-label">Pessimista · PIB</div><div class="term-card-value down" style="font-size:1.2rem;">0,8%</div><div class="term-card-sub">IPCA 6,5% · Selic 15,0%</div></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Valores ilustrativos. Versão futura: simulador interativo onde o usuário altera premissas e vê impactos em renda fixa, ações e câmbio.</p>
</section>

<!-- 17 IMPACTO POR CLASSE DE ATIVOS -->
<section class="term-module" id="impacto">
	<div class="term-module-header">
		<span class="term-module-num">17</span>
		<h2>Impacto por Classe de Ativos</h2>
		<span class="term-module-tag model">Matriz</span>
	</div>
	<table class="term-table">
		<thead>
			<tr><th>Evento</th><th>Ações</th><th>Juros (RF)</th><th>Dólar</th><th>Ouro</th><th>FIIs</th></tr>
		</thead>
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
		<span class="term-module-tag model">Research</span>
	</div>
	<div class="term-insights">
		<article class="term-insight">
			<div class="insight-date">Jun · 2026</div>
			<h3 class="insight-title">Selic em 14,25% e o juro real ex-ante elevado</h3>
			<p class="insight-body">Com a Selic em patamar contracionista e a inflação esperada ancorada próxima do teto da meta, o juro real ex-ante permanece em território historicamente alto. O posicionamento em prefixados e NTN-Bs longas depende da convicção sobre o início do ciclo de corte — que a curva DI ainda precifica de forma conservadora.</p>
		</article>
		<article class="term-insight">
			<div class="insight-date">Jun · 2026</div>
			<h3 class="insight-title">Câmbio e o diferencial de juros</h3>
			<p class="insight-body">O real segue sensível ao diferencial de juros entre Brasil e EUA e ao apetite global por risco. O carry elevado sustenta o fluxo, mas a assimetria fiscal doméstica mantém o prêmio de risco como principal vetor de volatilidade do USD/BRL.</p>
		</article>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Notas de conjuntura autorais. Novas análises são publicadas periodicamente conforme os movimentos macro relevantes.</p>
</section>

<!-- 19 MODELOS ECONÔMICOS -->
<section class="term-module" id="modelos">
	<div class="term-module-header">
		<span class="term-module-num">19</span>
		<h2>Modelos Econômicos</h2>
		<span class="term-module-tag model">Referência</span>
	</div>
	<p class="term-prose" style="font-size:0.74rem;margin-bottom:1em;">Clique em um modelo para abrir teoria, equações, aplicação prática e leitura para investimentos.</p>
	<div class="term-chips">
		<button type="button" class="term-chip clickable" data-model="taylor" aria-haspopup="dialog">Taylor Rule<div class="chip-desc">Regra de juros do banco central</div><span class="chip-cta">abrir &rsaquo;</span></button>
		<button type="button" class="term-chip clickable" data-model="phillips" aria-haspopup="dialog">Phillips Curve<div class="chip-desc">Trade-off inflação × desemprego</div><span class="chip-cta">abrir &rsaquo;</span></button>
		<button type="button" class="term-chip clickable" data-model="islm" aria-haspopup="dialog">IS-LM<div class="chip-desc">Equilíbrio bens × moeda</div><span class="chip-cta">abrir &rsaquo;</span></button>
		<button type="button" class="term-chip clickable" data-model="mundell" aria-haspopup="dialog">Mundell-Fleming<div class="chip-desc">Economia aberta</div><span class="chip-cta">abrir &rsaquo;</span></button>
		<button type="button" class="term-chip clickable" data-model="var" aria-haspopup="dialog">VAR<div class="chip-desc">Vetores autorregressivos</div><span class="chip-cta">abrir &rsaquo;</span></button>
		<button type="button" class="term-chip clickable" data-model="nowcasting" aria-haspopup="dialog">Nowcasting<div class="chip-desc">Estimativa em tempo real</div><span class="chip-cta">abrir &rsaquo;</span></button>
		<button type="button" class="term-chip clickable" data-model="nelson" aria-haspopup="dialog">Nelson-Siegel<div class="chip-desc">Modelagem da curva de juros</div><span class="chip-cta">abrir &rsaquo;</span></button>
		<button type="button" class="term-chip clickable" data-model="blacklitt" aria-haspopup="dialog">Black-Litterman<div class="chip-desc">Alocação de portfólio</div><span class="chip-cta">abrir &rsaquo;</span></button>
	</div>

	<!-- Conteúdo dos modelos (fonte do modal) -->
	<div id="model-details" hidden>
		<div class="model-detail" id="md-taylor" data-title="Taylor Rule" data-sub="Regra de juros do banco central">
			<div class="model-section">
				<h4><span>01</span> Teoria</h4>
				<p>Proposta por John Taylor (1993), descreve como um banco central deve fixar a taxa de juros nominal de curto prazo reagindo a dois desvios: a inflação em relação à meta e o produto em relação ao potencial. Funciona como <strong>benchmark</strong> para julgar se a política monetária está apertada ou frouxa em relação ao que a economia pede.</p>
			</div>
			<div class="model-section">
				<h4><span>02</span> Equações</h4>
				<div class="model-eq">i = r* + &pi; + &alpha;(&pi; &minus; &pi;*) + &beta;&middot;hiato</div>
				<div class="model-eq">i = juro nominal &middot; r* = juro real neutro &middot; &pi; = inflação corrente</div>
				<div class="model-eq">&pi;* = meta &middot; hiato = (produto &minus; potencial) &middot; &alpha;,&beta; = pesos (Taylor: 0,5 e 0,5)</div>
				<p class="model-eqnote">Princípio de Taylor: o coeficiente da inflação na taxa <em>nominal</em> deve ser &gt; 1 (&alpha; &gt; 0) para estabilizar preços.</p>
			</div>
			<div class="model-section">
				<h4><span>03</span> Aplicação prática</h4>
				<p>No Brasil, compara-se a Selic efetiva do COPOM contra a Taylor estimada (r* &asymp; 4,5&ndash;5%, meta 3%). Um gap positivo indica BC acima da regra (viés contracionista); negativo, espaço para afrouxar. É exatamente o gráfico interativo do módulo 04 desta página.</p>
			</div>
			<div class="model-section invest">
				<h4><span>04</span> Para investimentos</h4>
				<p>Selic acima da Taylor &rarr; juros reais altos favorecem renda fixa e pressionam múltiplos de bolsa. Gap negativo antecipa corte &rarr; alongar duration (NTN-B), montar recebedor de juros, comprar teses de queda de juros. Serve de bússola de ciclo e de timing para posições na curva.</p>
			</div>
		</div>
		<div class="model-detail" id="md-phillips" data-title="Phillips Curve" data-sub="Trade-off inflação × desemprego">
			<div class="model-section">
				<h4><span>01</span> Teoria</h4>
				<p>Relação inversa de curto prazo entre inflação e desemprego (ou hiato do produto). A versão moderna incorpora expectativas (Friedman-Phelps) e, na forma Nova-Keynesiana (NKPC), expectativas <em>forward-looking</em>. No longo prazo a curva é vertical na NAIRU &mdash; não há trade-off permanente.</p>
			</div>
			<div class="model-section">
				<h4><span>02</span> Equações</h4>
				<div class="model-eq">NKPC:&nbsp; &pi;<sub>t</sub> = &beta;&middot;E<sub>t</sub>[&pi;<sub>t+1</sub>] + &kappa;&middot;hiato<sub>t</sub> + u<sub>t</sub></div>
				<div class="model-eq">Adaptativa:&nbsp; &pi;<sub>t</sub> = &pi;<sup>e</sup><sub>t</sub> &minus; &gamma;(u<sub>t</sub> &minus; u*) + &epsilon;<sub>t</sub></div>
				<div class="model-eq">&kappa; = inclinação &middot; u* = NAIRU &middot; u<sub>t</sub> = desemprego &middot; u<sub>t</sub> = choque de custo</div>
			</div>
			<div class="model-section">
				<h4><span>03</span> Aplicação prática</h4>
				<p>O BCB usa curva de Phillips no modelo semiestrutural para projetar inflação, calibrando a sensibilidade ao hiato e ao câmbio. Na prática: cruzar desemprego (PNAD) com a inflação de serviços e núcleos.</p>
			</div>
			<div class="model-section invest">
				<h4><span>04</span> Para investimentos</h4>
				<p>Mercado de trabalho apertado + hiato fechando &rarr; inflação de serviços persistente &rarr; BC mais <em>hawkish</em> &rarr; juro alto por mais tempo. Orienta a leitura de inflação implícita (breakeven das NTN-B) e do prêmio de risco. Curva achatada por desancoragem muda todo o jogo.</p>
			</div>
		</div>
		<div class="model-detail" id="md-islm" data-title="IS-LM" data-sub="Equilíbrio bens × moeda">
			<div class="model-section">
				<h4><span>01</span> Teoria</h4>
				<p>Modelo Hicks-Hansen do equilíbrio simultâneo entre o mercado de bens (curva IS) e o mercado monetário (curva LM), em economia fechada com preços rígidos no curto prazo. Determina conjuntamente a renda (Y) e o juro (i).</p>
			</div>
			<div class="model-section">
				<h4><span>02</span> Equações</h4>
				<div class="model-eq">IS:&nbsp; Y = C(Y &minus; T) + I(i) + G</div>
				<div class="model-eq">LM:&nbsp; M / P = L(Y, i)</div>
				<div class="model-eq">I cai com i (IS negativa) &middot; demanda por moeda sobe com Y e cai com i</div>
			</div>
			<div class="model-section">
				<h4><span>03</span> Aplicação prática</h4>
				<p>Ferramenta para analisar o efeito de política fiscal (desloca a IS) e monetária (desloca a LM) sobre juro e produto. Como hoje os BCs fixam o <em>juro</em> (não a quantidade de moeda), usa-se a versão IS-MP, em que a LM vira a regra de juros do BC.</p>
			</div>
			<div class="model-section invest">
				<h4><span>04</span> Para investimentos</h4>
				<p>Expansão fiscal com BC parado &rarr; pressão de juro e <em>crowding-out</em> do investimento privado. Aperto monetário &rarr; juro sobe, atividade cai. É o mapa mental para ler choques de política e antecipar a direção de juros, câmbio e bolsa.</p>
			</div>
		</div>
		<div class="model-detail" id="md-mundell" data-title="Mundell-Fleming" data-sub="Economia aberta">
			<div class="model-section">
				<h4><span>01</span> Teoria</h4>
				<p>Extensão do IS-LM para economia aberta com mobilidade de capital; acrescenta câmbio e setor externo. Seu resultado central é a <strong>trindade impossível</strong>: não se pode ter, ao mesmo tempo, câmbio fixo, livre mobilidade de capital e política monetária independente &mdash; só dois dos três.</p>
			</div>
			<div class="model-section">
				<h4><span>02</span> Equações</h4>
				<div class="model-eq">IS:&nbsp; Y = C + I(i) + G + NX(e, Y, Y*)</div>
				<div class="model-eq">Paridade:&nbsp; i = i* + E[&Delta;e] + prêmio</div>
				<div class="model-eq">e = câmbio &middot; i* = juro externo &middot; NX = exportações líquidas</div>
			</div>
			<div class="model-section">
				<h4><span>03</span> Aplicação prática</h4>
				<p>O Brasil opera com câmbio flutuante e conta de capital aberta &rarr; mantém política monetária independente. Mecanismo: corte de juro &rarr; saída de capital &rarr; depreciação do real &rarr; estímulo às exportações líquidas. Centraliza a análise do diferencial Selic &minus; Fed.</p>
			</div>
			<div class="model-section invest">
				<h4><span>04</span> Para investimentos</h4>
				<p>O diferencial de juros e o prêmio de risco-país movem o real: corte de Selic ou alta do Fed tendem a pressionar o dólar para cima &mdash; base da tese de <em>long</em> dólar / <em>short</em> bolsa. Essencial para posições em WDO, hedge cambial de carteiras e leitura do fluxo estrangeiro na B3.</p>
			</div>
		</div>
		<div class="model-detail" id="md-var" data-title="VAR" data-sub="Vetores autorregressivos">
			<div class="model-section">
				<h4><span>01</span> Teoria</h4>
				<p>Modelo econométrico multivariado (Sims, 1980) em que cada variável é explicada pelos próprios lags e pelos lags das demais, sem impor estrutura teórica forte. Usado para previsão, funções de impulso-resposta e decomposição da variância dos erros.</p>
			</div>
			<div class="model-section">
				<h4><span>02</span> Equações</h4>
				<div class="model-eq">Y<sub>t</sub> = c + A<sub>1</sub>Y<sub>t&minus;1</sub> + &hellip; + A<sub>p</sub>Y<sub>t&minus;p</sub> + &epsilon;<sub>t</sub></div>
				<div class="model-eq">Y<sub>t</sub> = vetor n&times;1 de variáveis &middot; A<sub>i</sub> = matrizes n&times;n</div>
				<div class="model-eq">SVAR: identifica choques estruturais (Cholesky / restrições)</div>
			</div>
			<div class="model-section">
				<h4><span>03</span> Aplicação prática</h4>
				<p>Prever conjuntamente Selic, inflação, câmbio e atividade; estimar a resposta da inflação a um choque de juros ao longo do tempo (IRF); e decompor de onde vem a variância da inflação. Base de boa parte dos modelos de previsão macro.</p>
			</div>
			<div class="model-section invest">
				<h4><span>04</span> Para investimentos</h4>
				<p>Quantifica <em>como</em> e em <em>quanto tempo</em> um choque se propaga &mdash; a defasagem é o que dá o timing. A resposta da inflação a um choque cambial dimensiona o <em>pass-through</em>; o IRF de juros ajuda a posicionar a curva antes do mercado reprecificar.</p>
			</div>
		</div>
		<div class="model-detail" id="md-nowcasting" data-title="Nowcasting" data-sub="Estimativa em tempo real">
			<div class="model-section">
				<h4><span>01</span> Teoria</h4>
				<p>Estimar, em tempo quase real, uma variável de baixa frequência e divulgação defasada (p. ex. o PIB trimestral) a partir de um fluxo de indicadores de maior frequência, à medida que vão sendo publicados. Lida com o <em>ragged edge</em> &mdash; dados que chegam em datas diferentes.</p>
			</div>
			<div class="model-section">
				<h4><span>02</span> Equações</h4>
				<div class="model-eq">Fator dinâmico:&nbsp; x<sub>t</sub> = &Lambda; f<sub>t</sub> + &epsilon;<sub>t</sub></div>
				<div class="model-eq">Estado:&nbsp; f<sub>t</sub> = A f<sub>t&minus;1</sub> + u<sub>t</sub></div>
				<div class="model-eq">Filtro de Kalman atualiza a estimativa a cada nova divulgação (também bridge / MIDAS)</div>
			</div>
			<div class="model-section">
				<h4><span>03</span> Aplicação prática</h4>
				<p>BCB (via IBC-Br) e os Feds de NY/Atlanta (GDPNow) fazem nowcast do PIB. No Brasil: combinar IBC-Br, PMC, PMS, PIM e o Focus para antecipar o PIB antes da divulgação oficial do IBGE.</p>
			</div>
			<div class="model-section invest">
				<h4><span>04</span> Para investimentos</h4>
				<p>Um bom nowcast reduz a surpresa nos dados &mdash; e surpresa de atividade move juro curto e bolsa. Quem antecipa a revisão se posiciona antes da reação e lê melhor a <em>data dependence</em> do BC antes de cada COPOM.</p>
			</div>
		</div>
		<div class="model-detail" id="md-nelson" data-title="Nelson-Siegel" data-sub="Modelagem da curva de juros">
			<div class="model-section">
				<h4><span>01</span> Teoria</h4>
				<p>Modelo paramétrico parcimonioso que ajusta toda a estrutura a termo das taxas de juros com poucos parâmetros interpretáveis como <strong>nível, inclinação e curvatura</strong>. A extensão Svensson acrescenta uma segunda corcova; Diebold-Li o torna dinâmico no tempo.</p>
			</div>
			<div class="model-section">
				<h4><span>02</span> Equações</h4>
				<div class="model-eq">y(&tau;) = &beta;<sub>0</sub> + &beta;<sub>1</sub>&middot;[(1&minus;e<sup>&minus;&lambda;&tau;</sup>)/&lambda;&tau;] + &beta;<sub>2</sub>&middot;[(1&minus;e<sup>&minus;&lambda;&tau;</sup>)/&lambda;&tau; &minus; e<sup>&minus;&lambda;&tau;</sup>]</div>
				<div class="model-eq">&beta;<sub>0</sub> = nível (taxa longa) &middot; &beta;<sub>1</sub> = inclinação (curto&minus;longo)</div>
				<div class="model-eq">&beta;<sub>2</sub> = curvatura (corcova) &middot; &lambda; = onde a curvatura atua</div>
			</div>
			<div class="model-section">
				<h4><span>03</span> Aplicação prática</h4>
				<p>Suavizar e interpolar a curva DI/pré da B3 e a ETTJ da ANBIMA; extrair taxas <em>forward</em> implícitas; precificar vértices ilíquidos; e construir os fatores nível/inclinação/curvatura. É o motor do projeto de Curva de Juros.</p>
			</div>
			<div class="model-section invest">
				<h4><span>04</span> Para investimentos</h4>
				<p>Decompõe a curva em fatores negociáveis: apostar em <em>steepening</em>/<em>flattening</em> (inclinação), em corcova (curvatura) ou em nível. Base para DV01 por vértice, <em>carry &amp; rolldown</em> e estruturação de operações de juros. Mudança de inclinação costuma antecipar o ciclo.</p>
			</div>
		</div>
		<div class="model-detail" id="md-blacklitt" data-title="Black-Litterman" data-sub="Alocação de portfólio">
			<div class="model-section">
				<h4><span>01</span> Teoria</h4>
				<p>Modelo de alocação (Goldman Sachs, 1990) que combina, num arcabouço bayesiano, o equilíbrio de mercado &mdash; os retornos implícitos na carteira de mercado, obtidos por <em>reverse optimization</em> &mdash; com as <em>views</em> do investidor. Corrige a instabilidade e os pesos extremos do Markowitz puro.</p>
			</div>
			<div class="model-section">
				<h4><span>02</span> Equações</h4>
				<div class="model-eq">Equilíbrio:&nbsp; &Pi; = &delta;&middot;&Sigma;&middot;w<sub>mkt</sub></div>
				<div class="model-eq">Posterior:&nbsp; E[R] = [(&tau;&Sigma;)<sup>&minus;1</sup> + P&prime;&Omega;<sup>&minus;1</sup>P]<sup>&minus;1</sup> &middot; [(&tau;&Sigma;)<sup>&minus;1</sup>&Pi; + P&prime;&Omega;<sup>&minus;1</sup>Q]</div>
				<div class="model-eq">P,Q = views &middot; &Omega; = incerteza das views &middot; &tau; = confiança no prior &middot; &delta; = aversão a risco</div>
			</div>
			<div class="model-section">
				<h4><span>03</span> Aplicação prática</h4>
				<p>Construir carteiras partindo do mercado e inclinando-as conforme teses (p. ex. &ldquo;bolsa BR supera o S&amp;P em X%&rdquo;), cada <em>view</em> com seu grau de confiança. Evita os cantos e o <em>overfitting</em> do otimizador clássico. Aplica-se às carteiras de ETFs internacionais, BDRs e multiativos.</p>
			</div>
			<div class="model-section invest">
				<h4><span>04</span> Para investimentos</h4>
				<p>Traduz uma tese macro (real deprecia, juro cai) em inclinações de portfólio <em>controladas</em> e diversificadas, em vez de apostas concentradas. Gera pesos mais estáveis e explicáveis &mdash; ideal para mandato fee-based e para decks de clientes UHNW.</p>
			</div>
		</div>
	</div>

	<!-- Modal -->
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
	(function(){
		var modal = document.getElementById('model-modal');
		if(!modal) return;
		var panel = modal.querySelector('.model-modal-panel');
		var body  = modal.querySelector('.model-modal-body');
		var titleEl = modal.querySelector('#model-modal-title');
		var subEl = modal.querySelector('.model-modal-sub');
		var store = document.getElementById('model-details');
		var lastFocus = null;

		function open(key){
			var src = store.querySelector('#md-' + key);
			if(!src) return;
			titleEl.textContent = src.getAttribute('data-title') || '';
			subEl.textContent = src.getAttribute('data-sub') || '';
			body.innerHTML = src.innerHTML;
			body.scrollTop = 0;
			modal.hidden = false;
			document.body.style.overflow = 'hidden';
			requestAnimationFrame(function(){ modal.classList.add('is-open'); });
			lastFocus = document.activeElement;
			modal.querySelector('.model-modal-close').focus();
		}
		function close(){
			modal.classList.remove('is-open');
			document.body.style.overflow = '';
			setTimeout(function(){ modal.hidden = true; body.innerHTML=''; }, 180);
			if(lastFocus && lastFocus.focus) lastFocus.focus();
		}

		document.querySelectorAll('.term-chip.clickable').forEach(function(c){
			c.addEventListener('click', function(){ open(c.getAttribute('data-model')); });
		});
		modal.addEventListener('click', function(e){ if(e.target.hasAttribute('data-close')) close(); });
		document.addEventListener('keydown', function(e){ if(e.key==='Escape' && !modal.hidden) close(); });
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
