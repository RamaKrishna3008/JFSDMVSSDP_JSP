<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
    <style>
           table {
            width: 100%;
            max-width: 1200px;
            margin: 20px auto;
            border-collapse: collapse;
            table-layout: auto;
            background-color: #fff;
        }

        table, th, td {
            border: 2px solid black;
        }

        th, td {
            padding: 10px;
            text-align: center;
            word-wrap: break-word;
        }

        th {
            background-color: black;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:nth-child(odd) {
            background-color: #fff;
        }
    </style>
</head>
<body>
     <%@include file="adminnavbar.jsp" %>
     
    <h3 align="center"><u>View All Products</u></h3>
    <h3 align="center">Total Products : <c:out value="${count}"/></h3>
    
    <table id="myTable">
        <tr class="header">
            <th></th>
            <th>ID</th>
            <th>Category</th>
            <th>Name</th>
            <th>Description</th>
            <th>Cost</th>
        </tr>

        <c:forEach items="${productlist}" var="product">
            <tr>
                <td>
                    <img src='displayprodimage?id=${product.id}' width="20%" height="20%">
                </td>
                <td><c:out value="${product.id}"></c:out></td>
                <td><c:out value="${product.category}"></c:out></td>
                <td><c:out value="${product.name}"></c:out></td>
                <td><c:out value="${product.description}"></c:out></td>
                <td><c:out value="${product.cost}"></c:out></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
