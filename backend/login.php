<?php
header("Access-Control-Allow-Origin: *");
session_start();
include "db.php";

$email = $_POST['email'];
$password = $_POST['password'];

$sql = "SELECT * FROM users WHERE email='$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();

    if (password_verify($password, $user['password_hash'])) {
        $_SESSION['user'] = $user['username'];
        echo "Zalogowano!";
    } else {
        echo "Złe hasło";
    }
} else {
    echo "Nie ma takiego użytkownika";
}
?>