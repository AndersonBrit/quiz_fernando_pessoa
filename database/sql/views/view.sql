-- database/sql/views/view.sql

-- ========================================
-- View: vw_utilizadores_desempenho
-- Combines user info, total score, and answer stats
-- Columns:
--   ID_Utilizador: User ID
--   Nome: User name
--   Turma: Class
--   Data_Registo: Registration timestamp
--   Pontuacao_Total: Total score (0 if none)
--   Perguntas_Respondidas: Number of questions answered
--   Respostas_Certas: Number of correct answers
--   Ultima_Resposta: Last answer ID
-- ========================================
CREATE VIEW vw_utilizadores_desempenho AS
SELECT 
    u.ID_Utilizador,  
    u.Nome,           
    u.Turma,          
    u.Data_Registo,   
    COALESCE(p.Pontuacao_Total, 0) AS Pontuacao_Total,
    COUNT(r.ID_Resposta) AS Perguntas_Respondidas,
    COALESCE(SUM(CASE WHEN r.Acertou = TRUE THEN 1 ELSE 0 END), 0) AS Respostas_Certas,
    MAX(r.ID_Resposta) AS Ultima_Resposta
FROM Utilizador u
LEFT JOIN Pontuacao p ON u.ID_Utilizador = p.ID_Utilizador
LEFT JOIN Resposta r ON u.ID_Utilizador = r.ID_Utilizador
GROUP BY u.ID_Utilizador, u.Nome, u.Turma, u.Data_Registo, p.Pontuacao_Total;
