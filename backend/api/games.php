<?php
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once __DIR__ . '/../config/db.php';

try {
    $conn = get_db_connection();

    $q = trim($_GET['q'] ?? '');
    $category = trim($_GET['category'] ?? '');
    $sort = trim($_GET['sort'] ?? 'newest');

    $allowedSort = [
        'newest' => 'g.created_at DESC',
        'popular' => 'g.play_count DESC, g.title ASC',
        'rating' => 'average_rating DESC, g.title ASC',
        'title' => 'g.title ASC'
    ];

    $orderBy = $allowedSort[$sort] ?? $allowedSort['newest'];

    $sql = "
        SELECT
            g.id,
            g.title,
            g.slug,
            c.name AS category,
            g.short_description,
            g.description,
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
        WHERE g.is_active = 1
    ";

    $params = [];
    $types = '';

    if ($q !== '') {
        $sql .= " AND (g.title LIKE ? OR g.short_description LIKE ? OR g.description LIKE ?)";
        $searchValue = '%' . $q . '%';
        $params[] = $searchValue;
        $params[] = $searchValue;
        $params[] = $searchValue;
        $types .= 'sss';
    }

    if ($category !== '') {
        $sql .= " AND c.slug = ?";
        $params[] = $category;
        $types .= 's';
    }

    $sql .= " ORDER BY {$orderBy}";

    $stmt = $conn->prepare($sql);

    if (!empty($params)) {
        $stmt->bind_param($types, ...$params);
    }

    $stmt->execute();
    $result = $stmt->get_result();

    $games = [];
    while ($row = $result->fetch_assoc()) {
        $row['tags'] = $row['tags'] !== '' ? explode(', ', $row['tags']) : [];
        $games[] = $row;
    }

    echo json_encode([
        'success' => true,
        'count' => count($games),
        'data' => $games
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
} catch (Throwable $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Błąd podczas pobierania gier.',
        'error' => $e->getMessage()
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
}
