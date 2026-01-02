-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 28-Nov-2025 às 20:20
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `quiz_fernando_pessoa`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `opcao`
--

CREATE TABLE `opcao` (
  `ID_Opcao` int(11) NOT NULL,
  `Conteudo` varchar(255) DEFAULT NULL,
  `Certa` tinyint(1) DEFAULT 0,
  `ID_Pergunta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `opcao`
--

INSERT INTO `opcao` (`ID_Opcao`, `Conteudo`, `Certa`, `ID_Pergunta`) VALUES
(1, '1 de Dezembro de 1933', 0, 1),
(2, '1 de Dezembro de 1934', 1, 1),
(3, '1 de Dezembro de 1932', 0, 1),
(4, '2 de Dezembro de 1934', 0, 1),
(5, '14 anos', 1, 2),
(6, '13 anos', 0, 2),
(7, '16 anos', 0, 2),
(8, '12 anos', 0, 2),
(9, '9 anos', 0, 3),
(10, '7 anos', 0, 3),
(11, '8 anos', 1, 3),
(12, '6 anos', 0, 3),
(13, 'Mãe Leiteira, Pai Carpinteiro', 0, 4),
(14, 'Mãe Açoriana, Pai crítico musical', 1, 4),
(15, 'Mãe Cozinheira, Pai Caçador de ratos', 0, 4),
(16, 'Mãe Açougueira, Pai Engenheiro Agrícola', 0, 4),
(17, 'Viseu, Portugal', 0, 5),
(18, 'Lisboa, Portugal', 1, 5),
(19, 'Durban, África do Sul', 0, 5),
(20, 'Porto, Portugal', 0, 5),
(21, '43 anos, Vítima de tuberculose', 1, 6),
(22, '40 anos, Vítima de câncer', 0, 6),
(23, '42 anos, Vítima de Alzheimer', 0, 6),
(24, '45 anos, Vítima de Depressão', 0, 6),
(25, 'Tradutor Comercial', 1, 7),
(26, 'Jornalista', 0, 7),
(27, 'Treinador de Futebol', 0, 7),
(28, 'Professor', 0, 7),
(29, '1957', 0, 8),
(30, '1978', 0, 8),
(31, '1935', 1, 8),
(32, '1915', 0, 8),
(33, 'Fernando Joaquim Pessoa', 0, 9),
(34, 'Fernando António Nogueira Pessoa', 1, 9),
(35, 'Fernando Serafim Augusto Pessoa', 0, 9),
(36, 'Fernando Maria Pessoa', 0, 9),
(37, 'Umberto Eco, Álvares de Azevedo e Ricardo Reis', 0, 10),
(38, 'Ricardo Reis, João Ubaldo e Álvares de Azevedo', 0, 10),
(39, 'Alberto Caeiro, Ricardo Reis e Álvaro de Campos', 1, 10),
(40, 'Álvares de Campos, Saramago e Alberto Caeiro', 0, 10),
(41, 'Engenheiro', 0, 11),
(42, 'Médico', 1, 11),
(43, 'Arquiteto', 0, 11),
(44, 'Músico', 0, 11),
(45, 'Romantismo', 0, 12),
(46, 'Modernismo', 1, 12),
(47, 'Barroco', 0, 12),
(48, 'Realismo', 0, 12),
(49, 'Verdadeiro', 1, 13),
(50, 'Falso', 0, 13),
(51, 'Verdadeiro', 1, 14),
(52, 'Falso', 0, 14),
(53, 'Verdadeiro', 0, 15),
(54, 'Falso', 1, 15),
(55, 'Verdadeiro', 1, 16),
(56, 'Falso', 0, 16),
(57, 'Verdadeiro', 0, 17),
(58, 'Falso', 1, 17),
(59, 'Verdadeiro', 1, 18),
(60, 'Falso', 0, 18),
(61, 'Álvaro de Campos', 0, 19),
(62, 'Alberto Caeiro', 0, 19),
(63, 'Ricardo Reis', 1, 19),
(64, 'Bernardo Soares', 0, 19),
(65, 'Presença', 0, 20),
(66, 'Orpheu', 1, 20),
(67, 'Athena', 0, 20),
(68, 'Sudoeste', 0, 20);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pergunta`
--

CREATE TABLE `pergunta` (
  `ID_Pergunta` int(11) NOT NULL,
  `N` int(11) DEFAULT NULL,
  `Tipo` varchar(50) DEFAULT NULL,
  `Conteudo` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `pergunta`
--

INSERT INTO `pergunta` (`ID_Pergunta`, `N`, `Tipo`, `Conteudo`) VALUES
(1, 1, 'MC', 'Em que ano foi publicado o livro Mensagem de Fernando Pessoa?'),
(2, 2, 'MC', 'Com quantos anos Fernando Pessoa escreveu a sua primeira poesia oficial?'),
(3, 3, 'MC', 'Com quantos anos Fernando Pessoa se mudou para a África do Sul?'),
(4, 4, 'MC', 'Qual era a profissão dos pais de Fernando Pessoa?'),
(5, 5, 'MC', 'Em que cidade nasceu Fernando Pessoa?'),
(6, 6, 'MC', 'Com quantos anos morreu o pai de Fernando Pessoa?'),
(7, 7, 'MC', 'Qual era a principal profissão de Fernando Pessoa, além de escritor?'),
(8, 8, 'MC', 'Em que ano faleceu Fernando Pessoa?'),
(9, 9, 'MC', 'Qual era o nome completo de Fernando Pessoa?'),
(10, 10, 'MC', 'Quais são os heterónimos de Fernando Pessoa?'),
(11, 11, 'MC', 'Qual era a profissão do heterónimo Ricardo Reis?'),
(12, 12, 'MC', 'Fernando Pessoa faz parte de qual movimento literário?'),
(13, 13, 'VF', 'O primeiro heterónimo de Fernando Pessoa foi Alexandre Search, nascido em 13 de junho de 1888 em Lisboa.'),
(14, 14, 'VF', 'Fernando Pessoa é um dos mais importantes escritores portugueses do modernismo e poetas de língua portuguesa, por consolidar a modernidade na sua poesia.'),
(15, 15, 'VF', 'Umas das características do modernismo em Portugal eram Versos livres.'),
(16, 16, 'VF', 'A primeira fase do modernismo português era Orfismo.'),
(17, 17, 'VF', 'Fernando Pessoa escreveu apenas sob o seu próprio nome, sem utilizar heterônimos.'),
(18, 18, 'VF', 'Um dos heterônimos mais conhecidos de Fernando Pessoa é Alberto Caeiro, considerado o “mestre” dos outros heterônimos.'),
(19, 19, 'MC', 'Qual dos seguintes heterónimos de Fernando Pessoa é conhecido por seu estilo racional e científico?'),
(20, 20, 'MC', 'O modernismo português teve início em 1915 com o lançamento de qual revista literária, da qual Fernando Pessoa foi um dos fundadores?');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pontuacao`
--

CREATE TABLE `pontuacao` (
  `ID_Pontuacao` int(11) NOT NULL,
  `ID_Utilizador` int(11) DEFAULT NULL,
  `Pontuacao_Total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `pontuacao`
--

INSERT INTO `pontuacao` (`ID_Pontuacao`, `ID_Utilizador`, `Pontuacao_Total`) VALUES
(1, 1, 1),
(2, 1, 6),
(3, 2, 3),
(4, 1, 4),
(5, 1, 4),
(6, 3, 3),
(7, 1, 6),
(8, 4, 6),
(9, 1, 3),
(10, 1, 4),
(11, 1, 1),
(12, 5, 1),
(13, 6, 7),
(14, 8, 7),
(15, 9, 11),
(16, 1, 4),
(17, 1, 6),
(18, 17, 8),
(19, 1, 7),
(20, 19, 2),
(21, 1, 7),
(22, 14, 4),
(23, 1, 9),
(24, 1, 4),
(25, 1, 9),
(26, 1, 12),
(27, 32, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `resposta`
--

CREATE TABLE `resposta` (
  `ID_Resposta` int(11) NOT NULL,
  `ID_Utilizador` int(11) DEFAULT NULL,
  `ID_Opcao` int(11) DEFAULT NULL,
  `Pontuacao` int(11) DEFAULT NULL,
  `Acertou` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `resposta`
--

INSERT INTO `resposta` (`ID_Resposta`, `ID_Utilizador`, `ID_Opcao`, `Pontuacao`, `Acertou`) VALUES
(1, 1, 13, 0, 0),
(2, 1, 29, 0, 0),
(3, 1, 41, 0, 0),
(4, 1, 33, 0, 0),
(5, 1, 33, 0, 0),
(6, 1, 1, 0, 0),
(7, 1, 49, 1, 1),
(8, 1, 53, 0, 0),
(9, 1, 37, 0, 0),
(10, 1, 61, 0, 0),
(11, 1, 41, 0, 0),
(12, 1, 25, 1, 1),
(13, 1, 51, 1, 1),
(14, 1, 5, 1, 1),
(15, 1, 53, 0, 0),
(16, 1, 59, 1, 1),
(17, 1, 5, 1, 1),
(18, 1, 33, 0, 0),
(19, 1, 51, 1, 1),
(20, 1, 1, 0, 0),
(21, 2, 29, 0, 0),
(22, 2, 59, 1, 1),
(23, 2, 5, 1, 1),
(24, 2, 13, 0, 0),
(25, 2, 17, 0, 0),
(26, 2, 29, 0, 0),
(27, 2, 57, 0, 0),
(28, 2, 1, 0, 0),
(29, 2, 13, 0, 0),
(30, 2, 49, 1, 1),
(31, 1, 25, 1, 1),
(32, 1, 45, 0, 0),
(33, 1, 33, 0, 0),
(34, 1, 37, 0, 0),
(35, 1, 45, 0, 0),
(36, 1, 57, 0, 0),
(37, 1, 1, 0, 0),
(38, 1, 21, 1, 1),
(39, 1, 21, 1, 1),
(40, 1, 49, 1, 1),
(41, 1, 25, 1, 1),
(42, 1, 13, 0, 0),
(43, 1, 65, 0, 0),
(44, 1, 61, 0, 0),
(45, 1, 51, 1, 1),
(46, 1, 45, 0, 0),
(47, 1, 17, 0, 0),
(48, 1, 59, 1, 1),
(49, 1, 59, 1, 1),
(50, 1, 13, 0, 0),
(51, 3, 33, 0, 0),
(52, 3, 59, 1, 1),
(53, 3, 17, 0, 0),
(54, 3, 61, 0, 0),
(55, 3, 49, 1, 1),
(56, 3, 41, 0, 0),
(57, 3, 21, 1, 1),
(58, 3, 17, 0, 0),
(59, 3, 33, 0, 0),
(60, 3, 17, 0, 0),
(61, 1, 61, 0, 0),
(62, 1, 21, 1, 1),
(63, 1, 49, 1, 1),
(64, 1, 59, 1, 1),
(65, 1, 5, 1, 1),
(66, 1, 65, 0, 0),
(67, 1, 37, 0, 0),
(68, 1, 49, 1, 1),
(69, 1, 25, 1, 1),
(70, 1, 61, 0, 0),
(71, 4, 59, 1, 1),
(72, 4, 61, 0, 0),
(73, 4, 41, 0, 0),
(74, 4, 49, 1, 1),
(75, 4, 51, 1, 1),
(76, 4, 55, 1, 1),
(77, 4, 65, 0, 0),
(78, 4, 29, 0, 0),
(79, 4, 55, 1, 1),
(80, 4, 49, 1, 1),
(81, 1, 63, 1, 1),
(82, 1, 43, 0, 0),
(83, 1, 11, 1, 1),
(84, 1, 23, 0, 0),
(85, 1, 43, 0, 0),
(86, 1, 7, 0, 0),
(87, 1, 43, 0, 0),
(88, 1, 35, 0, 0),
(89, 1, 63, 1, 1),
(90, 1, 57, 0, 0),
(91, 1, 49, 1, 1),
(92, 1, 33, 0, 0),
(93, 1, 65, 0, 0),
(94, 1, 65, 0, 0),
(95, 1, 1, 0, 0),
(96, 1, 59, 1, 1),
(97, 1, 17, 0, 0),
(98, 1, 13, 0, 0),
(99, 1, 21, 1, 1),
(100, 1, 55, 1, 1),
(101, 1, 9, 0, 0),
(102, 1, 53, 0, 0),
(103, 1, 33, 0, 0),
(104, 1, 17, 0, 0),
(105, 1, 13, 0, 0),
(106, 1, 21, 1, 1),
(107, 1, 53, 0, 0),
(108, 1, 29, 0, 0),
(109, 1, 1, 0, 0),
(110, 1, 9, 0, 0),
(111, 5, 25, 1, 1),
(112, 5, 61, 0, 0),
(113, 5, 61, 0, 0),
(114, 5, 45, 0, 0),
(115, 5, 41, 0, 0),
(116, 5, 9, 0, 0),
(117, 5, 13, 0, 0),
(118, 5, 41, 0, 0),
(119, 5, 1, 0, 0),
(120, 5, 13, 0, 0),
(121, 6, 45, 0, 0),
(122, 6, 25, 1, 1),
(123, 6, 5, 1, 1),
(124, 6, 29, 0, 0),
(125, 6, 25, 1, 1),
(126, 6, 37, 0, 0),
(127, 6, 5, 1, 1),
(128, 6, 5, 1, 1),
(129, 6, 37, 0, 0),
(130, 6, 65, 0, 0),
(131, 6, 45, 0, 0),
(132, 6, 53, 0, 0),
(133, 6, 9, 0, 0),
(134, 6, 25, 1, 1),
(135, 6, 41, 0, 0),
(136, 6, 55, 1, 1),
(137, 6, 33, 0, 0),
(138, 6, 57, 0, 0),
(139, 6, 37, 0, 0),
(140, 6, 1, 0, 0),
(141, 7, 59, 1, 1),
(142, 7, 1, 0, 0),
(143, 7, 1, 0, 0),
(144, 7, 57, 0, 0),
(145, 7, 1, 0, 0),
(146, 7, 65, 0, 0),
(147, 8, 37, 0, 0),
(148, 8, 41, 0, 0),
(149, 8, 13, 0, 0),
(150, 8, 65, 0, 0),
(151, 8, 61, 0, 0),
(152, 8, 59, 1, 1),
(153, 8, 49, 1, 1),
(154, 8, 5, 1, 1),
(155, 8, 33, 0, 0),
(156, 8, 61, 0, 0),
(157, 8, 21, 1, 1),
(158, 8, 53, 0, 0),
(159, 8, 13, 0, 0),
(160, 8, 33, 0, 0),
(161, 8, 57, 0, 0),
(162, 8, 9, 0, 0),
(163, 8, 21, 1, 1),
(164, 8, 59, 1, 1),
(165, 8, 45, 0, 0),
(166, 8, 25, 1, 1),
(167, 9, 5, 1, 1),
(168, 9, 21, 1, 1),
(169, 9, 45, 0, 0),
(170, 9, 25, 1, 1),
(171, 9, 49, 1, 1),
(172, 9, 21, 1, 1),
(173, 9, 59, 1, 1),
(174, 9, 49, 1, 1),
(175, 9, 41, 0, 0),
(176, 9, 57, 0, 0),
(177, 9, 45, 0, 0),
(178, 9, 21, 1, 1),
(179, 9, 33, 0, 0),
(180, 9, 41, 0, 0),
(181, 9, 51, 1, 1),
(182, 9, 55, 1, 1),
(183, 9, 65, 0, 0),
(184, 9, 9, 0, 0),
(185, 9, 5, 1, 1),
(186, 9, 45, 0, 0),
(187, 10, 53, 0, 0),
(188, 10, 29, 0, 0),
(189, 10, 21, 1, 1),
(190, 1, 57, 0, 0),
(191, 1, 41, 0, 0),
(192, 1, 61, 0, 0),
(193, 1, 5, 1, 1),
(194, 13, 13, 0, 0),
(195, 13, 59, 1, 1),
(196, 13, 37, 0, 0),
(197, 1, 9, 0, 0),
(198, 1, 6, 0, 0),
(199, 1, 56, 0, 0),
(200, 1, 17, 0, 0),
(201, 1, 61, 0, 0),
(202, 1, 65, 0, 0),
(203, 1, 57, 0, 0),
(204, 1, 45, 0, 0),
(205, 1, 59, 1, 1),
(206, 1, 49, 1, 1),
(207, 1, 57, 0, 0),
(208, 1, 17, 0, 0),
(209, 1, 45, 0, 0),
(210, 1, 49, 1, 1),
(211, 1, 51, 1, 1),
(212, 1, 65, 0, 0),
(213, 1, 29, 0, 0),
(214, 1, 61, 0, 0),
(215, 1, 1, 0, 0),
(216, 1, 1, 0, 0),
(217, 1, 41, 0, 0),
(218, 1, 18, 1, 1),
(219, 1, 41, 0, 0),
(220, 1, 55, 1, 1),
(221, 1, 33, 0, 0),
(222, 1, 65, 0, 0),
(223, 1, 51, 1, 1),
(224, 1, 45, 0, 0),
(225, 1, 53, 0, 0),
(226, 1, 13, 0, 0),
(227, 1, 21, 1, 1),
(228, 1, 13, 0, 0),
(229, 1, 45, 0, 0),
(230, 1, 21, 1, 1),
(231, 1, 51, 1, 1),
(232, 1, 9, 0, 0),
(233, 1, 57, 0, 0),
(234, 1, 49, 1, 1),
(235, 1, 33, 0, 0),
(236, 1, 57, 0, 0),
(237, 1, 17, 0, 0),
(238, 1, 9, 0, 0),
(239, 1, 29, 0, 0),
(240, 15, 41, 0, 0),
(241, 15, 57, 0, 0),
(242, 15, 59, 1, 1),
(243, 15, 57, 0, 0),
(244, 15, 9, 0, 0),
(245, 15, 9, 0, 0),
(246, 1, 25, 1, 1),
(247, 1, 53, 0, 0),
(248, 1, 45, 0, 0),
(249, 1, 61, 0, 0),
(250, 16, 59, 1, 1),
(251, 17, 45, 0, 0),
(252, 17, 59, 1, 1),
(253, 17, 25, 1, 1),
(254, 17, 51, 1, 1),
(255, 17, 17, 0, 0),
(256, 17, 59, 1, 1),
(257, 17, 13, 0, 0),
(258, 17, 29, 0, 0),
(259, 17, 29, 0, 0),
(260, 17, 25, 1, 1),
(261, 17, 5, 1, 1),
(262, 17, 17, 0, 0),
(263, 17, 59, 1, 1),
(264, 17, 53, 0, 0),
(265, 17, 13, 0, 0),
(266, 17, 65, 0, 0),
(267, 17, 65, 0, 0),
(268, 17, 21, 1, 1),
(269, 17, 13, 0, 0),
(270, 17, 65, 0, 0),
(271, 1, 17, 0, 0),
(272, 1, 45, 0, 0),
(273, 1, 17, 0, 0),
(274, 1, 41, 0, 0),
(275, 1, 61, 0, 0),
(276, 1, 9, 0, 0),
(277, 1, 33, 0, 0),
(278, 1, 29, 0, 0),
(279, 1, 21, 1, 1),
(280, 1, 53, 0, 0),
(281, 1, 21, 1, 1),
(282, 1, 65, 0, 0),
(283, 1, 57, 0, 0),
(284, 1, 13, 0, 0),
(285, 1, 33, 0, 0),
(286, 1, 61, 0, 0),
(287, 1, 9, 0, 0),
(288, 1, 57, 0, 0),
(289, 1, 61, 0, 0),
(290, 1, 17, 0, 0),
(291, 1, 45, 0, 0),
(292, 1, 1, 0, 0),
(293, 1, 21, 1, 1),
(294, 1, 5, 1, 1),
(295, 1, 59, 1, 1),
(296, 1, 9, 0, 0),
(297, 1, 37, 0, 0),
(298, 1, 51, 1, 1),
(299, 1, 57, 0, 0),
(300, 1, 55, 1, 1),
(301, 1, 49, 1, 1),
(302, 1, 13, 0, 0),
(303, 1, 25, 1, 1),
(304, 18, 25, 1, 1),
(305, 18, 59, 1, 1),
(306, 18, 25, 1, 1),
(307, 18, 51, 1, 1),
(308, 18, 57, 0, 0),
(309, 19, 1, 0, 0),
(310, 19, 49, 1, 1),
(311, 19, 5, 1, 1),
(312, 19, 9, 0, 0),
(313, 19, 37, 0, 0),
(314, 1, 1, 0, 0),
(315, 1, 49, 1, 1),
(316, 1, 5, 1, 1),
(317, 1, 17, 0, 0),
(318, 1, 1, 0, 0),
(319, 1, 1, 0, 0),
(320, 1, 13, 0, 0),
(321, 1, 41, 0, 0),
(322, 1, 57, 0, 0),
(323, 1, 9, 0, 0),
(324, 1, 21, 1, 1),
(325, 1, 5, 1, 1),
(326, 1, 41, 0, 0),
(327, 1, 55, 1, 1),
(328, 1, 41, 0, 0),
(329, 1, 61, 0, 0),
(330, 1, 45, 0, 0),
(331, 1, 59, 1, 1),
(332, 1, 57, 0, 0),
(333, 1, 9, 0, 0),
(334, 1, 59, 1, 1),
(335, 29, 55, 1, 1),
(336, 29, 45, 0, 0),
(337, 14, 41, 0, 0),
(338, 14, 9, 0, 0),
(339, 14, 65, 0, 0),
(340, 14, 53, 0, 0),
(341, 14, 33, 0, 0),
(342, 14, 53, 0, 0),
(343, 14, 49, 1, 1),
(344, 14, 1, 0, 0),
(345, 14, 51, 1, 1),
(346, 14, 61, 0, 0),
(347, 14, 65, 0, 0),
(348, 14, 33, 0, 0),
(349, 14, 1, 0, 0),
(350, 14, 49, 1, 1),
(351, 14, 9, 0, 0),
(352, 14, 45, 0, 0),
(353, 14, 17, 0, 0),
(354, 14, 5, 1, 1),
(355, 14, 61, 0, 0),
(356, 14, 65, 0, 0),
(357, 30, 5, 1, 1),
(358, 1, 9, 0, 0),
(359, 1, 51, 1, 1),
(360, 1, 5, 1, 1),
(361, 1, 29, 0, 0),
(362, 1, 41, 0, 0),
(363, 1, 33, 0, 0),
(364, 1, 55, 1, 1),
(365, 1, 51, 1, 1),
(366, 1, 17, 0, 0),
(367, 1, 61, 0, 0),
(368, 1, 59, 1, 1),
(369, 1, 59, 1, 1),
(370, 1, 45, 0, 0),
(371, 1, 57, 0, 0),
(372, 1, 53, 0, 0),
(373, 1, 29, 0, 0),
(374, 1, 25, 1, 1),
(375, 1, 25, 1, 1),
(376, 1, 51, 1, 1),
(377, 1, 1, 0, 0),
(378, 17, 49, 1, 1),
(379, 1, 57, 0, 0),
(380, 1, 17, 0, 0),
(381, 1, 5, 1, 1),
(382, 1, 53, 0, 0),
(383, 1, 45, 0, 0),
(384, 1, 13, 0, 0),
(385, 1, 17, 0, 0),
(386, 1, 1, 0, 0),
(387, 1, 61, 0, 0),
(388, 1, 57, 0, 0),
(389, 1, 25, 1, 1),
(390, 1, 25, 1, 1),
(391, 1, 41, 0, 0),
(392, 1, 53, 0, 0),
(393, 1, 33, 0, 0),
(394, 1, 5, 1, 1),
(395, 1, 53, 0, 0),
(396, 1, 41, 0, 0),
(397, 1, 45, 0, 0),
(398, 1, 17, 0, 0),
(399, 1, 25, 1, 1),
(400, 1, 55, 1, 1),
(401, 1, 49, 1, 1),
(402, 1, 1, 0, 0),
(403, 1, 33, 0, 0),
(404, 1, 21, 1, 1),
(405, 1, 61, 0, 0),
(406, 1, 41, 0, 0),
(407, 1, 17, 0, 0),
(408, 1, 13, 0, 0),
(409, 1, 53, 0, 0),
(410, 1, 51, 1, 1),
(411, 1, 9, 0, 0),
(412, 1, 49, 1, 1),
(413, 1, 5, 1, 1),
(414, 1, 29, 0, 0),
(415, 1, 49, 1, 1),
(416, 1, 25, 1, 1),
(417, 1, 37, 0, 0),
(418, 1, 13, 0, 0),
(419, 14, 9, 0, 0),
(420, 1, 49, 1, 1),
(421, 1, 61, 0, 0),
(422, 1, 41, 0, 0),
(423, 1, 59, 1, 1),
(424, 1, 59, 1, 1),
(425, 1, 33, 0, 0),
(426, 1, 49, 1, 1),
(427, 1, 37, 0, 0),
(428, 1, 25, 1, 1),
(429, 1, 1, 0, 0),
(430, 1, 25, 1, 1),
(431, 1, 25, 1, 1),
(432, 1, 1, 0, 0),
(433, 1, 33, 0, 0),
(434, 1, 25, 1, 1),
(435, 1, 21, 1, 1),
(436, 1, 51, 1, 1),
(437, 1, 5, 1, 1),
(438, 1, 17, 0, 0),
(439, 1, 59, 1, 1),
(440, 32, 65, 0, 0),
(441, 32, 61, 0, 0),
(442, 32, 51, 1, 1),
(443, 32, 13, 0, 0),
(444, 32, 45, 0, 0),
(445, 32, 57, 0, 0),
(446, 32, 13, 0, 0),
(447, 32, 33, 0, 0),
(448, 32, 57, 0, 0),
(449, 32, 13, 0, 0),
(450, 32, 5, 1, 1),
(451, 32, 9, 0, 0),
(452, 32, 49, 1, 1),
(453, 32, 5, 1, 1),
(454, 32, 21, 1, 1),
(455, 32, 45, 0, 0),
(456, 32, 45, 0, 0),
(457, 32, 21, 1, 1),
(458, 32, 41, 0, 0),
(459, 32, 33, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizador`
--

CREATE TABLE `utilizador` (
  `ID_Utilizador` int(11) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Turma` varchar(50) DEFAULT NULL,
  `Data_Registo` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `utilizador`
--

INSERT INTO `utilizador` (`ID_Utilizador`, `Nome`, `Turma`, `Data_Registo`) VALUES
(1, 'Anderson', 'GPSI', '2025-11-22 18:45:52'),
(2, 'Andeson', 'GPSI', '2025-11-22 21:35:18'),
(3, 'Vanessa', 'GPSI', '2025-11-23 10:12:03'),
(4, 'And', 'GPSI', '2025-11-23 10:30:29'),
(5, 'Pedro', 'GPSI', '2025-11-23 11:18:45'),
(6, 'Derson', 'GPSI', '2025-11-23 11:21:11'),
(7, 'Vencedor', 'IG', '2025-11-23 11:28:56'),
(8, 'Perdedor', 'IG', '2025-11-23 11:29:47'),
(9, 'Teste', 'IG', '2025-11-23 11:31:00'),
(10, 'Anderson?', 'GPSI', '2025-11-23 11:31:17'),
(11, 'k', 'GPSI', '2025-11-23 11:32:09'),
(12, 'Kk', 'GPSI', '2025-11-23 11:32:48'),
(13, 'kjk', 'GPSI', '2025-11-23 11:37:56'),
(14, 'Ander', 'GPSI', '2025-11-23 11:47:07'),
(15, 'Gabriel', 'GPSI', '2025-11-23 12:28:26'),
(16, 'Tiago', 'GPSI', '2025-11-23 12:51:24'),
(17, 'asda', 'GPSI', '2025-11-23 13:08:51'),
(18, 'asdafsa', 'GPSI', '2025-11-23 15:23:13'),
(19, 'Frutas', 'GPSI', '2025-11-23 15:38:08'),
(20, 'Afonso', 'IG', '2025-11-23 16:05:54'),
(21, 'Branquinho', 'GPSI', '2025-11-23 16:23:14'),
(22, 'sdasf', 'GPSI', '2025-11-23 16:45:41'),
(23, 'Preto', 'IG', '2025-11-23 16:53:20'),
(24, 'Silva', 'COM', '2025-11-23 17:19:47'),
(25, 'befess', 'COM', '2025-11-23 18:16:41'),
(26, 'hhhhh', 'IG', '2025-11-23 19:33:03'),
(27, 'lll', 'GPSI', '2025-11-23 19:33:40'),
(28, 'kkkk', 'GPSI', '2025-11-23 19:33:47'),
(29, 'Adnd', 'IG', '2025-11-23 19:42:23'),
(30, 'adas', 'GPSI', '2025-11-23 19:46:47'),
(31, 'asdas', 'GPSI', '2025-11-23 20:03:11'),
(32, 'Anderson5', 'GPSI', '2025-11-28 19:00:14');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `opcao`
--
ALTER TABLE `opcao`
  ADD PRIMARY KEY (`ID_Opcao`),
  ADD KEY `ID_Pergunta` (`ID_Pergunta`);

--
-- Índices para tabela `pergunta`
--
ALTER TABLE `pergunta`
  ADD PRIMARY KEY (`ID_Pergunta`);

--
-- Índices para tabela `pontuacao`
--
ALTER TABLE `pontuacao`
  ADD PRIMARY KEY (`ID_Pontuacao`),
  ADD KEY `ID_Utilizador` (`ID_Utilizador`);

--
-- Índices para tabela `resposta`
--
ALTER TABLE `resposta`
  ADD PRIMARY KEY (`ID_Resposta`),
  ADD KEY `ID_Utilizador` (`ID_Utilizador`),
  ADD KEY `ID_Opcao` (`ID_Opcao`);

--
-- Índices para tabela `utilizador`
--
ALTER TABLE `utilizador`
  ADD PRIMARY KEY (`ID_Utilizador`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `opcao`
--
ALTER TABLE `opcao`
  MODIFY `ID_Opcao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT de tabela `pergunta`
--
ALTER TABLE `pergunta`
  MODIFY `ID_Pergunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `pontuacao`
--
ALTER TABLE `pontuacao`
  MODIFY `ID_Pontuacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de tabela `resposta`
--
ALTER TABLE `resposta`
  MODIFY `ID_Resposta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=460;

--
-- AUTO_INCREMENT de tabela `utilizador`
--
ALTER TABLE `utilizador`
  MODIFY `ID_Utilizador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `opcao`
--
ALTER TABLE `opcao`
  ADD CONSTRAINT `opcao_ibfk_1` FOREIGN KEY (`ID_Pergunta`) REFERENCES `pergunta` (`ID_Pergunta`);

--
-- Limitadores para a tabela `pontuacao`
--
ALTER TABLE `pontuacao`
  ADD CONSTRAINT `pontuacao_ibfk_1` FOREIGN KEY (`ID_Utilizador`) REFERENCES `utilizador` (`ID_Utilizador`);

--
-- Limitadores para a tabela `resposta`
--
ALTER TABLE `resposta`
  ADD CONSTRAINT `resposta_ibfk_1` FOREIGN KEY (`ID_Utilizador`) REFERENCES `utilizador` (`ID_Utilizador`),
  ADD CONSTRAINT `resposta_ibfk_2` FOREIGN KEY (`ID_Opcao`) REFERENCES `opcao` (`ID_Opcao`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
