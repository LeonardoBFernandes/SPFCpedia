var database = require("../database/config")

function listar(id) {
    var instrucao = `
        SELECT max(pontuacao) as pontuacao FROM tentativaQuiz where fk_idusuario = ('${id}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function cadastrar(id, pontuacao, porcentagem) {
    var instrucao = `
        INSERT INTO tentativaQuiz (fk_idusuario, pontuacao, porcentagemAcertos) VALUES ('${id}', ${pontuacao}, '${porcentagem}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    cadastrar,
    listar
};