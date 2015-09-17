<?php
$validation_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$serv_dir = $validation_dir.'../service/';
require_once $serv_dir.'cegRecordServ.php';
require_once $serv_dir.'organismServ.php';
require_once 'service.php';

/*
 * This is api script for comparing CEG record.
 * param, 'id' , a string of organism id.
 * return, records of CEG with JSON format.
 * example, http://yourHost.com/api/cegRecord/compare.php?id=01020304
 */

/**
 * Init function of API.
 */
function init() {
    if($paramArr = getParam()) {
        $repeat = $paramArr[0];
        for ($i = 1; $i < 101; $i++) {
            $halfNum = $i / 100;
            for($j = 4; $j < 29; $j++) {
                $ogListArr = getRandOgList(1, 29, $j, $repeat);
                $total = 0;
                foreach ($ogListArr as $ogList) {
                    $statics = execute($ogList, $halfNum);
                    $total += $statics['count'];
                }
                $avgNumber = $total / $repeat;
                echo $avgNumber;
                if($j < 28) {
                    echo ',';
                }
            }
            echo '<br>';
        }
    }else {
        printParamErr();
    }
}

/**
 * get the parameter.
 * @return 
 */
function getParam() {
    $paramArr[0] = 10; //define num of repeat
    return $paramArr;
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
function execute($idArr, $num) {
    $tmp = getMgsPureCegWithHalfNum($idArr, $num);
    $statics = getStaticsForCmpHalfNumWithNumber($tmp);
    return $statics;
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