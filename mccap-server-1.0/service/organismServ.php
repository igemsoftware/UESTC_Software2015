<?php
$serv_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$data_dir = $serv_dir.'../data/';
require_once $data_dir.'organismDA.php';

/*
 * This is php script for the service function of organism.
 */

/**
 * Get array of organism ID.
 * @return type
 */
function getOgIDArr() {
    $result = array();
    $tmpRs = queryOgID();
    foreach ($tmpRs as $row) {
        array_push($result, $row['organismid']);
    }
    return $result;
}

/**
 * Validate organism ID.
 * @param type $id
 * @return boolean
 */
function validateOgID($id) {
    $idArr = getOgIDArr();
    if(in_array($id, $idArr)) {
        return TRUE;
    }  else {
        return FALSE;
    }
}

/**
 * Validate an array of organism ID.
 * @param type $idArr
 * @return boolean
 */
function validateOgIDArr($idArr) {
    $arrLen = count($idArr, COUNT_NORMAL);
    if(!is_array($idArr)) {
        $error = 'An Error has occurred in parameter.';
        return FALSE;
    }elseif ($arrLen < 4) {
        $error = 'An Error has occurred in parameter.';
        return FALSE;
    }elseif ($arrLen != count(array_unique($idArr))) {
        $error = 'An Error has occurred in parameter.';
        return FALSE;
    }  else {
        $flag = 1;
        foreach ($idArr as $id) {
            if(!validateOgID($id)) {
                $flag = 0;
            }
        }
        if($flag == 0) {
            return FALSE;
        }  else {
            return TRUE;
        }
    }
}