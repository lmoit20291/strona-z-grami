SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') NOT NULL DEFAULT 'user',
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE categories (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE games (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_id INT UNSIGNED NOT NULL,
    title VARCHAR(150) NOT NULL,
    slug VARCHAR(170) NOT NULL UNIQUE,
    short_description VARCHAR(255) NOT NULL,
    description TEXT NULL,
    thumbnail VARCHAR(255) NULL,
    game_url VARCHAR(255) NOT NULL,
    source_type ENUM('file', 'link') NOT NULL DEFAULT 'file',
    play_count INT UNSIGNED NOT NULL DEFAULT 0,
    is_featured TINYINT(1) NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_by INT UNSIGNED NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_games_category FOREIGN KEY (category_id) REFERENCES categories(id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_games_created_by FOREIGN KEY (created_by) REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    INDEX idx_games_title (title),
    INDEX idx_games_category (category_id),
    INDEX idx_games_created_at (created_at),
    INDEX idx_games_popular (play_count)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tags (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(60) NOT NULL UNIQUE,
    slug VARCHAR(70) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE game_tags (
    game_id INT UNSIGNED NOT NULL,
    tag_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (game_id, tag_id),
    CONSTRAINT fk_game_tags_game FOREIGN KEY (game_id) REFERENCES games(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_game_tags_tag FOREIGN KEY (tag_id) REFERENCES tags(id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE favorites (
    user_id INT UNSIGNED NOT NULL,
    game_id INT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, game_id),
    CONSTRAINT fk_favorites_user FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_favorites_game FOREIGN KEY (game_id) REFERENCES games(id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE reviews (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    game_id INT UNSIGNED NOT NULL,
    rating TINYINT UNSIGNED NULL,
    comment TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uq_reviews_user_game UNIQUE (user_id, game_id),
    CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_reviews_game FOREIGN KEY (game_id) REFERENCES games(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    INDEX idx_reviews_game (game_id),
    INDEX idx_reviews_rating (rating)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELIMITER //
CREATE TRIGGER reviews_before_insert
BEFORE INSERT ON reviews
FOR EACH ROW
BEGIN
    IF NEW.rating IS NULL AND (NEW.comment IS NULL OR CHAR_LENGTH(TRIM(NEW.comment)) = 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocena lub komentarz są wymagane.';
    END IF;

    IF NEW.rating IS NOT NULL AND (NEW.rating < 1 OR NEW.rating > 5) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocena musi być w zakresie 1-5.';
    END IF;
END //

CREATE TRIGGER reviews_before_update
BEFORE UPDATE ON reviews
FOR EACH ROW
BEGIN
    IF NEW.rating IS NULL AND (NEW.comment IS NULL OR CHAR_LENGTH(TRIM(NEW.comment)) = 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocena lub komentarz są wymagane.';
    END IF;

    IF NEW.rating IS NOT NULL AND (NEW.rating < 1 OR NEW.rating > 5) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ocena musi być w zakresie 1-5.';
    END IF;
END //
DELIMITER ;

INSERT INTO users (username, email, password_hash, role) VALUES
('admin', 'admin@stronazgrami.local', '$2y$12$kTSKfOifTPlc/1nS.0vwoe.VM9f3Zo9KqaUwmh/.65YEgaFyXZ.3u', 'admin'),
('gracz1', 'gracz1@stronazgrami.local', '$2y$12$4JFIKPeOO/OBGYSlItVppenAmLgosp9zPVStbzne4f5imW81Ebkx2', 'user');

INSERT INTO categories (name, slug, description) VALUES
('Logiczne', 'logiczne', 'Gry rozwijające myślenie i planowanie.'),
('Zręcznościowe', 'zrecznosciowe', 'Dynamiczne gry wymagające refleksu.'),
('Edukacyjne', 'edukacyjne', 'Gry uczące poprzez zabawę.'),
('Arcade', 'arcade', 'Klasyczne gry przeglądarkowe w szybkim stylu.'),
('Strategiczne', 'strategiczne', 'Gry o planowaniu i podejmowaniu decyzji.');

INSERT INTO games (category_id, title, slug, short_description, description, thumbnail, game_url, source_type, play_count, is_featured, is_active, created_by, created_at) VALUES
(2, 'Snake', 'snake', 'Klasyczna gra Snake w wersji przeglądarkowej.', 'Steruj wężem, zbieraj punkty i unikaj kolizji ze ścianą oraz własnym ogonem.', '/games/snake/solid_snake.jpg', '/games/snake/index.html', 'file', 256, 1, 1, 1, '2026-03-15 12:00:00'),
(1, '2048', '2048', 'Połącz kafelki i zdobądź liczbę 2048.', 'Logiczna gra polegająca na łączeniu identycznych wartości w większe liczby.', NULL, '/games/2048/index.html', 'file', 334, 1, 1, 1, '2026-03-16 12:00:00'),
(1, 'Memory Match', 'memory-match', 'Znajdź pary kart w jak najmniejszej liczbie ruchów.', 'Gra pamięciowa, idealna do szybkiej rozgrywki i ćwiczenia koncentracji.', 'https://placehold.co/600x400?text=Memory+Match', '/games/placeholder/index.html?game=memory-match', 'file', 118, 0, 1, 1, '2026-03-17 12:00:00'),
(3, 'Quiz Matematyczny', 'quiz-matematyczny', 'Krótki quiz do ćwiczenia działań matematycznych.', 'Sprawdź swoje umiejętności rachunkowe i popraw szybkość liczenia.', 'https://placehold.co/600x400?text=Quiz+Matematyczny', '/games/placeholder/index.html?game=quiz-matematyczny', 'file', 74, 0, 1, 1, '2026-03-18 12:00:00'),
(1, 'Tic Tac Toe', 'tic-tac-toe', 'Kółko i krzyżyk w prostym wydaniu online.', 'Rozegraj szybką partię i spróbuj pokonać przeciwnika.', 'https://placehold.co/600x400?text=Tic+Tac+Toe', '/games/placeholder/index.html?game=tic-tac-toe', 'file', 153, 0, 1, 1, '2026-03-19 12:00:00'),
(2, 'Flappy Pixel', 'flappy-pixel', 'Omijaj przeszkody i utrzymaj się jak najdłużej.', 'Zręcznościowa gra w stylu endless runner z prostym sterowaniem.', 'https://placehold.co/600x400?text=Flappy+Pixel', '/games/placeholder/index.html?game=flappy-pixel', 'file', 198, 0, 1, 1, '2026-03-20 12:00:00'),
(1, 'Sudoku Mini', 'sudoku-mini', 'Małe sudoku do szybkiego rozwiązania.', 'Krótka wersja sudoku przeznaczona do rozgrywki w przeglądarce.', 'https://placehold.co/600x400?text=Sudoku+Mini', '/games/placeholder/index.html?game=sudoku-mini', 'file', 92, 0, 1, 1, '2026-03-21 12:00:00'),
(3, 'Typing Challenge', 'typing-challenge', 'Ćwicz szybkie pisanie na klawiaturze.', 'Gra edukacyjna pomagająca poprawić tempo i dokładność pisania.', 'https://placehold.co/600x400?text=Typing+Challenge', '/games/placeholder/index.html?game=typing-challenge', 'file', 67, 0, 1, 1, '2026-03-22 12:00:00');

INSERT INTO tags (id, name, slug) VALUES
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

INSERT INTO game_tags (game_id, tag_id) VALUES
-- Snake (ID: 1) -> Akcja (2), Indie (7)
(1, 2), (1, 7), 
-- 2048 (ID: 2) -> Strategiczne (4), Indie (7)
(2, 4), (2, 7),
-- Memory Match (ID: 3) -> Indie (7)
(3, 7),
-- Quiz Matematyczny (ID: 4) -> Indie (7)
(4, 7),
-- Tic Tac Toe (ID: 5) -> Strategiczne (4), Indie (7)
(5, 4), (5, 7),
-- Flappy Pixel (ID: 6) -> Akcja (2), Indie (7)
(6, 2), (6, 7),
-- Sudoku Mini (ID: 7) -> Strategiczne (4), Indie (7)
(7, 4), (7, 7),
-- Typing Challenge (ID: 8) -> Symulatory (5), Indie (7)
(8, 5), (8, 7);

INSERT INTO favorites (user_id, game_id) VALUES
(2, 1),
(2, 2),
(2, 5);

INSERT INTO reviews (user_id, game_id, rating, comment, created_at) VALUES
(2, 1, 5, 'Bardzo przyjemna klasyczna gra.', '2026-03-20 14:15:00'),
(2, 2, 4, 'Prosta i wciągająca.', '2026-03-20 14:20:00'),
(1, 6, 4, 'Dobra gra na szybką przerwę.', '2026-03-21 11:00:00');

CREATE OR REPLACE VIEW v_games_catalog AS
SELECT
    g.id,
    g.title,
    g.slug,
    c.name AS category,
    g.short_description,
    g.thumbnail,
    g.game_url,
    g.source_type,
    g.play_count,
    g.is_featured,
    g.created_at,
    COALESCE((SELECT ROUND(AVG(r.rating), 2) FROM reviews r WHERE r.game_id = g.id AND r.rating IS NOT NULL), 0) AS average_rating,
    COALESCE((SELECT COUNT(*) FROM favorites f WHERE f.game_id = g.id), 0) AS favorites_count,
    COALESCE((SELECT GROUP_CONCAT(t.name ORDER BY t.name SEPARATOR ', ') FROM game_tags gt JOIN tags t ON t.id = gt.tag_id WHERE gt.game_id = g.id), '') AS tags
FROM games g
JOIN categories c ON c.id = g.category_id
WHERE g.is_active = 1;

SET FOREIGN_KEY_CHECKS = 1;
