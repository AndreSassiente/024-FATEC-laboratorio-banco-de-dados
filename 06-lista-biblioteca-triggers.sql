-- Alterar a tabela Livros, acrescentando o campo quantidade
ALTER TABLE Livros
ADD Quantidade INT NOT NULL;

-- [ Trigger 01 ] Atualizar a quantidade disponível após um empréstimo
CREATE TRIGGER tgr_emprestimo
AFTER INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    UPDATE Livros
    SET Quantidade = Quantidade - 1
    WHERE LivroID = NEW.LivroID;
END;

-- [ Trigger 02 ] Atualizar a quantidade disponível após uma devolução
CREATE TRIGGER tgr_devolucao
AFTER INSERT ON Devolucoes
FOR EACH ROW
BEGIN
    UPDATE Livros
    SET Quantidade = Quantidade + 1
    WHERE LivroID = (SELECT LivroID FROM Emprestimos WHERE EmprestimoID = NEW.EmprestimoID);
END;
