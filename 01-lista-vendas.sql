CREATE DATABASE VENDAS;
USE VENDAS;

CREATE TABLE Enderecos (
 ID INT PRIMARY KEY,
 CEP VARCHAR(10),
 RUA VARCHAR(255),
 CIDADE VARCHAR(100),
 UF VARCHAR(3),
 Numero INT
);
 
CREATE TABLE Clientes (
 ID INT PRIMARY KEY,
 Nome VARCHAR(255),
 Email VARCHAR(255),
 Telefone VARCHAR(20),
 EnderecoID INT,
 FOREIGN KEY (EnderecoID) REFERENCES Enderecos(ID)
);
 
CREATE TABLE Pedidos (
 ID INT PRIMARY KEY,
 ClienteID INT,
 DataPedido DATE,
 ValorTotal DECIMAL(10, 2),
 FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);
 
CREATE TABLE Fornecedores (
 ID INT PRIMARY KEY,
 Nome VARCHAR(255),
 Email VARCHAR(255),
 Telefone VARCHAR(20),
 EnderecoID INT,
 FOREIGN KEY (EnderecoID) REFERENCES Enderecos(ID)
);

CREATE TABLE Produtos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Preco DECIMAL(10 , 2 ),
    Estoque INT,
    FornecedorID INT,
    FOREIGN KEY (FornecedorID) REFERENCES Fornecedores (ID)
);
 
CREATE TABLE Itens_Pedidos (
 ID INT PRIMARY KEY,
 PedidoID INT,
 ProdutoID INT,
 Quantidade INT,
 PrecoUnitario DECIMAL(10, 2),
 FOREIGN KEY (PedidoID) REFERENCES Pedidos(ID),
 FOREIGN KEY (ProdutoID) REFERENCES Produtos(ID)
);
 
CREATE TABLE Compras (
 ID INT PRIMARY KEY,
 FornecedorID INT,
 DataCompra DATE,
 ValorTotal DECIMAL(10, 2),
 FOREIGN KEY (FornecedorID) REFERENCES Fornecedores(ID)
);
 
CREATE TABLE Itens_Compras (
 ID INT PRIMARY KEY,
 CompraID INT,
 ProdutoID INT,
 Quantidade INT,
 PrecoUnitario DECIMAL(10, 2),
 FOREIGN KEY (CompraID) REFERENCES Compras(ID),
 FOREIGN KEY (ProdutoID) REFERENCES Produtos(ID)
);

INSERT INTO Enderecos (ID, CEP, RUA, CIDADE, UF, Numero)
VALUES
 (1, '12345-678', 'Rua das Flores', 'Cidade A', 'UF1', 123),
 (2, '54321-876', 'Avenida Central', 'Cidade B', 'UF2', 456),
 (3, '98765-432', 'Praça Principal', 'Cidade C', 'UF3', 789),
 (4, '56789-012', 'Alameda dos Parques', 'Cidade D', 'UF4', 101),
 (5, '34567-890', 'Travessa da Colina', 'Cidade E', 'UF5', 202);
 
INSERT INTO Clientes (ID, Nome, Email, Telefone, EnderecoID)
VALUES
 (1, 'João Silva', 'joao@example.com', '(11) 1234-5678', 1),
 (2, 'Maria Santos', 'maria@example.com', '(22) 9876-5432', 2),
 (3, 'Carlos Oliveira', 'carlos@example.com', '(33) 4567-8901', 3),
 (4, 'Ana Pereira', 'ana@example.com', '(44) 2345-6789', 4),
 (5, 'Pedro Almeida', 'pedro@example.com', '(55) 8765-4321', 5),
 (6, 'Luiza Costa', 'luiza@example.com', '(66) 3456-7890', 1),
 (7, 'Rafael Barbosa', 'rafael@example.com', '(77) 6543-2109', 2),
 (8, 'Isabela Ferreira', 'isabela@example.com', '(88) 4321-0987', 3),
 (9, 'Paulo Souza', 'paulo@example.com', '(99) 7654-3210', 4),
 (10, 'Fernanda Lima', 'fernanda@example.com', '(00) 2109-8765', 5);
 
INSERT INTO Pedidos (ID, ClienteID, DataPedido, ValorTotal)
VALUES
 (1, 3, '2023-08-10', 150.00),
 (2, 1, '2023-08-11', 75.50),
 (3, 5, '2023-08-12', 200.25),
 (4, 2, '2023-08-13', 50.00),
 (5, 4, '2023-08-14', 300.75);
 
INSERT INTO Fornecedores (ID, Nome, Email, Telefone, EnderecoID)
VALUES
 (1, 'Fornecedor A', 'fornecedorA@example.com', '(11) 1234-5678', 1),
 (2, 'Fornecedor B', 'fornecedorB@example.com', '(22) 9876-5432', 2),
 (3, 'Fornecedor C', 'fornecedorC@example.com', '(33) 4567-8901', 3),
 (4, 'Fornecedor D', 'fornecedorD@example.com', '(44) 2345-6789', 4),
 (5, 'Fornecedor E', 'fornecedorE@example.com', '(55) 8765-4321', 5),
 (6, 'Fornecedor F', 'fornecedorF@example.com', '(66) 3456-7890', 1),
 (7, 'Fornecedor G', 'fornecedorG@example.com', '(77) 6543-2109', 2),
 (8, 'Fornecedor H', 'fornecedorH@example.com', '(88) 4321-0987', 3),
 (9, 'Fornecedor I', 'fornecedorI@example.com', '(99) 7654-3210', 4),
 (10, 'Fornecedor J', 'fornecedorJ@example.com', '(00) 2109-8765', 5);
 
INSERT INTO Produtos (ID, Nome, Preco, Estoque, FornecedorID)
VALUES
 (1, 'Produto A', 25.99,0, 1),
 (2, 'Produto B', 12.50,0, 2),
 (3, 'Produto C', 45.75,0, 3),
 (4, 'Produto D', 8.99,0, 4),
 (5, 'Produto E', 30.25,0, 5);
 
INSERT INTO Itens_Pedidos (ID, PedidoID, ProdutoID, Quantidade, PrecoUnitario)
VALUES
 (1, 1, 3, 2, 25.99),
 (2, 1, 5, 3, 12.50),
 (3, 2, 2, 1, 45.75),
 (4, 2, 4, 4, 8.99),
 (5, 3, 1, 2, 30.25),
 (6, 3, 3, 1, 25.99),
 (7, 4, 5, 5, 12.50),
 (8, 4, 1, 3, 30.25),
 (9, 5, 4, 2, 8.99),
 (10, 5, 2, 1, 45.75);
 
INSERT INTO Compras (ID, FornecedorID, DataCompra, ValorTotal)
VALUES
 (1, 3, '2023-08-10', 1500.00),
 (2, 1, '2023-08-11', 750.50),
 (3, 5, '2023-08-12', 2000.25),
 (4, 2, '2023-08-13', 500.00),
 (5, 4, '2023-08-14', 3000.75);

INSERT INTO Itens_Compras (ID, CompraID, ProdutoID, Quantidade, PrecoUnitario)
VALUES
 (1, 1, 1, 5, 100.00),
 (2, 2, 2, 3, 45.00),
 (3, 3, 3, 2, 30.00),
 (4, 4, 4, 4, 20.00),
 (5, 5, 5, 1, 15.00);

-- PARTE 2 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- [01] Adicione uma coluna chamada "Bairro" a tabela "Enderecos" com um limite de caracteres de 100
ALTER TABLE Enderecos
	ADD COLUMN bairro VARCHAR(100);
    
-- [02] Crie uma nova tabela chamada "Categorias" com colunas para ID, Nome e Descricao
CREATE TABLE Categorias (
	ID INT,
    Nome VARCHAR(255),
    Descricao VARCHAR(255),
    PRIMARY KEY (ID)
);

-- [03] Altere a tabela "Produtos" para adicionar uma chave estrangeira referenciando a tabela "Categorias"
ALTER TABLE Produtos
	ADD COLUMN CategoriaId INT,
    ADD FOREIGN KEY (CategoriaId) REFERENCES Categorias(ID);
    
-- [04] Aumente o limite de caracteres da coluna "Email" na tabela "Clientes" para 150
ALTER TABLE Clientes
	MODIFY Email VARCHAR(150);
    
-- [05] Adicione uma coluna "DataEntrega" a tabela "Pedidos" para armazenar a data de entrega prevista
ALTER TABLE Pedidos
	ADD COLUMN DataEntrega DATE;
    
-- [06] Renomeie a coluna "Telefone" na tabela "Fornecedores" para "TelefoneContato"
ALTER TABLE Fornecedores
	CHANGE COLUMN Telefone TelefoneContato VARCHAR(20);

-- [07] Adicione uma chave estrangeira à tabela "Itens_Pedidos" referenciando a tabela "Pedidos"
ALTER TABLE Itens_pedidos
	ADD FOREIGN KEY (PedidoId) REFERENCES Pedidos(ID);

-- [08] Altere o tipo de dados da coluna "Estoque" na tabela "Produtos" para um tipo de dados que permita valores negativos
ALTER TABLE Produtos
	MODIFY Estoque INT;
    
-- [09] Adicione uma restrição de chave única à coluna "Nome" na tabela "Produtos"
ALTER TABLE Produtos
	MODIFY Nome VARCHAR(255) UNIQUE;
    
-- [10] Adicione uma coluna "DataNascimento" à tabela "Clientes" para armazenar a data de nascimento dos clientes
ALTER TABLE Clientes
	ADD COLUMN DataNascimento DATE;

-- [11] Adicione uma coluna "DataCadastro" à tabela "Clientes" para registrar a data em que o cliente foi cadastrado
ALTER TABLE Clientes
	ADD COLUMN DataCadastro DATE;

-- [12] Crie uma nova tabela chamada "Pagamentos" com colunas para ID, Tipo (por exemplo, 'Cartão de Crédito', 'Boleto', 'Transferência'), e Data
CREATE TABLE Pagamentos (
	ID INT,
    TipoPagamento VARCHAR(20),
    DataPagamento DATE,
    PRIMARY KEY (ID)
);

-- [13] Adicione uma coluna "Observacoes" à tabela "Pedidos" para permitir que os clientes deixem notas adicionais sobre seus pedidos
ALTER TABLE Pedidos
	ADD COLUMN Observacoes VARCHAR(255);
    
-- [14] Adicione uma coluna "NomeFantasia" à tabela "Fornecedores" para armazenar o nome fantasia da empresa
ALTER TABLE Fornecedores
	ADD COLUMN NomeFantasia VARCHAR(255);
    
-- [15]  Crie uma nova tabela chamada "Vendedores" com colunas para ID, Nome, Email e Telefone
CREATE TABLE Vendedores (
	ID INT, 
    Nome VARCHAR(255),
    Email VARCHAR(255),
    Telefone VARCHAR(20),
    PRIMARY KEY(ID)
);

-- [16] Altere a tabela "Produtos" para adicionar uma coluna "ImagemURL" para armazenar URLs de imagens dos produtos
ALTER TABLE Produtos
	ADD COLUMN ImagemURL BLOB;

-- [17] Adicione uma chave estrangeira à tabela "Compras" referenciando a tabela "Fornecedores"
-- QUERY JA EXECUTADA NA PARTE 1 DA ATIVIDADE

-- [18] Adicione uma coluna "DataUltimaCompra" à tabela "Fornecedores" para rastrear a última data em que um fornecedor fez uma venda
ALTER TABLE Fornecedores
	ADD COLUMN DataUltimaCompra DATE;

-- [19] Altere o tipo de dados da coluna "ValorTotal" na tabela "Pedidos" para um tipo de dados que permita valores nulos
ALTER TABLE Pedidos
	MODIFY COLUMN ValorTotal DECIMAL (10,2) NULL;
    
-- [20] Adicione uma restrição de verificação à coluna "Quantidade" na tabela "Itens_Pedidos" para garantir que não seja possível inserir valores negativos
ALTER TABLE Itens_pedidos
	MODIFY Quantidade INT CHECK (Quantidade >= 0);
    
-- PARTE 3 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

-- Inserir dados utilizando INSERT ou UPDATE nas tabelas e/ou campos que 
-- foram criados de maneira que todas as tabelas tenham seus dados completos

-- CATEGORIAS
INSERT INTO Categorias
VALUES 	(1, 'Categoria A', 'AAAAAAAAA'),
		(2, 'Categoria B', 'BBBBBBBBB'),
        (3, 'Categoria C', 'CCCCCCCCC'),
        (4, 'Categoria D', 'DDDDDDDDD'),
        (5, 'Categoria E', 'EEEEEEEEE');

-- CLIENTES
UPDATE clientes SET DataNascimento = '1993-06-21' WHERE ID = 1;
UPDATE clientes SET DataNascimento = '1992-06-12' WHERE ID = 2;
UPDATE clientes SET DataNascimento = '1995-06-21' WHERE ID = 3;
UPDATE clientes SET DataNascimento = '1997-06-22' WHERE ID = 4;
UPDATE clientes SET DataNascimento = '2002-06-23' WHERE ID = 5;
UPDATE clientes SET DataNascimento = '2007-06-01' WHERE ID = 6;
UPDATE clientes SET DataNascimento = '1993-06-21' WHERE ID = 7;
UPDATE clientes SET DataNascimento = '1999-06-22' WHERE ID = 8;
UPDATE clientes SET DataNascimento = '1998-06-05' WHERE ID = 9;
UPDATE clientes SET DataNascimento = '1993-06-09' WHERE ID = 10;
UPDATE clientes SET DataCadastro = CURRENT_DATE();    

-- ENDERECOS
UPDATE Enderecos SET Bairro = 'Cariobinha' WHERE ID = 1;
UPDATE Enderecos SET Bairro = 'Jaguari' WHERE ID = 2;
UPDATE Enderecos SET Bairro = 'Centro' WHERE ID = 3;
UPDATE Enderecos SET Bairro = 'Jardim Europa' WHERE ID = 4;
UPDATE Enderecos SET Bairro = 'Zanaga' WHERE ID = 5;

-- FORNECEDORES
UPDATE Fornecedores SET NomeFantasia = 'TechNova Solutions' WHERE ID = 1;
UPDATE Fornecedores SET NomeFantasia = 'BrightWave Innovations' WHERE ID = 2;
UPDATE Fornecedores SET NomeFantasia = 'Zenith Nexus Enterprises' WHERE ID = 3;
UPDATE Fornecedores SET NomeFantasia = 'SparkShift' WHERE ID = 4;
UPDATE Fornecedores SET NomeFantasia = 'QuantumLeap Ventures' WHERE ID = 5;
UPDATE Fornecedores SET NomeFantasia = 'StellarEdge Solutions' WHERE ID = 6;
UPDATE Fornecedores SET NomeFantasia = 'NovaGenix Labs' WHERE ID = 7;
UPDATE Fornecedores SET NomeFantasia = 'Echelon Dynamics' WHERE ID = 8;
UPDATE Fornecedores SET NomeFantasia = 'EnigmaWorks Corporation' WHERE ID = 9;
UPDATE Fornecedores SET NomeFantasia = 'ApexSphere' WHERE ID = 10;

UPDATE Fornecedores SET DataUltimaCompra = CURRENT_DATE();

-- PAGAMENTOS
INSERT INTO Pagamentos 
VALUES 	(1, 'Credito', CURRENT_DATE()), 
		(2, 'Debito', CURRENT_DATE()),
        (3, 'Pix', CURRENT_DATE()),
        (4, 'Credito', CURRENT_DATE()),
        (5, 'Debito', CURRENT_DATE());

-- PEDIDOS
UPDATE Pedidos SET Observacoes = 'Bla blba bla' WHERE ID = 1;
UPDATE Pedidos SET Observacoes = 'Ble ble ble' WHERE ID = 2;
UPDATE Pedidos SET Observacoes = 'Bli bli bli' WHERE ID = 3;
UPDATE Pedidos SET Observacoes = 'Blo blo blo' WHERE ID = 4;
UPDATE Pedidos SET Observacoes = 'Blu blu blu' WHERE ID = 5;

UPDATE Pedidos SET DataEntrega = CURRENT_DATE();

-- PRODUTOS
UPDATE Produtos SET CategoriaId = 1 WHERE ID = 1; 
UPDATE Produtos SET CategoriaId = 2 WHERE ID = 2; 
UPDATE Produtos SET CategoriaId = 3 WHERE ID = 3; 
UPDATE Produtos SET CategoriaId = 4 WHERE ID = 4; 
UPDATE Produtos SET CategoriaId = 5 WHERE ID = 5; 

UPDATE Produtos SET ImagemURL = 'images/img1.jpg' WHERE ID = 1;
UPDATE Produtos SET ImagemURL = 'images/img2.jpg' WHERE ID = 2;
UPDATE Produtos SET ImagemURL = 'images/img3.jpg' WHERE ID = 3;
UPDATE Produtos SET ImagemURL = 'images/img4.jpg' WHERE ID = 4;
UPDATE Produtos SET ImagemURL = 'images/img5.jpg' WHERE ID = 5;

-- VENDEDORES
INSERT INTO Vendedores
VALUES	(1, 'Andre', 'andre@vendas.com', '019 98262-7288'),
		(2, 'Felipe', 'felipe@vendas.com', '019 97272-1278'),
        (3, 'Leticia', 'leticia@vendas.com', '019 93767-8923'),
        (4, 'Gabriel', 'gabriel@vendas.com', '019 96363-0011'),
        (5, 'Rafael', 'rafael@vendas.com', '019 90321-6739');
