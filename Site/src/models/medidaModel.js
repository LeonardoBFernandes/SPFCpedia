var database = require("../database/config");

function buscarUltimasMedidas(idGrafico, limite_linhas) {
    if (idGrafico == 1) {
        var instrucaoSql = `SELECT pst.nome as plano, count(*) as contagem 
        FROM usuario usu 
        INNER JOIN planoST pst on pst.idplanoST = usu.fk_idplanoST 
        GROUP BY plano`;
        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idGrafico == 2) {
        var instrucaoSql = `SELECT est.regiao as regiao, count(*) as contagem
        FROM usuario usu
        INNER JOIN estado est on est.idestado = usu.fk_idestado
        GROUP BY regiao`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idGrafico == 3) {
        var instrucaoSql = `SELECT desempenho, count(*) as contagem
        FROM 
        (SELECT 
        CASE 
            WHEN porcentagemAcertos = 1 THEN '100%'
            WHEN porcentagemAcertos >= 0.75 THEN 'Entre 75% e 99%'
            WHEN porcentagemAcertos >= 0.5 THEN 'Entre 50% e 74%'
            WHEN porcentagemAcertos >= 0.25 THEN 'Entre 25% e 49%'
            ELSE 'Abaixo de 25%'
        END AS desempenho
    FROM tentativaQuiz) as classificacao
    GROUP BY desempenho;`;
        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idGrafico == 4) {
        var instrucaoSql = `SELECT *
        FROM view_faixaIdade`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idGrafico == 5) {
        var instrucaoSql = `SELECT jog.apelido as apelido, count(*) as contagem
        FROM usuario usu
        INNER JOIN jogador jog on jog.idjogador = usu.fk_jogadorFavorito
        GROUP BY apelido
    ORDER BY contagem DESC LIMIT ${limite_linhas}`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }
}

function buscarMedidasEmTempoReal(idIndicador) {
    if (idIndicador == 1) {
        var instrucaoSql = `SELECT plano
        FROM view_planoST
        WHERE contagem = (SELECT MAX(contagem) FROM view_planoST)`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idIndicador == 2) {
        var instrucaoSql = `SELECT estado
        FROM view_estado
        WHERE contagem = (SELECT MAX(contagem) FROM view_estado)`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idIndicador == 3) {
        var instrucaoSql = `SELECT ROUND(AVG(pontuacao), 0) as media
        FROM tentativaQuiz`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idIndicador == 4) {
        var instrucaoSql = `SELECT faixa_idade
        FROM view_faixaIdade
        WHERE contagem = (SELECT MAX(contagem) FROM view_faixaIdade)`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idIndicador == 5) {
        var instrucaoSql = `SELECT jogador
        FROM view_jogador
        WHERE contagem = (SELECT MAX(contagem) FROM view_jogador)`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idIndicador == 6) {
        var instrucaoSql = `SELECT regiao
        FROM view_regiao
        WHERE contagem = (SELECT MAX(contagem) FROM view_regiao)`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
