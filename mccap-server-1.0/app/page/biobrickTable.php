<?php
$page_dir = str_replace('\\', '/', dirname(__FILE__)) . '/';
$serv_dir = $page_dir . "../../service/";
require_once $serv_dir . 'cegRecordServ.php';
require_once $serv_dir . 'keggServ.php';
require_once $serv_dir . 'util.php';

$matchArr = getAllMatchingGene();
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Biobrick Table</title>

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
                            <h1 class="center-block">Biobrick Table</h1>
                        </div>-->

            <!-- body -->
            <div class="row" id="body">
                <!-- main content -->
                <div class="col-sm-12" id="mainContent">
                    <div class="panel panel-info" id="BBK-panel">
                        <div class="panel-heading">
                            <b>All Matching Biobrick</b>
                        </div>
                        <div class="panel-body">
                            <table class="table-striped table-responsive" id="BBK">
                                <thead>
                                    <tr>
                                        <th>Gid</th>
                                        <th>Biobrick Name</th>
                                        <th>Protein</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    foreach ($matchArr as $match) {
                                    ?>
                                        <tr>
                                            <td> <?php echo $match['gid']; ?> </td>
                                            <td> <a href="<?php echo getBbkUrl($match['biobrick_name']); ?>"><?php echo $match['biobrick_name']; ?></a> </td>
                                            <td> <?php echo $match['protein']; ?> </td>
                                        </tr>
                                    <?php
                                    }
                                    ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div><!-- end of main content -->
            </div><!-- end of body -->
        </div><!-- end of container -->
        <script>
        </script>
    </body>
</html>