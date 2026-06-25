---
title: Projetos
layout: landing
description: Economia • Finanças • Dados
image: assets/images/blur.jpg
nav-menu: true
---

<!-- Main -->
<div id="main">

<!-- Intro -->
<section id="one">
	<div class="inner">
		<header class="major">
			<h2>Projetos e Aplicações</h2>
		</header>
		<p>
			Portfólio de projetos aplicados nas intersecções entre economia, finanças quantitativas e engenharia de software.
			Cada entrega reflete uma abordagem orientada a dados, com rigor metodológico e foco em resultados reais —
			seja em assessoria de investimentos, pesquisa acadêmica ou desenvolvimento de produtos financeiros.
		</p>
	</div>
</section>

<!-- Projetos em destaque -->
<section id="two" class="spotlights">

	<section>
		<a href="{{ site.baseurl }}/projects/trading-system/" class="image">
			<img src="{{ site.baseurl }}/assets/images/market.jpg" alt="Trading System BOVA11" data-position="center center" loading="lazy" />
		</a>
		<div class="content">
			<div class="inner">
				<header class="major">
					<h3>Trading System BOVA11</h3>
				</header>
				<p>Modelo ARIMA com geração de sinais long/short sistemáticos para o BOVA11. Engine de backtest própria com métricas de risco completas (Sharpe, Drawdown, Profit Factor) e exportação para Excel.</p>
				<ul class="actions">
					<li><a href="{{ site.baseurl }}/projects/trading-system/" class="button">Ver projeto</a></li>
				</ul>
			</div>
		</div>
	</section>

	<section>
		<a href="{{ site.baseurl }}/projects/curva-juros/" class="image">
			<img src="{{ site.baseurl }}/assets/images/luz.jpg" alt="Curva de Juros" data-position="top center" loading="lazy" />
		</a>
		<div class="content">
			<div class="inner">
				<header class="major">
					<h3>Curva de Juros Brasileira</h3>
				</header>
				<p>Dashboard analítico da ETTJ com forwards implícitos, breakeven inflacionário, carry & rolldown e DV01 por vértice. Conexão em tempo real com APIs do BCB e ANBIMA.</p>
				<ul class="actions">
					<li><a href="{{ site.baseurl }}/projects/curva-juros/" class="button">Ver projeto</a></li>
				</ul>
			</div>
		</div>
	</section>

	<section>
		<a href="{{ site.baseurl }}/projects/sistema-fiscal/" class="image">
			<img src="{{ site.baseurl }}/assets/images/cafe.png" alt="Sistema Fiscal B3" data-position="25% 25%" loading="lazy" />
		</a>
		<div class="content">
			<div class="inner">
				<header class="major">
					<h3>Sistema Fiscal B3</h3>
				</header>
				<p>Engine completa de cálculo de IR para todos os ativos B3 com compensação automática de perdas, geração de DARF em PDF e módulo Trade Fiscal de otimização tributária. Arquitetura SaaS (FastAPI + PostgreSQL).</p>
				<ul class="actions">
					<li><a href="{{ site.baseurl }}/projects/sistema-fiscal/" class="button">Ver projeto</a></li>
				</ul>
			</div>
		</div>
	</section>

</section>

<!-- Todos os projetos -->
<section id="three">
	<div class="inner">
		<header class="major">
			<h2>Todos os Projetos</h2>
		</header>
		<div class="tiles">
			{% for project in site.projects %}
			{% if project.show_tile != false %}
			<article>
				<span class="image">
					<img src="{{ site.baseurl }}/{{ project.image }}" alt="{{ project.title }}" loading="lazy" />
				</span>
				<header class="major">
					<h3><a href="{{ project.url | relative_url }}" class="link">{{ project.title }}</a></h3>
					<p>{{ project.description | truncate: 100 }}</p>
				</header>
			</article>
			{% endif %}
			{% endfor %}
		</div>
	</div>
</section>

</div>
