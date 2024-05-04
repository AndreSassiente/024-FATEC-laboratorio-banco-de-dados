CREATE DATABASE BIBLIOTECA;
USE BIBLIOTECA;

-- Tabela de Tipos de Usuários
CREATE TABLE TiposDeUsuarios (
    TipoUsuarioID INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL
);

-- Tabela de Usuários
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    TipoUsuarioID INT,
    FOREIGN KEY (TipoUsuarioID) REFERENCES TiposDeUsuarios(TipoUsuarioID)
);

-- Tabela de Livros
CREATE TABLE Livros (
    LivroID INT PRIMARY KEY,
    Titulo VARCHAR(255) NOT NULL,
    Autor VARCHAR(100) NOT NULL,
    AnoPublicacao INT,
    Disponivel BOOLEAN NOT NULL
);

-- Tabela de Empréstimos
CREATE TABLE Emprestimos (
    EmprestimoID INT PRIMARY KEY,
    UsuarioID INT,
    LivroID INT,
    DataEmprestimo DATE NOT NULL,
    DataDevolucaoPrevista DATE NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (LivroID) REFERENCES Livros(LivroID)
);

-- Tabela de Devoluções
CREATE TABLE Devolucoes (
    DevolucaoID INT PRIMARY KEY,
    EmprestimoID INT,
    DataDevolucao DATE NOT NULL,
    Penalidade DECIMAL(10, 2),
    FOREIGN KEY (EmprestimoID) REFERENCES Emprestimos(EmprestimoID)
);

-- Inserir registros na tabela TiposDeUsuarios
INSERT INTO TiposDeUsuarios (TipoUsuarioID, Nome)
VALUES
    (1, 'Estudante'),
    (2, 'Professor'),
    (3, 'Funcionário'),
    (4, 'Visitante'),
    (5, 'Bibliotecário');

-- Inserir registros na tabela Usuarios
INSERT INTO Usuarios (UsuarioID, Nome, TipoUsuarioID)
VALUES
    (1, 'João Silva', 1),
    (2, 'Maria Santos', 2),
    (3, 'Pedro Alves', 1),
    (4, 'Ana Pereira', 3),
    (5, 'Lucas Oliveira', 4);

-- Inserir registros na tabela Livros
INSERT INTO Livros (LivroID, Titulo, Autor, AnoPublicacao, Disponivel)
VALUES
    (1, 'Dom Casmurro', 'Machado de Assis', 1899, true),
    (2, 'A Revolução dos Bichos', 'George Orwell', 1945, true),
    (3, 'Cem Anos de Solidão', 'Gabriel García Márquez', 1967, true),
    (4, 'O Senhor dos Anéis', 'J.R.R. Tolkien', 1954, true),
    (5, 'Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 1997, true);

-- Inserir registros na tabela Emprestimos
INSERT INTO Emprestimos (EmprestimoID, UsuarioID, LivroID, DataEmprestimo, DataDevolucaoPrevista)
VALUES
    (1, 1, 2, '2023-08-15', '2023-09-15'),
    (2, 3, 1, '2023-08-20', '2023-09-20'),
    (3, 2, 4, '2023-08-25', '2023-09-25'),
    (4, 4, 3, '2023-08-30', '2023-09-30'),
    (5, 5, 5, '2023-09-01', '2023-10-01');

-- Inserir registros na tabela Devolucoes
INSERT INTO Devolucoes (DevolucaoID, EmprestimoID, DataDevolucao, Penalidade)
VALUES
    (1, 1, '2023-09-16', 0.00),
    (2, 2, '2023-09-21', 0.00),
    (3, 3, '2023-09-28', 0.00),
    (4, 4, '2023-10-05', 0.00),
    (5, 5, '2023-10-02', 0.00);
    
    
-- [ 01 ] SELECIONE TODOS OS LIVROS EMPRESTADOS ATUALMENTE COM OS NOMES DOS USUARIOS
SELECT 	Livros.titulo AS "LIVRO EMPRESTADO", 
	Usuarios.nome AS "USUARIO"
FROM Livros
INNER JOIN Emprestimos ON emprestimos.LivroID = Livros.livroID
INNER JOIN Usuarios ON emprestimos.UsuarioID = Usuarios.UsuarioID;


-- [ 02 ] LISTAR TODOS OS LIVROS CUJOS TITULOS COMEÇAM COM A LETRA 'A'
SELECT * FROM Livros 
WHERE Livros.titulo LIKE "A%";


-- [ 03 ] ENCONTRE TODOS OS EMPRESTIMOS COM UMA DATA DE DEVOLUÇÃO PREVISTA APOS 2023-09-15 
SELECT * FROM Emprestimos
WHERE Emprestimos.DataDevolucaoPrevista > "2023-09-15";


-- [ 04 ] LISTE TODOS OS USUARIOS QUE NÃO SÃO DO TIPO FUNCIONARIO
SELECT Usuarios.nome AS "NAO SAO FUNCIONARIOS"
FROM Usuarios
WHERE Usuarios.TipoUsuarioID != 3;


-- [ 05 ] LISTAR TODOS OS EMPRESTIMOS DE LIVROS FEITOS POR USUARIOS DO TIPO
-- ESTUDANTE, INCLUINDO OS DETALHES DO LIVRO EMPRESTADO
SELECT 	Usuarios.nome,
	Livros.titulo,
        Livros.autor,
        Livros.anoPublicacao
FROM Usuarios
INNER JOIN Emprestimos ON Emprestimos.usuarioID = Usuarios.usuarioID
INNER JOIN Livros ON Emprestimos.livroID = Livros.livroID
WHERE Usuarios.TipoUsuarioID = 1;


-- [ 06 ] LISTAR TODOS OS EMPRESTIMOS DE LIVROS COM SUAS DEVOLUÇÕES CORRESPONDENTES,
-- INCLUINDO OS NOMES DOS USUARIOS			
SELECT	Emprestimos.*,
	Devolucoes.DataDevolucao,
        Devolucoes.Penalidade,
        Usuarios.nome AS "Usuario"
FROM Emprestimos
INNER JOIN Devolucoes ON Devolucoes.EmprestimoID = Emprestimos.EmprestimoID
INNER JOIN Usuarios ON Usuarios.UsuarioID = Emprestimos.UsuarioID;


-- [ 07 ] ENCONTRE O TOTAL DE EMPRESTIMOS FEITOS POR CADA USUARIO E ORDENE OS 
-- RESULTADOS PELO NUMERO DE EMPRESTIMOS EM ORDEM DECRESCENTE
SELECT 	u.Nome AS Usuario, 
	COUNT(e.EmprestimoID) AS TotalEmprestimos
FROM Usuarios u
INNER JOIN Emprestimos e ON u.UsuarioID = e.UsuarioID
GROUP BY u.UsuarioID
ORDER BY TotalEmprestimos DESC;


-- [ 08 ] ENCONTRE O NUMERO TOTAL DE EMPRESTIMOS POR ANO DE PUBLICACAO DOS LIVROS
-- E ORDENE OS RESULTADOS PELO ANO EM ORDEM CRESCENTE
SELECT	l.anoPublicacao AS AnoPublicacao,
	COUNT(e.emprestimoID) AS TotalEmprestimos
FROM Livros l
INNER JOIN Emprestimos e ON e.livroID = l.livroID
GROUP BY l.livroID, l.anoPublicacao
ORDER BY l.anoPublicacao ASC;


-- [ 09 ] LISTE TODOS OS LIVROS QUE NÃO FORAM EMPRESTADOS AINDA
SELECT *
FROM Livros l
INNER JOIN Emprestimos e ON l.LivroID = e.LivroID
WHERE e.LivroID IS NULL;


-- [ 10 ] MOSTRE O NUMERO TOTAL DE EMPRESTIMOS PARA CADA USUARIO
SELECT 	u.Nome AS Usuario, 
	COUNT(e.EmprestimoID) AS TotalEmprestimos
FROM Usuarios u
INNER JOIN Emprestimos e ON u.UsuarioID = e.UsuarioID
GROUP BY u.UsuarioID;


-- [ 11 ] ENCONTRE O AUTOR COM A MAIOR QUANTIDADE DE LIVROS EMPRESTADOS
SELECT	l.autor,
	COUNT(e.emprestimoID) AS TotalEmprestimos
FROM Livros l
INNER JOIN Emprestimos e ON e.livroID = l.livroID
GROUP BY l.autor;


-- [ 12 ] LISTE TODOS OS LIVROS EMPRESTADOS POR USUARIOS DO TIPO 'ESTUDANTE'
SELECT l.titulo AS LivrosEmprestadosParaEstudantes
FROM Livros l 
INNER JOIN Emprestimos e ON e.livroID = l.livroID
INNER JOIN Usuarios u ON e.usuarioID = u.UsuarioID
WHERE u.TipoUsuarioID = 1;


-- [ 13 ] MOSTRE A MEDIA DAS PENALIDADES DE DEVOLUÇÃO
SELECT AVG(devolucoes.Penalidade) AS "MEDIA PENALIDADES"
FROM Devolucoes;


-- [ 14 ] LISTE OS LIVROS EMPRESTADOS QUE FORAM PUBLICADOS ENTRE 1990 E 2000
SELECT	l.titulo AS "LIVROS EMPRESTADOS",
	l.anoPublicacao AS "ANO PUBLICAÇÃO"
FROM Livros l 
INNER JOIN Emprestimos e ON e.livroID = l.livroID
WHERE l.anoPublicacao >= 1990 AND l.anoPublicacao <= 2000;


-- [ 15 ] ENCONTRE OS USUARIOS QUE NÃO FIZERAM NENHUM EMPRESTIMO
SELECT u.Nome AS "USUARIOS QUE NÃO FIZERAM EMPRESTIMOS"
FROM Usuarios u
INNER JOIN Emprestimos e ON e.usuarioID = u.usuarioID
WHERE e.usuarioID IS NULL;

-- [ 16 ] LISTE TODOS OS LIVROS EMPRESTADOS POR USUARIOS DO TIPO ESTUDANTE OU PROFESSOR
SELECT l.titulo AS "LIVROS EMPRESTADOS PARA ESTUDANTE/PROFESSOR"
FROM Livros l 
INNER JOIN Emprestimos e ON l.livroID = e.livroID
INNER JOIN Usuarios u ON u.usuarioID = e.usuarioID
INNER JOIN TiposDeUsuarios tu ON u.tipoUsuarioID = tu.tipoUsuarioID
WHERE tu.nome IN ('Estudante', 'Professor');


-- [ 17 ] MOSTRE O TOTAL DE EMPRESTIMOS POR USUARIO E FILTRE APENAS AQUELES COM MAIS DE 3 EMPRESTIMOS
SELECT	u.UsuarioID, u.Nome AS NomeUsuario, 
	COUNT(e.EmprestimoID) AS TotalEmprestimos
FROM Usuarios u
INNER JOIN Emprestimos e ON u.UsuarioID = e.UsuarioID
GROUP BY u.UsuarioID, u.Nome
HAVING COUNT(e.EmprestimoID) > 3;


-- [ 18 ] LISTAR TODOS OS LIVROS EMPRESTADOS POR USUARIOS DO TIPO 'ESTUDANTE' OU 'PROFESSOR'
-- AGRUPADOS POR AUTOR
SELECT l.Autor, COUNT(l.LivroID) AS TotalLivrosEmprestados
FROM Livros l
JOIN Emprestimos e ON l.LivroID = e.LivroID
JOIN Usuarios u ON e.UsuarioID = u.UsuarioID
JOIN TiposDeUsuarios tu ON u.TipoUsuarioID = tu.TipoUsuarioID
WHERE tu.Nome IN ('Estudante', 'Professor')
GROUP BY l.Autor;
