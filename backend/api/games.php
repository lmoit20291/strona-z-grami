<?php

header("Access-Control-Allow-Origin: *");

$conn = new mysqli("localhost", "root", "", "strona_z_grami");

if ($conn->connect_error) {
    die("Błąd połączenia: " . $conn->connect_error);
}

$result = $conn->query("SELECT * FROM games");

$games = [];

while ($row = $result->fetch_assoc()) {
    $games[] = $row;
}

echo json_encode($games);