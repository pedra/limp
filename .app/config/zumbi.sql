SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

CREATE DATABASE IF NOT EXISTS `zumbi` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `zumbi`;

DROP TABLE IF EXISTS `access`;
CREATE TABLE IF NOT EXISTS `access` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `REQUEST` varchar(200) NOT NULL,
  `METHOD` varchar(12) NOT NULL,
  `REMOTE` varchar(200) NOT NULL,
  `AGENT` varchar(300) NOT NULL,
  `ACCEPT` varchar(200) NOT NULL,
  `ENCODING` varchar(200) NOT NULL,
  `LANGUAGE` varchar(200) NOT NULL,
  `IDATE` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`,`IDATE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

DROP TABLE IF EXISTS `erp_usuarios`;
CREATE TABLE IF NOT EXISTS `erp_usuarios` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `primeiro_nome` varchar(45) CHARACTER SET latin1 NOT NULL,
  `segundo_nome` varchar(45) CHARACTER SET latin1 NOT NULL,
  `email` varchar(100) CHARACTER SET latin1 NOT NULL,
  `senha` varchar(60) CHARACTER SET latin1 NOT NULL,
  `criado` datetime NOT NULL,
  `modificado` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ativo` bit(1) NOT NULL DEFAULT b'1',
  `status` varchar(20) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_email` (`email`),
  KEY `key_email` (`email`) COMMENT '  ',
  KEY `key_senha` (`senha`),
  KEY `key_ativo` (`ativo`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

INSERT INTO `erp_usuarios` (`id`, `primeiro_nome`, `segundo_nome`, `email`, `senha`, `criado`, `modificado`, `ativo`, `status`) VALUES
(1, 'Bill', 'Rocha', 'paulo.rocha@outlook.com', 'e807f1fcf82d132f9bb018ca6738a19f', '2015-10-10 00:00:00', '2015-10-10 20:10:39', b'1', 'ACTIVE'),
(2, 'Willian', 'Rafael César', 'abul@gmail.com', 'e807f1fcf82d132f9bb018ca6738a19f', '2015-10-10 00:00:00', '2015-10-10 20:10:39', b'1', 'ACTIVE'),
(3, 'Gerber', 'Zurox', 'zurox@outlook.com', 'e807f1fcf82d132f9bb018ca6738a19f', '2015-10-10 00:00:00', '2015-10-10 20:12:12', b'1', 'ACTIVE'),
(4, 'Jefferson', 'dos Santos e Silva', 'jeff_ss@gmail.com', 'e807f1fcf82d132f9bb018ca6738a19f', '2015-10-10 00:00:00', '2015-10-10 20:12:12', b'1', 'ACTIVE'),
(5, 'Marcos', 'Vinícios do Nascimento', 'vini-nascimento@ymail.com', 'e807f1fcf82d132f9bb018ca6738a19f', '2015-10-10 00:00:00', '2015-10-10 20:13:10', b'1', 'DISABLED'),
(6, 'Marta', 'Barata da Silva', 'martachinela@gmail.com', 'e807f1fcf82d132f9bb018ca6738a19f', '0000-00-00 00:00:00', '2015-10-25 01:46:13', b'1', 'ACTIVE'),
(7, 'Armando', 'Pinto de Souza', 'armandinho24@gmagazine.com.br', 'e807f1fcf82d132f9bb018ca6738a19f', '0000-00-00 00:00:00', '2015-10-25 01:46:13', b'1', 'ACTIVE'),
(8, 'Marina', 'do Rego Salgado', 'maresal@yahoo.com.br', 'e807f1fcf82d132f9bb018ca6738a19f', '0000-00-00 00:00:00', '2015-10-25 01:46:13', b'1', 'ACTIVE');

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PAR` int(11) NOT NULL DEFAULT '0',
  `STATUS` tinyint(1) NOT NULL DEFAULT '1',
  `NAME` varchar(200) NOT NULL,
  `ABOUT` text NOT NULL,
  PRIMARY KEY (`ID`,`PAR`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Groups defines' AUTO_INCREMENT=19 ;

INSERT INTO `groups` (`ID`, `PAR`, `STATUS`, `NAME`, `ABOUT`) VALUES
(1, 0, 1, 'Gerências', 'Grupo de acesso geral as gerências'),
(2, 0, 1, 'Marketing', 'Grupo base do setor de marketing'),
(3, 1, 1, 'Financeiro', 'Departamento financeiro'),
(4, 1, 1, 'Administrativo', 'Gerência administrativa'),
(5, 1, 1, 'Novos Negócios', 'Gerência de Novos Negócios'),
(6, 2, 1, 'Pesquisa', 'Departamento de Pesquisa de Mercado'),
(7, 2, 1, 'Midias Digitais', 'Departamento de gerenciamento de midias digitais'),
(8, 2, 1, 'Produtos', 'Departamento de Marketing a Produtos'),
(9, 0, 1, 'TI', 'Tecnologia da Infomação'),
(10, 9, 1, 'Hardware', 'Equipamentos de TI'),
(11, 9, 1, 'Software', 'Departamento de Software'),
(12, 10, 1, 'CPD', 'Central de processamento de dados'),
(13, 10, 1, 'Rede', 'Rede de dados e conexões'),
(14, 10, 1, 'Manutenção', 'Manetenção de equipamentos de TI'),
(15, 11, 1, 'Desenvolvimento', 'Desenvolvimento de sistemas'),
(16, 11, 1, 'Sistemas', 'Análise de sistemas'),
(17, 11, 1, 'Segurança', 'Análise e desenvolvimento de segurança em TI'),
(18, 11, 1, 'Database', 'Inteligência operacional de base de dados');

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `ID` double NOT NULL AUTO_INCREMENT,
  `SENDDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IDFROM` int(11) NOT NULL,
  `NAMEFROM` varchar(200) NOT NULL,
  `TOGROUP` int(11) DEFAULT '0',
  `TOUSER` int(11) DEFAULT '0',
  `TYPE` enum('msg','img','file') NOT NULL DEFAULT 'msg' COMMENT 'types: msg/img/file',
  `CONTENT` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Messages data' AUTO_INCREMENT=261 ;

INSERT INTO `messages` (`ID`, `SENDDATE`, `IDFROM`, `NAMEFROM`, `TOGROUP`, `TOUSER`, `TYPE`, `CONTENT`) VALUES
(1, '2015-10-13 08:43:44', 1, 'Bill Rocha', 9, 0, 'msg', 'Teste de envio de mensagem para um GRUPO'),
(2, '2015-10-13 08:43:50', 1, 'Bill Rocha', 0, 3, 'msg', 'Teste de envio de mensagem para um determinado USUÁRIO.'),
(3, '2015-10-13 09:15:43', 1, 'Bill Rocha', 16, 0, 'msg', 'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'),
(4, '2015-10-13 09:01:22', 1, 'Bill Rocha', 16, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor.'),
(5, '2015-10-13 08:43:58', 1, 'Bill Rocha', 16, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(6, '2015-10-13 09:15:09', 1, 'Bill Rocha', 16, 0, 'msg', 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(7, '2015-10-13 08:44:04', 1, 'Bill Rocha', 15, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(8, '2015-10-13 08:44:06', 1, 'Bill Rocha', 15, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(9, '2015-10-17 17:55:03', 1, 'Bill Rocha', 15, 0, 'msg', 'teste'),
(10, '2015-10-17 17:59:40', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'olá'),
(11, '2015-10-17 18:00:03', 1, 'Bill Rocha', 15, 0, 'msg', 'ttfcdfggh'),
(12, '2015-10-17 18:02:46', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'ola, de novo'),
(13, '2015-10-17 18:02:56', 1, 'Bill Rocha', 15, 0, 'msg', 'hi'),
(14, '2015-10-17 18:03:07', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'ok'),
(15, '2015-10-17 18:04:04', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'ttt'),
(16, '2015-10-17 18:05:01', 1, 'Bill Rocha', 15, 0, 'msg', 'ghg'),
(17, '2015-10-17 18:05:14', 1, 'Bill Rocha', 15, 0, 'msg', 'hhh'),
(18, '2015-10-17 18:05:27', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'hjjkkk'),
(19, '2015-10-17 18:08:07', 1, 'Bill Rocha', 15, 0, 'msg', 'Estou no canal 15'),
(20, '2015-10-17 18:08:28', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Estou no canal 1'),
(21, '2015-10-17 18:08:35', 1, 'Bill Rocha', 15, 0, 'msg', 'ok'),
(22, '2015-10-17 18:08:59', 1, 'Bill Rocha', 15, 0, 'msg', 'ok'),
(23, '2015-10-17 18:09:11', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'como?'),
(24, '2015-10-17 18:09:28', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'fala, ai'),
(25, '2015-10-17 18:09:37', 1, 'Bill Rocha', 15, 0, 'msg', 'como assim?:'),
(26, '2015-10-17 18:35:27', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'sadsad'),
(27, '2015-10-17 18:39:20', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'teste'),
(28, '2015-10-17 18:40:32', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'tese'),
(29, '2015-10-17 18:41:47', 1, 'Bill Rocha', 1, 0, 'msg', 'olá'),
(30, '2015-10-17 18:42:00', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'tudo bem?'),
(31, '2015-10-17 18:42:10', 1, 'Bill Rocha', 1, 0, 'msg', 'ok'),
(32, '2015-10-17 18:42:19', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'hi'),
(33, '2015-10-17 18:42:27', 1, 'Bill Rocha', 1, 0, 'msg', 'ui'),
(34, '2015-10-17 18:42:41', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'a\\cxxz\\cxz\\c\\xzc sadd aSDASdAS'),
(35, '2015-10-17 18:44:03', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'olá'),
(36, '2015-10-17 18:44:11', 1, 'Bill Rocha', 1, 0, 'msg', 'oi'),
(37, '2015-10-17 18:44:22', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'hime aslkjd  m ksnm'),
(38, '2015-10-17 18:44:26', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(39, '2015-10-17 18:45:46', 1, 'Bill Rocha', 1, 0, 'msg', 'hello!'),
(40, '2015-10-17 18:46:14', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'olá, galera!!'),
(41, '2015-10-17 18:47:14', 1, 'Bill Rocha', 1, 0, 'msg', 'hi'),
(42, '2015-10-17 18:47:22', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'ok'),
(43, '2015-10-17 19:05:10', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'teste'),
(44, '2015-10-17 19:10:08', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'sdfdsf'),
(45, '2015-10-17 19:10:14', 1, 'Bill Rocha', 1, 0, 'msg', 'asdsa'),
(46, '2015-10-17 19:35:19', 1, 'Bill Rocha', 1, 0, 'msg', 'fdgbfd'),
(47, '2015-10-17 19:35:33', 1, 'Bill Rocha', 15, 0, 'msg', 'vcbcv'),
(48, '2015-10-17 19:35:54', 1, 'Bill Rocha', 15, 0, 'msg', 'asdsad'),
(49, '2015-10-17 19:36:30', 1, 'Bill Rocha', 15, 0, 'msg', 'dsfsd df'),
(50, '2015-10-17 20:03:59', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(51, '2015-10-17 20:09:04', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(52, '2015-10-17 20:18:39', 1, 'Bill Rocha', 1, 0, 'msg', 'Outro teste'),
(53, '2015-10-17 20:19:41', 2, 'Willian Rafael César', 1, 0, 'msg', 'Hello'),
(54, '2015-10-17 20:26:00', 1, 'Bill Rocha', 1, 0, 'msg', 'olá'),
(55, '2015-10-17 20:28:09', 1, 'Bill Rocha', 1, 0, 'msg', 'dsafdsa dsaf sadf sdaf~pdsj]fçlskda<br/>f'),
(56, '2015-10-17 20:28:11', 1, 'Bill Rocha', 1, 0, 'msg', 'sdakf sda~fkjsdaflsdakflsdkjf~sdkf'),
(57, '2015-10-17 20:28:13', 1, 'Bill Rocha', 1, 0, 'msg', 'dsfdslfknjsdfsdalkfsdaoifhsda'),
(58, '2015-10-17 20:28:15', 1, 'Bill Rocha', 1, 0, 'msg', 'sdahssdidhs sad'),
(59, '2015-10-17 20:33:39', 2, 'Willian Rafael César', 9, 0, 'msg', 'aasd saas dsad'),
(60, '2015-10-17 20:33:40', 2, 'Willian Rafael César', 9, 0, 'msg', 'asd sa'),
(61, '2015-10-17 20:33:41', 2, 'Willian Rafael César', 9, 0, 'msg', 'sad'),
(62, '2015-10-17 20:33:41', 2, 'Willian Rafael César', 9, 0, 'msg', 'd sad sad'),
(63, '2015-10-17 21:19:46', 1, 'Bill Rocha', 15, 0, 'msg', 'xzcxzcxzc'),
(64, '2015-10-17 21:23:55', 1, 'Bill Rocha', 16, 0, 'msg', 'zxczxczx cxzc'),
(65, '2015-10-21 23:01:55', 2, 'Willian Rafael César', 9, 0, 'msg', 'teste'),
(66, '2015-10-21 23:02:01', 2, 'Willian Rafael César', 9, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(67, '2015-10-21 23:03:57', 1, 'Bill Rocha', 15, 0, 'msg', 'teste'),
(68, '2015-10-21 23:06:20', 1, 'Bill Rocha', 15, 0, 'msg', 'teste'),
(69, '2015-10-21 23:21:33', 1, 'Bill Rocha', 9, 0, 'msg', 'Teste'),
(70, '2015-10-21 23:22:25', 1, 'Bill Rocha', 1, 0, 'msg', 'olá'),
(71, '2015-10-21 23:35:46', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(72, '2015-10-21 23:45:58', 1, 'Bill Rocha', 1, 0, 'msg', 'Este é mais um teste de mensagem!'),
(73, '2015-10-21 23:51:32', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(74, '2015-10-22 00:10:29', 1, 'Bill Rocha', NULL, 0, 'msg', 'Enviando mensagens de teste'),
(75, '2015-10-22 00:10:53', 1, 'Bill Rocha', 1, 0, 'msg', 'Enviando algumas mensagens de teste ao servidor.'),
(76, '2015-10-22 00:12:10', 1, 'Bill Rocha', NULL, 0, 'msg', 'teste'),
(77, '2015-10-22 00:12:29', 1, 'Bill Rocha', 1, 0, 'msg', 'oqeu é isso'),
(78, '2015-10-22 00:13:57', 2, 'Willian Rafael César', 1, 0, 'msg', 'olá, galera!!'),
(79, '2015-10-22 00:15:48', 2, 'Willian Rafael César', 1, 0, 'msg', 'teste'),
(80, '2015-10-22 00:16:02', 1, 'Bill Rocha', 1, 0, 'msg', 'Meu teste'),
(81, '2015-10-22 00:16:10', 2, 'Willian Rafael César', 1, 0, 'msg', 'ok'),
(82, '2015-10-22 00:19:59', 2, 'Willian Rafael César', 1, 0, 'msg', 'outra mensagem de teste'),
(83, '2015-10-22 00:29:49', 2, 'Willian Rafael César', 1, 0, 'msg', 'teste'),
(84, '2015-10-22 00:30:46', 2, 'Willian Rafael César', 1, 0, 'msg', 'olá!'),
(85, '2015-10-22 00:32:05', 2, 'Willian Rafael César', 1, 0, 'msg', 'Olá, galera!'),
(86, '2015-10-22 00:32:16', 1, 'Bill Rocha', 1, 0, 'msg', 'blaz'),
(87, '2015-10-22 00:33:00', 2, 'Willian Rafael César', 1, 0, 'msg', 'hi, men.'),
(88, '2015-10-22 00:33:05', 1, 'Bill Rocha', 1, 0, 'msg', 'olá'),
(89, '2015-10-22 00:33:38', 2, 'Willian Rafael César', 1, 0, 'msg', 'ok'),
(90, '2015-10-22 00:46:03', 2, 'Willian Rafael César', 1, 0, 'msg', 'ts'),
(91, '2015-10-22 00:52:54', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(92, '2015-10-22 00:53:06', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(93, '2015-10-22 01:27:50', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(94, '2015-10-22 01:40:39', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(95, '2015-10-22 01:51:21', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(96, '2015-10-22 02:01:29', 1, 'Bill Rocha', 1, 0, 'msg', 'olá'),
(97, '2015-10-22 02:01:54', 2, 'Willian Rafael César', 1, 0, 'msg', 'Olá, alguém por ai?'),
(98, '2015-10-22 02:02:13', 2, 'Willian Rafael César', 1, 0, 'msg', 'oi'),
(99, '2015-10-22 02:02:25', 1, 'Bill Rocha', 1, 0, 'msg', 'Come está, Rafael?'),
(100, '2015-10-22 02:06:27', 2, 'Willian Rafael César', 1, 0, 'msg', 'ok'),
(101, '2015-10-22 02:13:53', 1, 'Bill Rocha', 1, 0, 'msg', 'Teste'),
(102, '2015-10-22 02:14:57', 3, 'Gerber Zurox', 9, 0, 'msg', 'E ai, gente?'),
(103, '2015-10-22 02:22:02', 1, 'Bill Rocha', 1, 0, 'msg', 'Testando com um smartphone microsoft Lumia'),
(104, '2015-10-22 02:43:59', 1, 'Bill Rocha', 15, 0, 'msg', 'olá'),
(105, '2015-10-22 02:44:56', 2, 'Willian Rafael César', 9, 0, 'msg', 'Falái'),
(106, '2015-10-22 02:46:23', 1, 'Bill Rocha', 9, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(107, '2015-10-22 02:46:44', 1, 'Bill Rocha', 9, 0, 'msg', '<b>olá</b>, pessoal!'),
(108, '2015-10-22 02:49:22', 1, 'Bill Rocha', 15, 0, 'msg', 'Teste'),
(109, '2015-10-22 02:50:50', 1, 'Bill Rocha', 15, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(110, '2015-10-22 03:00:30', 1, 'Bill Rocha', 15, 0, 'msg', 'teste'),
(111, '2015-10-22 03:09:27', 1, 'Bill Rocha', 16, 0, 'msg', 'asdasd'),
(112, '2015-10-22 03:21:25', 1, 'Bill Rocha', 16, 0, 'msg', 'fasdfsdfs'),
(113, '2015-10-22 03:24:25', 1, 'Bill Rocha', 16, 0, 'msg', 'dfdfsfs'),
(114, '2015-10-23 00:51:20', 1, 'Bill Rocha', 15, 0, 'msg', 'Teste'),
(115, '2015-10-23 03:21:52', 1, 'Bill Rocha', 17, 0, 'msg', 'Hello!'),
(116, '2015-10-23 03:23:23', 1, 'Bill Rocha', 17, 0, 'msg', 'Oi!'),
(117, '2015-10-23 03:54:41', 1, 'Bill Rocha', 15, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(118, '2015-10-23 03:56:15', 1, 'Bill Rocha', 1, 0, 'msg', 'Olá!<br/>Alguém tem o controle do mês de Novembro - ativo?'),
(119, '2015-10-24 02:59:08', 1, 'Bill Rocha', 1, 0, 'msg', 'oi'),
(120, '2015-10-24 03:00:19', 1, 'Bill Rocha', 1, 0, 'msg', 'olá'),
(121, '2015-10-24 03:00:55', 1, 'Bill Rocha', 1, 0, 'msg', 'hi!!'),
(122, '2015-10-24 03:04:49', 1, 'Bill Rocha', 1, 0, 'msg', 'alguém por ai?'),
(123, '2015-10-24 03:05:03', 2, 'Willian Rafael César', 1, 0, 'msg', 'ok'),
(124, '2015-10-24 03:15:33', 1, 'Bill Rocha', 9, 0, 'msg', 'oi, mano!'),
(125, '2015-10-24 03:16:16', 2, 'Willian Rafael César', 9, 0, 'msg', 'olá'),
(126, '2015-10-24 03:18:12', 1, 'Bill Rocha', 9, 0, 'msg', 'hi'),
(127, '2015-10-24 03:18:29', 2, 'Willian Rafael César', 9, 0, 'msg', 'olá'),
(128, '2015-10-24 03:18:52', 1, 'Bill Rocha', 9, 0, 'msg', 'fala'),
(129, '2015-10-24 03:19:04', 2, 'Willian Rafael César', 9, 0, 'msg', 'ok'),
(130, '2015-10-24 03:21:24', 2, 'Willian Rafael César', 9, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(131, '2015-10-24 03:22:04', 1, 'Bill Rocha', 9, 0, 'msg', 'olá'),
(132, '2015-10-24 03:22:09', 2, 'Willian Rafael César', 9, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(133, '2015-10-24 03:22:16', 1, 'Bill Rocha', 9, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(134, '2015-10-24 03:23:12', 2, 'Willian Rafael César', 9, 0, 'msg', 'this type'),
(135, '2015-10-24 03:28:06', 2, 'Willian Rafael César', 9, 0, 'msg', 'yes'),
(136, '2015-10-24 03:28:18', 1, 'Bill Rocha', 9, 0, 'msg', 'ok'),
(137, '2015-10-24 03:28:25', 2, 'Willian Rafael César', 9, 0, 'msg', 'yes, ok!'),
(138, '2015-10-24 03:42:06', 3, 'Gerber Zurox', 9, 0, 'msg', 'hi'),
(139, '2015-10-25 01:32:06', 1, 'Bill Rocha', 16, 0, 'msg', 'hi'),
(140, '2015-10-25 03:10:29', 8, 'Marina do Rego Salgado', 3, 0, 'msg', 'Olá, alguém interessado?'),
(141, '2015-10-25 03:12:22', 7, 'Armando Pinto de Souza', 7, 0, 'msg', 'oieee'),
(142, '2015-10-25 03:12:54', 6, 'Marta Barata da Silva', 3, 0, 'msg', 'hi, all'),
(143, '2015-10-25 03:14:46', 5, 'Marcos Vinícios do Nascimento', 5, 0, 'msg', 'My god!? <br/><br/>It´s running!!'),
(144, '2015-10-27 04:28:09', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore<br/> et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(145, '2015-10-27 04:28:34', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/><br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/><br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/><br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(146, '2015-10-27 04:30:42', 1, 'Bill Rocha', 17, 0, 'msg', 'oi, gente!'),
(147, '2015-10-27 04:30:50', 1, 'Bill Rocha', 17, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(148, '2015-10-27 05:28:53', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
(149, '2015-10-27 05:51:13', 3, 'Gerber Zurox', 9, 0, 'msg', 'Hello!'),
(150, '2015-10-27 05:52:16', 2, 'Willian Rafael César', 1, 0, 'msg', 'Bem vindo!'),
(151, '2015-10-27 05:52:39', 2, 'Willian Rafael César', 1, 0, 'msg', 'Valeu!<br/>Mas, por<br/>que ?'),
(152, '2015-10-27 05:53:09', 1, 'Bill Rocha', 1, 0, 'msg', 'Porque sou o <b>dono</b> dessa sala!'),
(153, '2015-10-27 05:54:36', 2, 'Willian Rafael César', 1, 0, 'msg', 'txs'),
(154, '2015-10-27 05:54:45', 2, 'Willian Rafael César', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(155, '2015-10-27 05:55:20', 2, 'Willian Rafael César', 1, 0, 'msg', 'ok'),
(156, '2015-10-27 05:56:25', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'olá'),
(157, '2015-10-27 05:57:01', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'oi'),
(158, '2015-10-27 05:57:22', 1, 'Bill Rocha', 1, 0, 'msg', 'hi, jeff'),
(159, '2015-10-27 05:57:40', 2, 'Willian Rafael César', 1, 0, 'msg', 'hi, galkera'),
(160, '2015-10-27 05:57:48', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(161, '2015-10-27 05:58:12', 2, 'Willian Rafael César', 1, 0, 'msg', 'yelow?!'),
(162, '2015-10-27 05:58:26', 1, 'Bill Rocha', 1, 0, 'msg', 'como assim?'),
(163, '2015-10-27 05:58:39', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'A cor de seu perfil!'),
(164, '2015-10-27 05:58:51', 2, 'Willian Rafael César', 1, 0, 'msg', 'Não! Do seu, Jeff'),
(165, '2015-10-27 06:00:27', 1, 'Bill Rocha', 1, 0, 'msg', 'hi'),
(166, '2015-10-27 06:00:34', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'o que?'),
(167, '2015-10-27 06:01:50', 1, 'Bill Rocha', 1, 0, 'msg', 'hello'),
(168, '2015-10-27 06:02:14', 2, 'Willian Rafael César', 1, 0, 'msg', 'Voltei!'),
(169, '2015-10-27 06:03:29', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'olá?'),
(170, '2015-10-27 06:03:55', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
(171, '2015-10-27 06:04:24', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(172, '2015-10-27 06:04:42', 2, 'Willian Rafael César', 1, 0, 'msg', 'Voltei'),
(173, '2015-10-27 06:05:02', 2, 'Willian Rafael César', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua'),
(174, '2015-10-27 06:05:29', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Já caiu?'),
(175, '2015-10-27 06:05:37', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Jeff'),
(176, '2015-10-27 06:15:20', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(177, '2015-10-27 06:16:20', 1, 'Bill Rocha', 1, 0, 'msg', 'hello'),
(178, '2015-10-27 06:16:33', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(179, '2015-10-27 06:17:14', 1, 'Bill Rocha', 1, 0, 'msg', 'olá'),
(180, '2015-10-27 06:17:23', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(181, '2015-10-27 06:22:31', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(182, '2015-10-27 06:24:20', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(183, '2015-10-27 06:24:28', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(184, '2015-10-27 06:25:01', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(185, '2015-10-27 06:26:01', 1, 'Bill Rocha', 1, 0, 'msg', 'enviando'),
(186, '2015-10-27 06:26:09', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(187, '2015-10-27 06:26:28', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(188, '2015-10-27 06:26:52', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(189, '2015-10-27 06:27:18', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(190, '2015-10-27 06:28:08', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(191, '2015-10-27 06:28:42', 1, 'Bill Rocha', 1, 0, 'msg', 'ho'),
(192, '2015-10-27 06:28:53', 1, 'Bill Rocha', 1, 0, 'msg', 'hello, mans'),
(193, '2015-10-27 06:29:01', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(194, '2015-10-27 06:32:28', 1, 'Bill Rocha', 17, 0, 'msg', 'olá'),
(195, '2015-10-27 06:32:35', 1, 'Bill Rocha', 17, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(196, '2015-10-27 06:37:29', 2, 'Willian Rafael César', 9, 0, 'msg', 'hello, galera!'),
(197, '2015-10-27 06:37:47', 2, 'Willian Rafael César', 9, 0, 'msg', 'oi?'),
(198, '2015-10-28 19:15:35', 1, 'Bill Rocha', 1, 0, 'msg', 'hello'),
(199, '2015-10-28 19:15:46', 2, 'Willian Rafael César', 1, 0, 'msg', 'e ai?'),
(200, '2015-10-28 19:33:06', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Hi!'),
(201, '2015-10-28 19:35:58', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Teste'),
(202, '2015-10-28 19:36:02', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Ok'),
(203, '2015-10-28 19:36:07', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', '?'),
(204, '2015-10-28 19:40:32', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
(205, '2015-10-28 20:01:58', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Teste'),
(206, '2015-10-29 18:53:38', 1, 'Bill Rocha', 1, 0, 'msg', ']'),
(207, '2015-10-29 19:55:14', 1, 'Bill Rocha', 1, 0, 'msg', 'Outro teste'),
(208, '2015-10-29 19:55:35', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
(209, '2015-11-05 20:42:46', 1, 'Bill Rocha', 1, 0, 'msg', 'teste'),
(210, '2015-11-05 20:43:23', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(211, '2015-11-05 20:52:24', 1, 'Bill Rocha', 1, 0, 'msg', 'hello!!'),
(212, '2015-11-05 20:53:23', 2, 'Willian Rafael César', 1, 0, 'msg', 'cvvsfd'),
(213, '2015-11-05 20:53:29', 1, 'Bill Rocha', 1, 0, 'msg', 'olá!!'),
(214, '2015-11-05 20:55:09', 1, 'Bill Rocha', 1, 0, 'msg', 'dsfsd'),
(215, '2015-11-05 20:55:41', 2, 'Willian Rafael César', 1, 0, 'msg', 'sadasd'),
(216, '2015-11-05 20:55:54', 2, 'Willian Rafael César', 1, 0, 'msg', 'Hi,men!'),
(217, '2015-11-05 20:56:48', 2, 'Willian Rafael César', 1, 0, 'msg', 'dsfsdfsd'),
(218, '2015-11-05 20:59:07', 2, 'Willian Rafael César', 1, 0, 'msg', 'Galera!!'),
(219, '2015-11-05 20:59:25', 2, 'Willian Rafael César', 1, 0, 'msg', 'olá!!'),
(220, '2015-11-05 21:00:35', 2, 'Willian Rafael César', 1, 0, 'msg', 'kill?'),
(221, '2015-11-05 21:06:39', 2, 'Willian Rafael César', 1, 0, 'msg', 'Olá, IE!'),
(222, '2015-11-05 21:12:20', 2, 'Willian Rafael César', 1, 0, 'msg', 'outro, IE?'),
(223, '2015-11-05 21:25:04', 2, 'Willian Rafael César', 1, 0, 'msg', 'asdsa sad asdas dasd asdas asdsad'),
(224, '2015-11-05 21:26:38', 2, 'Willian Rafael César', 1, 0, 'msg', 'hi'),
(225, '2015-11-05 21:26:59', 2, 'Willian Rafael César', 1, 0, 'msg', 'Now, is bealtifull.'),
(226, '2015-11-05 21:27:22', 2, 'Willian Rafael César', 1, 0, 'msg', 'It´s ok?'),
(227, '2015-11-05 21:27:33', 1, 'Bill Rocha', 1, 0, 'msg', 'Yes, ok.'),
(228, '2015-11-05 21:28:43', 4, 'Jefferson dos Santos e Silva', 1, 0, 'msg', 'Oi, galera!!'),
(229, '2015-11-05 21:28:59', 1, 'Bill Rocha', 1, 0, 'msg', 'boa noite, Jeff'),
(230, '2015-11-05 21:29:10', 2, 'Willian Rafael César', 1, 0, 'msg', 'Hi, Jeff'),
(231, '2015-11-05 21:31:10', 1, 'Bill Rocha', 1, 0, 'msg', 'ol´s'),
(232, '2015-11-05 21:31:16', 1, 'Bill Rocha', 1, 0, 'msg', 'ok'),
(233, '2015-11-09 01:59:40', 2, 'Willian Rafael César', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(234, '2015-11-09 02:49:39', 1, 'Bill Rocha', 1, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(235, '2015-11-09 03:46:29', 1, 'Bill Rocha', 15, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(236, '2015-11-09 04:35:59', 2, 'Willian Rafael César', 9, 0, 'msg', 'Testando com mensagem encriptada em AES-192.'),
(237, '2015-11-09 06:07:31', 2, 'Willian Rafael César', 9, 0, 'msg', 'Testando'),
(238, '2015-11-09 06:08:07', 1, 'Bill Rocha', 9, 0, 'msg', 'hello!'),
(239, '2015-11-09 06:08:43', 2, 'Willian Rafael César', 9, 0, 'msg', 'hi, mem'),
(240, '2015-11-09 06:08:48', 2, 'Willian Rafael César', 9, 0, 'msg', 'ok'),
(241, '2015-11-09 06:08:55', 1, 'Bill Rocha', 9, 0, 'msg', 'olá?!'),
(242, '2015-11-09 06:09:29', 1, 'Bill Rocha', 9, 0, 'msg', 'ok?'),
(243, '2015-11-09 06:10:00', 2, 'Willian Rafael César', 9, 0, 'msg', 'hi'),
(244, '2015-11-09 07:21:54', 2, 'Willian Rafael César', 1, 0, 'msg', 'teste'),
(245, '2015-11-09 07:35:16', 1, 'Bill Rocha', 9, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(246, '2015-11-09 07:35:32', 2, 'Willian Rafael César', 9, 0, 'msg', 'Teste'),
(247, '2015-11-09 07:35:48', 1, 'Bill Rocha', 9, 0, 'msg', 'Hi, galera!!'),
(248, '2015-11-09 07:35:59', 1, 'Bill Rocha', 9, 0, 'msg', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <br/>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. <br/>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. <br/>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
(249, '2015-11-09 07:36:58', 2, 'Willian Rafael César', 9, 0, 'msg', 'send messages encrypted with AES 256?!'),
(250, '2015-11-09 07:37:12', 2, 'Willian Rafael César', 9, 0, 'msg', 'It´s ok?'),
(251, '2015-11-09 07:37:20', 1, 'Bill Rocha', 1, 0, 'msg', 'yes.'),
(252, '2015-11-09 07:37:25', 1, 'Bill Rocha', 1, 0, 'msg', 'ok'),
(253, '2015-11-09 07:37:43', 1, 'Bill Rocha', 1, 0, 'msg', 'hello!'),
(254, '2015-11-09 07:37:46', 2, 'Willian Rafael César', 9, 0, 'msg', 'ok'),
(255, '2015-11-09 07:38:02', 2, 'Willian Rafael César', 9, 0, 'msg', 'ok'),
(256, '2015-11-09 07:38:07', 1, 'Bill Rocha', 1, 0, 'msg', 'ok'),
(257, '2015-11-09 07:38:18', 1, 'Bill Rocha', 1, 0, 'msg', 'hi'),
(258, '2015-11-09 07:38:57', 1, 'Bill Rocha', 9, 0, 'msg', 'oi, galera'),
(259, '2015-11-09 07:39:06', 2, 'Willian Rafael César', 9, 0, 'msg', 'blz??'),
(260, '2015-11-09 07:39:23', 1, 'Bill Rocha', 9, 0, 'msg', 'tudo bem?');

DROP TABLE IF EXISTS `relay`;
CREATE TABLE IF NOT EXISTS `relay` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PID` int(11) NOT NULL,
  `STATUS` int(11) NOT NULL COMMENT '0 = stop, 1 = running, 2 = stoped',
  `SCRIPT` varchar(200) NOT NULL,
  `TITLE` varchar(200) NOT NULL,
  `IP` varchar(30) NOT NULL,
  `PORT` varchar(6) NOT NULL,
  `CHA_NOW` int(11) NOT NULL,
  `CHA_MAX` int(11) NOT NULL,
  `US_NOW` int(11) NOT NULL,
  `US_MAX` int(11) NOT NULL,
  `ERRORS` int(11) NOT NULL,
  `START` datetime NOT NULL,
  `LAST_UPDATE` datetime NOT NULL,
  PRIMARY KEY (`ID`,`TITLE`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='tabela de relays' AUTO_INCREMENT=32 ;

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `ID` int(11) NOT NULL COMMENT 'ID from erp_usuarios',
  `NAME` varchar(200) NOT NULL COMMENT 'erp_usuarios: nome + sobrenome',
  `SKEY` varchar(200) NOT NULL COMMENT 'assincronous key',
  `LAST` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date of last sending msg  ',
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`ID`, `NAME`, `SKEY`, `LAST`) VALUES
(2, 'Willian Rafael César', 'RcGJ68O7-PWAXip>7{b4!NNgU/YQ(.=Fo+#%85lx', '2015-11-11 15:32:36'),
(4, 'Jefferson dos Santos e Silva', 'X*/$I*JR@[%.ntUD$fcgXM/-=3C:v08yy6r3[z4D', '2015-11-05 21:31:31');

DROP TABLE IF EXISTS `user_group`;
CREATE TABLE IF NOT EXISTS `user_group` (
  `IDUSER` int(11) NOT NULL,
  `IDGROUP` int(11) NOT NULL,
  `LASTMSG` double NOT NULL,
  `LASTDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `USER` (`IDUSER`,`IDGROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User in groups';

INSERT INTO `user_group` (`IDUSER`, `IDGROUP`, `LASTMSG`, `LASTDATE`) VALUES
(1, 1, 257, '2015-11-09 07:38:49'),
(1, 4, 0, '2015-10-12 21:41:59'),
(1, 9, 255, '2015-11-09 07:38:51'),
(1, 10, 0, '2015-10-12 16:47:12'),
(1, 11, 0, '2015-10-11 00:24:43'),
(1, 13, 0, '2015-10-12 16:46:13'),
(1, 14, 0, '2015-10-12 16:46:13'),
(1, 15, 117, '2015-10-23 03:54:48'),
(1, 16, 139, '2015-10-25 03:30:56'),
(1, 17, 195, '2015-10-27 06:35:36'),
(2, 1, 257, '2015-11-09 07:38:23'),
(2, 3, 142, '2015-11-09 03:58:28'),
(2, 9, 260, '2015-11-09 07:41:50'),
(3, 9, 197, '2015-10-28 19:31:17'),
(3, 10, 0, '2015-10-11 00:24:43'),
(3, 12, 0, '2015-10-11 00:24:43'),
(3, 18, 0, '2015-10-11 00:24:43'),
(4, 1, 227, '2015-11-05 21:28:32'),
(4, 2, 0, '2015-10-11 00:24:43'),
(4, 6, 0, '2015-10-11 00:24:43'),
(4, 7, 0, '2015-10-11 00:24:43'),
(4, 8, 0, '2015-10-11 00:24:43'),
(5, 1, 123, '2015-10-25 01:47:12'),
(5, 5, 0, '2015-10-11 00:24:43'),
(6, 3, 142, '2015-10-27 05:55:34'),
(6, 7, 0, '2015-10-25 03:11:55'),
(7, 3, 140, '2015-10-25 03:12:12'),
(7, 7, 0, '2015-10-25 03:11:32'),
(8, 3, 142, '2015-11-09 02:38:17');

DROP VIEW IF EXISTS `view_group_by_user`;
CREATE TABLE IF NOT EXISTS `view_group_by_user` (
`ID` int(11)
,`LASTMSG` double
,`LASTDATE` timestamp
,`GID` int(10) unsigned
,`PAR` int(11)
,`NAME` varchar(200)
,`ABOUT` text
,`MSG` bigint(21)
,`TOTAL` bigint(21)
);

DROP VIEW IF EXISTS `view_msg_from_users`;
CREATE TABLE IF NOT EXISTS `view_msg_from_users` (
`ID` int(11)
,`NAME` varchar(200)
,`TYPE` enum('msg','img','file')
,`LAST` timestamp
,`TOTAL` bigint(21)
);

DROP TABLE IF EXISTS `view_group_by_user`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_group_by_user` AS select `user_group`.`IDUSER` AS `ID`,`user_group`.`LASTMSG` AS `LASTMSG`,`user_group`.`LASTDATE` AS `LASTDATE`,`groups`.`ID` AS `GID`,`groups`.`PAR` AS `PAR`,`groups`.`NAME` AS `NAME`,`groups`.`ABOUT` AS `ABOUT`,(select count(`messages`.`ID`) from `messages` where ((`messages`.`TOGROUP` = `GID`) and (`messages`.`ID` > `user_group`.`LASTMSG`))) AS `MSG`,(select count(`messages`.`ID`) from `messages` where (`messages`.`TOGROUP` = `GID`)) AS `TOTAL` from ((`user_group` join `users`) join `groups`) where ((`users`.`ID` = `user_group`.`IDUSER`) and (`groups`.`ID` = `user_group`.`IDGROUP`)) order by `groups`.`PAR` desc;

DROP TABLE IF EXISTS `view_msg_from_users`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_msg_from_users` AS select `messages`.`IDFROM` AS `ID`,`messages`.`NAMEFROM` AS `NAME`,`messages`.`TYPE` AS `TYPE`,max(`messages`.`SENDDATE`) AS `LAST`,count(`messages`.`ID`) AS `TOTAL` from `messages` where `messages`.`IDFROM` in (select `user_group`.`IDUSER` from `user_group`) group by `messages`.`IDFROM`,`messages`.`TYPE` order by `LAST` desc;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
