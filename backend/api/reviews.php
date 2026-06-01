<?php

require_once("../db.php");

$game_id = $_GET['game_id'] ?? 0;


$sql = "
SELECT users.username, reviews.comment
FROM reviews
JOIN users ON reviews.user_id = users.id
WHERE reviews.game_id = $game_id
ORDER BY reviews.created_at DESC
";

$result = $conn->query($sql);

$reviews = [];

while($row = $result->fetch_assoc()) {
    $reviews[] = $row;
}

header('Content-Type: application/json');
echo json_encode($reviews);