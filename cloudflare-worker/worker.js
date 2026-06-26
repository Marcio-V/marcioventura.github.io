/**
 * Cloudflare Worker — Proxy de Cotações de Mercado
 * Para: marcioventura.com.br
 *
 * Função: buscar IBOVESPA, S&P 500 e Nasdaq do Yahoo Finance server-side,
 * contornando o bloqueio de CORS do navegador.
 *
 * Endpoint:  https://SEU-WORKER.workers.dev/?ticker=^BVSP
 * Retorno:   { "current": 137000, "previous": 136200, "change": 0.58 }
 *
 * Deploy: ver INSTRUCOES-CLOUDFLARE.md
 */

// Tickers permitidos (whitelist de segurança — evita uso indevido do seu Worker)
const ALLOWED_TICKERS = [
  '^BVSP', '^GSPC', '^IXIC', '^TNX', '^VIX', '^DJI',
  'PETR4.SA', 'VALE3.SA', 'GGBR4.SA', 'BPAC11.SA', 'SBSP3.SA', 'CSMG3.SA', 'ITUB4.SA', 'WEGE3.SA',
  // Commodities (futuros)
  'CL=F', 'BZ=F', 'GC=F', 'HG=F', 'ZS=F', 'ZC=F',
];

// Domínios autorizados a consumir este Worker (CORS)
const ALLOWED_ORIGINS = [
  'https://marcioventura.com.br',
  'https://www.marcioventura.com.br',
  'http://localhost:4000', // Jekyll local
  'http://127.0.0.1:4000',
];

function corsHeaders(origin) {
  const allowed = ALLOWED_ORIGINS.includes(origin) ? origin : ALLOWED_ORIGINS[0];
  return {
    'Access-Control-Allow-Origin': allowed,
    'Access-Control-Allow-Methods': 'GET, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Cache-Control': 'public, max-age=300', // cache de 5 min na borda
    'Content-Type': 'application/json; charset=utf-8',
  };
}

export default {
  async fetch(request) {
    const origin = request.headers.get('Origin') || '';

    // Preflight CORS
    if (request.method === 'OPTIONS') {
      return new Response(null, { status: 204, headers: corsHeaders(origin) });
    }

    const url = new URL(request.url);
    const ticker = url.searchParams.get('ticker');

    // Validação
    if (!ticker || !ALLOWED_TICKERS.includes(ticker)) {
      return new Response(
        JSON.stringify({ error: 'Ticker inválido ou não permitido.' }),
        { status: 400, headers: corsHeaders(origin) }
      );
    }

    // Busca no Yahoo Finance (server-side, sem restrição de CORS)
    const yahooUrl =
      'https://query1.finance.yahoo.com/v8/finance/chart/' +
      encodeURIComponent(ticker) +
      '?interval=1d&range=2d';

    try {
      const res = await fetch(yahooUrl, {
        headers: {
          // User-Agent ajuda a evitar bloqueio do Yahoo
          'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          'Accept': 'application/json',
        },
        // cache na rede da Cloudflare
        cf: { cacheTtl: 300, cacheEverything: true },
      });

      if (!res.ok) {
        throw new Error('Yahoo respondeu HTTP ' + res.status);
      }

      const json = await res.json();
      const result = json?.chart?.result?.[0];
      if (!result || !result.meta) {
        throw new Error('Estrutura de dados inesperada do Yahoo.');
      }

      const meta = result.meta;
      const current = meta.regularMarketPrice;
      const previous = meta.chartPreviousClose ?? meta.previousClose;
      const change = ((current - previous) / previous) * 100;

      const payload = {
        ticker: ticker,
        current: current,
        previous: previous,
        change: change,
        currency: meta.currency || null,
        timestamp: Date.now(),
      };

      return new Response(JSON.stringify(payload), {
        status: 200,
        headers: corsHeaders(origin),
      });
    } catch (err) {
      return new Response(
        JSON.stringify({ error: 'Falha ao buscar cotação: ' + err.message }),
        { status: 502, headers: corsHeaders(origin) }
      );
    }
  },
};
