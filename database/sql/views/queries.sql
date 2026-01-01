-- database/sql/views/queries.sql

-- ========================================
-- Select all users with their performance stats
-- ========================================
SELECT * FROM vw_utilizadores_desempenho;

-- ========================================
-- Select users from a specific class
-- Replace '12º Ano' with the desired class
-- ========================================
SELECT * FROM vw_utilizadores_desempenho
WHERE Turma = '12º Ano';

-- ========================================
-- Order users by total score in descending order
-- ========================================
SELECT * FROM vw_utilizadores_desempenho
ORDER BY Pontuacao_Total DESC;
