/* Projeto final criado por mim para a disciplina de Banco de dados 1 */

/* CASE, MAX(), DATE_FORMAT(), INSERT, UPDATE, DELETE, CREATE, DESCRIBE, SELECT, INNER JOIN, IF()... and others */

DROP DATABASE IF EXISTS loja_de_roupa;		
CREATE DATABASE loja_de_roupa;				
USE loja_de_roupa;							

DROP TABLE IF EXISTS Tipo;					
CREATE TABLE Tipo(							
id INT NOT NULL AUTO_INCREMENT				
,tipo_produto VARCHAR(200) NOT NULL			
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,descricao VARCHAR(200)
,CONSTRAINT pk_tipo PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Produto;
CREATE TABLE Produto(
id INT NOT NULL AUTO_INCREMENT
,nome_produto VARCHAR(200) NOT NULL
,preco_produto DECIMAL(9,2) NOT NULL
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estoque INT NOT NULL
,CONSTRAINT pk_produto PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Tipo_Produto;
CREATE TABLE Tipo_Produto(
estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,Produtos_id INT NOT NULL 
,Tipo_id INT NOT NULL 
,CONSTRAINT pk_composta_produto_tipo PRIMARY KEY(Produtos_id, Tipo_id)
,CONSTRAINT fk_produto FOREIGN KEY (Produtos_id) REFERENCES Produto(id)
,CONSTRAINT fk_tipo FOREIGN KEY (Tipo_id) REFERENCES Tipo(id)
);

DROP TABLE IF EXISTS Estado;
CREATE TABLE Estado(
id INT NOT NULL AUTO_INCREMENT
,nome_estado VARCHAR(200) NOT NULL
,status_ativo CHAR(1) NOT NULL DEFAULT 'S' CHECK (status_ativo IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_estado PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Cidade;
CREATE TABLE Cidade(
id INT NOT NULL AUTO_INCREMENT
,nome_cidade VARCHAR(200) NOT NULL
,status_ativo CHAR(1) NOT NULL DEFAULT 'S' CHECK (status_ativo IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,Estado_id INT NOT NULL
,CONSTRAINT pk_cidade PRIMARY KEY(id)
,CONSTRAINT fk_estado FOREIGN KEY(Estado_id) REFERENCES Estado(id)
);

DROP TABLE IF EXISTS Funcionario;
CREATE TABLE Funcionario(
id INT NOT NULL AUTO_INCREMENT
,nome_funcionario VARCHAR(200) NOT NULL
,cpf CHAR(14) NOT NULL UNIQUE
,funcao VARCHAR(200) NOT NULL 
,endereco VARCHAR(200) NOT NULL
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,telefone VARCHAR(50) NOT NULL
,email VARCHAR(100) NOT NULL
,Cidade_id INT NOT NULL
,CONSTRAINT pk_funcionario PRIMARY KEY(id)
,CONSTRAINT fk_cidade_funcionario FOREIGN KEY(Cidade_id) REFERENCES Cidade(id)
);

DROP TABLE IF EXISTS Fornecedor;
CREATE TABLE Fornecedor(
id INT NOT NULL AUTO_INCREMENT
,nome_fornecedor VARCHAR(200) NOT NULL
,cnpj CHAR(18) NOT NULL UNIQUE
,endereco VARCHAR(200) NOT NULL
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,telefone VARCHAR(50) DEFAULT NULL
,email VARCHAR(100) DEFAULT NULL
,Cidade_id INT NOT NULL
,CONSTRAINT pk_fornecedor PRIMARY KEY(id)
,CONSTRAINT fk_cidade_fornecedor FOREIGN KEY(Cidade_id) REFERENCES Cidade(id)
);

DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente(
id INT NOT NULL AUTO_INCREMENT
,nome_cliente VARCHAR(200) NOT NULL
,cpf CHAR(18) NOT NULL UNIQUE
,endereco VARCHAR(200) NOT NULL
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,telefone VARCHAR(50) DEFAULT NULL
,email VARCHAR(100) DEFAULT NULL
,Cidade_id INT NOT NULL
,CONSTRAINT pk_cliente PRIMARY KEY(id)
,CONSTRAINT fk_cidade_cliente FOREIGN KEY(Cidade_id) REFERENCES Cidade(id)
);

DROP TABLE IF EXISTS Compra;
CREATE TABLE Compra(
id INT NOT NULL AUTO_INCREMENT
,desconto DECIMAL(9,2)
,descricao VARCHAR(200)
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,total_compra DECIMAL(9,2) NOT NULL
,Funcionario_id INT NOT NULL
,Fornecedor_id INT NOT NULL
,CONSTRAINT pk_compra PRIMARY KEY(id)
,CONSTRAINT fk_funcionario_compra FOREIGN KEY (Funcionario_id) REFERENCES Funcionario(id)
,CONSTRAINT fk_fornecedor FOREIGN KEY (Fornecedor_id) REFERENCES Fornecedor(id)
);

DROP TABLE IF EXISTS Produto_compra;
CREATE TABLE Produto_compra(
valor DECIMAL(9,2) NOT NULL
,quantidade_produtos INT NOT NULL
,Compras_id INT NOT NULL
,Produtos_id INT NOT NULL
,CONSTRAINT pk_composta_compras_produtos PRIMARY KEY(Compras_id, Produtos_id)
,CONSTRAINT fk_compras FOREIGN KEY(Compras_id) REFERENCES Compra(id)
,CONSTRAINT fk_produtos FOREIGN KEY(Produtos_id) REFERENCES Produto(id)
);

DROP TABLE IF EXISTS Venda;
CREATE TABLE Venda(
id INT NOT NULL AUTO_INCREMENT
,desconto DECIMAL(9,2)
,descricao VARCHAR(200)
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,total_venda DECIMAL(9,2) NOT NULL
,Funcionario_id INT NOT NULL
,Cliente_id INT NOT NULL
,CONSTRAINT pk_venda PRIMARY KEY(id)
,CONSTRAINT fk_funcionario_venda FOREIGN KEY (Funcionario_id) REFERENCES Funcionario(id)
,CONSTRAINT fk_Cliente FOREIGN KEY (Cliente_id) REFERENCES Cliente(id)
);

DROP TABLE IF EXISTS Produto_venda;
CREATE TABLE Produto_venda(
valor DECIMAL(9,2) NOT NULL
,quantidade_produtos INT NOT NULL
,Vendas_id INT NOT NULL
,Produtos_id INT NOT NULL
,CONSTRAINT pk_composta_vendas_produtos PRIMARY KEY(Vendas_id, Produtos_id)
,CONSTRAINT fk_vendas FOREIGN KEY(Vendas_id) REFERENCES Venda(id)
,CONSTRAINT fk_produtos_venda FOREIGN KEY(Produtos_id) REFERENCES Produto(id)
);

DROP TABLE IF EXISTS Caixa;
CREATE TABLE Caixa(
id INT NOT NULL AUTO_INCREMENT
,saldo DECIMAL(9,2) NOT NULL
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,CONSTRAINT pk_caixa PRIMARY KEY(id)
);

DROP TABLE IF EXISTS Item_caixa;
CREATE TABLE Item_caixa(
id INT NOT NULL AUTO_INCREMENT
,valor DECIMAL(9,2) NOT NULL
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,tipo_item VARCHAR(200)
,Caixa_id INT NOT NULL
,CONSTRAINT pk_Item_caixa PRIMARY KEY(id)
,CONSTRAINT fk_caixa FOREIGN KEY (Caixa_id) REFERENCES Caixa(id)
);

DROP TABLE IF EXISTS Recebimento;
CREATE TABLE Recebimento(
id INT NOT NULL AUTO_INCREMENT
,valor_recebido DECIMAL(9,2) NOT NULL
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,desconto DECIMAL(9,2) 
,meio_de_pagamento VARCHAR(200) NOT NULL
,valor_parcelas DECIMAL(9,2)
,juros DECIMAL(9,2)
,status_pago CHAR(1) NOT NULL DEFAULT 'S' CHECK (status_pago IN ('S','N'))
,numero_parcela INT
,Vendas_id INT NOT NULL
,Item_caixa_id INT NOT NULL
,CONSTRAINT pk_recebimento PRIMARY KEY(id)
,CONSTRAINT fk_vendas_recebimento FOREIGN KEY(Vendas_id) REFERENCES Venda(id)
,CONSTRAINT fk_item_caixa_recebimento FOREIGN KEY (Item_caixa_id) REFERENCES Item_caixa(id)
);

DROP TABLE IF EXISTS Pagamento;
CREATE TABLE Pagamento(
id INT NOT NULL AUTO_INCREMENT
,valor_pago DECIMAL(9,2) NOT NULL
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,desconto DECIMAL(9,2) 
,meio_de_pagamento VARCHAR(200) NOT NULL
,valor_parcelas DECIMAL(9,2)
,juros DECIMAL(9,2)
,status_pago CHAR(1) NOT NULL DEFAULT 'S' CHECK (status_pago IN ('S','N'))
,numero_parcela INT
,Compras_id INT NOT NULL
,Item_caixa_id INT NOT NULL
,CONSTRAINT pk_pagamento PRIMARY KEY(id)
,CONSTRAINT fk_compras_pagamento FOREIGN KEY(Compras_id) REFERENCES Compra(id)
,CONSTRAINT fk_item_caixa FOREIGN KEY (Item_caixa_id) REFERENCES Item_caixa(id)
);

DESCRIBE Estado;
DESCRIBE Cidade;
DESCRIBE Cliente;
DESCRIBE Funcionario;
DESCRIBE Fornecedor;
DESCRIBE Produto;

INSERT INTO Estado VALUES (NULL,'Paraná',DEFAULT,DEFAULT);
INSERT INTO Estado VALUES (NULL,'Rio de Janeiro',DEFAULT,DEFAULT);
INSERT INTO Estado VALUES (NULL,'Santa Catarina',DEFAULT,DEFAULT);
INSERT INTO Estado VALUES (NULL,'São Paulo',DEFAULT,DEFAULT);
INSERT INTO Estado VALUES (NULL,'Rio Grande do Sul',DEFAULT,DEFAULT);
INSERT INTO Estado VALUES (NULL,'Amazonas',DEFAULT,DEFAULT);
INSERT INTO Estado VALUES (NULL,'Goiás',DEFAULT,DEFAULT);
INSERT INTO Estado VALUES (NULL,'Bahia',DEFAULT,DEFAULT);
INSERT INTO Estado VALUES (NULL,'Minas Gerais',DEFAULT,DEFAULT);

INSERT INTO Cidade VALUES (NULL,'Curitiba',DEFAULT,DEFAULT,1);
INSERT INTO Cidade VALUES (NULL,'Niterói',DEFAULT,DEFAULT,2);
INSERT INTO Cidade VALUES (NULL,'Belo Horizonte',DEFAULT,DEFAULT,9);
INSERT INTO Cidade VALUES (NULL,'Florianópolis',DEFAULT,DEFAULT,3);
INSERT INTO Cidade VALUES (NULL,'São José dos Campos',DEFAULT,DEFAULT,4);
INSERT INTO Cidade VALUES (NULL,'Cidade que nao existe',DEFAULT,DEFAULT,8);
INSERT INTO Cidade VALUES (NULL,'disneylandia',DEFAULT,DEFAULT,5);

INSERT INTO Produto VALUES (NULL,'Camiseta Nike',299.99,DEFAULT,DEFAULT,10);
INSERT INTO Produto VALUES (NULL,'Boné Adidas',50.00,DEFAULT,DEFAULT,1);
INSERT INTO Produto VALUES (NULL,'Tênis Puma',219.99,DEFAULT,DEFAULT,3);

SELECT * FROM Estado;
SELECT * FROM Cidade;
SELECT * FROM Produto;

INSERT INTO Funcionario(nome_funcionario, cpf, funcao, endereco, email, telefone, Cidade_id) VALUES ('José', '11122233344554', 'vendedor', 'Avenida Sao Jose, 50', 'jose@hotmail.com', '42999665544', 3);
INSERT INTO Funcionario(nome_funcionario, cpf, funcao, endereco, email, telefone, Cidade_id) VALUES ('Roberta', '99988877766556', 'estoquista', 'Rua Sao Joao, 815', 'roberta10@gmail.com', '42987659987', 3);
INSERT INTO Funcionario(nome_funcionario, cpf, funcao, endereco, email, telefone, Cidade_id) VALUES ('Paulo', '90908077761221', 'vendedor online', 'Avenida Sao Malaquias, 5050', 'paulocarvalho@outlook.com', '41999553290',2);

INSERT INTO Fornecedor(nome_fornecedor, cnpj, endereco, email, telefone, Cidade_id) VALUES ('Marquinho Market', '99988877733322', 'Rua Joaquim Fernandez, 30', 'marquinltda@gmail.com' , '41999762345', 3);
INSERT INTO Fornecedor VALUES (NULL,'Roupas Style', '11111111111111', 'Rua dos Mangues, 1240',DEFAULT,DEFAULT,NULL,NULL,1);
INSERT INTO Fornecedor VALUES (NULL,'Moda Masculina Show', '22222222222222', 'Rua Afonso Tadeu, 1240',DEFAULT,DEFAULT,NULL,NULL,2);
INSERT INTO Fornecedor VALUES (NULL,'Moda', '00000000000000', 'Rua Afonso, 124',DEFAULT,DEFAULT,NULL,NULL,2);

INSERT INTO Cliente VALUES (NULL,'Arthur', '99999999999999', 'Rua Tiradentes, 1288',DEFAULT,DEFAULT, '41987654560', 'arthurzinho@outlook.com',2);
INSERT INTO Cliente(nome_cliente, cpf, endereco, Cidade_id) VALUES ('Kevin', '22222222222222', 'Avenida Águas Claras, 3030', 3);
INSERT INTO Cliente(nome_cliente, cpf, endereco, Cidade_id) VALUES ('Joaquim', '33333333333333', 'Avenida Paulo Fernandez, 4040', 1);
INSERT INTO Cliente(nome_cliente, cpf, endereco, Cidade_id) VALUES ('Joaquim', '333333333333333', 'Avenida Paulo Fernandez, 4040', 1);

SELECT * FROM Funcionario;
SELECT * FROM Cliente;
SELECT * FROM Fornecedor;

DESCRIBE Tipo_Produto;
DESCRIBE Tipo;
DESCRIBE Caixa;

INSERT INTO Tipo VALUES(NULL,'Camiseta',DEFAULT,DEFAULT,NULL);
INSERT INTO Tipo VALUES(NULL,'Boné',DEFAULT,DEFAULT,NULL);
INSERT INTO Tipo VALUES(NULL,'Tênis',DEFAULT,DEFAULT,NULL);

INSERT INTO Tipo_Produto VALUES(DEFAULT,DEFAULT,1,1);
INSERT INTO Tipo_Produto VALUES(DEFAULT,DEFAULT,2,2);
INSERT INTO Tipo_Produto VALUES(DEFAULT,DEFAULT,3,3);

INSERT INTO Caixa VALUES (NULL,9500.59,DEFAULT,DEFAULT);

SELECT * FROM Tipo;
SELECT * FROM Tipo_Produto;
SELECT * FROM Caixa;

DESCRIBE Compra; 
DESCRIBE Venda;
DESCRIBE Produto_compra;
DESCRIBE Produto_venda;
DESCRIBE Item_caixa;
DESCRIBE Pagamento;
DESCRIBE Recebimento;

INSERT INTO Compra(desconto, descricao, data_lancamento, estado, total_compra, Funcionario_id, Fornecedor_id) VALUES (100.00,'compra de bonés',DEFAULT,DEFAULT,1500.50,2,1);
INSERT INTO Compra(total_compra, Funcionario_id, Fornecedor_id) VALUES (200.00,2,2);
INSERT INTO Compra(total_compra, Funcionario_id, Fornecedor_id) VALUES (3500.00,2,3);

INSERT INTO Venda(desconto, descricao, data_lancamento, estado, total_venda, Cliente_id, Funcionario_id) VALUES (50.00,'venda de bonés',DEFAULT,DEFAULT,100.00,3,1);
INSERT INTO Venda(total_venda, Cliente_id, Funcionario_id) VALUES (299.99,1,3);
INSERT INTO Venda(total_venda, Cliente_id, Funcionario_id) VALUES (439.98,2,3);

SELECT * FROM Compra;
SELECT * FROM Venda;

INSERT INTO Produto_compra VALUES(20.00,5,1,2);
INSERT INTO Produto_compra VALUES(40.00,5,2,3);
INSERT INTO Produto_compra VALUES(100.00,35,3,1);

INSERT INTO Produto_venda VALUES(50.00,2,1,2);
INSERT INTO Produto_venda VALUES(299.99,1,2,1);
INSERT INTO Produto_venda VALUES(219.99,2,3,3);

SELECT * FROM Produto_compra;
SELECT * FROM Produto_venda;

INSERT INTO Item_caixa VALUES (NULL,100.00,DEFAULT,'boné',1);
INSERT INTO Item_caixa VALUES (NULL,200.00,DEFAULT,'tênis',1);
INSERT INTO Item_caixa VALUES (NULL,3500.00,DEFAULT,'camiseta',1);

INSERT INTO Item_caixa VALUES (NULL,50.00,DEFAULT,'boné',1);
INSERT INTO Item_caixa VALUES (NULL,299.99,DEFAULT,'camiseta',1);
INSERT INTO Item_caixa VALUES (NULL,439.98,DEFAULT,'tênis',1);

INSERT INTO Pagamento(valor_pago, meio_de_pagamento, Compras_id, Item_caixa_id) VALUES(100.00,'cartão de crédito',1,1);
INSERT INTO Pagamento(valor_pago, meio_de_pagamento, Compras_id, Item_caixa_id) VALUES(200.00,'dinheiro',2,2);
INSERT INTO Pagamento(valor_pago, meio_de_pagamento, Compras_id, Item_caixa_id) VALUES(3500.00,'dinheiro',3,3);

INSERT INTO Recebimento(valor_recebido, meio_de_pagamento, Vendas_id, Item_caixa_id) VALUES (50.00, 'débito', 1, 4);
INSERT INTO Recebimento(valor_recebido, meio_de_pagamento, Vendas_id, Item_caixa_id) VALUES (299.99, 'dinheiro', 2, 5);
INSERT INTO Recebimento(valor_recebido, meio_de_pagamento, Vendas_id, Item_caixa_id) VALUES (439.98, 'débito', 3, 6);

SELECT * FROM Item_caixa;
SELECT * FROM Pagamento;
SELECT * FROM Recebimento;

UPDATE Cidade SET nome_cidade = 'Porto Seguro' WHERE id=6;			/* Cidade com nome errado  */
UPDATE Estado SET status_ativo='N' WHERE id=6;						/* Estado passou a ficar inativo */
DELETE FROM Cidade WHERE Cidade.nome_cidade='disneylandia';			/* Cidade inexistente excluída do registro */

SELECT * FROM Estado;
SELECT * FROM Cidade;

DELETE FROM Fornecedor WHERE Fornecedor.id=4;					/*   Fornecedor com CNPJ falso, excluído do registro */
DELETE FROM Cliente WHERE Cliente.cpf='333333333333333';    	/*   Cliente duplicado, erro no cadastro */

/* COMANDOS */

SELECT * FROM Cliente;				/* Usamos esse SELECT para visualizar a tabela Cliente 'por inteiro', sendo possivel ver todos os registros já inseridos nela. Nao eh tao vantajoso utilizar essa forma, pois acabamos visualizando atributos em excesso, e também é de dificil visualizacao. É mais recomendado utilizar o nome da Tabela e em seguida, o nome do seu atributo */

SELECT Fornecedor.id, Fornecedor.cnpj FROM Fornecedor WHERE Fornecedor.nome_fornecedor = 'Roupas Style';	/* Visualizamos apenas o id e o cnpj do Fornecedor, onde o nome dele é 'Roupas Style' em um determinado registro. É vantajoso fazer dessa forma por que escolhemos os registros que desejamos visualizar, e ainda fica bem evidente de 'quem é' determinado atributo */

SELECT F.id, F.nome_funcionario, F.funcao FROM Funcionario F;		/* utilizamos um 'apelido F' para a tabela Funcionario, de forma que passamos a utilizar apenas esse 'F' para escolher os dados da tabela, é vantajoso utilizar essa forma porque acabamos escrevendo menos que o nome todo da tabela, e tambem fica simples de visualizar a operacao a ser feita */


/* JOIN */

SELECT * FROM Cidade INNER JOIN Estado ON Cidade.estado_id = Estado.id;       /* Fazemos um JOIN do tipo 92, utilizando INNER JOIN, é uma das maneiras de 'juntar tabelas'. Escolhemos visualizar todos os atributos da Tabela Cidade e da Tabela Estado. Utilizamos o id para juntar essa tabelas. É vantajoso usar as juncoes para visualizar dados de mais de uma tabela, sendo possivel escolher os dados que desejamos visualizar em ambas as opcoes */

SELECT * FROM Cliente, Cidade WHERE Cliente.cidade_id = Cidade.id;			  /* Fazemos um JOIN do tipo 89, utilizando WHERE, é outra maneira de juntar tabelas. Não existe forma melhor, é necessario aprender as duas maneiras. Alguns acham essa mais simples, mas é uma questao de preferencia, não existe melhor */

SELECT Fornecedor.id AS 'Fornecedor id',Fornecedor.nome_fornecedor, Estado.id AS 'Estado id', Estado.nome_estado 
FROM Fornecedor
INNER JOIN Cidade ON Fornecedor.cidade_id = Cidade.id									/* Aqui escolhemos o id do Fornecedor e damos a ele um 'nome' para visualizacao, escolhemos tambem o nome do Fornecedor, e escolhemos o Estado.id como 'Estado id', que será a forma de visualizacao que aparecerá na tela para nome da coluna, tambem selecionamos o nome do estado, conectamos as tabelas através dos ID's, primeiro comparamos o id da Cidade com o 'Id da Cidade que estava dentro do Fornecedor', em seguida comparamos o Id do estado com o Id que estava em Cidade.estado_id, dessa forma 'conectamos' 3 tabelas diferentes e mostramos apenas as informacoes relevantes!!!! */
INNER JOIN Estado ON Cidade.estado_id = Estado.id;										/* Visualizamos a relação do Fornecedor, com a cidade e o seu determinado estado */

SELECT Funcionario.nome_funcionario, Cliente.nome_cliente, Venda.total_venda
FROM Funcionario
JOIN Venda ON Venda.Funcionario_id = Funcionario.id										/* Aqui utilizamos o mesmo exemplo acima, porem não 'damos nome para cada coluna que iremos visualizar'. E tambem nesse caso, iremos visualizar a relação da Venda entre o Cliente e o Funcionario */
JOIN Cliente ON Venda.Cliente_id = Cliente.id;

SELECT *
FROM Funcionario
JOIN Compra ON Compra.Funcionario_id = Funcionario.id									/* Aqui selecionamos todos os atributos para que possamos visualiza-los, das tabelas Funcionario, Fornecedor e Compra */
JOIN Fornecedor ON Compra.Fornecedor_id = Fornecedor.id;

SELECT Funcionario.nome_funcionario AS 'Nome Funcionario', Funcionario.cpf AS 'CPF Funcionario', Cliente.nome_cliente AS 'Nome Cliente', Cliente.cpf AS 'CPF Cliente'
FROM Funcionario
JOIN Venda ON Venda.Funcionario_id = Funcionario.id										/* Aqui eu novamente dou nome para cada coluna que iremos visualizar, e nesse caso visualizamos o nome do funcionario que fez a venda, cpf do funcionario que vendeu para o cliente, o nome do cliente que comprou e o  seu respectivo cpf  */
JOIN Cliente ON Venda.Cliente_id = Cliente.id;

SELECT Venda.total_venda, Venda.desconto, Recebimento.valor_recebido, Item_caixa.valor
FROM Venda
INNER JOIN Recebimento ON Recebimento.Vendas_id = Venda.id								/* Nesse SELECT, visualizamos a relação entre a Venda, o recebimento gerado por ela, e o 'Item de caixa que utilizamos' nessa Venda */
INNER JOIN Item_caixa ON Recebimento.Item_caixa_id = Item_caixa.id;

SELECT Produto.nome_produto AS 'Nome Produtos' , Produto.preco_produto AS 'Preco' , Venda.total_venda AS 'Valor total' , Venda.data_lancamento AS 'Data/horario emissao', Produto_venda.quantidade_produtos AS 'Quantidade', Recebimento.meio_de_pagamento AS 'Meio de pagamento'
FROM Produto_venda
INNER JOIN Venda ON Venda.id = Produto_venda.Vendas_id
INNER JOIN Produto ON Produto.id = Produto_venda.Produtos_id					/* Nesse caso, conectamos 4 tabelas e visualizamos informacoes importantes para uma VENDA em cada uma delas, como o nome dos produtos, a data, o preco, a quantidade de produtos vendidos, e o meio de pagamento utilizado */
INNER JOIN Recebimento ON Venda.id = Recebimento.Vendas_id;


/* Functions() */

SELECT
Venda.id 'Venda ID'
,Venda.total_venda 'Valor total da venda'								
,(Venda.desconto/Venda.total_venda)*100 AS 'Porcentagem Desconto'					/* nesse caso, utilizamos operadores para visualizar a porcentagem dada em desconto para determinada venda, que possui id=1. É muito vantajoso utilizar operadores para visualizar 'expressoes' especificas que apresentam valores relevantes para o negocio, como por exemplo um valor de desconto, o calculo de juros, e coisas desse tipo */
FROM Venda WHERE id=1;

SELECT 
Compra.total_compra 'Total compra'															/* para esse caso, utilizamos IF para estabelecer um Feedback com relação ao valor gasto na compra de Produtos. Caso o valor for maior que 2000 temos 'Gasto muito Grande', caso for menor ou igual que 2000, temos um 'valor razoavel' */
,IF(Compra.total_compra>2000,'Gasto muito grande!','Valor razoável') AS 'Feedback Gastos'
FROM Compra;

UPDATE Cliente SET Cliente.estado = 'N' WHERE id=3;
SELECT
Cliente.nome_cliente																				/* nesse caso, utilizamos CASE para estabelecer uma visualizacao mais atrativa dos registros de clientes ativos, de forma que seja possivel entender melhor o significado dos caracteres preenchidos S (Ativo) e N (Inativo), facilita a visualizacao e entendimento dos dados, para esse caso */
,CASE Cliente.estado WHEN 'S' THEN 'Ativo' WHEN 'N' THEN 'Inativo' ELSE 'Dado Inconsistente!' END
FROM Cliente;

SELECT 
Recebimento.valor_recebido AS 'Valor recebido'											/* Aqui utilizei a Funcao DATE_FORMAT() para estabelecer um padrão na visualização de uma data, configurei esse padrao de acordo com minha preferencia, utilizando dia x, mes y, ano z */
,DATE_FORMAT(data_lancamento, 'dia %d, mês %m, ano %Y') AS 'Data lancamento'			/* Tambem defini a visualizacao da coluna como 'Data lancamento', afim de facilitar o entendimento */
FROM Recebimento;

SELECT MAX(valor_recebido) FROM Recebimento;										/*  Aqui utilizamos a Funcao MAX() para extrair o valor máximo dentro de todos os registros da tabela Recebimento, é muito util para escolher e visualizar o valor máximo de um registro dentro de uma determinada tabela */
SELECT MIN(valor_pago) FROM Pagamento;												/*  Aqui utilizei a Funcao MIN() para extrair o valor mínimo dentro de todos os registros da tabela Pagamento, é muito util para escolher e visualizar o valor mínimo dentro de uma determinada tabela */

/* COMANDOS */

/* made by: Gabriel Hort */