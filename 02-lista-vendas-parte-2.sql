-- [ 01 ] Crie uma nova tabela chamada "funcionarios" para armazenar informações sobre 
-- os funcionários da farmácia, incluindo nome, cargo e salário.
CREATE TABLE Funcionarios (
	id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    	nome VARCHAR(100) NOT NULL,
    	cargo VARCHAR(20) NOT NULL,
    	salario DECIMAL (10,2) NOT NULL
);



-- [ 02 ] Adicione uma coluna chamada "data_nascimento" à tabela "clientes" para 
-- armazenar a data de nascimento dos clientes.
ALTER TABLE Clientes 
	ADD COLUMN data_nascimento DATE;
    
    
    
-- [ 03 ] Modifique a tabela "produtos" para incluir uma nova coluna chamada 
-- "data_validade" para armazenar a data de validade dos produtos.
ALTER TABLE Produtos
	ADD COLUMN data_validade DATE;
    
    
    
-- [ 04 ] Crie uma tabela chamada "compras" para registrar as compras de produtos pelos 
-- clientes, incluindo o ID do cliente, o ID do produto, a quantidade comprada e o preço total.
CREATE TABLE Compras (
	id_compra INT AUTO_INCREMENT PRIMARY KEY,
    	id_cliente INT,
    	id_produto INT,
    	quantidade INT NOT NULL,
    	preco_total DECIMAL(10,2) NOT NULL,
    	FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    	FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);



-- [ 05 ] Adicione uma restrição UNIQUE à coluna "nome" na tabela "medicos" para 
-- garantir que não haja dois médicos com o mesmo nome.
ALTER TABLE Medicos
	MODIFY nome VARCHAR(100) UNIQUE;



-- [ 06 ] Crie uma tabela chamada "estoque" para rastrear o nível de estoque de cada 
-- produto na farmácia.
CREATE TABLE Estoque (
	id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    	id_produto INT,
	quantidade INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produtos (id_produto)
);



-- [ 07 ] Modifique a tabela "vendas" para incluir uma nova coluna chamada 
-- "forma_pagamento" para registrar o método de pagamento utilizado em cada venda.
ALTER TABLE Vendas
	ADD COLUMN forma_pagamento VARCHAR(30) NOT NULL;
    
    
    
-- [ 08 ] Crie uma tabela chamada "consultas" para registrar as consultas médicas 
-- realizadas pelos clientes, incluindo o ID do cliente, o ID do médico, a data da 
-- consulta e a descrição dos sintomas.
CREATE TABLE Consultas (
	id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    	id_cliente INT,
    	id_medico INT,
    	data_consulta DATE NOT NULL,
    	descricao_sintomas TEXT NOT NULL,
    	FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    	FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)
);



-- [ 09 ] Adicione uma restrição NOT NULL à coluna "telefone" na tabela "clientes" para 
-- garantir que todos os clientes tenham um número de telefone registrado.
ALTER TABLE Clientes 
	MODIFY telefone VARCHAR(20) NOT NULL; 



-- [ 10 ] Crie uma tabela chamada "descontos" para armazenar informações sobre os 
-- descontos oferecidos em determinados produtos, incluindo o ID do produto, o 
-- valor do desconto e a data de validade do desconto.
CREATE TABLE Descontos (
	id_desconto INT AUTO_INCREMENT PRIMARY KEY,
    	id_produto INT,
    	valor_desconto DECIMAL(10,2) NOT NULL,
    	data_validade DATE,
    	FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);
