<?php
if (!isset($_POST)) {
    $response = array('status' => 'Failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$results_per_page = 5;
$pageno = (int)$_POST['pageno'];
$search = $_POST['search'];
$type = $_POST['type'];
$page_first_result = ($pageno - 1) * $results_per_page;

//if ($type=="All"){
 //   $sqlloadsubject  = "SELECT * FROM tbl_subjects WHERE subject_name LIKE '%$search%' ORDER BY subject_id DESC";
//}else{
//    $sqlloadsubject  = "SELECT * FROM tbl_subjects WHERE subject_name LIKE '%$search%' AND subject_type ='$type' ORDER BY subject_id DESC";    
//}
if ( $type=="All"){
    $sqlloadsubject = "SELECT * FROM tbl_subjects as sub LEFT JOIN tbl_tutors AS tt ON sub.tutor_id =tt.tutor_id WHERE subject_name LIKE '%$search%'";
    }else {
    $sqlloadsubject = "SELECT * FROM tbl_subjects as sub LEFT JOIN tbl_tutors AS tt ON sub.tutor_id =tt.tutor_id WHERE subject_name LIKE '%$search%' AND sub.subject_type >= '$type' ORDER BY sub.subject_type DESC";
    }




//$sqlloadsubject = "SELECT * FROM tbl_subjects";
$result = $conn->query($sqlloadsubject);
$number_of_result = $result->num_rows;
$number_of_page = ceil($number_of_result / $results_per_page);
$sqlloadsubject = $sqlloadsubject . " LIMIT $page_first_result , $results_per_page";
$result = $conn->query($sqlloadsubject);
if ($result->num_rows > 0) {
    $subjects["subjects"] = array();
    while ($row = $result -> fetch_assoc()) {
        $sublist = array();
        $sublist['subject_id'] = $row['subject_id'];
        $sublist['subject_name'] = $row['subject_name'];
        $sublist['subject_description'] = $row['subject_description'];
        $sublist['subject_price'] = $row['subject_price'];
        $sublist['tutor_id'] = $row['tutor_id'];
        $sublist['subject_sessions'] = $row['subject_sessions'];
        $sublist['subject_rating'] = $row['subject_rating'];
        $sublist['tutor_name'] = $row['tutor_name'];
        array_push($subjects["subjects"],$sublist);
    }
    $response = array('status' => 'success', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page", 'data' => $subjects);
    sendJsonResponse($response);
    
} else {
    $response = array('status' => 'failed', 'pageno'=>"$pageno",'numofpage'=>"$number_of_page",'data' => null);
    sendJsonResponse($response);

}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>