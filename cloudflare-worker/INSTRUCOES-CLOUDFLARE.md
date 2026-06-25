# Deploy do Cloudflare Worker — Proxy de Cotações

Este Worker busca IBOVESPA, S&P 500 e Nasdaq do Yahoo Finance sem o bloqueio de CORS
que impedia os dados de aparecerem no portfólio.

## Pré-requisitos
- Conta gratuita na Cloudflare (https://dash.cloudflare.com/sign-up)

---

## Opção A — Deploy pelo Painel (mais simples, sem instalar nada)

1. Acesse https://dash.cloudflare.com e faça login.
2. No menu lateral, vá em **Workers & Pages**.
3. Clique em **Create** → **Create Worker**.
4. Dê um nome, ex: `market-proxy`. A URL final será algo como
   `https://market-proxy.SEU-USUARIO.workers.dev`.
5. Clique em **Deploy** (ele cria um worker "Hello World" inicial).
6. Clique em **Edit code**.
7. Apague todo o código do editor e cole o conteúdo do arquivo `worker.js`.
8. Clique em **Deploy** (canto superior direito).

Pronto. Teste no navegador abrindo:
```
https://market-proxy.SEU-USUARIO.workers.dev/?ticker=^BVSP
```
Você deve ver um JSON com os campos `current`, `previous` e `change`.

---

## Opção B — Deploy via terminal (Wrangler CLI)

```bash
# 1. Instale o Wrangler
npm install -g wrangler

# 2. Faça login na Cloudflare
wrangler login

# 3. Dentro da pasta cloudflare-worker/, faça o deploy
cd cloudflare-worker
wrangler deploy
```
O `wrangler.toml` já está configurado nesta pasta.

---

## Passo final OBRIGATÓRIO — conectar o Worker ao site

Depois do deploy, copie a URL do seu Worker e cole no arquivo:

**`assets/js/economic-tracker.js`** → linha da constante `MARKET_PROXY`:

```js
const MARKET_PROXY = 'https://market-proxy.SEU-USUARIO.workers.dev';
```

Substitua pela URL real. Faça o commit e o deploy do site. Os índices passam a carregar.

---

## Segurança já incluída no Worker

- **Whitelist de tickers:** só aceita `^BVSP`, `^GSPC`, `^IXIC`. Ninguém pode usar
  seu Worker para proxiar outras coisas.
- **Whitelist de origem (CORS):** só responde para marcioventura.com.br e localhost.
- **Cache de 5 min** na borda da Cloudflare — reduz chamadas ao Yahoo e acelera o site.

## Limites do plano gratuito
- 100.000 requisições/dia. Um portfólio usa uma fração mínima disso.
