<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
include "../db.php";

$sql = "SELECT * FROM v_games_catalog";
$result = $conn->query($sql);

$games = [];

while ($row = $result->fetch_assoc()) {
    $games[] = $row;
}

echo json_encode($games);
?>