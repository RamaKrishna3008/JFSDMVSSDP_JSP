
<%@page import="com.klef.jfsd.springboot.model.Admin"%>
<%
  	 Admin a = (Admin)session.getAttribute("admin");
  		if(a==null)
  		{
  			response.sendRedirect("sessionexpiry");
  			return ;
  		}
  	%> 
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
</head>
<body>
    <h2 align="center">Spring Boot MVC SDP Project</h2>
    <div class="navbar">
    <a href="adminhome">Home</a>
    <div class="dropdown">
        <button class="dropbtn">Employee Tasks</button>
        <div class="dropdown-content">
            <a href="viewallemps">View All Employees</a>
            <a href="deleteemp">Delete Employee</a>
            <a href="updateempstatus">Update Employee Status</a>
            <a href="empreg">Employee Registration</a>
        </div>
    </div>
    <div class="dropdown">
        <button class="dropbtn">Customer Tasks</button>
        <div class="dropdown-content">
            <a href="viewallcustomers">View All Customers</a>
            <a href="viewallOrders">Customer Orders</a>
            <a href="viewallProducts">View All Products</a>
        </div>
    </div>
    <a href="Logout">Logout</a>
</div>

</body>
</html>