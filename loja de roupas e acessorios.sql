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

DROP TABLE IF EXISTS Telefone;
CREATE TABLE Telefone(
id INT NOT NULL AUTO_INCREMENT
,telefone CHAR(20) NOT NULL
,descricao VARCHAR(200)
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,Cliente_id INT NOT NULL
,Fornecedor_id INT NOT NULL
,Funcionario_id INT NOT NULL
,CONSTRAINT pk_telefone PRIMARY KEY(id)
,CONSTRAINT fk_cliente_telefone FOREIGN KEY(Cliente_id) REFERENCES Cliente(id)
,CONSTRAINT fk_fornecedor_telefone FOREIGN KEY(Fornecedor_id) REFERENCES Fornecedor(id)
,CONSTRAINT fk_funcionario_telefone FOREIGN KEY(Funcionario_id) REFERENCES Funcionario(id)
);

DROP TABLE IF EXISTS Email;
CREATE TABLE Email(
id INT NOT NULL AUTO_INCREMENT
,email VARCHAR(200) NOT NULL
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,Cliente_id INT NOT NULL
,Funcionario_id INT NOT NULL
,Fornecedor_id INT NOT NULL
,CONSTRAINT pk_email PRIMARY KEY(id)
,CONSTRAINT fk_cliente_email FOREIGN KEY (Cliente_id) REFERENCES Cliente(id)
,CONSTRAINT fk_fornecedor_email FOREIGN KEY (Fornecedor_id) REFERENCES Fornecedor(id)
,CONSTRAINT fk_funcionario_email FOREIGN KEY (Funcionario_id) REFERENCES Funcionario(id)
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

DROP TABLE IF EXISTS Troca;
CREATE TABLE Troca(
id INT NOT NULL AUTO_INCREMENT
,codigo_trocado_produtos INT NOT NULL
,preco_trocado_produtos DECIMAL(9,2) NOT NULL
,codigo_paratrocar_produtos INT NOT NULL
,preco_paratrocar_produtos DECIMAL(9,2) NOT NULL
,diferenca_preco DECIMAL(9,2)
,estado CHAR(1) NOT NULL DEFAULT 'S' CHECK (estado IN ('S','N'))
,data_lancamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,Funcionario_id INT NOT NULL
,Venda_id INT NOT NULL
,CONSTRAINT pk_troca PRIMARY KEY (id)
,CONSTRAINT fk_funcionario_troca FOREIGN KEY (Funcionario_id) REFERENCES Funcionario(id)
,CONSTRAINT fk_venda_troca FOREIGN KEY (Venda_id) REFERENCES Venda(id)
);

DROP TABLE IF EXISTS Produto_troca;
CREATE TABLE Produto_troca(
quantidade_produtos INT NOT NULL
,Trocas_id INT NOT NULL
,Produtos_id INT NOT NULL
,CONSTRAINT pk_composta_trocas_produtos PRIMARY KEY(Trocas_id, Produtos_id)
,CONSTRAINT fk_trocas FOREIGN KEY(Trocas_id) REFERENCES Troca(id)
,CONSTRAINT fk_produtos_produto_troca FOREIGN KEY(Produtos_id) REFERENCES Produto(id)
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

INSERT INTO Cidade VALUES (NULL,'Curitiba',DEFAULT,DEFAULT,1);
INSERT INTO Cidade VALUES (NULL,'Niterói',DEFAULT,DEFAULT,2);
INSERT INTO Cidade VALUES (NULL,'Florianópolis',DEFAULT,DEFAULT,3);

INSERT INTO Produto VALUES (NULL,'Camiseta Nike',299.99,DEFAULT,DEFAULT,10);
INSERT INTO Produto VALUES (NULL,'Boné Adidas',50.00,DEFAULT,DEFAULT,1);
INSERT INTO Produto VALUES (NULL,'Tênis Puma',219.99,DEFAULT,DEFAULT,3);

SELECT * FROM Estado;
SELECT * FROM Cidade;
SELECT * FROM Produto;

