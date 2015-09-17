<?php
$result_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$serv_dir = $result_dir.'../service/';
require_once $serv_dir.'cegRecordServ.php';
require_once $serv_dir.'organismServ.php';
require_once 'service.php';

/*
 * This is a script to generate results for iGEM Game.
 */

/**
 * Init function of API.
 */
function init() {
    if(($idArr = parseParam()) && validateParam($idArr)) {
        execute($idArr);
    }else {
        printParamErr();
    }
}

/**
 * Parse the parameter.
 * @return 
 */
function parseParam() {
    return array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29);
}

/**
 * Validate parameter.
 * @param type $idArr
 * @return boolean
 */
function validateParam($idArr) {
    if((count($idArr) > 3) && (count($idArr) == count(array_unique($idArr))) && validateOgIDArr($idArr)) {
        return TRUE;
    }  else {
        return FALSE;
    }
}

/**
 * main service function.
 * @param type $idArr
 */
function execute($idArr) {
    $cegBase = getAllCegBase();
//    print_r($cegBase);
    $statics = getCegBaseSatics($cegBase);
    foreach ($statics as $row) {
        echo '"' . $row['function'] . ' (' . $row['alphabet'] . ')",';
    }
    echo '<br>';
    foreach ($statics as $row) {
        echo $row['ratio'] . ',';
    }
}

/**
 * print the error info. 
 */
function printParamErr() {
    $err['status'] = 1;
    $err['error'] = 'An error has occurred in parameter.';
    echo json_encode($err);
}

init();