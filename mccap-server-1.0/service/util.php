<?php
$serv_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$data_dir = $serv_dir.'../data/';
$config_dir = $serv_dir.'../config/';
require_once $config_dir.'main.php';

/*
 * This is php script for the common functions.
 */

/**
 * Validate the ID of cog
 * @param type $cogId
 * @return boolean
 */
function validateCogId($cogId) {
    if(strlen($cogId) > 7) {
        return TRUE;
    }  else {
        return FALSE;
    }
}

/**
 * Determine if the category of cluster is transport and metabolism.
 * @param type $cogId
 * @return boolean
 */
function isTranMeta($cogId) {
    $alphabet = array('D', 'E', 'F', 'G', 'H', 'I', 'P');
    if(validateCogId($cogId) && in_array($cogId[7], $alphabet)) {
        return TRUE;
    }else {
        return FALSE;
    }
}

/**
 * Determine if the category of cluster is transcription and translation.
 * @param type $cogId
 * @return boolean
 */
function is2Tran($cogId) {
    $alphabet = array('J', 'K', 'L');
    if(validateCogId($cogId) && in_array($cogId[7], $alphabet)) {
        return TRUE;
    }else {
        return FALSE;
    }
}

/**
 * Determine if the category of cluster is General function prediction only.
 * @param type $cogId
 * @return boolean
 */
function isGFPO($cogId) {
    $alphabet = array('R');
    if(validateCogId($cogId) && in_array($cogId[7], $alphabet)) {
        return TRUE;
    }else {
        return FALSE;
    }
}

/**
 * Determine the category of cluster by COG ID.
 * @param type $cogId
 * @return int
 */
function determineCategory($cogId) {
    if(isTranMeta($cogId)) {
        return 1; // transport and metabolism
    }else if(is2Tran($cogId)) {
        return 2; // transcription and translation
    }else if(isGFPO($cogId)) {
        return 3; // general function prediction only
    }else {
        return 4; // others
    }
}

/**
 * Determine the category of ceg_base.
 * @param type $cegBase
 * @return type
 */
function deterCegBaseCate($cegBase) {
    $cogId = $cegBase['cogid'];
    return determineCategory($cogId);
}

/**
 * trsnsform number of category to category name.
 * @param type $category
 * @return string
 */
function cate2Name($category) {
    $categoryName = '';
    if($category == 1) {
        $categoryName = 'Transport & Metabolism';
    }elseif ($category == 2) {
        $categoryName = 'Transcription & Translation';
    }elseif ($category == 3) {
        $categoryName = 'General function prediction only';
    }elseif ($category == 4) {
        $categoryName = 'Others';
    }
    return $categoryName;
}

/**
 * Transform an array of reference species to String.
 * @param type $arr
 * @return string
 */
function idArr2Str($arr) {
    $str = "";
    for($i = 0;$i < count($arr);$i++) {
        $str = $str . idNum2Str($arr[$i]);
    }
    return $str;
}

/**
 * Transform the id of reference species to String.
 * @param type $id
 * @return type
 */
function idNum2Str($id) {
    $str = "";
    if($id < 10) {
        $str = "0" . (String)$id;
    }  else {
        $str = (String)$id;
    }
    return $str;
}

/**
 * Get the url of corresponding page. for gene network diagram.
 * @param type $pageName
 * @param type $idArr
 * @return string
 */
function getPageUrl($pageName, $idArr = array(1 ,2, 3, 4)) {
    $host = getHost();
    $param = idArr2Str($idArr);
    switch ($pageName) {
        case "entirePathway":
            $preUrl = "/mccap-server/app/page/mapEntirePathway.php?id=";
            break;
        case "metaPathway":
            $preUrl = "/mccap-server/app/page/mapMetaPathway.php?id=";
            break;
        case "entireModule":
            $preUrl = "/mccap-server/app/page/mapEntireModule.php?id=";
            break;
        case  "metaModule":
            $preUrl = "/mccap-server/app/page/mapMetaModule.php?id=";
            break;
        default:
            $preUrl = "/mccap-server/app/page/error.php";
            $param = "";
            break;
    }
    $url = $host . $preUrl . $param;
    return $url;
}

/**
 * get an detailed information of a biobrick by their name.
 * @param type $bbkName
 * @return String
 */
function getBbkUrl($bbkName) {
    $preUrl = "http://parts.igem.org/Part:";
    return $preUrl . $bbkName;
}

/**
 * get categories of COG function.
 * @return array
 */
function getCogFunCate() {
    $funcCate = array(
        0 => array('alphabet' => 'A', 'function' => 'RNA processing and modification'),
        1 => array('alphabet' => 'B', 'function' => 'Chromatin structure and dynamics'),
        2 => array('alphabet' => 'C', 'function' => 'Energy production and conversion'),
        3 => array('alphabet' => 'D', 'function' => 'Cell division and chromosome partitioning'),
        4 => array('alphabet' => 'E', 'function' => 'Amino acid transport and metabolism'),
        5 => array('alphabet' => 'F', 'function' => 'Nucleotide transport and metabolism'),
        6 => array('alphabet' => 'G', 'function' => 'Carbohydrate transport and metabolism'),
        7 => array('alphabet' => 'H', 'function' => 'Coenzyme metabolism'),
        8 => array('alphabet' => 'I', 'function' => 'Lipid metabolism'),
        9 => array('alphabet' => 'J', 'function' => 'Translation, ribosomal structure and biogenes'),
        10 => array('alphabet' => 'K', 'function' => 'Transcription'),
        11 => array('alphabet' => 'L', 'function' => 'DNA replication, recombination repair'),
        12 => array('alphabet' => 'M', 'function' => 'Cell envelope biogenesis, outer membrane'),
        13 => array('alphabet' => 'N', 'function' => 'Cell motility and secretion'),
        14 => array('alphabet' => 'O', 'function' => 'Posttranslational modification, protein turno'),
        15 => array('alphabet' => 'P', 'function' => 'Inorganic ion transport and metabolism'),
        16 => array('alphabet' => 'Q', 'function' => 'Secondary metabolites biosynthesis, transport'),
        17 => array('alphabet' => 'R', 'function' => 'General function prediction only'),
        18 => array('alphabet' => 'S', 'function' => 'Function unknown'),
        19 => array('alphabet' => 'T', 'function' => 'Signal transduction mechanisms'),
        20 => array('alphabet' => 'U', 'function' => 'Intracellular trafficking, secretion, and ves'),
        21 => array('alphabet' => 'V', 'function' => 'Defense mechanisms'),
        22 => array('alphabet' => 'W', 'function' => 'Extracellular structures'),
        23 => array('alphabet' => 'Y', 'function' => 'Nuclear structures'),
        24 => array('alphabet' => 'Z', 'function' => 'Cytoskeleton'),
    );
    return $funcCate;
}


