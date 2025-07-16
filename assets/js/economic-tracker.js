document.addEventListener('DOMContentLoaded', function() {

    // --- Funções para buscar dados ---

    // Função para buscar dados da API do Banco Central (SGS)
    // endpointId: ID da série no SGS (ex: 1 para Dólar, 433 ou 173 para IPCA)
    // lastN: Quantos últimos valores buscar
    async function fetchBCBData(endpointId, lastN = 1) {
        // Data atual (formato YYYY-MM-DD)
        const today = new Date();
        const endDate = today.toISOString().split('T')[0];

        // Calcular a data de início para pegar N valores
        // Ex: para 1 valor, não precisa de data inicial, mas a API pode exigir
        // Ou se precisar de variação diária, pode precisar de 2 dias.
        // Para simplificar, vou buscar os N últimos e pegar o mais recente.
        const apiUrl = `https://api.bcb.gov.br/dados/serie/bcdata.sgs.${endpointId}/dados/ultimos/${lastN}?formato=json`;

        try {
            const response = await fetch(apiUrl);
            if (!response.ok) {
                throw new Error(`Erro HTTP: ${response.status}`);
            }
            const data = await response.json();
            return data;
        } catch (error) {
            console.error(`Erro ao buscar dados do BCB (SGS ${endpointId}):`, error);
            return null;
        }
    }

    // --- Funções para atualizar o HTML ---

    async function updateDolar() {
        const data = await fetchBCBData(1, 2); // 1 = Série Dólar Comercial (venda), buscando os 2 últimos para calcular variação
        if (data && data.length >= 2) {
            const latest = parseFloat(data[data.length - 1].valor);
            const previous = parseFloat(data[data.length - 2].valor);
            const date = data[data.length - 1].data; // Data do último valor

            const change = ((latest - previous) / previous) * 100;

            const valueElement = document.querySelector('#dolar-data .dolar-current-value');
            const changeElement = document.querySelector('#dolar-data .dolar-daily-change');

            if (valueElement) valueElement.textContent = latest.toFixed(4).replace('.', ',');
            if (changeElement) {
                changeElement.textContent = `${change.toFixed(2).replace('.', ',')}%`;
                changeElement.classList.remove('positive', 'negative');
                if (change > 0) {
                    changeElement.classList.add('positive');
                } else if (change < 0) {
                    changeElement.classList.add('negative');
                }
            }
        } else {
            console.warn('Dados insuficientes para o Dólar.');
        }
    }

    async function updateIbovespa() {
        // **ESTE É UM PLACEHOLDER!**
        // Você precisará de uma API real para o Ibovespa aqui.
        // Ex: Alpha Vantage, Tiingo, ou outra fonte.
        // O ideal é buscar o valor atual e o do dia anterior para calcular a variação.

        // Exemplo de dados mock (simulados)
        const currentIbov = (Math.random() * (130000 - 100000) + 100000);
        const previousIbov = currentIbov * (1 + (Math.random() * 0.02 - 0.01)); // Variação de -1% a +1%
        const change = ((currentIbov - previousIbov) / previousIbov) * 100;

        const valueElement = document.querySelector('#ibovespa-data .ibov-current-value');
        const changeElement = document.querySelector('#ibovespa-data .ibov-daily-change');

        if (valueElement) valueElement.textContent = Math.round(currentIbov).toLocaleString('pt-BR');
        if (changeElement) {
            changeElement.textContent = `${change.toFixed(2).replace('.', ',')}%`;
            changeElement.classList.remove('positive', 'negative');
            if (change > 0) {
                changeElement.classList.add('positive');
            } else if (change < 0) {
                changeElement.classList.add('negative');
            }
        }
        console.warn('Ibovespa está usando dados mock. Implemente uma API real!');
    }

    async function updateIPCA() {
        // ID da série IPCA no SGS (173 para IPCA - Nacional - mês)
        // Buscamos 1 valor, pois a variação é mensal e a referência é o próprio valor.
        const data = await fetchBCBData(173, 1);
        if (data && data.length > 0) {
            const latest = parseFloat(data[data.length - 1].valor);
            const date = data[data.length - 1].data; // Formato DD/MM/YYYY

            const valueElement = document.querySelector('#ipca-data .ipca-current-value');
            const refDateElement = document.querySelector('#ipca-data .ipca-ref-date');

            if (valueElement) valueElement.textContent = latest.toFixed(2).replace('.', ',');
            if (refDateElement) refDateElement.textContent = date.substring(3); // Pegar MM/YYYY
        } else {
            console.warn('Dados de IPCA não encontrados.');
        }
    }

    function updatePIB() {
        // **Para o PIB, não há uma API em tempo real.**
        // Você deve atualizar isso manualmente ou de uma fonte estática/confiável.
        // Os dados do PIB são divulgados trimestralmente ou anualmente pelo IBGE.
        // Para este exemplo, vou usar dados mock (simulados).

        const pibValue = 2.5; // Exemplo: crescimento de 2.5% no último período
        const pibRefDate = "Mar/2025"; // Exemplo: Referência do último dado divulgado

        const valueElement = document.querySelector('#pib-data .pib-current-value');
        const refDateElement = document.querySelector('#pib-data .pib-ref-date');

        if (valueElement) valueElement.textContent = pibValue.toFixed(1).replace('.', ',');
        if (refDateElement) refDateElement.textContent = pibRefDate;

        // O PIB é geralmente uma variação positiva; se quiser mostrar variação negativa, pode adicionar lógica.
        const changeElement = document.querySelector('#pib-data .indicator-value'); // Ou outro elemento para cor
        if (pibValue > 0) {
            changeElement.classList.add('positive'); // Adiciona cor verde se positivo
        } else if (pibValue < 0) {
            changeElement.classList.add('negative'); // Adiciona cor vermelha se negativo
        }
        console.warn('PIB está usando dados mock. Atualize manualmente ou de uma fonte oficial!');
    }

    // --- Inicialização e Atualização Periódica ---

    // Função para carregar todos os indicadores
    function loadEconomicIndicators() {
        updateDolar();
        updateIbovespa(); // Lembre-se que é mock!
        updateIPCA();
        updatePIB();     // Lembre-se que é mock!
    }

    // Carregar os indicadores na inicialização da página
    loadEconomicIndicators();

    // Atualizar Dólar e Ibovespa a cada 5 minutos (300.000 ms)
    // IPCA e PIB não precisam de atualização em tempo real, só no carregamento.
    setInterval(updateDolar, 300000); // 5 minutos
    setInterval(updateIbovespa, 300000); // 5 minutos (mock)
});