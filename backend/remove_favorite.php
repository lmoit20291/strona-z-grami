<?php

session_start();
require_once("db.php");

if (!isset($_SESSION['user_id'])) {
    die("Musisz być zalogowany");
}

$user_id = $_SESSION['user_id'];
$game_id = (int)$_POST['game_id'];

$conn->query("
DELETE FROM favorites
WHERE user_id = $user_id
AND game_id = $game_id
");

echo "OK";