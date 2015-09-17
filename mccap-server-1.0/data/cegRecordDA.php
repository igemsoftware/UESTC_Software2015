<?php
$data_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$config_dir = $data_dir.'../config/';
require_once $config_dir.'db.php';

/*
 * Data access from database.
 * This is a simple php script for querying the data/record of ceg_core & ceg_base table.
 * corresponding column:
 * access_num,
 * gid,
 * organismid,
 * koid,
 * description,
 */

/**
 * Query CEG record by organism ID.
 * @param type int
 * @return Array
 */
function queryCegRecByOgID($id) {
    $pdo = getPDO();
    try {
        $sql = 'select * from ceg_core where organismid = :id';
        $ps = $pdo->prepare($sql);
        $ps->bindValue(':id', $id);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = 'An Error has occurred in data accessing.';
        exit();
    }
    return $result;
}

/**
 * Query CEG record by a state which means the expression with where in sql.
 * @param type String
 * @return Array
 */
function queryCegRecByState($state) {
    $pdo = getPDO();
    try {
        $sql = 'select * from ceg_core where '.$state;
        $ps =$pdo->prepare($sql);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = 'An Error has occurred in data accessing.';
        exit();
    }
    return $result;
}

/**
 * Query all of access_num in ceg_base table.
 * @return Array
 */
function queryAccessNum() {
    $pdo = getPDO();
    try {
        $sql = 'select access_num from ceg_base';
        $ps = $pdo->prepare($sql);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = 'An Error has occurred in data accessing.';
        exit();
    }
    return $result;
}

/**
 * Query all of data in ceg_base table.
 * @return Array
 */
function queryAllCegBase() {
    $pdo = getPDO();
    try  {
        $sql = 'select * from ceg_base';
        $ps = $pdo->prepare($sql);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = 'An Error has occurred in data accessing.';
        exit();
    }
    return $result;
}

/**
 * Query nucleic acid sequence of one gid.
 * @param type QString $gid
 * @return Array
 */
function queryNaSeq($gid) {
    $pdo = getPDO();
    try {
        $sql = "select * from na_seq where gid = :id";
        $ps = $pdo->prepare($sql);
        $ps->bindValue(":id", $gid);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = "An Error has occurred in data accessing.";
        exit();
    }
    return $result;
}

/**
 * Query all of nucleic acid sequence in databse.
 * @return Array
 */
function queryAllNaSeq() {
    $pdo = getPDO();
    try {
        $sql = "select * from na_seq";
        $ps = $pdo->prepare($sql);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = "An Error has occurred in data accessing.";
        exit();
    }
    return $result;
}

/**
 * Query all of annotion in databse.
 * @return Array
 */
function queryAllAnnotation() {
    $pdo = getPDO();
    try {
        $sql = "select * from annotation";
        $ps = $pdo->prepare($sql);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = "An Error has occurred in data accessing.";
        exit();
    }
    return $result;
}

/**
 * Query annotation of one gid.
 * @param type String $gid
 * @return Array
 */
function queryAnnotationByGid($gid) {
    $pdo = getPDO();
    try {
        $sql = "select * from annotation where gid = :id";
        $ps = $pdo->prepare($sql);
        $ps->bindValue(":id", $gid);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = "An Error has occurred in data accessing.";
        exit();
    }
    return $result;
}

/**
 * Query all of gid which belong to one gene cluster.
 * @param type String $accessNum
 * @return Array
 */
function queryGidByAccessNum($accessNum) {
    $pdo = getPDO();
    try {
        $sql = "select gid from ceg_core where access_num = :access_num";
        $ps = $pdo->prepare($sql);
        $ps->bindValue(":access_num", $accessNum);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = "An Error has occurred in data accessing.";
        exit();
    }
    return $result;
}

/**
 * Query all of data which belong to one gene cluster in ceg_base table.
 * @param type String $accessNum
 * @return Array
 */
function queryCegBaseByAccessNum($accessNum) {
    $pdo = getPDO();
    try {
        $sql = "select * from ceg_base where access_num = :access_num";
        $ps = $pdo->prepare($sql);
        $ps->bindValue(":access_num", $accessNum);
        $ps->execute();
        $ps->setFetchMode(PDO::FETCH_ASSOC);
        $result = $ps->fetchAll();
    } catch (Exception $ex) {
        $error = "An Error has occurred in data accessing.";
        exit();
    }
    return $result;
}
