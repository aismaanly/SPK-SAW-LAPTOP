-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2025 at 06:41 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spk_laptop`
--

-- --------------------------------------------------------

--
-- Table structure for table `alternatif`
--

CREATE TABLE `alternatif` (
  `id_alternatif` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `alternatif`
--

INSERT INTO `alternatif` (`id_alternatif`, `nama`) VALUES
(1, 'ASUS Vivobook 14'),
(2, 'ASUS Vivobook 15'),
(3, 'ASUS ZenBook 14'),
(4, 'ASUS ZenBook 15'),
(5, 'ASUS TUF Gaming F15'),
(6, 'ASUS ROG Zephyrus G14'),
(7, 'Acer Swift 3'),
(8, 'Acer Aspire 5'),
(9, 'Acer Nitro 5'),
(10, 'Acer Predator Helios 16'),
(11, 'Lenovo IdeaPad Slim 5'),
(12, 'Lenovo IdeaPad 5 Pro'),
(13, 'Lenovo Legion 5'),
(14, 'Lenovo ThinkPad X1 Carbon'),
(15, 'Lenovo ThinkPad T14'),
(16, 'HP Pavilion 15'),
(17, 'HP Envy 13'),
(18, 'HP Envy 15'),
(19, 'HP OMEN 16'),
(20, 'HP Spectre x360 14'),
(21, 'Dell XPS 13'),
(22, 'Dell XPS 15'),
(23, 'Dell Inspiron 14'),
(24, 'Dell G15 Gaming'),
(25, 'Microsoft Surface Laptop 5'),
(26, 'Microsoft Surface Laptop Studio'),
(27, 'Microsoft Surface Pro 9'),
(28, 'Acer Aspire Lite'),
(29, 'Acer Swift Go 14'),
(30, 'ASUS Vivobook Go 14'),
(31, 'ASUS Zenbook Duo'),
(32, 'ASUS ROG Strix SCAR 16'),
(33, 'ASUS ROG Flow X13'),
(34, 'Lenovo Yoga Slim 7'),
(35, 'Lenovo Yoga 7i'),
(36, 'Lenovo Legion Slim 7'),
(37, 'HP Victus 15'),
(38, 'HP Victus 16'),
(39, 'HP EliteBook 840 G10'),
(40, 'HP EliteBook 640 G10'),
(41, 'Dell Latitude 5440'),
(42, 'Dell Vostro 15'),
(43, 'Dell Alienware M16 R2'),
(44, 'Dell Inspiron 16 Plus'),
(45, 'MSI Katana 15'),
(46, 'MSI Cyborg 15'),
(47, 'MSI Stealth 16 Studio'),
(48, 'MSI Prestige 14 Evo'),
(49, 'MSI Raider GE78'),
(50, 'Apple MacBook Air'),
(51, 'Apple MacBook Pro 14');

-- --------------------------------------------------------

--
-- Table structure for table `hasil`
--

CREATE TABLE `hasil` (
  `id_alternatif` int(11) NOT NULL,
  `nilai` decimal(10,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hasil`
--

INSERT INTO `hasil` (`id_alternatif`, `nilai`) VALUES
(1, '0.4628'),
(2, '0.4893'),
(3, '0.7183'),
(4, '0.3978'),
(5, '0.5629'),
(6, '0.5861'),
(7, '0.4415'),
(8, '0.4010'),
(9, '0.4793'),
(10, '0.6252'),
(11, '0.5360'),
(12, '0.5898'),
(13, '0.6582'),
(14, '0.5530'),
(15, '0.4876'),
(16, '0.4603'),
(17, '0.4856'),
(18, '0.5619'),
(19, '0.7051'),
(20, '0.6408'),
(21, '0.7062'),
(22, '0.6457'),
(23, '0.4767'),
(24, '0.7014'),
(25, '0.4492'),
(26, '0.4432'),
(27, '0.4292'),
(28, '0.4254'),
(29, '0.5906'),
(30, '0.3456'),
(31, '0.7401'),
(32, '0.8955'),
(33, '0.7633'),
(34, '0.6851'),
(35, '0.5602'),
(36, '0.8206'),
(37, '0.5295'),
(38, '0.6731'),
(39, '0.5237'),
(40, '0.4924'),
(41, '0.4738'),
(42, '0.4254'),
(43, '0.8206'),
(44, '0.7353'),
(45, '0.6348'),
(46, '0.5286'),
(47, '0.7510'),
(48, '0.6888'),
(49, '0.9604'),
(50, '0.2773'),
(51, '0.5046');

-- --------------------------------------------------------

--
-- Table structure for table `kriteria`
--

CREATE TABLE `kriteria` (
  `id_kriteria` int(11) NOT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `jenis` varchar(10) NOT NULL,
  `kode_kriteria` varchar(10) DEFAULT NULL,
  `bobot` decimal(10,3) DEFAULT 0.000
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kriteria`
--

INSERT INTO `kriteria` (`id_kriteria`, `keterangan`, `jenis`, `kode_kriteria`, `bobot`) VALUES
(1, 'Harga', 'Cost', 'C1', '0.044'),
(2, 'Processor', 'Benefit', 'C2', '0.350'),
(3, 'RAM', 'Benefit', 'C3', '0.243'),
(4, 'VGA', 'Benefit', 'C4', '0.163'),
(5, 'Storage', 'Benefit', 'C5', '0.118'),
(6, 'Baterai', 'Benefit', 'C6', '0.082');

-- --------------------------------------------------------

--
-- Table structure for table `kriteria_ahp`
--

CREATE TABLE `kriteria_ahp` (
  `id_kriteria_1` int(11) NOT NULL,
  `id_kriteria_2` int(11) NOT NULL,
  `nilai_1` double(10,5) NOT NULL,
  `nilai_2` double(10,5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kriteria_ahp`
--

INSERT INTO `kriteria_ahp` (`id_kriteria_1`, `id_kriteria_2`, `nilai_1`, `nilai_2`) VALUES
(1, 2, 0.20000, 5.00000),
(1, 3, 0.20000, 5.00000),
(1, 4, 0.33333, 3.00000),
(1, 5, 0.33333, 3.00000),
(1, 6, 0.33333, 3.00000),
(2, 3, 3.00000, 0.33333),
(2, 4, 3.00000, 0.33333),
(2, 5, 3.00000, 0.33333),
(2, 6, 3.00000, 0.33333),
(3, 4, 3.00000, 0.33333),
(3, 5, 3.00000, 0.33333),
(3, 6, 3.00000, 0.33333),
(4, 5, 3.00000, 0.33333),
(4, 6, 3.00000, 0.33333),
(5, 6, 3.00000, 0.33333);

-- --------------------------------------------------------

--
-- Table structure for table `penilaian`
--

CREATE TABLE `penilaian` (
  `id_penilaian` int(11) NOT NULL,
  `id_alternatif` int(11) NOT NULL,
  `id_kriteria` int(11) NOT NULL,
  `nilai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `penilaian`
--

INSERT INTO `penilaian` (`id_penilaian`, `id_alternatif`, `id_kriteria`, `nilai`) VALUES
(1, 1, 1, 3),
(2, 1, 2, 18),
(3, 1, 3, 24),
(4, 1, 4, 29),
(5, 1, 5, 43),
(6, 1, 6, 48),
(7, 2, 1, 4),
(8, 2, 2, 18),
(9, 2, 3, 25),
(10, 2, 4, 29),
(11, 2, 5, 43),
(12, 2, 6, 48),
(13, 3, 1, 8),
(14, 3, 2, 21),
(15, 3, 3, 26),
(16, 3, 4, 31),
(17, 3, 5, 43),
(18, 3, 6, 55),
(19, 4, 1, 8),
(20, 4, 2, 13),
(21, 4, 3, 25),
(22, 4, 4, 32),
(23, 4, 5, 43),
(24, 4, 6, 54),
(25, 5, 1, 4),
(26, 5, 2, 18),
(27, 5, 3, 25),
(28, 5, 4, 32),
(29, 5, 5, 43),
(30, 5, 6, 51),
(31, 6, 1, 12),
(32, 6, 2, 18),
(33, 6, 3, 25),
(34, 6, 4, 33),
(35, 6, 5, 43),
(36, 6, 6, 54),
(37, 7, 1, 4),
(38, 7, 2, 15),
(39, 7, 3, 25),
(40, 7, 4, 31),
(41, 7, 5, 43),
(42, 7, 6, 51),
(43, 8, 1, 3),
(44, 8, 2, 16),
(45, 8, 3, 24),
(46, 8, 4, 29),
(47, 8, 5, 43),
(48, 8, 6, 49),
(49, 9, 1, 4),
(50, 9, 2, 17),
(51, 9, 3, 24),
(52, 9, 4, 32),
(53, 9, 5, 43),
(54, 9, 6, 51),
(55, 9, 1, 4),
(56, 9, 2, 17),
(57, 9, 3, 24),
(58, 9, 4, 32),
(59, 9, 5, 43),
(60, 9, 6, 51),
(61, 10, 1, 7),
(62, 10, 2, 19),
(63, 10, 3, 24),
(64, 10, 4, 33),
(65, 10, 5, 45),
(66, 10, 6, 57),
(67, 11, 1, 3),
(68, 11, 2, 18),
(69, 11, 3, 25),
(70, 11, 4, 29),
(71, 11, 5, 43),
(72, 11, 6, 51),
(73, 12, 1, 4),
(74, 12, 2, 19),
(75, 12, 3, 25),
(76, 12, 4, 31),
(77, 12, 5, 43),
(78, 12, 6, 52),
(79, 13, 1, 7),
(80, 13, 2, 19),
(81, 13, 3, 25),
(82, 13, 4, 34),
(83, 13, 5, 43),
(84, 13, 6, 56),
(85, 14, 1, 11),
(86, 14, 2, 18),
(87, 14, 3, 25),
(88, 14, 4, 31),
(89, 14, 5, 45),
(90, 14, 6, 51),
(91, 15, 1, 9),
(92, 15, 2, 17),
(93, 15, 3, 25),
(94, 15, 4, 31),
(95, 15, 5, 43),
(96, 15, 6, 50),
(97, 16, 1, 3),
(98, 16, 2, 17),
(99, 16, 3, 24),
(100, 16, 4, 31),
(101, 16, 5, 43),
(102, 16, 6, 48),
(103, 17, 1, 5),
(104, 17, 2, 16),
(105, 17, 3, 25),
(106, 17, 4, 31),
(107, 17, 5, 43),
(108, 17, 6, 53),
(109, 18, 1, 4),
(110, 18, 2, 18),
(111, 18, 3, 25),
(112, 18, 4, 31),
(113, 18, 5, 45),
(114, 18, 6, 50),
(115, 19, 1, 12),
(116, 19, 2, 20),
(117, 19, 3, 25),
(118, 19, 4, 35),
(119, 19, 5, 43),
(120, 19, 6, 56),
(121, 20, 1, 9),
(122, 20, 2, 20),
(123, 20, 3, 25),
(124, 20, 4, 31),
(125, 20, 5, 45),
(126, 20, 6, 53),
(127, 21, 1, 12),
(128, 21, 2, 21),
(129, 21, 3, 26),
(130, 21, 4, 31),
(131, 21, 5, 45),
(132, 21, 6, 51),
(133, 22, 1, 12),
(134, 22, 2, 19),
(135, 22, 3, 25),
(136, 22, 4, 33),
(137, 22, 5, 43),
(138, 22, 6, 57),
(139, 23, 1, 3),
(140, 23, 2, 17),
(141, 23, 3, 24),
(142, 23, 4, 31),
(143, 23, 5, 43),
(144, 23, 6, 50),
(145, 24, 1, 7),
(146, 24, 2, 20),
(147, 24, 3, 25),
(148, 24, 4, 34),
(149, 24, 5, 43),
(150, 24, 6, 57),
(151, 25, 1, 6),
(152, 25, 2, 16),
(153, 25, 3, 25),
(154, 25, 4, 31),
(155, 25, 5, 43),
(156, 25, 6, 49),
(157, 26, 1, 8),
(158, 26, 2, 15),
(159, 26, 3, 25),
(160, 26, 4, 32),
(161, 26, 5, 43),
(162, 26, 6, 51),
(163, 27, 1, 5),
(164, 27, 2, 16),
(165, 27, 3, 25),
(166, 27, 4, 31),
(167, 27, 5, 41),
(168, 27, 6, 49),
(169, 28, 1, 3),
(170, 28, 2, 16),
(171, 28, 3, 24),
(172, 28, 4, 31),
(173, 28, 5, 43),
(174, 28, 6, 48),
(175, 29, 1, 5),
(176, 29, 2, 19),
(177, 29, 3, 25),
(178, 29, 4, 31),
(179, 29, 5, 43),
(180, 29, 6, 53),
(181, 30, 1, 3),
(182, 30, 2, 16),
(183, 30, 3, 24),
(184, 30, 4, 29),
(185, 30, 5, 39),
(186, 30, 6, 48),
(187, 31, 1, 10),
(188, 31, 2, 21),
(189, 31, 3, 26),
(190, 31, 4, 31),
(191, 31, 5, 45),
(192, 31, 6, 55),
(193, 32, 1, 12),
(194, 32, 2, 22),
(195, 32, 3, 26),
(196, 32, 4, 36),
(197, 32, 5, 47),
(198, 32, 6, 57),
(199, 33, 1, 12),
(200, 33, 2, 21),
(201, 33, 3, 26),
(202, 33, 4, 34),
(203, 33, 5, 45),
(204, 33, 6, 52),
(205, 34, 1, 8),
(206, 34, 2, 21),
(207, 34, 3, 25),
(208, 34, 4, 31),
(209, 34, 5, 45),
(210, 34, 6, 54),
(211, 35, 1, 6),
(212, 35, 2, 18),
(213, 35, 3, 25),
(214, 35, 4, 31),
(215, 35, 5, 43),
(216, 35, 6, 54),
(217, 36, 1, 12),
(218, 36, 2, 21),
(219, 36, 3, 26),
(220, 36, 4, 35),
(221, 36, 5, 45),
(222, 36, 6, 57),
(223, 37, 1, 3),
(224, 37, 2, 18),
(225, 37, 3, 25),
(226, 37, 4, 32),
(227, 37, 5, 39),
(228, 37, 6, 50),
(229, 38, 1, 8),
(230, 38, 2, 19),
(231, 38, 3, 25),
(232, 38, 4, 35),
(233, 38, 5, 43),
(234, 38, 6, 56),
(235, 39, 1, 8),
(236, 39, 2, 18),
(237, 39, 3, 25),
(238, 39, 4, 31),
(239, 39, 5, 43),
(240, 39, 6, 50),
(241, 40, 1, 6),
(242, 40, 2, 17),
(243, 40, 3, 25),
(244, 40, 4, 31),
(245, 40, 5, 43),
(246, 40, 6, 50),
(247, 51, 1, 12),
(248, 51, 2, 18),
(249, 51, 3, 25),
(250, 51, 4, 28),
(251, 51, 5, 43),
(252, 51, 6, 54),
(253, 41, 1, 7),
(254, 41, 2, 17),
(255, 41, 3, 25),
(256, 41, 4, 31),
(257, 41, 5, 43),
(258, 41, 6, 48),
(259, 42, 1, 3),
(260, 42, 2, 16),
(261, 42, 3, 24),
(262, 42, 4, 31),
(263, 42, 5, 43),
(264, 42, 6, 48),
(265, 43, 1, 12),
(266, 43, 2, 21),
(267, 43, 3, 26),
(268, 43, 4, 35),
(269, 43, 5, 45),
(270, 43, 6, 57),
(271, 44, 1, 10),
(272, 44, 2, 19),
(273, 44, 3, 26),
(274, 44, 4, 34),
(275, 44, 5, 45),
(276, 44, 6, 57),
(277, 45, 1, 6),
(278, 45, 2, 19),
(279, 45, 3, 25),
(280, 45, 4, 34),
(281, 45, 5, 45),
(282, 45, 6, 50),
(283, 46, 1, 5),
(284, 46, 2, 17),
(285, 46, 3, 25),
(286, 46, 4, 33),
(287, 46, 5, 43),
(288, 46, 6, 50),
(289, 47, 1, 11),
(290, 47, 2, 19),
(291, 47, 3, 26),
(292, 47, 4, 35),
(293, 47, 5, 45),
(294, 47, 6, 57),
(295, 48, 1, 6),
(296, 48, 2, 21),
(297, 48, 3, 25),
(298, 48, 4, 31),
(299, 48, 5, 45),
(300, 48, 6, 54),
(301, 49, 1, 12),
(302, 49, 2, 22),
(303, 49, 3, 27),
(304, 49, 4, 37),
(305, 49, 5, 47),
(306, 49, 6, 57),
(307, 50, 1, 7),
(308, 50, 2, 13),
(309, 50, 3, 24),
(310, 50, 4, 28),
(311, 50, 5, 43),
(312, 50, 6, 53);

-- --------------------------------------------------------

--
-- Table structure for table `perhitungan`
--

CREATE TABLE `perhitungan` (
  `id_perhitungan` int(11) NOT NULL,
  `id_alternatif` int(11) NOT NULL,
  `nilai_total` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE `profile` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`id`, `nama`, `email`) VALUES
(1, 'SPK AHP-SAW', 'Sistem Pendukung Keputusan menggunakan metode AHP dan SAW.');

-- --------------------------------------------------------

--
-- Table structure for table `sub_kriteria`
--

CREATE TABLE `sub_kriteria` (
  `id_sub_kriteria` int(11) NOT NULL,
  `deskripsi` varchar(100) DEFAULT NULL,
  `id_kriteria` int(11) NOT NULL,
  `nilai` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sub_kriteria`
--

INSERT INTO `sub_kriteria` (`id_sub_kriteria`, `deskripsi`, `id_kriteria`, `nilai`) VALUES
(3, '< 12.500.000 (Sangat Murah)', 1, 1),
(4, '12.500.000 - 14.999.999	(Murah)', 1, 2),
(5, '15.000.000 - 17.499.999	(Agak Murah)', 1, 3),
(6, '17.500.000 - 19.999.999	(Sedang Bawah)', 1, 4),
(7, '20.000.000 - 22.499.999	(Sedang Atas)', 1, 5),
(8, '22.500.000 - 24.999.999 (Agak Mahal Menengah)', 1, 6),
(9, '25.000.000 - 27.499.999 (Agak Mahal Tinggi)', 1, 7),
(10, '27.500.000 - 29.999.999 (Mahal Menengah)', 1, 8),
(11, '30.000.000 - 32.499.999 (Mahal Tinggi)', 1, 9),
(12, '>= 32.500.000 (Sangat Mahal)', 1, 10),
(13, 'Basic (Paling Rendah)', 2, 1),
(14, 'Low-End Modern (Sangat Rendah)', 2, 2),
(15, 'Older Basic (Rendah)', 2, 3),
(16, 'Older Mid-Range (Cukup)', 2, 4),
(17, 'Entry/Older High-End (Masih Kuat) ', 2, 5),
(18, 'Mid-Low (Rata-Rata) ', 2, 6),
(19, 'Mid-Range (Cukup Baik) ', 2, 7),
(20, 'Mid-High (Baik) ', 2, 8),
(21, 'High-End (Sangat Baik)', 2, 9),
(22, 'Flagship (Performa Ekstrem)', 2, 10),
(23, '< 8 (Rendah)', 3, 2),
(24, '8 (Cukup) ', 3, 4),
(25, '16 (Baik)', 3, 6),
(26, ' 32 (Sangat Baik)', 3, 8),
(27, '>= 64 (Kapasitas Extreme)', 3, 10),
(28, 'Basic (Paling Rendah) ', 4, 1),
(29, 'Low-End Modern (Sangat Rendah) ', 4, 2),
(30, 'Older Basic (Rendah)', 4, 3),
(31, 'Older Mid-Range (Cukup)', 4, 4),
(32, 'Entry/Older High-End (Masih Kuat)', 4, 5),
(33, 'Mid-Low (Rata-Rata)', 4, 6),
(34, 'Mid-Range (Cukup Baik)', 4, 7),
(35, 'Mid-High (Baik)', 4, 8),
(36, 'High-End (Sangat Baik)', 4, 9),
(37, 'Flagship (Performa Ekstrem)', 4, 10),
(38, 'Paling Rendah', 5, 1),
(39, 'Cukup, Kecepatan Standar', 5, 2),
(40, 'Kapasitas Besar, Kecepatan Standar', 5, 3),
(41, 'Cukup (Entry Level NVMe)', 5, 4),
(42, 'Standar Modern', 5, 5),
(43, 'Standar Modern & Cepat', 5, 6),
(44, 'Sangat Baik', 5, 7),
(45, 'Sangat Baik & Cepat', 5, 8),
(46, 'Kapasitas Maksimal', 5, 9),
(47, 'Kapasitas Maksimal & Sangat Cepat', 5, 10),
(48, '< 45 (Paling Rendah)', 6, 1),
(49, '45 - 49 (Sangat Kurang)', 6, 2),
(50, '50 - 54 (Kurang)', 6, 3),
(51, '55 - 59 (Agak Kurang)', 6, 4),
(52, '60 - 64 (Sedang)', 6, 5),
(53, '65 - 69 (Rata-rata)', 6, 6),
(54, '70 - 74 (Cukup Baik)', 6, 7),
(55, '75 - 79 (Baik)', 6, 8),
(56, '80 - 84 (Sangat Baik)', 6, 9),
(57, '>=85 (Sangat Tahan Lama)', 6, 10);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_user_level` int(11) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `id_user_level`, `nama`, `email`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 1, 'Admin', 'admin@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `user_level`
--

CREATE TABLE `user_level` (
  `id` int(11) NOT NULL,
  `nama_level` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alternatif`
--
ALTER TABLE `alternatif`
  ADD PRIMARY KEY (`id_alternatif`);

--
-- Indexes for table `kriteria`
--
ALTER TABLE `kriteria`
  ADD PRIMARY KEY (`id_kriteria`);

--
-- Indexes for table `kriteria_ahp`
--
ALTER TABLE `kriteria_ahp`
  ADD PRIMARY KEY (`id_kriteria_1`,`id_kriteria_2`);

--
-- Indexes for table `penilaian`
--
ALTER TABLE `penilaian`
  ADD PRIMARY KEY (`id_penilaian`);

--
-- Indexes for table `perhitungan`
--
ALTER TABLE `perhitungan`
  ADD PRIMARY KEY (`id_perhitungan`);

--
-- Indexes for table `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_kriteria`
--
ALTER TABLE `sub_kriteria`
  ADD PRIMARY KEY (`id_sub_kriteria`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `user_level`
--
ALTER TABLE `user_level`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alternatif`
--
ALTER TABLE `alternatif`
  MODIFY `id_alternatif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `kriteria`
--
ALTER TABLE `kriteria`
  MODIFY `id_kriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `penilaian`
--
ALTER TABLE `penilaian`
  MODIFY `id_penilaian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=313;

--
-- AUTO_INCREMENT for table `perhitungan`
--
ALTER TABLE `perhitungan`
  MODIFY `id_perhitungan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `profile`
--
ALTER TABLE `profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sub_kriteria`
--
ALTER TABLE `sub_kriteria`
  MODIFY `id_sub_kriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_level`
--
ALTER TABLE `user_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
