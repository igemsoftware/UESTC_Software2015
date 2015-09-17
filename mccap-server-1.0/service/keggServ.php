<?php
$serv_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$data_dir = $serv_dir.'../data/';
require_once "cegRecordServ.php";

/*
 * This is php script for the service function of KEGG.
 */

/**
 * Get KO number of clusters.
 * @param type $clusterArr
 * @return type
 */
function getKOByCegArr($clusterArr) {
    $result = array();
    $cegBase = queryAllCegBase();
    $str = '---';
    foreach ($cegBase as $row) {
        $koId = $row['koid'];
        if(in_array($row['access_num'], $clusterArr) && strcmp($koId, $str)) {
            array_push($result, $koId);
        }
    }
    return $result;
}

/**
 * Get KO number by an array of organism ID.
 * @param type $idArr
 * @return type
 */
function getKOByIdArr($idArr) {
    $clusterArr = getMgsPureCeg($idArr);
    return getKOByCegArr($clusterArr);
}

/**
 * Get KO number of metabolism clusters by an array of organism ID.
 * @param type $idArr
 * @return type
 */
function getMetaKOByIdArr($idArr) {
    $clusterArr = array();
    $cegBaseArr = getCegBaseByIdArr($idArr);
    foreach ($cegBaseArr as $row) {
        if(deterCegBaseCate($row) == 1) {
            array_push($clusterArr, $row['access_num']);
        }
    }
    return getKOByCegArr($clusterArr);
}

/**
 * Get the url of Module from KEGG.
 * @param type $koArr
 * @return string
 */
function getModuleUrl($koArr) {
    $preUrl = 'http://www.kegg.jp/kegg-bin/search_module_object?org_name=ko&amp;unclassified=';
    $param = '';
    $count = count($koArr);
    $i = 0;
    foreach ($koArr as $ko) {
        $i ++;
        $param = $param . $ko;
        if($i < $count) {
            $param = $param . '%20';
        } 
    }
    $url = $preUrl . $param;
    return $url;
}

/**
 * Get the url of pathway from KEGG.
 * @param type $koArr
 * @return string
 */
function getPathwayUrl($koArr) {
    $preUrl = 'http://www.kegg.jp/kegg-bin/search_pathway_object?org_name=ko&amp;unclassified=';
    $param = '';
    $count = count($koArr);
    $i = 0;
    foreach ($koArr as $ko) {
        $i ++;
        $param = $param . $ko;
        if($i < $count) {
            $param = $param . '%20';
        } 
    }
    $url = $preUrl . $param;
    return $url;
}


