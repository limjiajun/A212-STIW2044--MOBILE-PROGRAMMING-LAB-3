<?php

if (isset($_POST['submit'])) {
    include 'dbconnect.php';
    $email = $_POST['email'];
    $password = sha1($_POST['password']);
    $sqllogin = "SELECT * FROM tbl_users WHERE user_email = '$email' AND user_password = '$password'";
    $stmt = $conn->prepare($sqllogin);
    $stmt->execute();
    $number_of_rows = $stmt->fetchColumn();
    
    if ($number_of_rows  > 0) {
        session_start();
        $_SESSION["sessionid"] = session_id();
        $_SESSION["email"] = $email ;
        echo "<script>alert('Login Success');</script>";
        echo "<script> window.location.replace('index.php')</script>";
    } else {
        echo "<script>alert('Login Failed');</script>";
        echo "<script> window.location.replace('login.php')</script>";
    }
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <script src="../js/login.js" defer></script>
    <link rel="stylesheet" href="../css/style.css" />
    
</head>


<body onload="loadCookies()">

    <div class="main">
        <div class="navbar">
            <div class="icon">
                <h2 class="logo">Mytutor</h2>
            </div>

            <div class="menu">
                
                <ul>
                    <li><a href="#">HOME</a></li>
                    <li><a href="#">ABOUT</a></li>
                    <li><a href="#">SERVICE</a></li>
                    
                    <li><a href="#">CONTACT</a></li>
                    </ul>
            </div>

            <div class="search">
                <input class="srch" type="search" name="" placeholder="">
                <a href="#"> <button class="btn">Search</button></a>
            </div>
         </div> 
         
         
        <div class="content">
            <h1>My Tutor <br><span>Website</span> </h1>
            <p class="par">Welcome to MyTutor</p>

                <button class="cn"><a href="#">JOIN US</a></button>
        </div>
       
    <div style="display:flex; justify-content: right">
     
        <div class="w3-container w3-card w3-padding w3-margin" style="width:600px;margin:auto;text-align:left;">
        
        <div class="form"> 
            <form name="loginForm" action="login.php" method="post">

            <div class="w3-center">    
            <h3>Login Page</h3>
</div>
            
                <p>
                    <label><b>Email</b></label>
                    <br/>
                    <input class="w3-input w3-round-large w3-border" type="email" name="email" id="idemail" placeholder="Your email" required>
                  
                </p>

                <p>
                    <label><b>Password</b></label>
                    <input class="w3-input w3-round-large  w3-border" type="password" name="password" id="idpass" placeholder="Your password" 
                    required>
                </p>
                <p>
                <label>RememberMe</label>
                    <input class="w3-radio" name="rememberme" type="radio" id="idremember" onclick="rememberMe()">
                   
                </p>
                <p>
                    <input class=" w3- container w3-button w3-white w3-border w3-border-red w3-round-large  " type="submit" name="submit" 
                    id="idsumit">
                </p>
                
                <div class="container signin">
    <p>Already have an account? <a href="signup.php">Sign in</a>.</p>
  </div>
               
            </form>
        </div>
    </div>
    <div id="cookieNotice" class="w3-right w3-block" style="display: none;">
        <div class="w3-red">
            <h4>Cookie Consent</h4>
            <p>This website uses cookies or similar technologies, to enhance your
                browsing experience and provide personalized recommendations.
                By continuing to use our website, you agree to our
                <a style="color:#11FAA5;" href="/privacy-policy">Privacy Policy</a>
            </p>
            <div class="w3-button">
                <button onclick="acceptCookieConsent();">Accept</button>
            </div>
        </div>
    </div>
    

</body>
<script>
    let cookie_consent = getCookie("user_cookie_consent");
    if (cookie_consent != "") {
        document.getElementById("cookieNotice").style.display = "none";
    } else {
        document.getElementById("cookieNotice").style.display = "block";
    }
</script>

</html>