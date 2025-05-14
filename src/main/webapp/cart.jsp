<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.klef.jfsd.springboot.model.CartItem"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="icon" href="ecommerce.png">
    <title>ShopEasy - Your Cart</title>
    <style>
        :root {
            --gpay-background: #1f1f1f;
            --gpay-surface: #2d2d2d;
            --gpay-text: #ffffff;
            --gpay-secondary-text: #9aa0a6;
            --gpay-primary: #4285f4;
            --gpay-border: #5f6368;
            --gpay-hover: #3367d6;
            --gpay-shadow: rgba(0, 0, 0, 0.2);
            --gpay-danger: #ea4335;
            --gpay-danger-hover: #d33426;
        }

        [data-theme="light"] {
            --gpay-background: #f8f9fa;
            --gpay-surface: #ffffff;
            --gpay-text: #202124;
            --gpay-secondary-text: #5f6368;
            --gpay-border: #dadce0;
            --gpay-shadow: rgba(60, 64, 67, 0.1);
            --gpay-danger: #ea4335;
            --gpay-danger-hover: #d33426;
        }

        body {
            font-family: 'Google Sans', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: var(--gpay-background);
            color: var(--gpay-text);
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: var(--gpay-surface);
            padding: 20px;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 100;
            transition: all 0.3s ease;
            box-shadow: 2px 0 10px var(--gpay-shadow);
        }

        .sidebar h2 {
            color: var(--gpay-primary);
            margin-bottom: 30px;
            font-weight: 500;
            text-align: center;
        }

        .sidebar a {
            display: block;
            padding: 15px;
            color: var(--gpay-text);
            text-decoration: none;
            font-size: 16px;
            border-radius: 8px;
            margin-bottom: 5px;
            transition: all 0.2s ease;
        }

        .sidebar a:hover {
            background-color: var(--gpay-primary);
            color: white;
        }

        .content {
            margin-left: 290px;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        h2 {
            color: var(--gpay-text);
            font-weight: 500;
            font-size: 28px;
            text-align: center;
            margin: 30px 0;
            position: relative;
            display: inline-block;
        }

        h2:after {
            content: '';
            position: absolute;
            width: 60%;
            height: 3px;
            background-color: var(--gpay-primary);
            bottom: -5px;
            left: 20%;
        }

        .cart-container {
            background-color: var(--gpay-surface);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 6px var(--gpay-shadow);
            margin: 30px auto;
            padding: 25px;
            max-width: 1000px;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        .cart-table th {
            background-color: rgba(0, 0, 0, 0.1);
            padding: 12px 15px;
            text-align: left;
            font-weight: 500;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid var(--gpay-border);
        }

        .cart-table td {
            padding: 15px;
            border-bottom: 1px solid var(--gpay-border);
            vertical-align: middle;
        }

        .cart-table tr:last-child td {
            border-bottom: none;
        }

        .cart-table tr:hover {
            background-color: rgba(0, 0, 0, 0.05);
        }

        .product-name {
            font-weight: 500;
            color: var(--gpay-text);
        }

        .product-category {
            color: var(--gpay-primary);
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .product-price, .product-quantity, .product-total {
            font-size: 16px;
            color: var(--gpay-text);
        }

        .remove-btn {
            display: inline-block;
            padding: 8px 16px;
            background-color: var(--gpay-danger);
            color: white;
            text-decoration: none;
            border-radius: 24px;
            font-weight: 500;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .remove-btn:hover {
            background-color: var(--gpay-danger-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(234, 67, 53, 0.3);
        }

        .cart-total {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            font-size: 20px;
            font-weight: 500;
            margin: 20px 0;
            padding: 15px;
            background-color: rgba(0, 0, 0, 0.05);
            border-radius: 8px;
        }

        .cart-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .clear-btn, .checkout-btn, .continue-btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 24px;
            font-weight: 500;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-align: center;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .clear-btn {
            background-color: var(--gpay-danger);
            color: white;
        }

        .clear-btn:hover {
            background-color: var(--gpay-danger-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(234, 67, 53, 0.3);
        }

        .checkout-btn {
            background-color: var(--gpay-primary);
            color: white;
        }

        .checkout-btn:hover {
            background-color: var(--gpay-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(66, 133, 244, 0.3);
        }

        .continue-btn {
            background-color: transparent;
            color: var(--gpay-text);
            border: 1px solid var(--gpay-border);
        }

        .continue-btn:hover {
            background-color: rgba(0, 0, 0, 0.05);
            transform: translateY(-2px);
        }

        .empty-cart {
            text-align: center;
            padding: 50px 20px;
            color: var(--gpay-secondary-text);
        }

        .empty-cart p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .empty-cart-icon {
            font-size: 60px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .header-buttons {
            position: fixed;
            top: 20px;
            right: 20px;
            display: flex;
            gap: 10px;
            z-index: 101;
        }

        .theme-toggle {
            padding: 12px 24px;
            background-color: var(--gpay-primary);
            color: white;
            border: none;
            border-radius: 24px;
            cursor: pointer;
            font-weight: 500;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px var(--gpay-shadow);
        }

        .theme-toggle:hover {
            background-color: var(--gpay-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px var(--gpay-shadow);
        }

        @media screen and (max-width: 768px) {
            .cart-container {
                padding: 15px;
                margin: 15px;
            }

            .cart-table {
                display: block;
                overflow-x: auto;
            }

            .cart-actions {
                flex-direction: column;
                gap: 10px;
            }

            .clear-btn, .checkout-btn, .continue-btn {
                width: 100%;
                margin-bottom: 10px;
            }

            .theme-toggle {
                padding: 8px 16px;
                font-size: 12px;
            }
        }
        
    </style>
</head>
<body>
<jsp:include page="Customersidenavbar.jsp"></jsp:include>
    <div class="content">
        <h2>Your Shopping Cart</h2>

        <div class="cart-container">
            <c:choose>
                <c:when test="${empty cart}">
                    <div class="empty-cart">
                        <p>Your cart is empty</p>
                        <a href="/customerhome" class="continue-btn">Continue Shopping</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cart}">
                                <tr>
                                    <td class="product-name">${item.name}</td>
                                    <td class="product-category">${item.category}</td>
                                    <td class="product-price">Rs. ${item.cost}</td>
                                    <td class="product-quantity">${item.quantity}</td>
                                    <td class="product-total">Rs. ${item.cost * item.quantity}</td>
                                    <td>
                                        <a href="removeFromCart?id=${item.id}" class="remove-btn">Remove</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <c:set var="total" value="0"/>
                    <c:forEach var="item" items="${cart}">
                        <c:set var="total" value="${total + (item.cost * item.quantity)}"/>
                    </c:forEach>

                    <div class="cart-total">
                        Total Amount: Rs. ${total}
                    </div>

                    <div class="cart-actions">
                        <a href="/customerhome" class="continue-btn">Continue Shopping</a>
                        <a href="clearCart" class="clear-btn">Clear Cart</a>
                        <a href="PlaceOrder?amount=${total}" class="checkout-btn">Proceed to Checkout</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function toggleTheme() {
            const html = document.documentElement;
            const currentTheme = html.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            html.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            
            const themeToggleBtn = document.querySelector(".theme-toggle");
            themeToggleBtn.textContent = newTheme === 'dark' ? 'Light' : 'Dark';
        }

        // Initialize theme
        const savedTheme = localStorage.getItem('theme') || 'dark';
        document.documentElement.setAttribute('data-theme', savedTheme);
        document.querySelector(".theme-toggle").textContent = savedTheme === 'dark' ? 'Light' : 'Dark';
    </script>
</body>
</html>