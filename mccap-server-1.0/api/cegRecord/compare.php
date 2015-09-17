<?php
$api_ceg_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$serv_dir = $api_ceg_dir.'../../service/';
require_once $serv_dir.'cegRecordServ.php';
require_once $serv_dir.'organismServ.php';

/*
 * This is api script for comparing CEG record.
 * param, 'id' , a string of organism id.
 * return, records of CEG with JSON format.
 * example, http://yourHost.com/api/cegRecord/compare.php?id=01020304+05060708
 */

/**
 * Init function of API.
 */
function init() {
    if(($idArrGroup = parseParam()) && validateParam($idArrGroup[0]) && validateParam($idArrGroup[1])) {
        execute($idArrGroup);
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
        $idGroup = explode(" ", $param);
        $idArrGroup = array();
        foreach ($idGroup as $idStr) {
            $idArr = array();
            $id = str_split($idStr, 2);
            foreach ($id as $k => $v) {
                array_push($idArr, $v);
            }
            array_push($idArrGroup, $idArr);
        }
        return $idArrGroup;
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
 * @param type $idArrGroup
 */
function execute($idArrGroup) {
    $tmp = getCompareResult($idArrGroup[0], $idArrGroup[1]);
    $result['status'] = 0;
    $result['data'] = $tmp;
    $result['statics'] = getCompareStatics($tmp);
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