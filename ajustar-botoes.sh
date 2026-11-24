#!/usr/bin/env bash
# Ajusta o espacamento/alinhamento dos botoes do hero. Rodar na raiz do repo.
set -e
if [ ! -f _config.yml ]; then echo "ERRO: rode na raiz do repo."; exit 1; fi
mkdir -p _sass/custom
cat > '_sass/custom/_home.scss' <<'EOF_HOME'
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

	// Botões do hero: flex com espaçamento nos dois sentidos (resolve o "colado")
	.actions {
		margin-top: 1.75em;
		display: flex;
		flex-wrap: wrap;
		gap: 0.9em;

		li { padding: 0; margin: 0; }

		.button {
			margin: 0;
			min-width: 11em;      // larguras iguais → alinhados
			text-align: center;
		}
	}
}

@media screen and (max-width: 736px) {
	#banner.major h1 { font-size: 2.25em; }
	#banner.major .content p { letter-spacing: 0.14em; }
}

// No celular: botões empilhados, largura total e alinhados
@media screen and (max-width: 480px) {
	#banner.major .actions {
		flex-direction: column;
		align-items: stretch;

		li, .button { width: 100%; min-width: 0; }
	}
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
EOF_HOME
echo "==> _home.scss atualizado (botoes com espacamento)."
echo "Publicar:  git add -A && git commit -m \"ui: espacamento dos botoes do hero\" && git push"
