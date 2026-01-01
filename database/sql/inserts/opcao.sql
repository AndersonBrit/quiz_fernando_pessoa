-- database/sql/inserts/opcoes.sql

USE quiz_db;

-- ========================================
-- Populate the "Opcao" table with quiz options
-- Each row links an option to a question (ID_Pergunta)
-- 'Certa' indicates if the option is correct (1 = correct, 0 = incorrect)
-- ========================================

-- Question 1 (ID = 1)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(1, '1 de Dezembro de 1933', 0),
(1, '1 de Dezembro de 1934', 1),
(1, '1 de Dezembro de 1932', 0),
(1, '2 de Dezembro de 1934', 0);

-- Question 2 (ID = 2)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(2, '14 anos', 1),
(2, '13 anos', 0),
(2, '16 anos', 0),
(2, '12 anos', 0);

-- Question 3 (ID = 3)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(3, '9 anos', 0),
(3, '7 anos', 0),
(3, '8 anos', 1),
(3, '6 anos', 0);

-- Question 4 (ID = 4)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(4, 'Mãe Leiteira, Pai Carpinteiro', 0),
(4, 'Mãe Açoriana, Pai crítico musical', 1),
(4, 'Mãe Cozinheira, Pai Caçador de ratos', 0),
(4, 'Mãe Açougueira, Pai Engenheiro Agrícola', 0);

-- Question 5 (ID = 5)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(5, 'Viseu, Portugal', 0),
(5, 'Lisboa, Portugal', 1),
(5, 'Durban, África do Sul', 0),
(5, 'Porto, Portugal', 0);

-- Question 6 (ID = 6)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(6, '43 anos, Vítima de tuberculose', 1),
(6, '40 anos, Vítima de câncer', 0),
(6, '42 anos, Vítima de Alzheimer', 0),
(6, '45 anos, Vítima de Depressão', 0);

-- Question 7 (ID = 7)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(7, 'Tradutor Comercial', 1),
(7, 'Jornalista', 0),
(7, 'Treinador de Futebol', 0),
(7, 'Professor', 0);

-- Question 8 (ID = 8)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(8, '1957', 0),
(8, '1978', 0),
(8, '1935', 1),
(8, '1915', 0);

-- Question 9 (ID = 9)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(9, 'Fernando Joaquim Pessoa', 0),
(9, 'Fernando António Nogueira Pessoa', 1),
(9, 'Fernando Serafim Augusto Pessoa', 0),
(9, 'Fernando Maria Pessoa', 0);

-- Question 10 (ID = 10)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(10, 'Umberto Eco, Álvares de Azevedo e Ricardo Reis', 0),
(10, 'Ricardo Reis, João Ubaldo e Álvares de Azevedo', 0),
(10, 'Alberto Caeiro, Ricardo Reis e Álvaro de Campos', 1),
(10, 'Álvares de Campos, Saramago e Alberto Caeiro', 0);

-- Question 11 (ID = 11)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(11, 'Engenheiro', 0),
(11, 'Médico', 1),
(11, 'Arquiteto', 0),
(11, 'Músico', 0);

-- Question 12 (ID = 12)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(12, 'Romantismo', 0),
(12, 'Modernismo', 1),
(12, 'Barroco', 0),
(12, 'Realismo', 0);

-- Questions 13 to 18 (ID = 13-18) — True/False questions
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(13, 'Verdadeiro', 1), (13, 'Falso', 0),
(14, 'Verdadeiro', 1), (14, 'Falso', 0),
(15, 'Verdadeiro', 0), (15, 'Falso', 1),
(16, 'Verdadeiro', 1), (16, 'Falso', 0),
(17, 'Verdadeiro', 0), (17, 'Falso', 1),
(18, 'Verdadeiro', 1), (18, 'Falso', 0);

-- Question 19 (ID = 19)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(19, 'Álvaro de Campos', 0),
(19, 'Alberto Caeiro', 0),
(19, 'Ricardo Reis', 1),
(19, 'Bernardo Soares', 0);

-- Question 20 (ID = 20)
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
(20, 'Presença', 0),
(20, 'Orpheu', 1),
(20, 'Athena', 0),
(20, 'Sudoeste', 0);
