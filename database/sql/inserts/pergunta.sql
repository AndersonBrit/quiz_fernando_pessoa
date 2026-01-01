-- database/sql/inserts/perguntas.sql

USE quiz_db;

-- ========================================
-- Populate the "Pergunta" table with quiz questions
-- Questions are in Portuguese and of type MC (Multiple Choice) or VF (True/False)
-- ========================================

INSERT INTO Pergunta (N, Tipo, Conteudo) VALUES
(1, 'MC', 'Em que ano foi publicado o livro Mensagem de Fernando Pessoa?'),
(2, 'MC', 'Com quantos anos Fernando Pessoa escreveu a sua primeira poesia oficial?'),
(3, 'MC', 'Com quantos anos Fernando Pessoa se mudou para a África do Sul?'),
(4, 'MC', 'Qual era a profissão dos pais de Fernando Pessoa?'),
(5, 'MC', 'Em que cidade nasceu Fernando Pessoa?'),
(6, 'MC', 'Com quantos anos morreu o pai de Fernando Pessoa?'),
(7, 'MC', 'Qual era a principal profissão de Fernando Pessoa, além de escritor?'),
(8, 'MC', 'Em que ano faleceu Fernando Pessoa?'),
(9, 'MC', 'Qual era o nome completo de Fernando Pessoa?'),
(10, 'MC', 'Quais são os heterónimos de Fernando Pessoa?'),
(11, 'MC', 'Qual era a profissão do heterónimo Ricardo Reis?'),
(12, 'MC', 'Fernando Pessoa faz parte de qual movimento literário?'),
(13, 'VF', 'O primeiro heterónimo de Fernando Pessoa foi Alexandre Search, nascido em 13 de junho de 1888 em Lisboa.'),
(14, 'VF', 'Fernando Pessoa é um dos mais importantes escritores portugueses do modernismo e poetas de língua portuguesa, por consolidar a modernidade na sua poesia.'),
(15, 'VF', 'Umas das características do modernismo em Portugal eram Versos livres.'),
(16, 'VF', 'A primeira fase do modernismo português era Orfismo.'),
(17, 'VF', 'Fernando Pessoa escreveu apenas sob o seu próprio nome, sem utilizar heterônimos.'),
(18, 'VF', 'Um dos heterônimos mais conhecidos de Fernando Pessoa é Alberto Caeiro, considerado o “mestre” dos outros heterônimos.'),
(19, 'MC', 'Qual dos seguintes heterónimos de Fernando Pessoa é conhecido por seu estilo racional e científico?'),
(20, 'MC', 'O modernismo português teve início em 1915 com o lançamento de qual revista literária, da qual Fernando Pessoa foi um dos fundadores?');
