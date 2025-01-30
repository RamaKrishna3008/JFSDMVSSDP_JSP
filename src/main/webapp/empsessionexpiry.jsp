<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
<style>
    body {
        font-family: Arial, sans-serif;
        text-align: center;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center; /* This ensures everything, including the image, is centered */
        height: 100vh;
    }
    
    h2 {
        color: #ff4d4d;
        font-size: 24px;
    }
    
    a {
        text-decoration: none;
        font-size: 16px; /* Smaller font size for the button */
        color:white ;
        border: 1px solid #007bff;
        padding: 10px 20px; /* Reduced padding for a smaller button */
        border-radius: 4px;
        transition: background-color 0.3s ease;
        background-color: #007bff;
    }
    
    a:hover {
        
        color: #fff;
    }

    img {
        display: block;
        max-width: 200px;
        margin: 20px auto; /* Center the image horizontally */
    }
</style>
</head>
<body>
    <img src="session-expired.gif" alt="Session Expired">
    <h2>OOPS ... !!!!! Session Expired</h2>
    <br><br>
    <a href="/">Login Again</a>
</body>
</html>
