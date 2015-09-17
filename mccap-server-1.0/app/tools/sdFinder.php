<?php
$seq = "";
$result = array();
if (isset($_POST["sequence"])) {
    $flag = 1;
    $seq = $_POST["sequence"];
    $initCodonArr = isset($_POST["initCodonArr"]) ? $_POST["initCodonArr"] : array("ATG","GTG", "TTG");
    $termCodonArr = isset($_POST["termCodonArr"]) ? $_POST["termCodonArr"] : array("TAG", "TAA", "TGA");
    $filterLength = isset($_POST["filterLength"]) ? $_POST["filterLength"] : 0;
    $result = execute($seq, $initCodonArr, $termCodonArr, $filterLength);
} else {
    $flag = 0;
}
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>SD Finder</title>

        <!-- Bootstrap -->
        <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="../bootstrap/jquery.min.js"></script>
        <script src="../bootstrap/js/bootstrap.min.js"></script>
        <!-- style -->
        <link href="../css/sdFinder.css" type="text/css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <!-- head  -->
            <div class="row" id="head">
                <h2 class="center-block">SD Finder</h2>
            </div>

            <!-- body  -->
            <div class="row" id="body">
                <!-- left content -->
                <div class="col-md-8" id="mainApp">
                    <form target="" method="post" name="sdform">
                        <div class="form-group">
                            <label >Sequence : </label>
                            <textarea class="form-control" rows="10" name="sequence"><?php if($flag){ echo $seq; } ?></textarea>
                        </div>
                        <div class="form-group">
                            <label >Initiation codon : </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="initCodonArr[]" value="ATG" checked="checked"> ATG
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="initCodonArr[]" value="GTG"> GTG
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="initCodonArr[]" value="TTG"> TTG
                            </label>
                        </div>
                        <div class="form-group">
                            <label >Termination codon : </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="termCodonArr[]" value="TAG" checked="checked"> TAG
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="termCodonArr[]" value="TAA" checked="checked"> GTG
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="termCodonArr[]" value="TGA"> TTG
                            </label>
                        </div>
                        <div class="form-group">
                            <label >Filter out(ORF) : </label>
                            <input type="number" name="filterLength" value="12"> bp
                        </div>
                        <a href="javascript:document.sdform.submit();" target="_self" type="submit" class="btn btn-success"> Execute </a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="btn btn-info" data-target="#resultModal" data-toggle="modal"> Show result </a>
                    </form>
                </div><!-- end of left content -->
                <!-- right bar -->
                <div class="col-md-4">
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingOne">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Introduction
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    We (UESTC_Software iGEM team) cooperated with SCU_China team and CHINA_CD_UESTC team to study how to find out SD sequence in DNA and analyze the strength of the SD sequence that affects translation issues. Then we developed an online software based on browser, which is used in helping user predict the ORF and SD sequence of DNA. User only needs to type sequence that needs to be predicted, select the initiation codons and termination codons. Then comes the prediction.
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingTwo">
                                <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        Help
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                <div class="panel-body">
                                    <p>Filter out: abandon the results of ORF whose length less than this number.</p>
                                    <p>Red tag: these sequences could be SD sequence.</p>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingThree">
                                <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                        Reference
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                <div class="panel-body">
                                    <p>[1] Golshani A, Krogan NJ, Xu J, Pacal M, Yang XC, Ivanov I, Providenti MA, Ganoza MC, Ivanov IG, AbouHaidar MG. Escherichia coli mRNAs with strong Shine/Dalgarno sequences also contain 5' end sequences complementary to domain # 17 on the 16S ribosomal RNA. Biochem Biophys Res Commun. 2004,316(4):978-83.</p>
                                    <p>[2] Wang XH, Li H. Identification of Shine-Dalgarno Region by the method of self-consistent Information clustering in E.coli. ACTA SCIENTIARUM NATURALIUM UNIVERSITATIS NEIMONGOL. 2008,39(3):314-320</p>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingThree">
                                <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                        About
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                                <div class="panel-body">
                                    <p>Version: beta 1.0</p>
                                    <p>Team: UESTC_software</p>
                                    <p>Contact: ycduan_uestc@yeah.net</p>
                                    <p>Sponsor: UESTC National Science Park</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- end of right bar -->
                <!-- Result modal -->
                <div class="modal fade bs-example-modal-lg" id="resultModal" tabindex="-1" role="dialog">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title text-center"><strong>Predicted SD sequence result</strong></h4>
                            </div>
                            <div class="modal-body">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Start</th>
                                            <th>Initiation Codon</th>
                                            <th>Stop</th>
                                            <th>Termination Codon</th>
                                            <th>Length</th>
                                            <th>SD-Seq(-14bp~-2bp)</th>
                                            <th>SD Type</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php for($i = 0;$i < count($result);$i++) { ?>
                                        <tr>
                                            <td><?php echo $i + 1; ?></td>
                                            <td><?php echo $result[$i]["init"]; ?></td>
                                            <td><?php echo $result[$i]["initCodon"]; ?></td>
                                            <td><?php echo $result[$i]["term"]; ?></td>
                                            <td><?php echo $result[$i]["termCodon"]; ?></td>
                                            <td><?php echo $result[$i]["length"]; ?></td>
                                            <td><?php echo $result[$i]["sdSeq"]; ?></td>
                                            <td><?php echo $result[$i]["sdType"]; ?></td>
                                        </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-dismiss="modal"> OK </button>
                            </div>
                        </div>
                    </div>
                </div><!-- end of result modal -->
            </div><!-- end of body  -->
        </div><!-- end of container -->
        <script>
            <?php if ($flag) { ?>
                $('#resultModal').modal('show');
            <?php } ?>
        </script>
    </body>
</html>

<?php
//initiation codon: ATG GTG TTG
// termination codon: TAG TAA TGA
//16S rRNA 3'anti-SD: 3'-AUUCCUCCACUAG-5'
function isInitCodon($codon, $initCodonArr = array("ATG","GTG", "TTG")) {
    if(in_array($codon, $initCodonArr)) {
        return TRUE;
    } else {
        return FALSE;
    }
}

function isTermCodon($codon, $termCodonArr = array("TAG", "TAA", "TGA")) {
    if(in_array($codon, $termCodonArr)) {
        return TRUE;
    } else {
        return FALSE;
    }
}

function isInitCdCoord($seq, $coordinate, $initCodonArr = array("ATG","GTG", "TTG")) {
    $codon = getCodon($seq, $coordinate);
    return isInitCodon($codon, $initCodonArr);
}

function isTermCdCoord($seq, $coordinate, $termCodonArr = array("TAG", "TAA", "TGA")) {
    $codon = getCodon($seq, $coordinate);
    return isTermCodon($codon, $termCodonArr);
}

function getCodon($seq, $coordinate) {
    return substr($seq, $coordinate, 3);
}

function getSd($seq, $init) {
    $result = array();
    $start = $init - 15 - 1 > 0 ? $init - 15 - 1 : 0;
    $stop = $init - 2 -1 > 0 ? $init -2 -1 : 0;
    $sdSeq = substr($seq, $start, 13);
    $tmp = markSdSeq($sdSeq);
    $scope = "(" . (String)($start + 1) ."~".(String)($stop + 1) . ")";
    $result["sdSeq"] = $tmp["sdSeq"] . $scope;
    $result["sdType"] = $tmp["type"];
    return $result;
}

function markSdSeq($sdSeq) {
    $result = array();
    $strongSDArr = array("AGGAGG", "TAAGGA", "AAGGAG", "AAGGAA", "AGGAGT", "TTAAGG", "AGGAGA", "AAGGA", "UAAGG", "AGGAG", "AGGAA", "AUAAC", "GGAGA", "AGGA", "AAGG", "UAAG", "GGAG", "AGG", "UAA", "AAG");
    $mediumSDArr = array("CAGGAG", "AGGAAA", "AGGAGA", "ACAGGA", "GAGGAA", "AGGAGU", "AGGAG", "CAGGA", "GAGGA", "AGGAA", "GAGGA", "AAGGA", "AGGA", "GGAG", "GAGG", "GGA", "GAG");
    $weakSDArr = array("GAGGAG", "GAGAGA", "GGGGGC", "AGAGAG", "UGGGGG", "CUGGGG", "GGAGG", "GAGAG", "GGGGG", "UGGGG", "AGAGA", "GGGGA", "GGGG", "GAGA", "AGAG", "GGG", "AGA", "AGG");
    $flag = 0;
    $type = "null";
    $prefix = "<span id = \"redMark\">";
    $suffix = "</span>";
    foreach ($strongSDArr as $s) {
        if(strstr($sdSeq, $s)) {
            $flag = 1;
            $type = "Strong";
            $sdSeq = str_replace($s, $prefix . $s . $suffix, $sdSeq);
            break;
        }
    }
    if (!$flag) {
        foreach ($mediumSDArr as $s) {
            if (strstr($sdSeq, $s)) {
                $flag = 1;
                $type = "Medium";
                $sdSeq = str_replace($s, $prefix . $s . $suffix, $sdSeq);
                break;
            }
        }
    }
    if (!$flag) {
        foreach ($weakSDArr as $s) {
            if (strstr($sdSeq, $s)) {
                $flag = 1;
                $type = "Weak";
                $sdSeq = str_replace($s, $prefix . $s . $suffix, $sdSeq);
                break;
            }
        }
    }
    $result["sdSeq"] = $sdSeq;
    $result["type"] = $type;
    return $result;
}

function execute($seq, $initCodonArr = array("ATG","GTG", "TTG"), $termCodonArr = array("TAG", "TAA", "TGA"), $filterLength = 0) {
    $result = array();
    $length = strlen($seq);
    for($site = 0;$site < $length;) {
        if(isInitCdCoord($seq, $site, $initCodonArr)) {
            $orf = array();
            $init = $site + 1;
            $initCodon = getCodon($seq, $site);
            $term = 0;
            $termCodon = "---";
            for($site = $site + 3;$site < $length;) {
                if(isTermCdCoord($seq, $site, $termCodonArr)) {
                    $term = $site + 1;
                    $termCodon = getCodon($seq, $site);
                    break;
                }
                $site = $site + 3;
                if($site >= $length) {
                    $term = "null";
                    $termCodon = "null";
                }
            }
            $orf["init"] = $init;
            $orf["initCodon"] = $initCodon;
            $orf["term"] = $term;
            $orf["termCodon"] = $termCodon;
            $orf["length"] = $term - $init > 0 ? $term - $init : 0;
            $tmp = getSd($seq, $init);
            $orf["sdSeq"] = $tmp["sdSeq"];
            $orf["sdType"] = $tmp["sdType"];
            if($orf["length"] > $filterLength) {
                array_push($result, $orf);
            }
        }else {
            $site++;
        }
    }
    return $result;
}
?>