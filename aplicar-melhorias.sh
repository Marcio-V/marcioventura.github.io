#!/usr/bin/env bash
# ===================================================================
# Aplica as melhorias do portfolio (home 2x2 + Consultoria + redesign)
# Rodar na RAIZ do repositorio:  bash aplicar-melhorias.sh
# ===================================================================
set -e
if [ ! -f _config.yml ] || [ ! -d _layouts ]; then
  echo "ERRO: rode na raiz do repositorio (onde estao _config.yml e _layouts)."; exit 1
fi
echo "==> Raiz confirmada."
mkdir -p _includes _layouts _sass/custom assets/css

# ---- _includes/tiles.html ----
cat > '_includes/tiles.html' <<'EOF_14630172'
{% comment %} Tiles da home — ordenados por tile-order, com chip de categoria {% endcomment %}
{% assign tiles = site.html_pages | where_exp: "item", "item.show_tile != false" | sort: "tile-order" %}
<section id="one" class="tiles">
  {% for tile in tiles limit:site.tiles-count %}
  <article>
    <span class="image">
      <img src="{{ tile.image | relative_url }}" alt="{{ tile.title }}" {% if tile.tile-position %}data-position="{{ tile.tile-position }}"{% endif %} />
    </span>
    <header class="major">
      {% if tile.tile-category %}<span class="tile-chip">{{ tile.tile-category }}</span>{% endif %}
      <h3><a href="{{ tile.url | relative_url }}" class="link">{{ tile.title }}</a></h3>
      <p>{{ tile.description }}</p>
    </header>
  </article>
  {% endfor %}
</section>
EOF_14630172
echo "==> escrito: _includes/tiles.html"

# ---- _includes/header.html ----
cat > '_includes/header.html' <<'EOF_79072921'
{% include market_ticker.html %}

<!-- Wrapper -->
<div id="wrapper">

<!-- Header -->
<header id="header"{% if page.layout == "landing" %} class="alt style2"{% endif %}{% if page.layout == "home" %} class="alt"{% endif %}>
	<a href="{{ site.baseurl }}/" class="logo"><strong>{{ site.title }}</strong></a>
	<nav>
		<a href="#menu">Menu</a>
	</nav>
</header>

<!-- Menu -->
<nav id="menu">
  <ul class="links">
    <li><a href="{{ '/' | relative_url }}">Home</a></li>

    {% assign nav_pages = site.html_pages | where_exp: "item", "item.nav-menu == true" | sort: "menu-order" %}
    {% for page in nav_pages %}
      {% if page.layout != "home" %}
        <li><a href="{{ page.url | relative_url }}">{{ page.title }}</a></li>
      {% endif %}
    {% endfor %}
  </ul>

  <ul class="actions vertical">
    <li><a href="{{ '/consultoria.html' | relative_url }}" class="button special fit">Consultoria</a></li>
  </ul>
</nav>
EOF_79072921
echo "==> escrito: _includes/header.html"

# ---- _layouts/home.html ----
cat > '_layouts/home.html' <<'EOF_14002604'
<!DOCTYPE html>
<html>

{% include head.html %}

<body>

    {% include header.html %}

    <!-- Hero -->
    <section id="banner" class="major">
        <div class="inner">
            <header class="major">
                <h1>{{ page.landing-title }}</h1>
            </header>
            <div class="content">
                <p style="text-transform: uppercase;">{{ page.hero-subtitle | default: site.description }}</p>
                <ul class="actions">
                    <li><a href="#one" class="button next scrolly">Explorar</a></li>
                    <li><a href="{{ '/consultoria.html' | relative_url }}" class="button primary">Consultoria</a></li>
                </ul>
                <div class="credibility">
                    <span>Economista · <strong>UERJ</strong></span>
                    <span>Educação executiva · <strong>Insper</strong></span>
                    <span>Renda Variável · <strong>B3</strong></span>
                    <span><strong>Arbitrium</strong> Capital</span>
                </div>
            </div>
        </div>
    </section>

    <div id="main">

        {% include tiles.html %}

        <!-- Introdução -->
        <section id="two">
            <div class="inner">
                <header class="major">
                    <h2>Introdução</h2>
                </header>
                <p>{{ content }}</p>
                <ul class="actions">
                    <li><a href="{{ '/generic.html' | relative_url }}" class="button next">Sobre mim</a></li>
                </ul>
            </div>
        </section>

        <!-- Faixa: Consultoria -->
        <section class="home-consult">
            <div class="inner">
                <span class="eyebrow">Arbitrium Consulting</span>
                <h2>Consultoria econômica, dados e ferramentas</h2>
                <p>Análises de conjuntura, automação de dados e desenvolvimento de ferramentas quantitativas sob medida para o mercado financeiro.</p>
                <ul class="actions special">
                    <li><a href="{{ '/consultoria.html' | relative_url }}" class="button primary">Conhecer serviços</a></li>
                </ul>
            </div>
        </section>

        {% include economic_indicators.html %}

    </div>

    {% include footer.html %}

</body>

</html>
EOF_14002604
echo "==> escrito: _layouts/home.html"

# ---- index.md ----
cat > 'index.md' <<'EOF_98889291'
---
layout: home
title: Home
landing-title: 'Economia, dados e mercado.'
hero-subtitle: 'Operador de Renda Variável · Finanças Quantitativas · Engenharia Financeira'
description: Finanças Quantitativas, Economia Aplicada e Engenharia Financeira
image: null
author: null
show_tile: false
---

Operador de renda variável (Sales &amp; Trading) e economista em formação pela UERJ, atuo na intersecção entre
economia aplicada, finanças quantitativas e engenharia de software — desenvolvendo modelos, plataformas e
análises orientadas a dados para o mercado financeiro brasileiro.

Explore os projetos, acompanhe os indicadores de mercado em tempo real e conheça os serviços de consultoria.
EOF_98889291
echo "==> escrito: index.md"

# ---- generic.md ----
cat > 'generic.md' <<'EOF_73506586'
---
layout: post
title: Resumo
description: Quem sou, trajetória e competências técnicas.
image: assets/images/eu.jpg
nav-menu: true
tile-category: Sobre
tile-order: 2
menu-order: 5
---

<p class="lead">
Operador de renda variável (Sales &amp; Trading) e economista em formação, atuo na intersecção entre
economia aplicada, finanças quantitativas e engenharia de software — transformando dados e teoria
econômica em decisões de investimento e ferramentas de mercado.
</p>

Graduando em Ciências Econômicas pela **Universidade do Estado do Rio de Janeiro (UERJ)**, com TCC sobre a
dinâmica da inflação brasileira, construo minha trajetória na mesa de operações, com foco em derivativos,
estruturas de opções, renda fixa e alocação. Complemento a formação acadêmica com educação executiva no
**Insper** (Operações de Tesouraria, Derivativos, e Gestão das Finanças Bancárias — ALM, RAROC e Performance),
direcionada à gestão de risco e tesouraria.

Desenvolvo a maior parte das minhas próprias ferramentas — dashboards, relatórios e calculadoras — com **R,
Python e Excel/VBA**, voltadas à avaliação de ativos, automação de processos, integração de dados econômicos
e análise de séries temporais. Entre as entregas, destaco um hub automatizado de séries econômicas integrando
as APIs de Banco Central (SGS), IBGE (SIDRA) e IPEADATA; uma engine de apuração fiscal a partir de notas de
corretagem; e modelos de mensuração de carrego e ágio para fundos imobiliários e crédito privado.

## Competências

- **Mercado:** derivativos, estruturas de opções, renda fixa, hedge e gestão de carteiras
- **Quant & dados:** séries temporais, backtesting, precificação, modelagem de risco (duration, VaR)
- **Engenharia:** Python, R, SQL, VBA, APIs (BCB, IBGE, ANBIMA), dashboards e automação
- **Economia:** macroeconomia aplicada, política monetária, conjuntura e inflação

Minha formação e experiência me permitem unir fundamento econômico à aplicação técnica, com atuação em
**research, structuring e gestão**. Busco desafios que exijam excelência analítica, rigor metodológico e
visão estratégica em ambientes de alta performance.
EOF_73506586
echo "==> escrito: generic.md"

# ---- landing.md ----
cat > 'landing.md' <<'EOF_35006676'
---
title: Projetos
layout: landing
description: Aplicações em economia, finanças quantitativas e engenharia.
image: assets/images/blur.jpg
nav-menu: true
tile-category: Portfólio
tile-order: 3
tile-position: center center
menu-order: 2
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
EOF_35006676
echo "==> escrito: landing.md"

# ---- all_posts.md ----
cat > 'all_posts.md' <<'EOF_2440306'
---
layout: allposts
title: All Posts
landing-title: 'Publicações'
nav-menu: true
description: Resumos de cursos, estudos e notas técnicas de mercado.
image: assets/images/market.jpg
tile-category: Publicações
tile-order: 4
tile-position: center center
show_tile: true
menu-order: 3
---
EOF_2440306
echo "==> escrito: all_posts.md"

# ---- elements.md ----
cat > 'elements.md' <<'EOF_82230584'
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
	<div class="term-chips">
		<div class="term-chip">Taylor Rule<div class="chip-desc">Regra de juros do banco central</div></div>
		<div class="term-chip">Phillips Curve<div class="chip-desc">Trade-off inflação × desemprego</div></div>
		<div class="term-chip">IS-LM<div class="chip-desc">Equilíbrio bens × moeda</div></div>
		<div class="term-chip">Mundell-Fleming<div class="chip-desc">Economia aberta</div></div>
		<div class="term-chip">VAR<div class="chip-desc">Vetores autorregressivos</div></div>
		<div class="term-chip">Nowcasting<div class="chip-desc">Estimativa em tempo real</div></div>
		<div class="term-chip">Nelson-Siegel<div class="chip-desc">Modelagem da curva de juros</div></div>
		<div class="term-chip">Black-Litterman<div class="chip-desc">Alocação de portfólio</div></div>
	</div>
	<p class="term-prose" style="margin-top:1em;font-size:0.72rem;">Versão futura: ao clicar, cada modelo abre teoria, equações, aplicação prática e interpretação para investimentos.</p>
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
EOF_82230584
echo "==> escrito: elements.md"

# ---- consultoria.md ----
cat > 'consultoria.md' <<'EOF_47749919'
---
title: Consultoria
layout: landing
description: Consultoria econômica, análise de dados e desenvolvimento de ferramentas para o mercado financeiro — pela Arbitrium Consulting.
image: assets/images/bloomberg.jpg
nav-menu: true
show_tile: false
menu-order: 4
---

<!-- Main -->
<div id="main">

<!-- Intro -->
<section id="one">
	<div class="inner">
		<header class="major">
			<h2>Economia e dados a serviço de decisões melhores</h2>
		</header>
		<p class="lead">
			A <strong>Arbitrium Consulting</strong> presta serviços de consultoria econômica, análise de dados e
			desenvolvimento de ferramentas quantitativas para profissionais e empresas do mercado financeiro.
			Unimos fundamento econômico, rigor quantitativo e engenharia de software para transformar dados
			dispersos em análises claras e sistemas que funcionam.
		</p>
	</div>
</section>

<!-- Serviços -->
<section id="two" class="services-section">
	<div class="inner">
		<header class="major">
			<h2>Serviços</h2>
		</header>
		<div class="service-grid">

			<div class="service-card">
				<span class="icon major fa-line-chart"></span>
				<h3>Análise econômica &amp; conjuntura</h3>
				<p>Relatórios de cenário macroeconômico, acompanhamento de indicadores (inflação, juros, atividade, câmbio) e leitura de política monetária aplicada à tomada de decisão.</p>
			</div>

			<div class="service-card">
				<span class="icon major fa-database"></span>
				<h3>Dados &amp; automação</h3>
				<p>Integração de fontes (BCB/SGS, IBGE/SIDRA, IPEADATA, ANBIMA), pipelines de dados, planilhas inteligentes e automação de processos repetitivos e operacionais.</p>
			</div>

			<div class="service-card">
				<span class="icon major fa-calculator"></span>
				<h3>Ferramentas quantitativas</h3>
				<p>Modelos de precificação, backtests, calculadoras de risco (duration, VaR, carrego) e engines de análise sob medida, em Python, R e VBA.</p>
			</div>

			<div class="service-card">
				<span class="icon major fa-pie-chart"></span>
				<h3>Relatórios &amp; dashboards</h3>
				<p>Painéis e relatórios institucionais com visualização de dados clara e profissional, prontos para apresentação a clientes, comitês e investidores.</p>
			</div>

		</div>
	</div>
</section>

<!-- Como trabalho -->
<section id="three" class="process-section">
	<div class="inner">
		<header class="major">
			<h2>Como trabalho</h2>
		</header>
		<div class="process-steps">
			<div class="process-step">
				<span class="process-num">01</span>
				<h4>Diagnóstico</h4>
				<p>Entendo o problema, os dados disponíveis e o objetivo da entrega.</p>
			</div>
			<div class="process-step">
				<span class="process-num">02</span>
				<h4>Desenvolvimento</h4>
				<p>Construo a análise, o modelo ou a ferramenta com método e transparência.</p>
			</div>
			<div class="process-step">
				<span class="process-num">03</span>
				<h4>Entrega</h4>
				<p>Documento, valido e entrego — com suporte para evolução contínua.</p>
			</div>
		</div>
	</div>
</section>

<!-- CTA -->
<section id="cta" class="consult-cta">
	<div class="inner">
		<header class="major">
			<h2>Vamos conversar sobre o seu projeto?</h2>
		</header>
		<p>Conte o que você precisa — respondo pessoalmente para avaliar como posso ajudar.</p>
		<ul class="actions special">
			<li><a href="{{ '/#contact' | relative_url }}" class="button primary">Falar sobre um projeto</a></li>
			<li><a href="mailto:{{ site.email }}" class="button">Enviar e-mail</a></li>
		</ul>
	</div>
</section>

<!-- Disclaimer -->
<section id="disclaimer" class="consult-disclaimer">
	<div class="inner">
		<p>
			A Arbitrium Consulting presta serviços de consultoria econômica, análise de dados e desenvolvimento
			tecnológico. O conteúdo deste site e os serviços aqui descritos têm caráter informativo e técnico e
			<strong>não constituem consultoria ou recomendação de valores mobiliários</strong> nos termos da
			regulamentação da CVM, nem oferta, promessa ou garantia de rentabilidade.
		</p>
	</div>
</section>

</div>
EOF_47749919
echo "==> escrito: consultoria.md"

# ---- _sass/custom/_home.scss ----
cat > '_sass/custom/_home.scss' <<'EOF_50698325'
// ============================================================
// Home — redesign (hero, tiles, faixa de credibilidade, CTA)
// Paleta: bg #070705 · bg-alt #0e1316 · ouro #e7b788 · azul #8ea9e8
// ============================================================

$c-gold:  #e7b788;
$c-blue:  #8ea9e8;
$c-green: #87c5a4;
$c-ink:   #070705;
$c-line:  rgba(212,212,255,0.10);

/* ---------- Hero ---------- */
#banner.major {
	.inner { padding: 2em 0; }

	h1 {
		font-size: 3.25em;
		line-height: 1.05;
		letter-spacing: -0.015em;
		font-weight: 600;
	}

	.content p {
		font-size: 0.95em;
		letter-spacing: 0.22em;
		color: rgba(255,255,255,0.72);
	}

	.actions { margin-top: 1.5em; }
}

@media screen and (max-width: 736px) {
	#banner.major h1 { font-size: 2.25em; }
	#banner.major .content p { letter-spacing: 0.14em; }
}

/* Faixa de credibilidade sob o hero */
.credibility {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	gap: 1.5em 2.5em;
	margin: 2.5em auto 0;
	padding-top: 2em;
	border-top: 1px solid $c-line;
	max-width: 46em;

	span {
		font-size: 0.7em;
		letter-spacing: 0.22em;
		text-transform: uppercase;
		color: rgba(255,255,255,0.55);
		white-space: nowrap;
	}
	strong { color: $c-gold; font-weight: 600; }
}

/* ---------- Tiles ---------- */
.tiles article {
	// overlay consistente: gradiente escuro por cima da imagem
	&:before {
		background: linear-gradient(to top, rgba(7,7,5,0.94) 0%, rgba(7,7,5,0.55) 45%, rgba(7,7,5,0.35) 100%) !important;
		opacity: 1 !important;
	}
	&:after { display: none !important; }

	// deixa a imagem “respirar” um pouco no hover, sem apagar o texto
	&:hover {
		transform: translateY(-6px);
		&:before { opacity: 0.8 !important; }
	}

	header.major {
		border-top: 0;
		&:after { display: none; }
	}

	// chip de categoria
	.tile-chip {
		display: inline-block;
		font-size: 0.6em;
		font-weight: 600;
		letter-spacing: 0.22em;
		text-transform: uppercase;
		color: $c-ink;
		background: $c-gold;
		padding: 0.35em 0.9em;
		border-radius: 3px;
		margin-bottom: 1em;
	}

	h3 {
		font-size: 1.6em;
		font-weight: 600;
		margin-bottom: 0.5em;
		a { border-bottom: 0; }
	}

	p {
		display: block !important;
		color: rgba(255,255,255,0.78);
		font-size: 0.85em;
		line-height: 1.6;
		max-width: 22em;
	}

	// linha de acento dourada no rodapé do card
	box-shadow: inset 0 -3px 0 rgba(231,183,136,0);
	transition: transform 0.25s ease, box-shadow 0.25s ease, opacity 0.25s ease;
	&:hover { box-shadow: inset 0 -4px 0 $c-gold; }
}

/* ---------- Faixa CTA Consultoria na home ---------- */
.home-consult {
	background: linear-gradient(120deg, #0e1316 0%, #070705 100%);
	border-top: 1px solid $c-line;
	border-bottom: 1px solid $c-line;
	padding: 4.5em 0;
	text-align: center;

	.inner { max-width: 48em; }

	.eyebrow {
		display: inline-block;
		font-size: 0.7em;
		letter-spacing: 0.25em;
		text-transform: uppercase;
		color: $c-gold;
		margin-bottom: 1em;
	}

	h2 { font-size: 2.1em; font-weight: 600; margin-bottom: 0.5em; }
	p  { color: rgba(255,255,255,0.78); font-size: 1em; margin-bottom: 1.75em; }
}

/* ---------- Lead paragraph (Resumo / páginas) ---------- */
.lead {
	font-size: 1.25em;
	line-height: 1.6;
	color: #ffffff;
	font-weight: 300;
	margin-bottom: 1.5em;
}
@media screen and (max-width: 736px) {
	.lead { font-size: 1.1em; }
}
EOF_50698325
echo "==> escrito: _sass/custom/_home.scss"

# ---- _sass/custom/_consultoria.scss ----
cat > '_sass/custom/_consultoria.scss' <<'EOF_63385396'
// ============================================================
// Consultoria — serviços, processo, CTA, disclaimer
// ============================================================

$c-gold:  #e7b788;
$c-blue:  #8ea9e8;
$c-line:  rgba(212,212,255,0.10);

/* Grade de serviços */
.service-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 1.5em;
}
@media screen and (max-width: 736px) {
	.service-grid { grid-template-columns: 1fr; }
}

.service-card {
	background: #0e1316;
	border: 1px solid $c-line;
	border-radius: 5px;
	padding: 2em 2em 1.75em;
	transition: transform 0.25s ease, border-color 0.25s ease, box-shadow 0.25s ease;

	.icon.major {
		color: $c-gold;
		margin: 0 0 0.5em 0;
		&:before { font-size: 2.25em; }
	}

	h3 {
		font-size: 1.15em;
		font-weight: 600;
		margin-bottom: 0.5em;
	}

	p {
		color: rgba(255,255,255,0.74);
		font-size: 0.9em;
		line-height: 1.65;
		margin: 0;
	}

	&:hover {
		transform: translateY(-5px);
		border-color: rgba(231,183,136,0.5);
		box-shadow: 0 10px 30px rgba(0,0,0,0.35);
	}
}

/* Processo */
.process-steps {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 1.5em;
}
@media screen and (max-width: 736px) {
	.process-steps { grid-template-columns: 1fr; }
}

.process-step {
	padding: 1.5em 0;
	border-top: 2px solid $c-gold;

	.process-num {
		display: block;
		font-family: "Courier New", monospace;
		font-size: 1.1em;
		color: $c-gold;
		letter-spacing: 0.1em;
		margin-bottom: 0.5em;
	}
	h4 { font-size: 1.1em; font-weight: 600; margin-bottom: 0.35em; }
	p  { color: rgba(255,255,255,0.72); font-size: 0.9em; margin: 0; }
}

/* CTA */
.consult-cta {
	text-align: center;
	padding: 4em 0;
	background: #0e1316;
	border-top: 1px solid $c-line;
	border-bottom: 1px solid $c-line;

	.inner { max-width: 42em; }
	h2 { font-weight: 600; }
	p  { color: rgba(255,255,255,0.78); margin-bottom: 1.5em; }
}

/* Disclaimer */
.consult-disclaimer {
	padding: 2.5em 0 4em;
	.inner { max-width: 50em; }
	p {
		font-size: 0.72em;
		line-height: 1.7;
		color: rgba(255,255,255,0.45);
		font-style: italic;
		margin: 0;
	}
}
EOF_63385396
echo "==> escrito: _sass/custom/_consultoria.scss"

# ---- assets/css/main.scss ----
cat > 'assets/css/main.scss' <<'EOF_21124580'
---
---
@import 'libs/vars';
@import 'libs/functions';
@import 'libs/mixins';
@import 'libs/skel';
@import 'font-awesome.min.css';
@import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,300italic,600,600italic');

/*
	Forty by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
*/

	@include skel-breakpoints((
		xlarge: '(max-width: 1680px)',
		large: '(max-width: 1280px)',
		medium: '(max-width: 980px)',
		small: '(max-width: 736px)',
		xsmall: '(max-width: 480px)',
		xxsmall: '(max-width: 360px)'
	));

	@include skel-layout((
		reset: 'full',
		boxModel: 'border',
		grid: ( gutters: 2em ),
		breakpoints: (
			large: (
				grid: ( gutters: 1.5em )
			),
			small: (
				grid: ( gutters: 1.25em )
			)
		)
	));

	@mixin inner {
		> .inner {
			@include padding(4em, 0);
			margin: 0 auto;
			max-width: _size(inner);
			width: calc(100% - 6em);

			@include breakpoint(small) {
				@include padding(3em, 0);
				width: calc(100% - 3em);
			}
		}
	}

// Base.

	@import 'base/page';
	@import 'base/typography';

// Component.

	@import 'components/section';
	@import 'components/form';
	@import 'components/box';
	@import 'components/icon';
	@import 'components/image';
	@import 'components/list';
	@import 'components/table';
	@import 'components/button';
	@import 'components/tiles';
	@import 'components/contact-method';
	@import 'components/spotlights';

// Layout.

	@import 'layout/header';
	@import 'layout/banner';
	@import 'layout/main';
	@import 'layout/contact';
	@import 'layout/footer';
	@import 'layout/wrapper';
	@import 'layout/menu';

// Custom — Marcio Ventura Portfolio.

	@import 'custom/indicators';
	@import 'custom/projects';
	@import 'custom/ticker';
	@import 'custom/terminal';
	@import 'custom/posts';
	@import 'custom/home';
	@import 'custom/consultoria';
EOF_21124580
echo "==> escrito: assets/css/main.scss"

echo ""
echo "===================================================================="
echo "PRONTO. Para publicar:"
echo "    git add -A"
echo "    git commit -m \"feat: home 2x2, pagina Consultoria e redesign\""
echo "    git push"
echo "===================================================================="
