-- insert.sql
USE quiz_db;

-- Popular a tabela Pergunta
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

-- Popular a tabela Opcao com ID_Pergunta explícito
INSERT INTO Opcao (ID_Pergunta, Conteudo, Certa) VALUES
-- Pergunta 1 (ID_Pergunta = 1)
(1, '1 de Dezembro de 1933', 0),
(1, '1 de Dezembro de 1934', 1),
(1, '1 de Dezembro de 1932', 0),
(1, '2 de Dezembro de 1934', 0),

-- Pergunta 2 (ID_Pergunta = 2)
(2, '14 anos', 1),
(2, '13 anos', 0),
(2, '16 anos', 0),
(2, '12 anos', 0),

-- Pergunta 3 (ID_Pergunta = 3)
(3, '9 anos', 0),
(3, '7 anos', 0),
(3, '8 anos', 1),
(3, '6 anos', 0),

-- Pergunta 4 (ID_Pergunta = 4)
(4, 'Mãe Leiteira, Pai Carpinteiro', 0),
(4, 'Mãe Açoriana, Pai crítico musical', 1),
(4, 'Mãe Cozinheira, Pai Caçador de ratos', 0),
(4, 'Mãe Açougueira, Pai Engenheiro Agrícola', 0),

-- Pergunta 5 (ID_Pergunta = 5)
(5, 'Viseu, Portugal', 0),
(5, 'Lisboa, Portugal', 1),
(5, 'Durban, África do Sul', 0),
(5, 'Porto, Portugal', 0),

-- Pergunta 6 (ID_Pergunta = 6)
(6, '43 anos, Vítima de tuberculose', 1),
(6, '40 anos, Vítima de câncer', 0),
(6, '42 anos, Vítima de Alzheimer', 0),
(6, '45 anos, Vítima de Depressão', 0),

-- Pergunta 7 (ID_Pergunta = 7)
(7, 'Tradutor Comercial', 1),
(7, 'Jornalista', 0),
(7, 'Treinador de Futebol', 0),
(7, 'Professor', 0),

-- Pergunta 8 (ID_Pergunta = 8)
(8, '1957', 0),
(8, '1978', 0),
(8, '1935', 1),
(8, '1915', 0),

-- Pergunta 9 (ID_Pergunta = 9)
(9, 'Fernando Joaquim Pessoa', 0),
(9, 'Fernando António Nogueira Pessoa', 1),
(9, 'Fernando Serafim Augusto Pessoa', 0),
(9, 'Fernando Maria Pessoa', 0),

-- Pergunta 10 (ID_Pergunta = 10)
(10, 'Umberto Eco, Álvares de Azevedo e Ricardo Reis', 0),
(10, 'Ricardo Reis, João Ubaldo e Álvares de Azevedo', 0),
(10, 'Alberto Caeiro, Ricardo Reis e Álvaro de Campos', 1),
(10, 'Álvares de Campos, Saramago e Alberto Caeiro', 0),

-- Pergunta 11 (ID_Pergunta = 11)
(11, 'Engenheiro', 0),
(11, 'Médico', 1),
(11, 'Arquiteto', 0),
(11, 'Músico', 0),

-- Pergunta 12 (ID_Pergunta = 12)
(12, 'Romantismo', 0),
(12, 'Modernismo', 1),
(12, 'Barroco', 0),
(12, 'Realismo', 0),

-- Pergunta 13 (ID_Pergunta = 13) VF
(13, 'Verdadeiro', 1),
(13, 'Falso', 0),

-- Pergunta 14 (ID_Pergunta = 14) VF
(14, 'Verdadeiro', 1),
(14, 'Falso', 0),

-- Pergunta 15 (ID_Pergunta = 15) VF
(15, 'Verdadeiro', 0),
(15, 'Falso', 1),

-- Pergunta 16 (ID_Pergunta = 16) VF
(16, 'Verdadeiro', 1),
(16, 'Falso', 0),

-- Pergunta 17 (ID_Pergunta = 17) VF
(17, 'Verdadeiro', 0),
(17, 'Falso', 1),

-- Pergunta 18 (ID_Pergunta = 18) VF
(18, 'Verdadeiro', 1),
(18, 'Falso', 0),

-- Pergunta 19 (ID_Pergunta = 19)
(19, 'Álvaro de Campos', 0),
(19, 'Alberto Caeiro', 0),
(19, 'Ricardo Reis', 1),
(19, 'Bernardo Soares', 0),

-- Pergunta 20 (ID_Pergunta = 20)
(20, 'Presença', 0),
(20, 'Orpheu', 1),
(20, 'Athena', 0),
(20, 'Sudoeste', 0);
