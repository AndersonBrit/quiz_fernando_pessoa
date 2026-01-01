-- database/sql/schema/tables.sql

-- ========================================
-- Switch to the "quiz_fernando_pessoa" database
-- ========================================
USE quiz_fernando_pessoa;

-- ========================================
-- Table: Utilizador (User)
-- Stores user information
-- Columns:
--   ID_Utilizador: Unique ID for each user
--   Nome: User's full name
--   Turma: Class or group
--   Data_Registo: Registration timestamp
-- ========================================
CREATE TABLE IF NOT EXISTS Utilizador (
    ID_Utilizador INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Turma VARCHAR(50),
    Data_Registo TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- Table: Pontuacao (Score)
-- Stores total scores for each user
-- Columns:
--   ID_Pontuacao: Unique ID for each score entry
--   ID_Utilizador: Foreign key to Utilizador
--   Pontuacao_Total: Total score
-- ========================================
CREATE TABLE IF NOT EXISTS Pontuacao (
    ID_Pontuacao INT AUTO_INCREMENT PRIMARY KEY,
    ID_Utilizador INT,
    Pontuacao_Total INT NOT NULL,
    FOREIGN KEY (ID_Utilizador) REFERENCES Utilizador(ID_Utilizador)
);

-- ========================================
-- Table: Pergunta (Question)
-- Stores all quiz questions
-- Columns:
--   ID_Pergunta: Unique ID for each question
--   N: Question number
--   Tipo: Question type (MC = multiple choice, VF = true/false)
--   Conteudo: The question text (in Portuguese)
-- ========================================
CREATE TABLE IF NOT EXISTS Pergunta (
    ID_Pergunta INT AUTO_INCREMENT PRIMARY KEY,
    N INT,
    Tipo VARCHAR(50),
    Conteudo TEXT
);

-- ========================================
-- Table: Opcao (Option)
-- Stores answer options for each question
-- Columns:
--   ID_Opcao: Unique ID for the option
--   Conteudo: Option text (in Portuguese)
--   Certa: TRUE if this option is correct
--   ID_Pergunta: Foreign key to Pergunta
-- ========================================
CREATE TABLE IF NOT EXISTS Opcao (
    ID_Opcao INT AUTO_INCREMENT PRIMARY KEY,
    Conteudo VARCHAR(255),
    Certa BOOLEAN DEFAULT FALSE,
    ID_Pergunta INT,
    FOREIGN KEY (ID_Pergunta) REFERENCES Pergunta(ID_Pergunta)
);

-- ========================================
-- Table: Resposta (Answer)
-- Stores the answers given by users
-- Columns:
--   ID_Resposta: Unique ID for the answer
--   ID_Utilizador: Foreign key to Utilizador
--   ID_Opcao: Foreign key to Opcao
--   Pontuacao: Score obtained for this answer
--   Acertou: TRUE if the answer was correct
-- ========================================
CREATE TABLE IF NOT EXISTS Resposta (
    ID_Resposta INT AUTO_INCREMENT PRIMARY KEY,
    ID_Utilizador INT,
    ID_Opcao INT,
    Pontuacao INT,
    Acertou BOOLEAN,
    FOREIGN KEY (ID_Utilizador) REFERENCES Utilizador(ID_Utilizador),
    FOREIGN KEY (ID_Opcao) REFERENCES Opcao(ID_Opcao)
);
