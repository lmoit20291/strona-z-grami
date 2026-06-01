<?php

require_once("../config/db.php");

$game_id = $_GET['game_id'] ?? 0;

$sql = "
SELECT comment
FROM reviews
WHERE game_id = $game_id
ORDER BY created_at DESC
";

$result = $conn->query($sql);

$reviews = [];

while($row = $result->fetch_assoc()) {
    $reviews[] = $row;
}

header('Content-Type: application/json');
echo json_encode($reviews);
?>