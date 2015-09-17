<?php
$api_ceg_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$serv_dir = $api_ceg_dir.'../../service/';
require_once $serv_dir.'cegRecordServ.php';
require_once $serv_dir.'organismServ.php';

/*
 * This is api script for fetching CEG record.
 * param, 'id' , a string of organism id.
 * return, records of CEG with JSON format.
 * example, http://yourHost.com/api/cegRecord/fetchCeg.php?id=01020304
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
    if (isset($_GET['id'])) {
        $param = trim($_GET['id']);
        $id = str_split($param, 2);
        $idArr = array();
        foreach ($id as $k => $v) {
            array_push($idArr, intval($v));
        }
        return $idArr;
    } else {
        return FALSE;
    }
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
    $result['status'] = 0;
    $result['data'] = getMgsCegDescCate($idArr);
    echo json_encode($result);
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