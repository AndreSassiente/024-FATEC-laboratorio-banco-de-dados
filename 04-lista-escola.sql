CREATE DATABASE escola;
USE escola;

CREATE TABLE alunos (
  RA char(11),
  nome VARCHAR(50) NOT NULL,
  idade INT(11) NOT NULL,
  cpf char(15),
  rg char(13),
  PRIMARY KEY (RA)
);

CREATE TABLE materias (
  id_materia INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  cargahoraria int not null,
  professor VARCHAR(50) NOT NULL,
  curso char(30),
  PRIMARY KEY (id_materia)
);

CREATE TABLE alunosxmateria (
  id INT(11) NOT NULL AUTO_INCREMENT,
  ra char(11) NOT NULL,
  id_materia INT(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (ra) REFERENCES alunos(ra),
  FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
);

-- Inserir registros na tabela alunos
INSERT INTO alunos (RA, nome, idade, cpf, rg) VALUES 
('12345678901', 'Maria Silva', 19, '111.111.111-11', '11.111.111-1'),
('23456789012', 'João Santos', 22, '222.222.222-22', '22.222.222-2'),
('34567890123', 'Pedro Souza', 18, '333.333.333-33', '33.333.333-3'),
('45678901234', 'Ana Costa', 20, '444.444.444-44', '44.444.444-4');

-- Inserir registros na tabela materias
INSERT INTO materias (nome, cargahoraria, professor, curso) VALUES 
('Matemática', 80, 'João Carlos', 'Ciência da Computação'),
('Física', 60, 'Maria Luiza', 'Engenharia Mecânica'),
('Programação', 120, 'José Oliveira', 'Sistemas de Informação'),
('Inglês', 40, 'Carla Rocha', 'Letras');

INSERT INTO materias (nome, cargahoraria, professor, curso) VALUES 
('Banco de Dados', 80, 'João Carlos', 'Ciência da Computação');

-- Inserir registros na tabela alunosxmateria
INSERT INTO alunosxmateria (ra, id_materia) VALUES 
('12345678901', 1),
('23456789012', 3),
('34567890123', 2),
('45678901234', 4);

-- INNER JOIN
SELECT alunos.nome AS Alunos
FROM alunos
INNER JOIN alunosxmateria ON alunos.RA = alunosxmateria.ra;

SELECT materias.id_materia , materias.nome, materias.professor
FROM materias
INNER JOIN alunosxmateria ON materias.id_materia = alunosxmateria.id_materia;

SELECT alunos.nome, alunosxmateria.id_materia, materias.curso 
FROM alunos
INNER JOIN alunosxmateria ON alunos.RA = alunosxmateria.ra
INNER JOIN materias ON alunosxmateria.id_materia = materias.id_materia
WHERE materias.curso = 'Ciência da Computação';

-- JOIN
SELECT alunos.nome, materias.nome AS materia
FROM alunos
JOIN alunosxmateria ON alunos.RA = alunosxmateria.ra
JOIN materias ON alunosxmateria.id_materia = materias.id_materia;

SELECT materias.nome AS Materia, materias.cargahoraria AS Carga
FROM alunos
JOIN alunosxmateria ON alunos.RA = alunosxmateria.ra
JOIN materias ON alunosxmateria.id_materia = materias.id_materia
WHERE materias.nome = 'Inglês';

SELECT alunos.nome AS Aluno, alunosxmateria.id_materia AS Codigo, materias.professor AS Professor
FROM alunos
JOIN alunosxmateria ON alunos.RA = alunosxmateria.ra
JOIN materias ON alunosxmateria.id_materia = materias.id_materia
WHERE materias.professor = 'João Carlos';

-- LEFT JOIN
SELECT alunos.nome, alunosxmateria.ra
FROM alunos
LEFT JOIN alunosxmateria ON alunos.RA = alunosxmateria.ra;

SELECT *
FROM alunosxmateria
LEFT JOIN materias ON  alunosxmateria.id_materia = materias.id_materia
WHERE materias.cargahoraria < 100;

SELECT curso
FROM materias
LEFT JOIN alunosxmateria ON materias.id_materia = alunosxmateria.id_materia
WHERE materias.cargahoraria > 50;

-- RIGHT JOIN
SELECT alunos.nome, materias.nome AS materia
FROM alunos
RIGHT JOIN alunosxmateria ON alunos.RA = alunosxmateria.ra
RIGHT JOIN materias ON alunosxmateria.id_materia = materias.id_materia
WHERE materias.id_materia <= 3;

SELECT nome AS Materia, professor
FROM materias
RIGHT JOIN alunosxmateria ON materias.id_materia = alunosxmateria.id_materia
WHERE materias.cargahoraria <= 60;

SELECT alunosxmateria.id, alunos.ra
FROM alunosxmateria
RIGHT JOIN alunos ON alunosxmateria.ra = alunos.RA
