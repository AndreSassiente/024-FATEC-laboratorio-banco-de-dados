-- [ 01 ] Criar um banco de dados com o nome PROVA. Aplicar o script a seguir para 
-- criar a estrutura do banco de dados e popular o banco.

CREATE DATABASE Prova;
USE Prova;

-- Criação da tabela "empresas"
CREATE TABLE empresas (
	 id INT PRIMARY KEY,
	 nome VARCHAR(100),
	 endereco VARCHAR(200)
);

-- Criação da tabela "produtos"
CREATE TABLE produtos (
	 id INT PRIMARY KEY,
	 nome VARCHAR(100),
	 preco DECIMAL(10, 2),
     data_atualizacao DATE
);

-- Criação da tabela "projetos"
CREATE TABLE projetos (
	 id INT PRIMARY KEY,
	 nome VARCHAR(100),
	 empresa_id INT,
	 produto_id INT,
	 FOREIGN KEY (empresa_id) REFERENCES empresas(id),
	 FOREIGN KEY (produto_id) REFERENCES produtos(id)
);


 
-- Inserção de registros na tabela "empresas"
INSERT INTO empresas (id, nome, endereco)
VALUES  (1, 'Empresa A', 'Rua A, 123'),
		(2, 'Empresa B', 'Avenida B, 456'),
		(3, 'Empresa C', 'Travessa C, 789'),
		(4, 'Empresa D', 'Praça D, 987');
 
-- Inserção de registros na tabela "produtos"
INSERT INTO produtos (id, nome, preco)
VALUES  (1, 'Produto A', 10.99),
		(2, 'Produto B', 20.50),
		(3, 'Produto C', 15.75),
		(4, 'Produto D', 5.99);
        
-- Inserção de registros na tabela "projetos"
INSERT INTO projetos (id, nome, empresa_id, produto_id)
VALUES  (1, 'Projeto A', 1, 1),
		(2, 'Projeto B', 2, 2),
		(3, 'Projeto C', 1, 3),
		(4, 'Projeto D', 3, 4);


-- [ 02 ] Listar todos os projetos com seus nomes, empresas correspondentes e produtos relacionados.
SELECT	Projetos.nome AS "PROJETO",
		Empresas.nome AS "EMPRESA",
        Produtos.nome AS "PRODUTO"
FROM Projetos
LEFT JOIN Empresas ON Projetos.empresa_id = Empresas.id
LEFT JOIN Produtos ON Projetos.produto_id = Produtos.id;



-- [ 03] Selecione o nome do produto e o preço para projetos com um preço superior a $15.00
SELECT	nome AS "PRODUTO NOME", 
		preco AS "PRECO"
FROM Produtos
WHERE preco > 15.00;



-- [ 04 ] Encontrar todos os projetos da Empresa A e listar seus nomes e preços dos produtos correspondentes.
SELECT	Projetos.nome AS "NOME PROJETO",
		Produtos.preco AS "PRECO PRODUTO"
FROM Projetos
INNER JOIN Produtos ON Projetos.produto_id = Produtos.id
WHERE Projetos.empresa_id = 1;
		


-- [ 05 ] Listar o nome de cada produto e a quantidade de projetos em que é utilizado
SELECT	p.nome AS NomeProduto,
		COUNT(pj.produto_id) AS QuantidadeProjetos
FROM Produtos p
INNER JOIN Projetos pj ON p.id = pj.produto_id
GROUP BY p.id;



-- [ 06 ] Mostrar todos os projetos, suas empresas correspondentes e o total de produtos utilizados em cada projeto.
SELECT	Projetos.*,
		Empresas.nome,
        COUNT(Produtos.id) AS totalProdutos
FROM Projetos
INNER JOIN Empresas ON Projetos.empresa_id = Empresas.id
INNER JOIN Produtos ON Projetos.produto_id = Produtos.id
GROUP BY Projetos.nome;

	
    
-- [ 07 ] Selecione o nome do projeto e o endereço da empresa para todos os projetos que utilizam produtos com preço superior a $10.00
SELECT  pj.nome AS nomeProjeto,
		emp.endereco AS enderecoEmpresa
FROM Projetos pj
INNER JOIN Empresas emp ON pj.empresa_id = emp.id
INNER JOIN Produtos pdt ON pj.produto_id = pdt.id
WHERE pdt.preco > 10.00;



-- [ 08 ] Selecione o nome do projeto, o nome da empresa e o nome do produto para todos os projetos.
SELECT  pj.nome AS nomeProjeto,
		emp.nome AS nomeEmpresa,
        pdt.nome AS nomeProduto
FROM Projetos pj
INNER JOIN Empresas emp ON pj.empresa_id = emp.id
INNER JOIN Produtos pdt ON pj.produto_id = pdt.id;


-- [ 09 ] Criar um Trigger de INSERT para a tabela produtos que define um valor padrão 
-- para a coluna preco caso não seja especificado durante a inserção.
DELIMITER $
	CREATE TRIGGER TRG_valorPadrao
	AFTER INSERT ON Produtos
	FOR EACH ROW
	BEGIN
		UPDATE Produtos
		SET preco = 10.00
		WHERE id = NEW.id;
	END;
DELIMITER ;


-- [ 10 ]Criar um Trigger de UPDATE para a tabela produtos que registra a data e hora da última 
-- atualização na coluna data_atualizacao
DELIMITER $
	CREATE TRIGGER TRG_registroAtualizacao
	AFTER UPDATE ON Produtos
	FOR EACH ROW
	BEGIN
		UPDATE Produtos
		SET OLD.data_atualizacao = CURRENT_DATE()
		WHERE id = NEW.id;
	END;
DELIMITER ;

