CREATE DATABASE Fornecedores;
USE Fornecedores;

CREATE TABLE Duplicata (
	nome VARCHAR(40),
	numero INT PRIMARY KEY,
    valor DECIMAL(10,2),
    vencimento DATE,
    banco VARCHAR(20)
);

INSERT INTO Duplicata
VALUES	("ABC PAPELARIA", 		100100, 	5000.00, 	"2017-01-20", 	"ITAU"				),
		("LIVRARIA FERNANDES", 	100110, 	2500.00, 	"2017-01-22", 	"ITAU"				),
        ("LIVRARIA FERNANDES", 	100120, 	1500.00, 	"2016-10-15", 	"BRADESCO"			),
        ("ABC PAPELARIA", 		100130, 	8000.00, 	"2016-10-15", 	"SANTANDER"			),
        ("LER E SABER", 		200120, 	10500.00, 	"2018-04-26", 	"BANCO DO BRASIL"	),
        ("LIVROS E CIA ",	 	200125, 	2000.00, 	"2018-04-26", 	"BANCO DO BRASIL"	),
        ("LER E SABER", 		200130, 	11000.00, 	"2018-09-26", 	"ITAU"				),
        ("PAPELARIA SILVA", 	250350, 	1500.00, 	"2018-01-26", 	"BRADESCO"			),
        ("LIVROS MM", 			250360, 	500.00, 	"2018-12-18", 	"SANTANDER"			),
        ("LIVROS MM", 			250370, 	3400.00, 	"2018-04-26", 	"SANTANDER"			),
        ("PAPELARIA SILVA", 	250380, 	3500.00, 	"2018-04-26", 	"BANCO DO BRASIL"	),
        ("LIVROS E CIA ", 		453360, 	1500.00, 	"2018-06-15", 	"ITAU"				),
        ("LIVROS MM", 			453365, 	5400.00, 	"2018-06-15", 	"BRADESCO"			),
        ("PAPELARIA SILVA", 	453370, 	2350.00, 	"2017-12-27", 	"ITAU"				),
        ("LIVROS E CIA", 		453380, 	1550.00, 	"2017-12-27", 	"BANCO DO BRASIL"	),
        ("ABC PAPELARIA", 		980130, 	4000.00, 	"2016-12-11", 	"ITAU"				),
        ("LIVRARIA FERNANDES", 	770710, 	2500.00, 	"2016-11-15", 	"SANTANDER"			),
        ("ABC PAPELARIA", 		985001, 	3000.00, 	"2016-09-11", 	"ITAU"				),
        ("PAPEL E AFINS", 		985002, 	2500.00, 	"2016-03-12", 	"SANTANDER"			),
        ("LER E SABER", 		888132, 	2500.00, 	"2017-03-05", 	"ITAU"				);

-- [ 01 ] Listar nome,vencimento e valor de cada duplicata da tabela. 
SELECT nome, vencimento, valor 
FROM Duplicata;

-- [ 02 ] Apresentar o número das duplicatas depositadas no banco Itaú
SELECT numero 
AS "DUPLICATAS ITAU" 
FROM Duplicata 
WHERE banco = "ITAU";


-- [ 03 ]  Apresentar o número de duplicatas depositadas no banco Santander
SELECT numero 
AS "DUPLICATAS SANTANDER" 
FROM Duplicata 
WHERE banco = "SANTANDER";


-- [ 04 ] Quais são as duplicatas (número, vencimento, valor e nome) 
-- que vencem no ano de 2017
SELECT numero, vencimento, valor, nome 
FROM Duplicata 
WHERE vencimento LIKE "2017%";


-- [ 05 ] Apresentar as duplicatas (número, vencimento, valor e nome) que 
-- não estão depositadas nos bancos Itaú e Santander.
SELECT numero, vencimento, valor, nome 
FROM Duplicata 
WHERE NOT banco LIKE "ITAU" 
AND NOT banco LIKE "SANTANDER";


-- [ 06 ] Quanto é o valor da divida do cliente PAPELARIA SILVA, 
-- e quais são as duplicatas?
SELECT SUM(valor) AS "VALOR DIVIDA" 
FROM Duplicata 
WHERE nome LIKE "PAPELARIA SILVA";

SELECT * FROM Duplicata
WHERE nome LIKE "PAPELARIA SILVA";


-- [ 07 ] Retirar da tabela a duplicata 770710 do cliente LIVRARIA FERNANDES, 
-- por ter sido devidamente quitada.
DELETE FROM Duplicata 
WHERE numero = 770710 AND nome = "LIVRARIA FERNANDES";


-- [ 08 ] Apresentar uma listagem em ordem alfabética por nome do cliente 
-- de todos os campos da tabela. 
SELECT * FROM Duplicata
ORDER BY nome ASC;


-- [ 09 ] Apresentar uma listagem em ordem de data de vencimento com o nome 
-- do cliente, banco, valor e vencimento.
SELECT nome, banco, valor, vencimento FROM Duplicata
ORDER BY vencimento ASC;


-- [ 10 ] As duplicatas do Banco do Brasil foram transferidas para o Santander. 
-- Proceder o ajuste dos registros.
UPDATE Duplicata
SET banco = "SANTANDER" WHERE banco LIKE "BANCO DO BRASIL";


-- [ 11 ] Quais são os clientes que possuem suas duplicatas depositadas no Banco Bradesco?
SELECT nome AS "Clientes Bradesco" 
FROM Duplicata
WHERE banco = "BRADESCO";


-- [ 12 ] Qual é a previsão de recebimento no período de 01/01/2016 até 31/12/2016?
SELECT SUM(valor) AS "Previsao de Recebimento"
FROM Duplicata
WHERE vencimento LIKE "2016%";


-- [ 13 ] Quanto a empresa tem para receber no período de 01/08/2016 até 30/08/2016?
SELECT SUM(valor) AS "Previsao de Recebimento"
FROM Duplicata
WHERE vencimento LIKE "2016-08-__";


-- [ 14 ] Quais foram os itens adquiridos pelo cliente ABC PAPELARIA?
SELECT numero AS "Itens Adquiridos ABC PAPELARIA"
FROM Duplicata
WHERE nome = "ABC PAPELARIA";


-- [ 15 ] Acrescentar uma multa de 15% para todos os títulos que se encontram 
-- vencidos no período de 01/01/2016 até 31/12/2016.
UPDATE Duplicata
SET valor = valor + (valor * 0.15) 
WHERE vencimento LIKE "2016%";


-- [ 16 ] Acrescentar uma multa de 5% para todos os títulos vencidos entre 
-- 01/01/2017 e 31/05/2017 que sejam do cliente LER E SABER. 
UPDATE Duplicata
SET valor = valor + (valor * 0.05)
WHERE vencimento > "2017-01-01" AND vencimento < "2017-05-31"
AND nome = "LER E SABER";


-- [ 17 ] Qual é a média aritmética dos valores das duplicatas do ano de 2016?
SELECT AVG(valor) AS "MEDIA"
FROM Duplicata
WHERE vencimento LIKE "2016%";


-- [ 18 ] Exiba as duplicatas e nome dos respectivos clientes que possuem 
-- duplicatas com valor superior a 10000,00?
SELECT * FROM Duplicata
WHERE valor > 10000;


-- [ 19 ] Qual o valor total das duplicatas lançadas para o banco Santander?
SELECT SUM(valor) AS "TOTAL SANTANDER"
FROM Duplicata
WHERE banco = "SANTANDER";


-- [ 20 ] Quais são os clientes que possuem suas duplicatas depositadas 
-- nos Bancos Bradesco ou Itaú?
SELECT nome AS "Clientes BRADESCO ou ITAU"
FROM Duplicata
WHERE banco = "BRADESCO" OR "ITAU";