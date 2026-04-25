<?php
$host = "sql2.7m.pl";
$user = "stronagrami_strona-z-grami";
$password = "Haslo123";
$db = "stronagrami_strona-z-grami";

$conn = new mysqli($host, $user, $password, $db);

if ($conn->connect_error) {
    die("Błąd połączenia: " . $conn->connect_error);
}
?>