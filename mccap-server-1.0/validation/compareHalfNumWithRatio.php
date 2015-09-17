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
                $totalRatio = 0;
                foreach ($ogListArr as $ogList) {
                    $statics = execute($ogList, $paramArr[1], $halfNum);
                    $totalRatio += $statics['overlapRatio'];
                }
                $avgRatio = $totalRatio / $repeat;
                echo $avgRatio;
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
    $paramArr[1] = array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29); //define the idArr1
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
function execute($idArr1, $idArr2, $num) {
    $tmp = getCmpResultWithHalfNum($idArr1, $idArr2, $num);
    $statics = getStaticsForCmpHalfNumWithRatio($tmp);
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