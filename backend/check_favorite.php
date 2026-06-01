<?php

session_start();
require_once("db.php");

if (!isset($_SESSION['user_id'])) {
    echo "false";
    exit;
}

$user_id = $_SESSION['user_id'];
$game_id = (int)$_GET['game_id'];

$result = $conn->query("
SELECT *
FROM favorites
WHERE user_id = $user_id
AND game_id = $game_id
");

echo ($result->num_rows > 0) ? "true" : "false";