<?php
$serv_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$data_dir = $serv_dir.'../data/';
require_once $data_dir.'cegRecordDA.php';
require_once 'util.php';
require_once 'bioBrickServ.php';

/*
 * This is php script for the service function of CEG record.
 */

/**
 * Get CEG record by a array of organism ID.
 * @param type $idArr
 * @return array
 */
function getCegRecByIDArr($idArr) {
    $arrLen = count($idArr, COUNT_NORMAL);
    $state = 'organismid in (';
    $count = 0;
    foreach ($idArr as $id) {
        $count++;
        if($count != $arrLen) {
            $state = $state . $id . ',';
        }else {
            $state = $state. $id . ')';
        }
    }
    $result = queryCegRecByState($state);
    return $result;
}

/**
 * Get an array of all the access_num.
 * @return array
 */
function getAccessNumArr() {
    $result = array();
    $tmpRs = queryAccessNum();
    foreach ($tmpRs as $row) {
        array_push($result, $row['access_num']);
    }
    return $result;
}

/**
 * Validate access_num.
 * @param type $accessNum
 * @return boolean
 */
function validateAccessNum($accessNum) {
    $accessNumArr = getAccessNumArr();
    if(in_array($accessNum, $accessNumArr)) {
        return TRUE;
    }else {
        return FALSE;
    }
}

/**
 * Find minimal gene set by the half retaining strategy, half number ratio = 0.420.
 * @param type $idArr
 * @return array
 */
function findMgs($idArr) {
    $halfNum = 0.420; //define the half number;
    $totalRecord = getCegRecByIDArr($idArr); //get all of the CEG record by an array of custom organism ID.
    
    $countOg = count($idArr, COUNT_NORMAL);
    $halfCountOg = $countOg * $halfNum; //half num of organisms.
    
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
        }
    }
    //find out the set of clusters which count greater than half_count_og.
    $clusterArr = array();
    $countArr = array();
    foreach ($tmpCountClusterArr as $cluster => $count) {
        if($count > $halfCountOg) {
            $countCluster ++;
            array_push($clusterArr, $cluster);
            array_push($countArr, $count);
        }
    }
    
    $result['cluster_arr'] = $clusterArr;
    $result['count_arr'] = $countArr;
    $result['cluster_num'] = $countCluster;
    $result['total_record'] = $totalRecord;
    return $result;
}

/**
 * Get the cluster information only of minimal gene set.
 * @param type $idArr
 * @return array
 */
function getMgsPureCeg($idArr) {
    $tmp = findMgs($idArr);
    $result = $tmp['cluster_arr'];
    return $result;
}

/**
 * Get CEG base record, each cluster with a description.
 * @param type $idArr
 * @return array
 */
function getCegBaseByIdArr($idArr) {
    $result = array();
    $clusterArr = getMgsPureCeg($idArr);
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
 * @return array
 */
function getMgsCegDescCate($idArr) {
    $result = array();
    $tmp = getCegBaseByIdArr($idArr);
    foreach ($tmp as $row) {
        $cegDescCate['cluster'] = $row['access_num'];
        $cegDescCate['description'] = $row['description'];
        $cegDescCate['category'] = deterCegBaseCate($row);
        array_push($result, $cegDescCate);
    }
    return $result;
}
/**
 * Get all record of ceg base table.
 * @return array
 */
function getAllCegBase() {
    return queryAllCegBase();
}

/**
 * get a piece of record of ceg base table by Access_num, it means get information of a gene cluster.
 * @param type $accessNum
 * @return array
 */
function getCegBaseByAccessNum($accessNum) {
    $tmp = queryCegBaseByAccessNum($accessNum);
    return $tmp[0];
}

/**
 * Get information of a minimal gene set by array of reference species ID.
 * @param type $idArr
 * @return array
 */
function getMgsInfo($idArr) {
    $result = array();
    $tmp = getCegBaseByIdArr($idArr);
    foreach ($tmp as $row) {
        $cegInfo['access_num'] = $row['access_num'];
        $cegInfo['koid'] = $row['koid'];
        $cegInfo['cogid'] = $row['cogid'];
        $cegInfo['ec'] = $row['ec'];
        $cegInfo['description'] = $row['description'];
        $cegInfo['category'] = cate2Name(deterCegBaseCate($row));
        array_push($result, $cegInfo);
    }
    return $result;
}

/**
 * Download minimal gene set data with XML format.
 * @param type $idArr
 */
function downloadMgsXML($idArr) {
    header("Content-type: application/octet-stream;charset=gbk");
    header("Content-Disposition: attachment; filename=ceg_filtered.xml");
    $tmp = getMgsInfo($idArr);
    $br = "\n";
    $t = "\t";
    
    echo '<Minimal_Gene_Set>' . $br;
    foreach ($tmp as $row) {
        echo '<Gene_cluster>' . $br;
        echo $t . '<Access_num>' . $row['access_num'] . '</Access_num>' . $br;
        echo $t . '<Ko_id>' . $row['koid'] . '</Ko_id>' . $br;
        echo $t . '<Cog_id>' . $row['cogid'] . '</Cog_id>' . $br;
        echo $t . '<Ec>' . $row['ec'] . '</Ec>' . $br;
        echo $t . '<Description>' . $row['description'] . '</Description>' . $br;
        echo $t . '<Category>' . $row['category'] . '</Category>' . $br;
        echo '</Gene_cluster>' . $br;
    }
    echo '</Minimal_Gene_Set>';
}

/**
 * Download minimal gene set data with CSV format.
 * @param type $idArr
 */
function downloadMgsCSV($idArr) {
    header("Content-type: application/octet-stream;charset=gbk");
    header("Content-Disposition: attachment; filename=ceg_filtered.csv");
    $tmp = getMgsInfo($idArr);
    $br = "\r\n";
    $t = "\t";
    
    echo '"Access_num","koid","cogid","ec","Description","Category"'.$br;
    foreach ($tmp as $row) {
        echo '"' . $row['access_num'] . '","' . $row['koid'] . '","' . $row['cogid'] . '","' . $row['ec'] . '","' . $row['description'] . '","' . $row['category'] . '"' . $br;
    }
}

/**
 * Compare two minimal gene sets by arraies of their reference species ID.
 * @param type $idArr1
 * @param type $idArr2
 * @return int
 */
function compareTwoMgs($idArr1, $idArr2) {
    $result = array();
    $data1 = getMgsCegDescCate($idArr1);
    $data2 = getMgsCegDescCate($idArr2);
    foreach ($data1 as $row) {
        $cluster = $row["cluster"];
        $rsRow["cluster"] = $cluster;
        $rsRow["description"] = $row["description"];
        $rsRow["category"] = $row["category"];
        $rsRow["group"] = 1;
        $result[$cluster] = $rsRow;
    }
    foreach ($data2 as $row) {
        $cluster = $row["cluster"];
        if (!isset($result[$cluster])) {
            $rsRow["cluster"] = $cluster;
            $rsRow["description"] = $row["description"];
            $rsRow["category"] = $row["category"];
            $rsRow["group"] = 2;
            $result[$cluster] = $rsRow;
        } else {
            $result[$cluster]["group"] = 3;
        }
    }
    return $result;
}

/**
 * Get result of an compare process.
 * @param type $idArr1
 * @param type $idArr2
 * @return array
 */
function getCompareResult($idArr1, $idArr2) {
    $result = array();
    $tmp = compareTwoMgs($idArr1, $idArr2);
    foreach ($tmp as $row) {
        array_push($result, $row);
    }
    return $result;
}

/**
 * Get statics result of an compare process.
 * @param type $compareRs
 * @return string
 */
function getCompareStatics($compareRs) {
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

/**
 * Get correspongding nucleic acid sequence by gene id
 * @param type $gid
 * @return array
 */
function getNaSeq($gid) {
    $seqs = queryNaSeq($gid);
    return $seqs[0]['naseq'];
}

/**
 * Get a plain nucleic acid sequence by gene id.
 * @param type $gid
 * @return String
 */
function getPlainNaSeq($gid) {
    $seqs = queryNaSeq($gid);
    $seq = $seqs[0]["naseq"];
    $seq = str_replace("\r\n", "", $seq);
    return $seq;
}

/**
 * Get all pain nuclerc acid sequence from database.
 * @return array
 */
function getAllPlainNaSeq() {
    $seqs = queryAllNaSeq();
    foreach ($seqs as $seq) {
        $seq["naseq"] = str_replace("\r\n", "", $seq["naseq"]);
    }
    return $seqs;
}

/**
 * Get all annotations of gene from database.
 * @return array
 */
function getAllAnnotation() {
    return queryAllAnnotation();
}

/**
 * get gid of gene by Access_num.
 * @param type $accessNum
 * @return array
 */
function getGidByAccessNum($accessNum) {
    $tmp = queryGidByAccessNum($accessNum);
    $result = array();
    foreach ($tmp as $row) {
        array_push($result, $row['gid']);
    }
    return $result;
}

/**
 * get all nucleic acid sequence by Access_num
 * @param type $accessNum
 * @return array
 */
function getNaSeqByAccessNum($accessNum) {
    $result = array();
    $gidArr = getGidByAccessNum($accessNum);
    foreach ($gidArr as $gid) {
        $naSeq = getNaSeq($gid);
        array_push($result, $naSeq);
    }
    return $result;
}

/**
 * get snnotation of a gene by access_num.
 * @param type $gid
 * @return array
 */
function getAnnotationByGid($gid) {
    $result = queryAnnotationByGid($gid);
    return $result[0];
}


