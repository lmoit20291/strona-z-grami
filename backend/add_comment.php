<?php

session_start();
require_once("db.php");

if (!isset($_SESSION['user_id'])) {
    die("Musisz być zalogowany");
}

$user_id = $_SESSION['user_id'];
$game_id = $_POST['game_id'];
$comment = $_POST['comment'];

$sql = "
INSERT INTO reviews (user_id, game_id, comment)
VALUES ($user_id, $game_id, '$comment')
";

if ($conn->query($sql)) {
    echo "Komentarz dodany";
} else {
    echo "Błąd";
}