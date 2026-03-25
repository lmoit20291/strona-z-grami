<?php

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

function get_db_connection(): mysqli
{
    $conn = new mysqli('localhost', 'root', '', 'strona_z_grami');
    $conn->set_charset('utf8mb4');
    return $conn;
}
