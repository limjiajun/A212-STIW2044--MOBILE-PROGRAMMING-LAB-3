<?php
include_once("dbconnect.php");

if (isset($_SESSION['sessionid'])) {
    $_email = $_SESSION['email'];
}else{
    $cust_email = "guest@gmail.com";
}

if (isset($_POST['submit'])){
    $subjectid = $_POST['subject_id'];
    if ($cust_email == "guest@gmail.com"){
        echo "<script>alert('Please register an account first.');</script>";
        echo "<script> window.location.replace('signup.php')</script>";
    }else{
       echo "<script> window.location.replace('subjectdetails.php?prid=$subjectid')</script>";
        echo "<script>alert('OK.');</script>";
    }
}

if (isset($_GET['subject_id'])) {
    $subjectid = $_GET['subject_id'];
    $sqlsubject= "SELECT * FROM tbl_subjects WHERE subject_id = '$subjectid'";
    $stmt = $conn->prepare($sqlsubject);
    $stmt->execute();
    $number_of_result = $stmt->rowCount();
    if ($number_of_result > 0) {
        $result = $stmt->setFetchMode(PDO::FETCH_ASSOC);
        $rows = $stmt->fetchAll();
    } else {
        echo "<script>alert('Subject not found.');</script>";
        echo "<script> window.location.replace('index.php')</script>";
    }
} else {
    echo "<script>alert('Page Error.');</script>";
    echo "<script> window.location.replace('index.php')</script>";
}



?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="../js/menu.js" defer></script>
    <link rel="stylesheet" href="../css/style1.css">
    <title>Welcome to MyTutor </title>
</head>

<body style="max-width:2200px;margin:0 auto;">
    <div class="w3-sidebar w3-bar-block w3-light-grey" style="width:15%" id="mySidebar">
    <button onclick="w3_close()" class="w3-bar-item w3-button w3-large">Close &times;</button>


        <a href="index.php" class="w3-bar-item w3-button w3-red">Dashboard</a>
        <a href="signup.php" class="w3-bar-item w3-button w3-black">My Profile</a>
        
        <a href="index.php" class="w3-bar-item w3-button w3-green">My Courses</a>
        <a href="tutors.php" class="w3-bar-item w3-button w3-pink">My Tutors</a>
        <a href="#" class="w3-bar-item w3-button w3-white w3-gray">My Subscription</a>
        
        <a href="login.php" class="w3-bar-item w3-button w3-pale-red">Logout</a>
       
      
    </div>

    <div class="w3-green">
        <button class="w3-button w3-yellow w3-xlarge" onclick="w3_open()">☰</button>
        <div class="w3-container">
            <h3>Subject Details</h3>
        </div>
    </div>
    <div class="w3-bar w3-yellow">
        <a href="index.php" class="w3-bar-item w3-button w3-right">Back</a>
    </div>
    <div>
    <?php
        foreach ($rows as $subjects) {
            $subjectid = $subjects['subject_id'];
            $subjectname = $subjects['subject_name'];
            $subjectdescription = $subjects['subject_description'];
            $subjectprice = $subjects['subject_price'];
            $tutorid = $subjects['tutor_id'];
            $subjectsessions = $subjects['subject_sessions'];
            $subjectrating = $subjects['subject_rating'];
        }
        echo "<div class='w3-padding w3-center'><img class='w3-image resimg'src=../../admin/assets/courses/$subjectid.png" .
        " onerror=this.onerror=null;this.src='../../admin/css/2.png'". " ></div><hr>";

        echo "<div class='w3-container w3-padding-large'><h4><b>$subjectname</b></h4>";

        echo " <div><p><b>Description</b><br>$subjectdescription</p><p><b>Price:</b>RM $subjectprice</p><p><b>Tutor id:</b>$tutorid</p>
        <p><b>Subject Session:</b> $subjectsessions</p><p><b>Subject Rating:</b> $subjectrating</p>
        <form action='subjectdetails.php' method='post'> 
            <input type='hidden'  name='subject_id' value='$subjectid'>
            <input class='w3-button w3-yellow w3-round' type='submit' name='submit' value='BUY'>
        </form>
        </div></div>";

     
     
     


    ?>
    </div>
    <div class="w3-center w3-bottom w3-yellow" style="max-width:3000px;margin:0 auto;">MyTutor<p>Author: LIM JIA JUN<br></div>
</body>

</html>