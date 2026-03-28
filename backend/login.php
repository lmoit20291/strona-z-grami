<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

include "db.php";

$email = $_POST['email'];
$password = $_POST['password'];

$result = $conn->query("SELECT * FROM users WHERE email='$email'");

if ($result->num_rows === 0) {
    echo "Nie ma takiego użytkownika";
    exit;
}

$user = $result->fetch_assoc();

if (password_verify($password, $user['password_hash'])) {
    $_SESSION['user'] = $user['username'];
    echo "OK";
} else {
    echo "Złe hasło";
}