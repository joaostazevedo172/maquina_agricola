-- Consultas na Tabela `SENSORES` (Dados da Fase 2)
-- Estas consultas exploram os dados que você importou do seu arquivo da Fase 2.

-- 1. Verificação Rápida (10 Linhas)
-- Objetivo: Mostrar rapidamente que os dados da Fase 2 (Plantas, Área, UF) estão na tabela.
SELECT
    UF,
    PLANTAS,
    ÁREA_COLHIDA
FROM
    SENSORES
FETCH FIRST 10 ROWS ONLY;

-- 2. Análise Principal por Categoria
-- Objetivo: Calcular o total de registros, a soma de plantas e a média de área por categoria.
SELECT
    CATEGORIA_ÁREA, 
    COUNT(*) AS NUMERO_DE_REGISTROS,
    SUM(PLANTAS) AS TOTAL_PLANTAS,
    ROUND(AVG(ÁREA_COLHIDA), 2) AS MEDIA_AREA_POR_REGISTRO
FROM
    SENSORES
GROUP BY
    CATEGORIA_ÁREA;

-- 3. Medidas de Tendência Central (Plantas)
-- Objetivo: Calcular as estatísticas centrais (Média, Mediana, Máximo) da coluna principal.
SELECT
    AVG(PLANTAS) AS MEDIA_PLANTAS,
    MEDIAN(PLANTAS) AS MEDIANA_PLANTAS,
    MAX(PLANTAS) AS MAX_PLANTAS
FROM
    SENSORES;

-- 4. Distribuição por Faixa de Área
-- Objetivo: Classificar as áreas como 'GRANDE' ou 'PEQUENA' e contar os registros em cada faixa.
SELECT
    CASE WHEN ÁREA_COLHIDA > 1000 THEN 'GRANDE' ELSE 'PEQUENA' END AS FAIXA_AREA,
    COUNT(*) AS TOTAL_REGISTROS,
    SUM(PLANTAS) AS SOMA_PLANTAS
FROM
    SENSORES
GROUP BY
    CASE WHEN ÁREA_COLHIDA > 1000 THEN 'GRANDE' ELSE 'PEQUENA' END;

-- 5. Ranking de Área Total por Estado (UF)
-- Objetivo: Mostrar quais estados (UF) possuem a maior soma de área colhida.
SELECT
    UF,
    SUM(ÁREA_COLHIDA) AS AREA_TOTAL_COLHIDA
FROM
    SENSORES
GROUP BY
    UF
ORDER BY
    AREA_TOTAL_COLHIDA DESC;

-- Consultas na Tabela `COLHEITAS`
-- Estas consultas analisam os dados de produtividade, perdas e preços.

-- 6. Análise de Desempenho por Mês de Plantio
-- Objetivo: Calcular a produtividade média, perda média e preço máximo, agrupados por mês.
SELECT
    MES_PLANTIO,
    ROUND(AVG(PRODUTIVIDADE_ESPERADA_THA), 2) AS PROD_MEDIA_ESPERADA,
    ROUND(AVG(PERDA_REGISTRADA_THA), 2) AS PERDA_MEDIA,
    MAX(PRECO_TONELADA) AS PRECO_MAXIMO
FROM
    COLHEITAS
GROUP BY
    MES_PLANTIO
ORDER BY
    PROD_MEDIA_ESPERADA DESC;

-- 7. Análise de Perda Total por Mês
-- Objetivo: Identificar os meses de plantio com a maior soma de perdas registradas.
SELECT
    MES_PLANTIO,
    SUM(PERDA_REGISTRADA_THA) AS PERDA_TOTAL_THA
FROM
    COLHEITAS
GROUP BY
    MES_PLANTIO
ORDER BY
    PERDA_TOTAL_THA DESC;

