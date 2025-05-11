create database if not exists spfcpedia;
use spfcpedia;

-- criando as tabelas
create table planoST (
idplanoST int primary key,
nome varchar(20),
nivel_acumuloPontos int,
prioridade_compradeIngressos int,
qtd_ST_infantilDependente int,
numero_convidados int
);

create table estado (
idEstado int primary key,
nome varchar(30),
sigla char(2),
regiao varchar(15)
);

create table usuario (
idUsuario int primary key auto_increment,
nome varchar(30) not null,
sobrenome varchar(70) not null,
dtNascimento date not null,
fk_idPlanoST int,
cidade varchar(50) not null,
fk_idEstado int not null,
email varchar(150) not null,
senha varchar(100) not null,
constraint FK_planoST_usuario foreign key (fk_idPlanoST) references planoST(idplanoST),
constraint FK_estado_usuario foreign key (fk_idEstado) references estado(idEstado)
);

create table tentativaQuiz (
idTentativa int primary key auto_increment,
fk_idusuario int not null,
dataHoraTentativa datetime default current_timestamp(),
pontuacao int not null,
constraint chk_pontuacao check (pontuacao between 0 and 15),
constraint fk_usuario_tentativaQuiz foreign key (fk_idusuario) references usuario(idUsuario)
);

-- inserindo dados na tabela de estados
insert into estado (idEstado, nome, sigla, regiao) values
(1,  'Acre', 'AC', 'Norte'),
(2,  'Alagoas', 'AL', 'Nordeste'),
(3,  'Amapá', 'AP', 'Norte'),
(4,  'Amazonas', 'AM', 'Norte'),
(5,  'Bahia', 'BA', 'Nordeste'),
(6,  'Ceará', 'CE', 'Nordeste'),
(7,  'Distrito Federal', 'DF', 'Centro-Oeste'),
(8,  'Espírito Santo', 'ES', 'Sudeste'),
(9,  'Goiás', 'GO', 'Centro-Oeste'),
(10, 'Maranhão', 'MA', 'Nordeste'),
(11, 'Mato Grosso', 'MT', 'Centro-Oeste'),
(12, 'Mato Grosso do Sul', 'MS', 'Centro-Oeste'),
(13, 'Minas Gerais', 'MG', 'Sudeste'),
(14, 'Pará', 'PA', 'Norte'),
(15, 'Paraíba', 'PB', 'Nordeste'),
(16, 'Paraná', 'PR', 'Sul'),
(17, 'Pernambuco', 'PE', 'Nordeste'),
(18, 'Piauí', 'PI', 'Nordeste'),
(19, 'Rio de Janeiro', 'RJ', 'Sudeste'),
(20, 'Rio Grande do Norte', 'RN', 'Nordeste'),
(21, 'Rio Grande do Sul', 'RS', 'Sul'),
(22, 'Rondônia', 'RO', 'Norte'),
(23, 'Roraima', 'RR', 'Norte'),
(24, 'Santa Catarina', 'SC', 'Sul'),
(25, 'São Paulo', 'SP', 'Sudeste'),
(26, 'Sergipe', 'SE', 'Nordeste'),
(27, 'Tocantins', 'TO', 'Norte');

-- inserindo dados na tabela de planos de sócio-torcedor
insert into planoST (idPlanoST, nome, nivel_acumuloPontos, prioridade_compradeIngressos, qtd_ST_infantilDependente, numero_convidados) values
(1, 'Sem plano', null, null, null, null),
(2, 'Vermelho', 1, 0, 1, 0),
(3, 'Branco', 2, 1, 1, 0),
(4, 'Preto', 3, 2, 2, 1),
(5, 'Tricolor', 4, 3, 2, 1),
(6, 'Diamante', 5, 4, 3, 2);