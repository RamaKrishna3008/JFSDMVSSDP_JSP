<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=ISO-8859-1" isELIgnored="false"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="icon" href="ecommerce.png">
	<title>ShopEasy</title>
    <style>
        body {
            background-color: #f4f4f4;
            padding: 20px;
        }

        h3 {
            color: #333;
            margin: 20px 0;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        h3 u {
            border-bottom: 2px solid #2c3e50;
            text-decoration: none;
            padding-bottom: 5px;
        }

        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
        }

        td {
            padding: 10px;
        }

        label {
            display: block;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        input[type="file"] {
            padding: 10px 0;
        }

        textarea {
            height: 100px;
            resize: vertical;
        }

        select {
            background-color: white;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        .button {
            background-color: #3498db;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        .button:hover {
            background-color: #2980b9;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
                margin: 10px;
            }

            td {
                display: block;
                padding: 5px 0;
            }

            tr {
                margin-bottom: 15px;
                display: block;
            }

            td[colspan="2"] {
                text-align: center;
            }
        }
    </style>
</head>
<%@ include file="empnavbar.jsp" %>
<body>
    <h3 align="center"><u>Add Product</u></h3>
    <c:out value="${message}"/>

    <form action="insertproduct" method="post" enctype="multipart/form-data" class="form-container">
        <table>
            <tr>
                <td><label>Category</label></td>
                <td>
                    <select name="category" required="required">
                        <option value="">---Select---</option>
                        <option value="Mobile">Mobile</option>
                        <option value="Laptop">Laptop</option>
                        <option value="Watch">Watch</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td><label>Name</label></td>
                <td><input type="text" name="name" required="required"/></td>
            </tr>

            <tr>
                <td><label>Description</label></td>
                <td>
                    <textarea name="description"></textarea>
                </td>
            </tr>

            <tr>
                <td><label>Cost</label></td>
                <td><input type="number" name="cost" required="required" step="0.01" max=999 /></td>
            </tr>

            <tr>
                <td><label>Image</label></td>
                <td><input type="file" name="productimage" required="required"/></td>
            </tr>

            <tr align="center">
                <td colspan="2"><input type="submit" value="Add" class="button"></td>
            </tr>
        </table>
    </form>
</body>
</html>