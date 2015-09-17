<?php
$api_ceg_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$serv_dir = $api_ceg_dir . '../../service/';
require_once $serv_dir . 'cegRecordServ.php';
require_once $serv_dir . 'organismServ.php';
require_once $serv_dir . 'bioBrickServ.php';

/*
 * This is api script for testing.
 */
$accessNum = "CEG0995";
$gid = "16272478";

$arr = getBiobrickByGid($gid);
print_r($arr);