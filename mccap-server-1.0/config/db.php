<?php
/**
 * get a PDO object by config
 * @return \PDO
 */
function getPDO() {
    $dsn = "mysql:host=HostName;dbname=DBName";
    $username = "YourUsername";
    $pwd = "YourPassword";
    try {
        $pdo = new PDO($dsn, $username, $pwd);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $pdo->exec('SET NAMES "utf8"');
    } catch (Exception $ex) {
        $error = 'Unabel to connect to the database server.';
        exit();
    }
    return $pdo;
}

