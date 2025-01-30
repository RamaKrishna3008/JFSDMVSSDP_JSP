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
     
    <h3 style="text-align: center;"><u>View All Orders Placed</u></h3>
    <h3 align="center">Total No Of Orders Placed : <c:out value="${count}"/></h3>
    <table>
        <tr>
            <th>ORDER ID</th>
            <th>CUSTOMER ID</th>
            <th>ORDER STATUS</th>
            <th>EMAIL</th>
            <th>AMOUNT</th>
            <th>RazorPay Order Id</th>
        </tr>
        <c:forEach items="${clist}" var="c">
            <tr>
                <td><c:out value="${c.orderId}"/></td>
                <td><c:out value="${c.customerId}"/></td>
                <td><c:out value="${c.orderStatus}"/></td>
                <td><c:out value="${c.email}"/></td>
                <td><c:out value="${c.amount}"/></td>
                <td><c:out value="${c.razorpayOrderId}"/></td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
