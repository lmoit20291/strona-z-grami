<?php
$host = "localhost";
$user = "root";
$password = "";
$db = "strona_z_grami";

$conn = new mysqli($host, $user, $password, $db);

if ($conn->connect_error) {
    die("Błąd połączenia: " . $conn->connect_error);
}
?>