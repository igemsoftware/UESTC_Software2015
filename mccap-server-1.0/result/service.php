<?php
$result_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$serv_dir = $result_dir . '../service/';
$data_dir = $result_dir . '../data/';
require_once $serv_dir.'cegRecordServ.php';
require_once $serv_dir.'organismServ.php';
require_once $serv_dir.'util.php';

function getCogFuncStatics($mgsInfo) {
    $cogFunCate = getCogFunCate();
    $statics = array();
    $total = 0;
    $totalvali = 0;
    foreach ($cogFunCate as $row) {
        $item = array(
            'alphabet' => $row['alphabet'],
            'function' => $row['function'],
            'count' => 0,
        );
        array_push($statics, $item);
    }
    foreach ($mgsInfo as $row) {
        $cogId = $row['cogid'];
        for($i = 0; $i < count($statics); $i++) {
            if($cogId[7] == $statics[$i]['alphabet']) {
                $total ++;
                $statics[$i]['count'] = $statics[$i]['count'] + 1;
            }
        }
    }
    for ($i = 0; $i < count($statics); $i++) {
        $totalvali += $statics[$i]['count'];
    }
//    echo $total;
//    echo '---';
//    echo $totalvali;
    return $statics;
}

function getCegBaseSatics($cegBase) {
    $cogFunCate = getCogFunCate();
    $statics = array();
    $total = 0;
    $totalvali = 0;
    foreach ($cogFunCate as $row) {
        $item = array(
            'alphabet' => $row['alphabet'],
            'function' => $row['function'],
            'count' => 0,
            'ratio' => 0,
        );
        array_push($statics, $item);
    }
    foreach ($cegBase as $row) {
        $cogId = $row['cogid'];
        if (strlen($cogId) > 7) {
            for ($i = 0; $i < count($statics); $i++) {
                if ($cogId[7] == $statics[$i]['alphabet']) {
                    $total ++;
                    $statics[$i]['count'] = $statics[$i]['count'] + 1;
                }
            }
        }
    }
    for ($i = 0; $i < count($statics); $i++) {
        $statics[$i]['ratio'] = number_format($statics[$i]['count'] / $total, 4);
        $totalvali += $statics[$i]['count'];
    }
//    echo $total;
//    echo '---';
//    echo $totalvali;
    return $statics;
}