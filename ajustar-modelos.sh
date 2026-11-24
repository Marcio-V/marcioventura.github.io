#!/usr/bin/env bash
# Da vida a secao 'Modelos Economicos' (modulo 19 da pagina Economia):
# cada modelo vira clicavel e abre teoria, equacoes, aplicacao pratica e leitura p/ investimentos.
# Rodar na RAIZ do repositorio.
set -e
if [ ! -f _config.yml ]; then echo "ERRO: rode na raiz do repo (onde esta _config.yml)."; exit 1; fi
if [ ! -f elements.md ]; then echo "ERRO: elements.md (pagina Economia) nao encontrado."; exit 1; fi
mkdir -p .tmp-modelos
cat > .tmp-modelos/old.html <<'OLD_EOF'
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
OLD_EOF
cat > .tmp-modelos/new.html <<'NEW_EOF'
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
NEW_EOF
cat > .tmp-modelos/styles.scss <<'SCSS_EOF'

// ═══════════════ Modelos Econômicos — chips clicáveis + modal ═══════════════
.macro-terminal {

	.term-chips .term-chip.clickable {
		cursor: pointer;
		text-align: left;
		width: 100%;
		display: block;
		font-family: inherit;
		position: relative;
		appearance: none;
		color: $term-text;

		.chip-cta {
			display: block;
			margin-top: 0.55em;
			font-size: 0.6rem;
			letter-spacing: 0.12em;
			text-transform: uppercase;
			color: $term-accent;
			opacity: 0;
			transform: translateY(2px);
			transition: all 0.15s ease;
		}
		&:hover, &:focus-visible {
			border-color: $term-accent;
			outline: none;
			.chip-cta { opacity: 1; transform: translateY(0); }
		}
	}

	// ─── Modal ───
	.model-modal {
		position: fixed;
		inset: 0;
		z-index: 9999;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 1.2rem;

		&[hidden] { display: none; }

		.model-modal-backdrop {
			position: absolute;
			inset: 0;
			background: rgba(3, 6, 9, 0.78);
			backdrop-filter: blur(3px);
			opacity: 0;
			transition: opacity 0.18s ease;
		}
		&.is-open .model-modal-backdrop { opacity: 1; }

		.model-modal-panel {
			position: relative;
			width: min(760px, 100%);
			max-height: 88vh;
			display: flex;
			flex-direction: column;
			background: $term-panel;
			border: 1px solid $term-border;
			border-radius: 8px;
			box-shadow: 0 24px 60px rgba(0,0,0,.55);
			opacity: 0;
			transform: translateY(12px) scale(.98);
			transition: opacity 0.18s ease, transform 0.18s ease;
		}
		&.is-open .model-modal-panel { opacity: 1; transform: translateY(0) scale(1); }

		.model-modal-head {
			display: flex;
			align-items: flex-start;
			justify-content: space-between;
			gap: 1rem;
			padding: 1.3rem 1.5rem 1rem;
			border-bottom: 1px solid $term-border;

			.model-modal-kicker {
				font-size: 0.6rem;
				letter-spacing: 0.2em;
				text-transform: uppercase;
				color: $term-accent;
				margin-bottom: 0.4em;
			}
			h3 {
				margin: 0;
				font-size: 1.3rem;
				color: $term-text;
				line-height: 1.15;
			}
			.model-modal-sub {
				margin-top: 0.3em;
				font-size: 0.72rem;
				color: $term-muted;
			}
		}
		.model-modal-close {
			flex: none;
			background: transparent;
			border: 1px solid $term-border;
			color: $term-muted;
			width: 2rem;
			height: 2rem;
			border-radius: 5px;
			font-size: 1.1rem;
			line-height: 1;
			cursor: pointer;
			transition: all 0.15s ease;
			&:hover { color: $term-text; border-color: $term-down; background: rgba(248,81,73,.1); }
		}

		.model-modal-body {
			padding: 1.3rem 1.5rem 1.6rem;
			overflow-y: auto;
		}
	}

	// ─── Seções do detalhe ───
	.model-section {
		padding: 0 0 1.25rem;
		margin-bottom: 1.25rem;
		border-bottom: 1px dashed $term-border;
		&:last-child { border-bottom: 0; margin-bottom: 0; padding-bottom: 0; }

		h4 {
			display: flex;
			align-items: center;
			gap: 0.55em;
			margin: 0 0 0.6em;
			font-size: 0.72rem;
			letter-spacing: 0.14em;
			text-transform: uppercase;
			color: $term-text;

			span {
				font-size: 0.62rem;
				color: $term-bg;
				background: $term-muted;
				border-radius: 3px;
				padding: 0.15em 0.45em;
				font-weight: 700;
			}
		}
		p {
			margin: 0;
			font-size: 0.82rem;
			line-height: 1.7;
			color: $term-muted;
			max-width: 68ch;
			strong { color: $term-text; }
			em { color: $term-blue; font-style: normal; }
		}

		&.invest {
			h4 span { background: $term-accent; }
			p { color: #cdd6df; }
		}
	}

	.model-eq {
		background: $term-bg;
		border: 1px solid $term-border;
		border-left: 2px solid $term-accent;
		border-radius: 4px;
		padding: 0.6em 0.9em;
		margin-bottom: 0.5em;
		font-family: "Roboto Mono", "Courier New", monospace;
		font-size: 0.82rem;
		color: $term-text;
		line-height: 1.6;
		overflow-x: auto;
		white-space: nowrap;

		& + .model-eq { margin-top: -0.1em; }
		sub, sup { color: $term-blue; }
	}
	.model-eqnote {
		font-size: 0.72rem !important;
		color: $term-muted !important;
		margin-top: 0.6em !important;
		font-style: italic;
	}

	@media screen and (max-width: 560px) {
		.model-modal .model-modal-panel { max-height: 92vh; }
		.model-modal .model-modal-head { padding: 1rem 1.1rem 0.8rem; h3 { font-size: 1.1rem; } }
		.model-modal .model-modal-body { padding: 1.1rem; }
		.model-eq { white-space: normal; font-size: 0.76rem; }
	}
}
SCSS_EOF
python3 -I - <<'PY_EOF'

import os
md=open('elements.md',encoding='utf-8').read()
old=open('.tmp-modelos/old.html',encoding='utf-8').read().rstrip('\n')
new=open('.tmp-modelos/new.html',encoding='utf-8').read().rstrip('\n')
if 'model-modal' in md and 'id="modelos"' in md:
    print('  - elements.md: secao de modelos ja atualizada (pulando)')
elif old in md:
    open('elements.md','w',encoding='utf-8').write(md.replace(old,new,1))
    print('  - elements.md: secao 19 atualizada (chips clicaveis + modal)')
else:
    raise SystemExit('ERRO: bloco original da secao 19 nao encontrado em elements.md.')
scssf='_sass/custom/_terminal.scss'
s=open(scssf,encoding='utf-8').read()
MARK='Modelos Economicos — chips clicaveis'  # nunca casa (acentos) -> usamos marcador real abaixo
MARK='chips clicáveis + modal'
if MARK in s:
    print('  - _terminal.scss: estilos ja presentes (pulando)')
else:
    add=open('.tmp-modelos/styles.scss',encoding='utf-8').read()
    open(scssf,'a',encoding='utf-8').write('\n'+add+'\n')
    print('  - _terminal.scss: estilos do modal adicionados')

PY_EOF
rm -rf .tmp-modelos
echo ""
echo "==> Concluido. Para publicar:"
echo "    git add -A && git commit -m \"feat: modelos economicos clicaveis (teoria, equacoes, aplicacao)\" && git push"
