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
            WHEN pontuacao = 15 THEN '100%'
            WHEN pontuacao >= 11.25 THEN 'Entre 75% e 99%'
            WHEN pontuacao >= 7.5 THEN 'Entre 50% e 74%'
            WHEN pontuacao >= 3.75 THEN 'Entre 25% e 49%'
            ELSE 'Abaixo de 25%'
        END AS desempenho
    FROM tentativaQuiz) as classificacao
    GROUP BY desempenho;`;

        console.log("Executando a instrução SQL: \n" + instrucaoSql);
        return database.executar(instrucaoSql);
    }

    if (idGrafico == 4) {
        var instrucaoSql = `SELECT faixa_idade, count(*) as contagem
        FROM (SELECT CASE
        WHEN TIMESTAMPDIFF(YEAR, dtNascimento, current_date()) > 60 THEN 'Acima de 60 anos'
        WHEN TIMESTAMPDIFF(YEAR, dtNascimento, current_date()) BETWEEN 41 AND 60 THEN 'Entre 41 e 60 anos'
        WHEN TIMESTAMPDIFF(YEAR, dtNascimento, current_date()) BETWEEN 21 AND 40 THEN 'Entre 21 e 40 anos'
        ELSE 'Abaixo de 20 anos'
        END AS faixa_idade
        FROM usuario
        ) as a
        GROUP BY faixa_idade`;

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

function buscarMedidasEmTempoReal(idAquario) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        FROM medida WHERE fk_aquario = ${idAquario} 
                    ORDER BY id DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
