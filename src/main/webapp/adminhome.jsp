<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
</head>
<body>
<%@include file="adminnavbar.jsp" %>
<h3 align="center">Total Employees : <c:out value="${count}"/></h3>
</body>
</html>