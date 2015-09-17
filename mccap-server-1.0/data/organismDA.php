<?php
$data_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$config_dir = $data_dir.'../config/';
require_once $config_dir.'db.php';

/*
 * Data access from database.
 * This is a simple php script for querying the data/record about organism.
 * corresponding column:
 * organismid,
 */

/**
 * Query all the ID of organisms.
 * @return Array
 */
function queryOgID() {
    $pdo = getPDO();
    try{
        $sql = 'select organismid from reference';
        $ps = $pdo->prepare($sql);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = 'An Error has occurred in data accessing.';
        exit();
    }
    return $result;
}