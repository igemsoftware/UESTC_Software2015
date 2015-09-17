<?php
$validation_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$serv_dir = $validation_dir . '../service/';
require_once $serv_dir.'cegRecordServ.php';
require_once $serv_dir.'organismServ.php';
require_once $serv_dir.'util.php';

/**
 * Find clusters of essential gene with a custom number.
 * @param type $idArr
 * @return int
 */
function findMgsWithHalfNum($idArr, $num) {
    $totalRecord = getCegRecByIDArr($idArr); //get all of the CEG record by an array of custom organism ID.
    
    $countOg = count($idArr, COUNT_NORMAL);
    $halfCountOg = $countOg * $num; //half num of organisms.
    
    $countCluster = 0; //used to count the number of cluster included in the result.
    
    $tmpCountClusterArr = array();
    $clusterOgArr = array();
    
    //count for every cluster.
    foreach ($totalRecord as $row) {
        $accessNum = $row['access_num'];
        $organismId = $row['organismid'];
        if(!isset($clusterOgArr[$accessNum])) {
            $clusterOgArr[$accessNum] = array(); //prepare an empty array for new cluster to store organism included.
        }
        if(!in_array($organismId, $clusterOgArr[$accessNum])) {
            if(isset($tmpCountClusterArr[$accessNum])) {
                $tmpCountClusterArr[$accessNum] ++; //the count of this cluster plus one.
            } else {
                $tmpCountClusterArr[$accessNum] = 1; //assign a initialization value for new cluster.
            }
            array_push($clusterOgArr[$accessNum], $organismId);
//            $cluster_og_arr[$access_num][] = $organism_id;
        }
    }
    //find out the set of clusters which count greater than half_count_og.
    $clusterArr = array();
    $countArr = array();
    foreach ($tmpCountClusterArr as $cluster => $count) {
        if($count >= $halfCountOg) {
            $countCluster ++;
            array_push($clusterArr, $cluster);
            array_push($countArr, $count);
        }
    }
    
    $result['access_num_arr'] = $clusterArr;
    $result['count_arr'] = $countArr;
    $result['cluster_num'] = $countCluster;
    $result['total_record'] = $totalRecord;
    return $result;
}

/**
 * Get the cluster only.
 * @param type $idArr
 * @return type
 */
function getMgsPureCegWithHalfNum($idArr, $num) {
    $tmp = findMgsWithHalfNum($idArr, $num);
    $result = $tmp['access_num_arr'];
    return $result;
}

/**
 * Get CEG base record, each cluster with a description.
 * @param type $idArr
 * @return type
 */
function getCegBaseByIdArrWithHalfNum($idArr, $num) {
    $result = array();
    $clusterArr = getMgsPureCegWithHalfNum($idArr, $num);
    $cegBase = queryAllCegBase();
    foreach ($cegBase as $row) {
        if(in_array($row['access_num'], $clusterArr)) {
            array_push($result, $row);
        }
    }
    return $result;
}

/**
 * Get a set of record with cluster, description and category.
 * @param type $idArr
 * @return type
 */
function getMgsCegDescCateWithHalfNum($idArr, $num) {
    $result = array();
    $tmp = getCegBaseByIdArrWithHalfNum($idArr, $num);
    foreach ($tmp as $row) {
        $ceg_desc_cate['access_num'] = $row['access_num'];
        $ceg_desc_cate['description'] = $row['description'];
        $ceg_desc_cate['category'] = deterCegBaseCate($row);
        array_push($result, $ceg_desc_cate);
    }
    return $result;
}

function compareTwoMgsWithHalfNum($idArr1, $idArr2, $num) {
    $result = array();
    $accessNumArr1 = getMgsPureCegWithHalfNum($idArr1, $num);
    $accessNumArr2 = getMgsPureCegWithHalfNum($idArr2, $num);
    foreach ($accessNumArr1 as $accessNum) {
        $rsRow["access_num"] = $accessNum;
        $rsRow["group"] = 1;
        $result[$accessNum] = $rsRow;
    }
    foreach ($accessNumArr2 as $accessNum) {
        if (!isset($result[$accessNum])) {
            $rsRow["access_num"] = $accessNum;
            $rsRow["group"] = 2;
            $result[$accessNum] = $rsRow;
        } else {
            $result[$accessNum]["group"] = 3;
        }
    }
    return $result;
}

function getCmpResultWithHalfNum($idArr1, $idArr2, $num) {
    $result = array();
    $tmp = compareTwoMgsWithHalfNum($idArr1, $idArr2, $num);
    foreach ($tmp as $row) {
        array_push($result, $row);
    }
    return $result;
}

function getValidateStatics($compareRs) {
    $result = array();
    $total = 0;
    $group1 = 0;
    $group2 = 0;
    $both = 0;
    foreach ($compareRs as $row) {
        $total++;
        switch ($row["group"]) {
            case 1:
                $group1++;
                break;
            case 2:
                $group2++;
                break;
            case 3:
                $both++;
                break;
        }
    }
    $overlapRatio = number_format($both / $total * 100, 2) . "%";
    $result["total"] = $total;
    $result["group1"] = $group1;
    $result["group2"] = $group2;
    $result["both"] = $both;
    $result["overlapRatio"] = $overlapRatio;
    return $result;
}

function getStaticsForHalfCmpFull($pureCegArr1, $pureCegArr2) {
    $result[0]['count'] = count($pureCegArr1);
    $result[1]['count'] = count($pureCegArr2);
    return $result;
}

function getStaticsForCmpHalfNumWithNumber($pureCegArr) {
    $result['count'] = count($pureCegArr);
    return $result;
}

function getStaticsForCmpHalfNumWithRatio($compareRs) {
    $result = array();
    $total = 0;
    $group1 = 0;
    $group2 = 0;
    $both = 0;
    foreach ($compareRs as $row) {
        $total++;
        switch ($row["group"]) {
            case 1:
                $group1++;
                break;
            case 2:
                $group2++;
                break;
            case 3:
                $both++;
                break;
        }
    }
    $overlapRatio = number_format($both / $total, 2);
    $result["overlapRatio"] = $overlapRatio;
    return $result;
}

function getRandOgList($minId, $maxId, $ogNum, $listNum = 1) {
    $result = array();
    for ($i = 0; $i < $listNum; $i++) {
        $arr = range($minId, $maxId);
        shuffle($arr);
        $ogList = array_slice($arr, 0, $ogNum);
        array_push($result, $ogList);
    }
    return $result;
}