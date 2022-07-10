<?php
session_start();
if (!isset($_SESSION['sessionid'])) {
    echo "<script>alert('Session not available. Please login');</script>";
    echo "<script> window.location.replace('login.php')</script>";
}
if (isset($_POST['submit'])) {
    include_once("dbconnect.php");
 
$name = $_POST['name'];
$email= $_POST['email'];
$password = sha1($_POST['password']);
$phone_Number= $_POST['phoneNumber'];
$homeaddress = $_POST['homeaddress'];

   

$sqlinsertproduct = "INSERT INTO `tbl_users`(`user_id`,`user_name`, `user_email`,
`user_password`, `phone_number`,`user_homeaddress`) VALUES ('','$name','$email','$password',$phone_Number, '$homeaddress')";

   
    try {
        $conn->exec($sqlinsertproduct);
        if (file_exists($_FILES["fileToUpload"]["tmp_name"]) || is_uploaded_file($_FILES["fileToUpload"]["tmp_name"])) {
            $last_id = $conn->lastInsertId();
            uploadImage($last_id);
            echo "<script>alert('Success')</script>";
            echo "<script>window.location.replace('login.php')</script>";
        }
    } catch (PDOException $e) {
        echo "<script>alert('Failed')</script>";
        echo "<script>window.location.replace('signup.php')</script>";
    }
}

function uploadImage($filename)
{
    $target_dir = "../res/products/";
    $target_file = $target_dir . $filename . ".png";
    move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file);
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
    <script src="../js/menu.js"></script>
    <script src="../js/script.js"></script>

    <title>Welcome to Mytutor</title>
</head>

<body>
    <!-- Sidebar -->
    <div class="w3-sidebar w3-bar-block" style="display:none" id="mySidebar">
        <button onclick="w3_close()" class="w3-bar-item w3-button w3-large">Close &times;</button>
        <a href="index.php" class="w3-bar-item w3-button">Home</a>
        <a href="#" class="w3-bar-item w3-button">ABOUT</a>
        <a href="#" class="w3-bar-item w3-button">SERVICE</a>
        <a href="#" class="w3-bar-item w3-button">CONTACT</a>
        <a href="#" class="w3-bar-item w3-button">Logout</a>
     
    </div>

    <div class="w3-black">
        <button class="w3-button w3-yellow w3-xlarge" onclick="w3_open()">☰</button>

        <div class="w3-container">
            <h3>Dashboard</h3>

        </div>
    </div>
   

    <div class="w3-content w3-padding-32">
        <form class="w3-card w3-padding" action="signup.php" method="post" enctype="multipart/form-data" onsubmit="return confirm('Are you sure?')">
            <div class="w3-container w3-teal w3-black">
                <h3>Create new account</h3>
            </div>
            <div class="w3-container w3-center">
                <img class="w3-image w3-margin" src="../css/2.png" style="height:100%;width:400px"><br>
                <input type="file" name="fileToUpload" onchange="previewFile()">
            </div>
            <hr>

            <div class="w3-row">
                
                    <p>
                        <label><b>Name</b></label>
                        <input class="w3-input w3-border w3-round" name="name" type="text" required>
                    </p>
                </div>
                <div class="w3-row">
                
                    <p>
                        <label><b>Email</b></label>
                        <input class="w3-input w3-border w3-round" name="email" type="text" required>
                    </p>
                </div>
                
                <div class="w3-row">
                    <p>
                        <label><b>Password</b></label>
                        <input class="w3-input w3-border w3-round" name="password" type="text" required>
                    </p>
                </div>
                <div class="w3-row">
                    <p>
                        <label><b>Repeat-Password</b></label>
                        <input class="w3-input w3-border w3-round" name="password" type="text" required>
                    </p>
                </div>
                <div class="w3-row">
                    <p>
                        <label><b>PhoneNumber</b></label>
                        <input class="w3-input w3-border w3-round" name="phoneNumber" type="text" required>
                    </p>
                </div>

                
            <p>
                <label><b>Home address</b></label>
                <textarea class="w3-input w3-border w3-round" rows="4" width="100%" name="homeaddress" required></textarea>
            </p>

        
                <p>
                    By clicking the Sumbit button,you agree to our 
              <a href="">Terms and Condition</a> and <a href="#">Policy Privacy</a>
            </p>
            <div class="w3-center">
                <p>
                    <input class=" w3-button w3-center w3-white w3-border w3-border-red w3-round-large" type="submit" name="submit" value="Sumbit">
                </p>
                
            </div>
        </form>
        
        <div >
       
    <a href="login.php" input class="w3-button  w3-white w3-border w3-border-red w3-round-large w3-right">Logout</a>
   
</div>

    </div>

  

</body>

</html>