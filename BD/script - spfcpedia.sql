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

create table jogador (
idJogador int primary key auto_increment,
apelido varchar(30) not null,
nome varchar(150) not null,
posicao varchar(20) not null,
pais varchar(40) not null,
cidadeOrigem varchar(50) not null,
fk_idEstado int,
constraint FK_estado_jogador foreign key (fk_idEstado) references estado(idEstado)
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
fk_jogadorFavorito int not null,
constraint FK_planoST_usuario foreign key (fk_idPlanoST) references planoST(idplanoST),
constraint FK_estado_usuario foreign key (fk_idEstado) references estado(idEstado),
constraint FK_jogador_usuario foreign key (fk_jogadorFavorito) references jogador(idJogador)
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

-- inserindo dados na tabela de jogadores
insert into jogador (apelido, nome, posicao, pais, cidadeOrigem, fk_idEstado) values
('Jandrei', 'Jandrei Chitolina Carniel', 'Goleiro', 'Brasil', 'Itaqui', 21),
('Leandro', 'Leandro Mathias Silva Bueno', 'Goleiro', 'Brasil', 'Campinas', 25),
('Rafael', 'Rafael Pires Monteiro', 'Goleiro', 'Brasil', 'Coronel Fabriciano', 13),
('Young', 'Young Navarro Moraes', 'Goleiro', 'Brasil', 'Catanduva', 25),
('Alan Franco', 'Alan Javier Franco', 'Defensor', 'Argentina', 'Avellaneda', null),
('Arboleda', 'Robert Abel Arboleda Escobar', 'Defensor', 'Equador', 'Esmeraldas', null),
('Cédric', 'Cédric Ricardo Alves Soares', 'Defensor', 'Portugal / Alemanha', 'Singen', null),
('Enzo Díaz', 'Enzo Hernán Díaz', 'Defensor', 'Argentina', 'Las Toscas', null),
('Ferraresi', 'Nahuel Adolfo Ferraresi Hernández', 'Defensor', 'Venezuela', 'San Cristóbal', null),
('Igão', 'Igor Odoni Gomes', 'Defensor', 'Brasil', 'São Paulo', 25),
('Igor Vinícius', 'Igor Vinícius de Souza', 'Defensor', 'Brasil', 'Sinop', 11),
('Patryck', 'Patryck Lanza dos Reis', 'Defensor', 'Brasil', 'Mogi Mirim', 11),
('Ruan', 'Ruan Tressoldi Netto', 'Defensor', 'Brasil', 'Tramandaí', 21),
('Sabino', 'José Sabino Chagas Monteiro', 'Defensor', 'Brasil', 'Brasília', 7),
('Wendell', 'Wendell Nascimento Borges', 'Defensor', 'Brasil', 'Fortaleza', 6),
('Alisson', 'Alisson Euler de Freitas Castro', 'Meio-campista', 'Brasil', 'Rio Pomba', 13),
('Alves', 'Matheus Alves Nascimento', 'Meio-campista', 'Brasil', 'São Vicente', 25),
('Bobadilla', 'Damián Josué Bobadilla Benítez', 'Meio-campista', 'Paraguai', 'Asunción', null),
('Luiz Gustavo', 'Luiz Gustavo Dias', 'Meio-campista', 'Brasil', 'Pindamonhangaba', 25),
('Marcos Antônio', 'Marcos Antônio Silva Santos', 'Meio-campista', 'Brasil', 'Poções', 5),
('Oscar', 'Oscar dos Santos Emboaba Júnior', 'Meio-campista', 'Brasil', 'Americana', 25),
('Pablo Maia', 'Pablo Gonçalves Maia Fortunato', 'Meio-campista', 'Brasil', 'Brazópolis', 13),
('Rodriguinho', 'Rodrigo Huendra Almeida Mendonça', 'Meio-campista', 'Brasil', 'Mineiros', 9),
('André Silva', 'André Oliveira e Silva', 'Atacante', 'Brasil', 'Taboão da Serra', 25),
('Calleri', 'Jonathan Calleri', 'Atacante', 'Argentina', 'Buenos Aires', null),
('Ferreirinha', 'Aldemir dos Santos Ferreira', 'Atacante', 'Brasil', 'Dourados', 12),
('Henrique Carmo', 'Henrique Fabiano do Carmo', 'Atacante', 'Brasil', 'Joinville', 24),
('Lucas Ferreira', 'Lucas dos Santos Ferreira', 'Atacante', 'Brasil', 'Campos dos Goytacazes', 19),
('Lucas Moura', 'Lucas Rodrigues Moura da Silva', 'Atacante', 'Brasil', 'São Paulo', 25),
('Luciano', 'Luciano da Rocha Neves', 'Atacante', 'Brasil', 'Anápolis', 9),
('Ryan Francisco', 'Ryan Francisco Rodrigues dos Santos Silva', 'Atacante', 'Brasil', 'São Paulo', 25);

-- Insert de dados fictícios para popular o BD e explorar o máximo da dashboard
insert into usuario (nome, sobrenome, dtNascimento, fk_idPlanoST, cidade, fk_idEstado, email, senha, fk_jogadorFavorito) values
('Ana', 'Silva', '1990-05-15', 2, 'São Paulo', 25, 'ana.silva@example.com', 'senha123', 1),
('Carlos', 'Souza', '1985-10-22', 3, 'Campinas', 25, 'carlos.souza@example.com', 'senha456', 2),
('Mariana', 'Oliveira', '1992-03-18', 4, 'Belo Horizonte', 13, 'mariana.oliveira@example.com', 'senha789', 3),
('João', 'Pereira', '1988-07-09', 5, 'Fortaleza', 6, 'joao.pereira@example.com', 'senha321', 4),
('Fernanda', 'Almeida', '1995-12-02', 6, 'Salvador', 5, 'fernanda.almeida@example.com', 'senha654', 5),
('Lucas', 'Lima', '2000-01-20', 2, 'Curitiba', 16, 'lucas.lima@example.com', 'senha987', 6),
('Beatriz', 'Ferreira', '1993-06-25', 3, 'Rio de Janeiro', 19, 'beatriz.ferreira@example.com', 'senhaabc', 7),
('Rafael', 'Rodrigues', '1991-11-11', 4, 'Porto Alegre', 21, 'rafael.rodrigues@example.com', 'senhadef', 8),
('Juliana', 'Costa', '1994-08-30', 5, 'Natal', 20, 'juliana.costa@example.com', 'senhaghi', 9),
('Eduardo', 'Martins', '1987-09-13', 6, 'Brasília', 7, 'eduardo.martins@example.com', 'senhajkl', 10),
('Paula', 'Ramos', '1996-04-04', 2, 'Manaus', 4, 'paula.ramos@example.com', 'senhamno', 11),
('Thiago', 'Barros', '1998-02-22', 3, 'Florianópolis', 24, 'thiago.barros@example.com', 'senhapqr', 12),
('Camila', 'Mendes', '1997-10-10', 4, 'Recife', 17, 'camila.mendes@example.com', 'senhastu', 13),
('André', 'Gomes', '1990-06-16', 5, 'Teresina', 18, 'andre.gomes@example.com', 'senhavwx', 14),
('Larissa', 'Souza', '1989-03-28', 6, 'João Pessoa', 15, 'larissa.souza@example.com', 'senhazyz', 15),
('Felipe', 'Cavalcanti', '1986-07-07', 2, 'Maceió', 2, 'felipe.cavalcanti@example.com', 'senha001', 16),
('Vanessa', 'Teixeira', '1999-11-23', 3, 'Vitória', 8, 'vanessa.teixeira@example.com', 'senha002', 17),
('Diego', 'Araújo', '1991-12-12', 4, 'Belém', 14, 'diego.araujo@example.com', 'senha003', 18),
('Tatiane', 'Cardoso', '1993-05-05', 5, 'Campo Grande', 12, 'tatiane.cardoso@example.com', 'senha004', 19),
('Gustavo', 'Fernandes', '2001-08-08', 6, 'São Luís', 10, 'gustavo.fernandes@example.com', 'senha005', 20),
('Patrícia', 'Monteiro', '1994-09-09', 2, 'Aracaju', 26, 'patricia.monteiro@example.com', 'senha006', 21);

insert into tentativaQuiz (fk_idusuario, pontuacao) values
(1, 12),
(2, 9),
(3, 14),
(4, 8),
(5, 13),
(6, 10),
(7, 7),
(8, 11),
(9, 15),
(10, 6),
(11, 13),
(12, 8),
(13, 14),
(14, 9),
(15, 10),
(16, 11),
(17, 12),
(18, 6),
(19, 7),
(20, 13);
