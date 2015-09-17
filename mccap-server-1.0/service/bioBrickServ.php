<?php
$serv_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$data_dir = $serv_dir . '../data/';
require_once $data_dir .'cegRecordDA.php';
require_once $data_dir . 'bioBrickDA.php';
require_once 'util.php';

/*
 * This is php script for the service function of BioBrick.
 */

/**
 * get information of RFC10 assembly standard.
 * @return Array
 */
function getRFC10() {
    $rfc10 = array();
    $restrictionSites = array(
        "EcoR1" => "gaattc",
        "Xba1" => "tctaga",
        "Spe1" => "actagt",
        "Pst1" => "ctgcag",
        "Not1" => "gcggccgc",
    );
    $rfc10["restrictionSites"] = $restrictionSites;
    return $rfc10;
}

/**
 * get information of RFC12 assembly standard.
 * @return Array
 */
function getRFC12() {
    $rfc12 = array();
    $restrictionSites = array(
        "EcoR1" => "gaattc",
        "Spe1" => "actagt",
        "Nhe1" => "gctagc",
        "Pst1" => "ctgcag",
        "Not1" => "gcggccgc",
        "Pvu2" => "cagctg",
        "Xho1" => "ctcgag",
        "Avr2" => "cctagg",
        "Xba1" => "tctaga",
        "sap1" => "gctcttc",
        "sap1_2" => "gaagagc",
    );
    $rfc12["restrictionSites"] = $restrictionSites;
    return $rfc12;
}

/**
 * get information of RFC21 assembly standard.
 * @return Array
 */
function getRFC21() {
    $rfc21 = array();
    $restrictionSites = array(
        "EcoR1" => "gaattc",
        "Bg3" => "agatct",
        "BamH1" => "ggattc",
        "Xho1" => "ctcgag",
    );
    $rfc21["restrictionSites"] = $restrictionSites;
    return $rfc21;
}

/**
 * get information of RFC23 assembly standard.
 * @return Array
 */
function getRFC23() {
    $rfc23 = array();
    $restrictionSites = array(
        "EcoR1" => "gaattc",
        "Xba1" => "tctaga",
        "Spe1" => "actagt",
        "Pst1" => "ctgcag",
        "Not1" => "gcggccgc",
    );
    $rfc23["restrictionSites"] = $restrictionSites;
    return $rfc23;
}

/**
 * get information of RFC23 assembly standard.
 * @return Array
 */
function getRFC25() {
    $rfc25 = array();
    $restrictionSites = array(
        "EcoR1" => "gaattc",
        "Xba1" => "tctaga",
        "NgoM4" => "gccggc",
        "Age1" => "accggt",
        "Spe1" => "actagt",
        "Pst1" => "ctgcag",
        "Not1" => "gcggccgc",
    );
    $rfc25["restrictionSites"] = $restrictionSites;
    return $rfc25;
}

/**
 * Determing if a nuleic sequence is compatible with RFC12 assembly standard.
 * @param type String $naSeq
 * @return Array
 */
function isCompatibleWithRFC10($naSeq) {
    $rfc = getRFC10();
    return isCompatibleWithRFC($naSeq, $rfc);
}

/**
 * Determine if a nuleic sequence is compatible with RFC12 assembly standard.
 * @param type String $naSeq
 * @return Array
 */
function isCompatibleWithRFC12($naSeq) {
    $rfc = getRFC12();
    return isCompatibleWithRFC($naSeq, $rfc);
}

/**
 * Determine if a nuleic acid sequecnce is compatible with RDC21 standard.
 * @param type String $naSeq
 * @return Array
 */
function isCompatibelWithRFC21($naSeq) {
    $rfc = getRFC21();
    return isCompatibleWithRFC($naSeq, $rfc);
}

/**
 * Determine if a nuleic acid sequence is compatible with RFC23 assembly standard.
 * @param type String $naSeq
 * @return Arrya
 */
function isCompatibleWithRFC23($naSeq) {
    $rfc = getRFC23();
    return isCompatibleWithRFC($naSeq, $rfc);
}

/**
 * Determine if a nuleic acid sequence is compatible with RFC25 assembly standard.
 * @param type String $naSeq
 * @return Array
 */
function isCompatibleWithRFC25($naSeq) {
    $rfc = getRFC25();
    return isCompatibleWithRFC($naSeq, $rfc);
}

/**
 * Determine if a nucleic acid sequence is compatible with a custom RFC assembly standard.
 * @param type String $naSeq
 * @param type array $rfc
 * @return bollean
 */
function isCompatibleWithRFC($naSeq, $rfc) {
    if(strlen($naSeq) == 0) {
        return FALSE;
    }
    $flag = 0;
    foreach ($rfc["restrictionSites"] as $rSite) {
        if(stristr($naSeq, $rSite) !== FALSE) {
            $flag = 1;
        }
    }
    if($flag) {
        return FALSE;
    }  else {
        return TRUE;
    }
}

/**
 * Get all of assembly standard which is compatible with. 
 * @param type String $naSeq
 * @return Array
 */
function getCompatibleRFC($naSeq) {
    $rfcSet = array();
    if(isCompatibleWithRFC10($naSeq)) {
        array_push($rfcSet, "RFC10");
    }
    if(isCompatibleWithRFC12($naSeq)) {
        array_push($rfcSet, "RFC12");
    }
    if(isCompatibelWithRFC21($naSeq)) {
        array_push($rfcSet, "RFC21");
    }
    if(isCompatibleWithRFC23($naSeq)) {
        array_push($rfcSet, "RFC23");
    }
    if(isCompatibleWithRFC25($naSeq)) {
        array_push($rfcSet, "RFC25");
    }
    return $rfcSet;
}

/**
 * Get all genes matching biobricks belong to category of protein coding sequence in Registry of standard biological parts.
 * @return array
 */
function getAllMatchingGene() {
    $result = array();
    $annotationArr = queryAllAnnotation();
    $cdsArr = queryAllCdsBiobrick();
    foreach ($annotationArr as $row) {
        foreach ($cdsArr as $cds) {
            if(strtoupper($cds['protein']) == strtoupper($row['Gene_Name'])) {
                $match = array(
                    'gid' => $row['gid'],
                    'biobrick_name' => $cds['name'],
                    'protein' => $cds['protein'],
                );
                array_push($result, $match);
            }
        }
    }
    return $result;
}

/**
 * get biobricks belong to category of protein coding sequence in Registry of standard biological parts.
 * @param type $gid
 * @return array
 */
function getBiobrickByGid($gid) {
    $result = array();
    $cdsArr = queryAllCdsBiobrick();
    $annotation = getAnnotationByGid($gid);
    foreach ($cdsArr as $cds) {
        if (strtoupper($cds['protein']) == strtoupper($annotation['Gene_Name'])) {
            $match = array(
                'gid' => $gid,
                'biobrick_name' => $cds['name'],
                'protein' => $cds['protein'],
            );
            array_push($result, $match);
        }
    }
    return $result;
}
