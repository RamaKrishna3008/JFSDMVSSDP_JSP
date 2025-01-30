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
     
    <h3 style="text-align: center;"><u>View All Customers</u></h3>
    <h3 align="center">Total Customers : <c:out value="${count}"/></h3>
    <table>
        <tr>
            <th>ID</th>
            <th>NAME</th>
            <th>GENDER</th>
            <th>EMAIL</th>
            <th>CONTACT</th>
            <th>ADDRESS</th>
        </tr>
        <c:forEach items="${clist}" var="c">
            <tr>
                <td><c:out value="${c.id}"/></td>
                <td><c:out value="${c.name}"/></td>
                <td><c:out value="${c.gender}"/></td>
                <td><c:out value="${c.email}"/></td>
                <td><c:out value="${c.contactno}"/></td>
                <td><c:out value="${c.address}"/></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
