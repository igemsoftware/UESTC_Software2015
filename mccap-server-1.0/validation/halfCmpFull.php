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
        $repeat = $paramArr[2];
        for($i = 4; $i <30; $i++) {
            $ogListArr = getRandOgList(1, 29, $i, $repeat);
            $total1 = 0;
            $total2 = 0;
            foreach ($ogListArr as $ogList) {
                echo json_encode($ogList);
                echo '<br>';
                $statics = execute($ogList, $paramArr[0], $paramArr[1]);
                $total1 += $statics[0]['count'];
                $total2 += $statics[1]['count'];
            }
            $avg1 = $total1 / $repeat;
            $avg2 = $total2 / $repeat;
            
            echo '1/2 --- ' . (string)$avg1 . '<br>';
            echo '1   --- ' . (string)$avg2 . '<br>';
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
    $paramArr[0] = 1/2; //define the harfNum
    $paramArr[1] = 1; //define the harfNum
    $paramArr[2] = 10; //define num of repeat
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
function execute($idArr, $halfNum1, $halfNum2) {
    $tmp1 = getMgsPureCegWithHalfNum($idArr, $halfNum1);
    $tmp2 = getMgsPureCegWithHalfNum($idArr, $halfNum2);
    $statics = getStaticsForHalfCmpFull($tmp1, $tmp2);
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