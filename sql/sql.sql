-- sql.sql
-- Criar base de dados
CREATE DATABASE IF NOT EXISTS quiz_fernando_pessoa;
USE quiz_fernando_pessoa;

-- Tabela de Utilizadore
CREATE TABLE IF NOT EXISTS Utilizador (
    ID_Utilizador INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Turma VARCHAR(50),
    Data_Registo TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Pontuacao
CREATE TABLE IF NOT EXISTS Pontuacao (
    ID_Pontuacao INT AUTO_INCREMENT PRIMARY KEY,
    ID_Utilizador INT,
    Pontuacao_Total INT NOT NULL,
    FOREIGN KEY (ID_Utilizador) REFERENCES Utilizador(ID_Utilizador)
);

-- Tabela de Pergunta
CREATE TABLE IF NOT EXISTS Pergunta (
    ID_Pergunta INT AUTO_INCREMENT PRIMARY KEY,
    N INT,
    Tipo VARCHAR(50),
    Conteudo TEXT
);

-- Tabela de Opcao
CREATE TABLE IF NOT EXISTS Opcao (
    ID_Opcao INT AUTO_INCREMENT PRIMARY KEY,
    Conteudo VARCHAR(255),
    Certa BOOLEAN DEFAULT FALSE,
    ID_Pergunta INT,
    FOREIGN KEY (ID_Pergunta) REFERENCES Pergunta(ID_Pergunta)
);

-- Tabela de Resposta
CREATE TABLE IF NOT EXISTS Resposta (
    ID_Resposta INT AUTO_INCREMENT PRIMARY KEY,
    ID_Utilizador INT,
    ID_Opcao INT,
    Pontuacao INT,
    Acertou BOOLEAN,
    FOREIGN KEY (ID_Utilizador) REFERENCES Utilizador(ID_Utilizador),
    FOREIGN KEY (ID_Opcao) REFERENCES Opcao(ID_Opcao)
);
