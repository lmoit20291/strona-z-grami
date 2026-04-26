-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2026 at 10:19 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `strona_z_grami`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `created_at`) VALUES
(1, 'Logiczne', 'logiczne', 'Gry rozwijające myślenie i planowanie.', '2026-04-26 19:06:54'),
(2, 'Zręcznościowe', 'zrecznosciowe', 'Dynamiczne gry wymagające refleksu.', '2026-04-26 19:06:54'),
(3, 'Edukacyjne', 'edukacyjne', 'Gry uczące poprzez zabawę.', '2026-04-26 19:06:54'),
(4, 'Arcade', 'arcade', 'Klasyczne gry przeglądarkowe w szybkim stylu.', '2026-04-26 19:06:54'),
(5, 'Strategiczne', 'strategiczne', 'Gry o planowaniu i podejmowaniu decyzji.', '2026-04-26 19:06:54');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `favorites`
--

CREATE TABLE `favorites` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `game_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`user_id`, `game_id`, `created_at`) VALUES
(2, 1, '2026-04-26 19:06:54'),
(2, 2, '2026-04-26 19:06:54'),
(2, 5, '2026-04-26 19:06:54');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `games`
--

CREATE TABLE `games` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `slug` varchar(170) NOT NULL,
  `short_description` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `game_url` varchar(255) NOT NULL,
  `source_type` enum('file','link') NOT NULL DEFAULT 'file',
  `play_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`id`, `category_id`, `title`, `slug`, `short_description`, `description`, `thumbnail`, `game_url`, `source_type`, `play_count`, `is_featured`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 2, 'Snake', 'snake', 'Klasyczna gra Snake w wersji przeglądarkowej.', 'Steruj wężem, zbieraj punkty i unikaj kolizji ze ścianą oraz własnym ogonem.', '/strona-z-grami/games/snake/solid_snake.jpg', '/games/snake/index.html', 'file', 256, 1, 1, 1, '2026-03-15 11:00:00', '2026-04-26 19:55:30'),
(2, 1, 'Tic Tac Toe', 'tic-tac-toe', 'Kółko i krzyżyk w prostym wydaniu online.', 'Rozegraj szybką partię i spróbuj pokonać przeciwnika.', '/strona-z-grami/games/tictactoe/TicTacToe.jpg', '/games/tictactoe/index.html', 'file', 153, 0, 1, 1, '2026-03-19 11:00:00', '2026-04-26 20:17:49'),
(3, 1, 'Memory Match', 'memory-match', 'Znajdź pary kart w jak najmniejszej liczbie ruchów.', 'Gra pamięciowa, idealna do szybkiej rozgrywki i ćwiczenia koncentracji.', '/strona-z-grami/games/memorymatch/MemoryMatch.jpg', '/games/memorymatch/index.html', 'file', 118, 0, 1, 1, '2026-03-17 11:00:00', '2026-04-26 20:17:41'),
(4, 2, 'Pirate Jump', 'pirate-jump', 'Skacz przez przeszkody jako dzielny pirat.', 'Zręcznościowa gra platformowa, w której wcielasz się w pirata skaczącego przez kolejne przeszkody.', '/strona-z-grami/games/piratejump/Pirate_Jump.jpg', '/games/pirate-jump/index.html', 'file', 0, 0, 1, 1, '2026-04-25 10:00:00', '2026-04-26 19:58:21'),
(5, 1, '2048', '2048', 'Połącz kafelki i zdobądź liczbę 2048.', 'Logiczna gra polegająca na łączeniu identycznych wartości w większe liczby.', '/strona-z-grami/games/2048/2048.jpg', '/games/2048/index.html', 'file', 334, 1, 1, 1, '2026-03-16 11:00:00', '2026-04-26 19:58:33'),
(6, 2, 'Flappy Pixel', 'flappy-pixel', 'Omijaj przeszkody i utrzymaj się jak najdłużej.', 'Zręcznościowa gra w stylu endless runner z prostym sterowaniem.', '/strona-z-grami/games/flappy/flappy.jpg', '/games/flappy/index.html', 'file', 198, 0, 1, 1, '2026-03-20 11:00:00', '2026-04-26 20:00:33'),
(7, 1, 'Sudoku Mini', 'sudoku-mini', 'Małe sudoku do szybkiego rozwiązania.', 'Krótka wersja sudoku przeznaczona do rozgrywki w przeglądarce.', '/strona-z-grami/games/sudoku/sudoku.jpg', '/games/sudoku/index.html', 'file', 92, 0, 1, 1, '2026-03-21 11:00:00', '2026-04-26 20:00:51'),
(8, 3, 'Typing Challenge', 'typing-challenge', 'Ćwicz szybkie pisanie na klawiaturze.', 'Gra edukacyjna pomagająca poprawić tempo i dokładność pisania.', '/strona-z-grami/games/typing/typing.jpg', '/games/typing/index.html', 'file', 67, 0, 1, 1, '2026-03-22 11:00:00', '2026-04-26 20:01:00');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `game_tags`
--

CREATE TABLE `game_tags` (
  `game_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `game_tags`
--

INSERT INTO `game_tags` (`game_id`, `tag_id`) VALUES
(1, 2),
(1, 7),
(2, 4),
(2, 7),
(3, 7),
(4, 2),
(4, 7),
(5, 4),
(5, 7),
(6, 2),
(6, 7),
(7, 4),
(7, 7),
(8, 5),
(8, 7);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `reviews`
--

CREATE TABLE `reviews` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `game_id` int(10) UNSIGNED NOT NULL,
  `rating` tinyint(3) UNSIGNED DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `game_id`, `rating`, `comment`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 5, 'Bardzo przyjemna klasyczna gra.', '2026-03-20 13:15:00', '2026-04-26 19:06:54'),
(2, 2, 5, 4, 'Prosta i wciągająca.', '2026-03-20 13:20:00', '2026-04-26 19:06:54'),
(3, 1, 6, 4, 'Dobra gra na szybką przerwę.', '2026-03-21 10:00:00', '2026-04-26 19:06:54');

--
-- Wyzwalacze `reviews`
--
DELIMITER $$
CREATE TRIGGER `reviews_before_insert` BEFORE INSERT ON `reviews` FOR EACH ROW BEGIN
    IF NEW.rating IS NULL AND (NEW.comment IS NULL OR CHAR_LENGTH(TRIM(NEW.comment)) = 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocena lub komentarz są wymagane.';
    END IF;

    IF NEW.rating IS NOT NULL AND (NEW.rating < 1 OR NEW.rating > 5) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocena musi być w zakresie 1-5.';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `reviews_before_update` BEFORE UPDATE ON `reviews` FOR EACH ROW BEGIN
    IF NEW.rating IS NULL AND (NEW.comment IS NULL OR CHAR_LENGTH(TRIM(NEW.comment)) = 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocena lub komentarz są wymagane.';
    END IF;

    IF NEW.rating IS NOT NULL AND (NEW.rating < 1 OR NEW.rating > 5) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocena musi być w zakresie 1-5.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(60) NOT NULL,
  `slug` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `slug`) VALUES
(1, 'RPG', 'rpg'),
(2, 'Akcja', 'akcja'),
(3, 'Przygodowe', 'przygodowe'),
(4, 'Strategiczne', 'strategiczne'),
(5, 'Symulatory', 'symulatory'),
(6, 'Horror', 'horror'),
(7, 'Indie', 'indie'),
(8, 'FPS', 'fps'),
(9, 'Wyścigowe', 'wyscigowe'),
(10, 'Sportowe', 'sportowe');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@stronazgrami.local', '$2y$12$kTSKfOifTPlc/1nS.0vwoe.VM9f3Zo9KqaUwmh/.65YEgaFyXZ.3u', 'admin', 1, '2026-04-26 19:06:54', '2026-04-26 19:06:54'),
(2, 'gracz1', 'gracz1@stronazgrami.local', '$2y$12$4JFIKPeOO/OBGYSlItVppenAmLgosp9zPVStbzne4f5imW81Ebkx2', 'user', 1, '2026-04-26 19:06:54', '2026-04-26 19:06:54');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `v_games_catalog`
-- (See below for the actual view)
--
CREATE TABLE `v_games_catalog` (
`id` int(10) unsigned
,`title` varchar(150)
,`slug` varchar(170)
,`category` varchar(80)
,`short_description` varchar(255)
,`thumbnail` varchar(255)
,`game_url` varchar(255)
,`source_type` enum('file','link')
,`play_count` int(10) unsigned
,`is_featured` tinyint(1)
,`created_at` timestamp
,`average_rating` decimal(6,2)
,`favorites_count` bigint(21)
,`tags` mediumtext
);

-- --------------------------------------------------------

--
-- Struktura widoku `v_games_catalog`
--
DROP TABLE IF EXISTS `v_games_catalog`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_games_catalog`  AS SELECT `g`.`id` AS `id`, `g`.`title` AS `title`, `g`.`slug` AS `slug`, `c`.`name` AS `category`, `g`.`short_description` AS `short_description`, `g`.`thumbnail` AS `thumbnail`, `g`.`game_url` AS `game_url`, `g`.`source_type` AS `source_type`, `g`.`play_count` AS `play_count`, `g`.`is_featured` AS `is_featured`, `g`.`created_at` AS `created_at`, coalesce((select round(avg(`r`.`rating`),2) from `reviews` `r` where `r`.`game_id` = `g`.`id` and `r`.`rating` is not null),0) AS `average_rating`, coalesce((select count(0) from `favorites` `f` where `f`.`game_id` = `g`.`id`),0) AS `favorites_count`, coalesce((select group_concat(`t`.`name` order by `t`.`name` ASC separator ', ') from (`game_tags` `gt` join `tags` `t` on(`t`.`id` = `gt`.`tag_id`)) where `gt`.`game_id` = `g`.`id`),'') AS `tags` FROM (`games` `g` join `categories` `c` on(`c`.`id` = `g`.`category_id`)) WHERE `g`.`is_active` = 1 ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeksy dla tabeli `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`user_id`,`game_id`),
  ADD KEY `fk_favorites_game` (`game_id`);

--
-- Indeksy dla tabeli `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `fk_games_created_by` (`created_by`),
  ADD KEY `idx_games_title` (`title`),
  ADD KEY `idx_games_category` (`category_id`),
  ADD KEY `idx_games_created_at` (`created_at`),
  ADD KEY `idx_games_popular` (`play_count`);

--
-- Indeksy dla tabeli `game_tags`
--
ALTER TABLE `game_tags`
  ADD PRIMARY KEY (`game_id`,`tag_id`),
  ADD KEY `fk_game_tags_tag` (`tag_id`);

--
-- Indeksy dla tabeli `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_reviews_user_game` (`user_id`,`game_id`),
  ADD KEY `idx_reviews_game` (`game_id`),
  ADD KEY `idx_reviews_rating` (`rating`);

--
-- Indeksy dla tabeli `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `games`
--
ALTER TABLE `games`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `fk_favorites_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_favorites_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `games`
--
ALTER TABLE `games`
  ADD CONSTRAINT `fk_games_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_games_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `game_tags`
--
ALTER TABLE `game_tags`
  ADD CONSTRAINT `fk_game_tags_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_game_tags_tag` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
