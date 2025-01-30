<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
  <style>
    body {
      background-color: #f0f0f0;
      margin: 0;
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .success-container {
      background-color: #ffffff;
      padding: 2em;
      border-radius: 8px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    .success-container h1 {
      color: #28a745;
      font-size: 2em;
      margin-bottom: 0.5em;
    }

    .success-container p {
      font-size: 1.2em;
      color: #333333;
    }

    .success-container a {
      display: inline-block;
      margin-top: 1em;
      padding: 0.8em 1.5em;
      background-color: #007bff;
      color: #ffffff;
      text-decoration: none;
      border-radius: 4px;
      transition: background-color 0.3s ease;
    }

    .success-container a:hover {
      background-color: #0056b3;
    }
  </style>
</head>

<body>

  <div class="success-container">
    <h1>Success!</h1>
    <p>${message}</p>
    <a href="updateemp">Return to Dashboard</a>
  </div>

</body>

</html>