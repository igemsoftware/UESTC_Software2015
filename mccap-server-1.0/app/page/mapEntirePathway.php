<?php
$page_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$serv_dir = $page_dir . "../../service/";
require_once $serv_dir.'keggServ.php';

function processUrl($url) {
    return "http://www.kegg.jp" . $url;
}

function processTitle($title) {
    return str_replace(array("</a>&nbsp;", "\">"), "", $title);
}

if (isset($_GET['id'])) {
    $param = trim($_GET['id']);
    $id = str_split($param, 2);
    $idArr = array();
    foreach ($id as $k => $v) {
        array_push($idArr, intval($v));
    }
    
    $koArr = getKOByIdArr($idArr);
    $url = getPathwayUrl($koArr);
    $content = file_get_contents($url);
    
    $flag = 0;
    $preg = "\/kegg-bin\/(.*)\.args/i";
    $pregUrl = "/\/kegg-bin\/(.*)\.args/i";
    $pregTitle = "/\">ko(.*)<\/a>&nbsp;/i";
    if(!preg_match_all($pregUrl, $content, $urlList)) {
        $flag = 1;
    }
    if(!preg_match_all($pregTitle, $content, $titleList)) {
        $flag = 2;
    }
}  else {
    echo 'An error has occurred in parameter.';
    die();
}
?>

<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="../css/page.css" type="text/css" rel="stylesheet" />
    <title>Result List</title>
</head>	
<body >
    <div>
        <ul id="ul-geneNetwork">
            <?php
            for($i = 0;$i < count($urlList[0]);$i++) {
            ?>
            <li id="li-geneNetwork"><a href="<?php echo processUrl($urlList[0][$i]); ?>"><?php echo processTitle($titleList[0][$i]); ?></a></li>
            <?php
            }
            ?>
        </ul>
    </div>
</body>
</html>

