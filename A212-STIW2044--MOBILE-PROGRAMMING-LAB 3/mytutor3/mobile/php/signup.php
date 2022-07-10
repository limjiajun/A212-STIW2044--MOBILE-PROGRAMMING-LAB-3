<?php
if (!isset($_POST)){
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");


$name = $_POST['name'];
$email= $_POST['email'];
$password = sha1($_POST['password']);
$phone= $_POST['phone'];
$homeaddress = $_POST['homeaddress'];

$sqlinsert = "INSERT INTO `tbl_users`( `user_name`, `user_email`,
 `user_password`, `user_phone`, `user_homeaddress`) VALUES ('$name','$email','$password','$phone','$homeaddress')";


if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
   
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>