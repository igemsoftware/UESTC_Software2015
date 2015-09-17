<?php
$data_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$config_dir = $data_dir.'../config/';
require_once $config_dir.'db.php';

/*
 * Data access file of BioBrick.
 * This is a simple php script for querying the data/record of BioBrick.
 */

/**
 * Query biobricks which belong to Transcriptional Regulators category.
 * @return array
 */
function queryTranscriptionalRegulators() {
    $transcriptionalRegulators = array(
        0 => array("name" => "BBa_C0079", "protein" => "lasR-LVA"),
        1 => array("name" => "BBa_C0077", "protein" => "cinR"),
        2 => array("name" => "BBa_C0179", "protein" => "lasR"),
        3 => array("name" => "BBa_J07009", "protein" => "ToxR"),
        4 => array("name" => "BBa_S04301", "protein" => "lasR-LVA"),
        5 => array("name" => "BBa_K266002", "protein" => "lasR-LVA"),
        6 => array("name" => "BBa_K783054", "protein" => "lasR-LVA"),
        7 => array("name" => "BBa_K352001", "protein" => "transcription activator"),
        8 => array("name" => "BBa_K1031911", "protein" => "XylS"),
        9 => array("name" => "BBa_C0012", "protein" => "LacI"),
        10 => array("name" => "BBa_C0040", "protein" => "TetR"),
        11 => array("name" => "BBa_C0050", "protein" => "CI HK022"),
        12 => array("name" => "BBa_C0051", "protein" => "CI lambda"),
        13 => array("name" => "BBa_C0052", "protein" => "CI 434-LVA"),
        14 => array("name" => "BBa_C0053", "protein" => "C2 P22"),
        15 => array("name" => "BBa_C0073", "protein" => "mnt-weak"),
        16 => array("name" => "BBa_C0075", "protein" => "cI TP901"),
        17 => array("name" => "BBa_C0074", "protein" => "penI"),
        18 => array("name" => "BBa_C0072", "protein" => "mnt"),
        19 => array("name" => "BBa_C2001", "protein" => "Zif23-GCN4"),
        20 => array("name" => "BBa_C0056", "protein" => "CI 434"),
        21 => array("name" => "BBa_K864201", "protein" => "LexA"),
        22 => array("name" => "BBa_K864202", "protein" => "MarR(G95S)"),
        23 => array("name" => "BBa_K864203", "protein" => "LexA3"),
        24 => array("name" => "BBa_J06501", "protein" => "LacI-mut2"),
        25 => array("name" => "BBa_J06500", "protein" => "LacI-mut1"),
        26 => array("name" => "BBa_K082004", "protein" => "LacI"),
        27 => array("name" => "BBa_K082005", "protein" => "LacI"),
        28 => array("name" => "BBa_K864200", "protein" => "MarR"),
        29 => array("name" => "BBa_C0062", "protein" => "LuxR"),
        30 => array("name" => "BBa_C0071", "protein" => "rhlR-LVA"),
        31 => array("name" => "BBa_C0080", "protein" => "araC"),
        32 => array("name" => "BBa_C0171", "protein" => "rhIR"),
    );
    return $transcriptionalRegulators;
}

/**
 * Query biobricks which belong to Selection Markers category.
 * @return array
 */
function querySelectionMarkers() {
    $selectionMarkers = array(
        1 => array("name" => "BBa_J31005", "protein" => "CAT"),
        2 => array("name" => "BBa_T9150", "protein" => "PyrF"),
        3 => array("name" => "BBa_J31002", "protein" => "AadA-bkw"),
        4 => array("name" => "BBa_J31003", "protein" => "AadA2"),
        5 => array("name" => "BBa_J31004", "protein" => "CAT-bkw"),
        6 => array("name" => "BBa_J31006", "protein" => "TetA(C)-bkw"),
        7 => array("name" => "BBa_J31007", "protein" => "TetA(C)"),
        8 => array("name" => "BBa_K823020", "protein" => "cat"),
    );
    return $selectionMarkers;
}

/**
 * Query biobricks which belong to Bio Synthesis category.
 * @return array
 */
function queryBioSynthesis() {
    $bioSynthesis = array(
        1 => array("name" => "BBa_C0061", "protein" => "luxI-LVA"),
        2 => array("name" => "BBa_C0060", "protein" => "aiiA-LVA"),
        3 => array("name" => "BBa_C0070", "protein" => "rhlI-LVA"),
        4 => array("name" => "BBa_C0076", "protein" => "cinI"),
        5 => array("name" => "BBa_C0078", "protein" => "lasI"),
        6 => array("name" => "BBa_C0161", "protein" => "luxI"),
        7 => array("name" => "BBa_C0170", "protein" => "rhII"),
        8 => array("name" => "BBa_C0178", "protein" => "lasI"),
        9 => array("name" => "BBa_C0060", "protein" => "aiiA-LVA"),
        10 => array("name" => "BBa_C0160", "protein" => "aiiA"),
        11 => array("name" => "BBa_J45014", "protein" => "ATF1-1148 mutant"),
        12 => array("name" => "BBa_J45001", "protein" => "SAMT"),
        13 => array("name" => "BBa_J45002", "protein" => "BAMT"),
        14 => array("name" => "BBa_J45004", "protein" => "BSMT1"),
        15 => array("name" => "BBa_J45008", "protein" => "BAT2"),
        16 => array("name" => "BBa_J45017", "protein" => "PchA & PchB"),
        17 => array("name" => "BBa_C0083", "protein" => "AspA"),
        18 => array("name" => "BBa_I15008", "protein" => "ho1"),
        19 => array("name" => "BBa_I15009", "protein" => "PcyA"),
        20 => array("name" => "BBa_T9150", "protein" => "PyrF"),
        21 => array("name" => "BBa_K356000", "protein" => "autoinducer"),
        20 => array("name" => "BBa_K1438000", "protein" => "19,7 kDa"),
        21 => array("name" => "BBa_K1342002", "protein" => "AspA"),
    );
    return $bioSynthesis;
}

/**
 * Query biobricks which belong to Dna Modification category.
 * @return array
 */
function queryDnaModification() {
    $dnaModification = array(
        1 => array("name" => "BBa_J31001", "protein" => "Hin-LVA"),
        2 => array("name" => "BBa_J31000", "protein" => "Hin"),
        3 => array("name" => "BBa_I11021", "protein" => "Xis lambda"),
        4 => array("name" => "BBa_I11031", "protein" => "Xis P22"),
        5 => array("name" => "BBa_I11020", "protein" => "Int lambda"),
        6 => array("name" => "BBa_I11030", "protein" => "Int P22"),
        7 => array("name" => "BBa_K112001", "protein" => "Xis"),
        8 => array("name" => "BBa_K106011", "protein" => "Sas2"),
        9 => array("name" => "BBa_K106012", "protein" => "Sas2"),
        10 => array("name" => "BBa_K106013", "protein" => "Esa1"),
    );
    return $dnaModification;
}

/**
 * Query biobricks which belong to Posttranslational Modification category.
 * @return array
 */
function queryPostTranslationalModification() {
    $postTranslationalModification = array(
        1 => array("name" => "BBa_C0082", "protein" => "tar-envZ"),
        2 => array("name" => "BBa_K283008", "protein" => "chez"),
        3 => array("name" => "BBa_C0024", "protein" => "CheB"),
    );
    return $postTranslationalModification;
}

/**
 * Query biobricks which belong to Membrane category.
 * @return array
 */
function queryMembrane() {
    $membrane = array(
        1 => array("name" => "BBa_J07009", "protein" => "ToxR"),
        2 => array("name" => "BBa_I15010", "protein" => "Cph8"),
        3 => array("name" => "BBa_C0082", "protein" => "tar-envZ"),
        4 => array("name" => "BBa_K141000", "protein" => "UCP1"),
        5 => array("name" => "BBa_K1666000", "protein" => "LsrA"),
        6 => array("name" => "BBa_K777113", "protein" => "MotA"),
        7 => array("name" => "BBa_K777117", "protein" => "MotB"),
    );
    return $membrane;
}

/**
 * Query biobricks which belong to Lysis category.
 * @return array
 */
function queryLysis() {
    $lysis = array(
        1 => array("name" => "BBa_K112000", "protein" => "Holin"),
        2 => array("name" => "BBa_K112002", "protein" => "Holin"),
    );
    return $lysis;
}

/**
 * Query all biobricks which belong to Coding Sequence category.
 * @return type
 */
function queryAllCdsBiobrick() {
    $arr1 = queryTranscriptionalRegulators();
    $arr2 = querySelectionMarkers();
    $arr3 = queryBioSynthesis();
    $arr4 = queryMembrane();
    $arr5 = queryPostTranslationalModification();
    $arr6 = queryDnaModification();
    $arr7 = queryLysis();
    $rsArr = array_merge($arr1, $arr2, $arr3, $arr4, $arr5, $arr6, $arr7);
    return $rsArr;
}
