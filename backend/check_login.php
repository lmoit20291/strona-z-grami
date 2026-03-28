<?php
session_start();

if (isset($_SESSION['user'])) {
    echo "logged";
} else {
    echo "not_logged";
}
?>