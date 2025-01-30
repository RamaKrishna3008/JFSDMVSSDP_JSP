<%@page import="com.klef.jfsd.springboot.model.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" isELIgnored="false"%>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
    Customer c = (Customer)session.getAttribute("customer");
    if(c==null) {
        response.sendRedirect("sessionexpiry");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="icon" href="ecommerce.png">
    <title>ShopEasy</title>
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
        }

        [data-theme="light"] {
            --gpay-background: #f8f9fa;
            --gpay-surface: #ffffff;
            --gpay-text: #202124;
            --gpay-secondary-text: #5f6368;
            --gpay-border: #dadce0;
            --gpay-shadow: rgba(60, 64, 67, 0.1);
        }

        body {
            font-family: 'Google Sans', sans-serif;
            margin: 0;
            padding: 20px;
            background-color: var(--gpay-background);
            color: var(--gpay-text);
            line-height: 1.6;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 24px;
            background-color: var(--gpay-primary);
            color: white;
            border: none;
            border-radius: 24px;
            cursor: pointer;
            font-family: 'Google Sans', sans-serif;
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

        h3 {
            color: var(--gpay-text);
            font-weight: 500;
            font-size: 24px;
            text-align: center;
            margin: 30px 0;
        }

        h3 u {
            text-decoration: none;
            border-bottom: 2px solid var(--gpay-primary);
            padding-bottom: 5px;
        }

        #myInput {
            width: 50%;
            padding: 16px 24px;
            margin: 20px auto 30px;
            display: block;
            background-color: var(--gpay-surface);
            border: 1px solid var(--gpay-border);
            border-radius: 24px;
            color: var(--gpay-text);
            font-family: 'Google Sans', sans-serif;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        #myInput:focus {
            outline: none;
            border-color: var(--gpay-primary);
            box-shadow: 0 0 0 2px rgba(66, 133, 244, 0.2);
        }

        #myInput::placeholder {
            color: var(--gpay-secondary-text);
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 24px;
            padding: 20px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .product-card {
            background-color: var(--gpay-surface);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 6px var(--gpay-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px var(--gpay-shadow);
        }

        .product-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-bottom: 1px solid var(--gpay-border);
        }

        .product-info {
            padding: 20px;
        }

        .product-category {
            color: var(--gpay-primary);
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .product-name {
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--gpay-text);
        }

        .product-description {
            color: var(--gpay-secondary-text);
            font-size: 14px;
            margin-bottom: 16px;
        }

        .product-price {
            font-size: 20px;
            font-weight: 500;
            color: var(--gpay-text);
            margin-bottom: 16px;
        }

        .buy-button {
            display: inline-block;
            width: 100%;
            padding: 12px 0;
            background-color: var(--gpay-primary);
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

        .buy-button:hover {
            background-color: var(--gpay-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(66, 133, 244, 0.2);
        }

        @media screen and (max-width: 768px) {
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                padding: 10px;
            }

            #myInput {
                width: 90%;
            }

            .theme-toggle {
                top: 10px;
                right: 10px;
                padding: 8px 16px;
                font-size: 12px;
            }
        }
    </style>
</head>

<body>
    <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle Theme">
        <span id="theme-icon">☽</span>
    </button>

    <h3><u>View All Products</u></h3>
    <input type="text" id="myInput" onkeyup="searchProducts()" placeholder="Search products...">
    
    <div class="product-grid" id="productGrid">
        <c:forEach items="${productlist}" var="product">
            <div class="product-card">
                <img class="product-image" src='displayprodimage?id=${product.id}' alt="${product.name}">
                <div class="product-info">
                    <div class="product-category">${product.category}</div>
                    <div class="product-name">${product.name}</div>
                    <div class="product-description">${product.description}</div>
                    <div class="product-price">Rs. ${product.cost}</div>
                    <a href="PlaceOrder?amount=${product.cost}" class="buy-button">Buy Now</a>
                </div>
            </div>
        </c:forEach>
    </div>

    <script>
        function searchProducts() {
            const input = document.getElementById('myInput');
            const filter = input.value.toLowerCase();
            const cards = document.getElementsByClassName('product-card');

            for (let card of cards) {
                const name = card.querySelector('.product-name').textContent.toLowerCase();
                const category = card.querySelector('.product-category').textContent.toLowerCase();
                const description = card.querySelector('.product-description').textContent.toLowerCase();
                
                if (name.includes(filter) || 
                    category.includes(filter) || 
                    description.includes(filter)) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            }
        }

        function toggleTheme() {
            const html = document.documentElement;
            const currentTheme = html.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            html.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            
            const themeIcon = document.getElementById("theme-icon");
            themeIcon.textContent = newTheme === 'dark' ? 'light' : 'dark';
        }

        const savedTheme = localStorage.getItem('theme') || 'dark';
        document.documentElement.setAttribute('data-theme', savedTheme);
        const themeIcon = document.getElementById("theme-icon");
        themeIcon.textContent = savedTheme === 'dark' ? 'light' : 'dark';
    </script>
</body>
</html>