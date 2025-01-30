<%@page import="com.klef.jfsd.springboot.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
<meta charset="UTF-8">
<link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
<style>
    .profile-card {
        max-width: 400px;
        margin: 50px auto;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        background-color: #f9f9f9;
        font-family: Arial, sans-serif;
    }
    .profile-card h3 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
        text-decoration: underline;
    }
    .profile-card b {
        color: #555;
    }
    .profile-info {
        line-height: 1.8;
        color: #333;
        text-align: left;
    }
    .profile-info div {
        margin-bottom: 10px;
    }
</style>
</head>
<body>

<%@include file="empnavbar.jsp" %>

<div class="profile-card">
    <h3>My Profile</h3>
    <div class="profile-info">
        <div><b>ID:</b> <%= emp.getId() %></div>
        <div><b>NAME:</b> <%= emp.getName() %></div>
        <div><b>GENDER:</b> <%= emp.getGender() %></div>
        <div><b>DATE OF BIRTH:</b> <%= emp.getDateofbirth() %></div>
        <div><b>DEPARTMENT:</b> <%= emp.getDepartment() %></div>
        <div><b>SALARY:</b> <%= emp.getSalary() %></div>
        <div><b>LOCATION:</b> <%= emp.getLocation() %></div>

