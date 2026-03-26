<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: text/plain");

include "db.php";

$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];

$passwordHash = password_hash($password, PASSWORD_DEFAULT);

$check = $conn->query("SELECT * FROM users WHERE email='$email'");

if ($check->num_rows > 0) {
    echo "Email już istnieje";
    exit;
}

$sql = "INSERT INTO users (username, email, password_hash)
        VALUES ('$username', '$email', '$passwordHash')";

if ($conn->query($sql)) {
    echo "Rejestracja udana";
} else {
    echo "Błąd rejestracji";
}
?>