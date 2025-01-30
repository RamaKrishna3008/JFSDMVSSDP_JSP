<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@page import="com.klef.jfsd.springboot.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
  	 Employee emp = (Employee)session.getAttribute("employee");
  		if(emp==null)
  		{
  			response.sendRedirect("sessionexpiry");
  			return ;
  		}
  	%>  
    
<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
<link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
</head>
<body>
<%@include file="empnavbar.jsp" %>
Welcome <%=emp.getName()%>
</body>
</html>
