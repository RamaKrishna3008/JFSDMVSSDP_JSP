<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="ecommerce.png">
	<title>ShopEasy</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
    body {
    margin: 0;
    overflow: auto;
    position: absolute;
    width: 100%; 
}
body:before {
	content: "";
    position: absolute;
     width: 100%;
    min-height: 100vh;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-image: url("background-image.jpg"); 
    background-size: cover;
    background-repeat: no-repeat;
    background-attachment: inherit;
    background-position: center;
    z-index: -1;
}
    </style>
</head>
<body>
    <h2 align="center">Spring Boot MVC SDP Project</h2>
    <div class="navbar">
         <a href="/">Home</a>
        <a href="addcustomer">Customer Registration</a>
        <a href="Login">Login</a>
    </div>
</body>
</html>