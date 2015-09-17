<?php
$page_dir = str_replace('\\', '/', dirname(__FILE__)).'/';
$serv_dir = $page_dir . "../../service/";
require_once $serv_dir . 'cegRecordServ.php';
require_once $serv_dir .'keggServ.php';
require_once $serv_dir . 'util.php';

$flag = 0;

if (isset($_GET['access_num'])) {
    $flag = 1;
    $accessNum = trim($_GET['access_num']);
    $cegBase = getCegBaseByAccessNum($accessNum);
    $gidArr = getGidByAccessNum($accessNum);
    $itemArr = array();
    foreach ($gidArr as $gid) {
        $annotation = getAnnotationByGid($gid);
        $item['gid'] = $gid;
        $item['gene_name'] = $annotation['Gene_Name'];
        $item['description'] = $annotation['fundescrp'];
        $item['sequence'] = getPlainNaSeq($gid);
        $item['rfc_arr'] = getCompatibleRFC($item['sequence']);
        $item['biobrick_arr'] = getBiobrickByGid($gid);
        array_push($itemArr, $item);
    }
}
if(!$flag) {
    die();
}
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Detail of Gene Cluster</title>

        <!-- Bootstrap -->
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="../bootstrap/jquery.min.js"></script>
        <script src="../bootstrap/js/bootstrap.min.js"></script>
        <!-- style -->
        <link href="../css/page.css" type="text/css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <!-- head -->
<!--            <div class="row" id="head">
                <h1 class="center-block">Detail of Gene Cluster</h1>
            </div>-->

            <!-- body -->
            <div class="row" id="body">
                <!-- main content -->
                <div class="col-sm-12" id="mainContent">
                    <div class="row">
                        <div class="col-sm-8">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <b>Corresponding Gene</b>
                                </div>
                                <div class="panel-body" id="gene-content">
                                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                        <?php
                                        foreach ($itemArr as $item) {
                                            ?>
                                            <div class="panel panel-default my-panel">
                                                <div class="panel-heading" role="tab" id="heading<?php echo $item['gid']; ?>">
                                                    <h4 class="panel-title">
                                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<?php echo $item['gid']; ?>" aria-expanded="false" aria-controls="collapseTwo">
                                                            GID: <?php echo $item['gid']; ?>
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="collapse<?php echo $item['gid']; ?>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<?php echo $item['gid']; ?>">
                                                    <div class="panel" id="div-scroll-bar">
                                                            <p><?php echo $item['sequence']; ?></p>
                                                    </div>
                                                    <table class="table-bordered table-responsive" id="gene-table">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 20%">Gene Name</th>
                                                                <th style="width: 30%">Description</th>
                                                                <th style="width: 50%">Compatible Assembly Standard</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td> <?php echo $item['gene_name']; ?> </td>
                                                                <td> <?php echo $item['description']; ?> </td>
                                                                <td> <?php echo json_encode($item['rfc_arr']); ?> </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <?php
                                        }
                                        ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <b>Cluster Infomation</b>
                                </div>
                                <div class="panel-body" id="right-bar-1">
                                    <table class="table-striped table-responsive" id="cluster-table">
                                        <tr>
                                            <td style="width: 50%">Access_num: </td>
                                            <td style="width: 50%"><?php echo $accessNum; ?></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 50%">Gene Number: </td>
                                            <td style="width: 50%"><?php echo count($itemArr); ?></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 50%">Description: </td>
                                            <td style="width: 50%"><?php echo $cegBase['description']; ?></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <b>Biobrick Content</b>
                                    <a href="biobrickTable.php" class="btn btn-default btn-xs pull-right">View All</a>
                                </div>
                                <div class="panel-body" id="right-bar-2">
                                    <table class="table-bordered table-responsive" id="biobrick-table">
                                        <thead>
                                            <tr>
                                                <th style="width: 30%">GID</th>
                                                <th style="width: 33%">BBK Name</th>
                                                <th>Protein</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?Php
                                        $BBkCount = 0;
                                        foreach ($itemArr as $item) {
                                            foreach ($item['biobrick_arr'] as $row) {
                                                $BBkCount++;
                                        ?>
                                            <tr>
                                                <td> <?php echo $row['gid']; ?> </td>
                                                <td> <a href="<?php echo getBbkUrl($match['biobrick_name']); ?>"><?php echo $row['biobrick_name']; ?></a> </td>
                                                <td> <?php echo $row['protein']; ?> </td>
                                            </tr>
                                        <?php    
                                            }
                                        }
                                        if(!$BBkCount) {
                                        ?>
                                            <tr>
                                                <td> null </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        <?php
                                        }
                                        ?> 
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- end of main content -->
            </div><!-- end of body -->
        </div><!-- end of container -->
        <script>
        </script>
    </body>
</html>