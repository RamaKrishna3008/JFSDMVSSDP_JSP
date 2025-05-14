
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            padding: 0;
            background-color: var(--gpay-background);
            color: var(--gpay-text);
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .content {
            padding: 20px;
            width: 100%;
            box-sizing: border-box;
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

        /* Enhanced Table Styles */
        table {
            width: 100%;
            max-width: 1200px;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: var(--gpay-surface);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 12px var(--gpay-shadow);
            border: none;
        }

        th, td {
            padding: 16px;
            text-align: center;
            word-wrap: break-word;
            border: none;
            border-bottom: 1px solid var(--gpay-border);
        }

        th {
            background-color: var(--gpay-primary);
            color: white;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 14px;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: rgba(66, 133, 244, 0.05);
        }

        /* Status Badge */
        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-completed {
            background-color: #34A853;
            color: white;
        }

        .status-pending {
            background-color: #FBBC05;
            color: #202124;
        }

        .status-processing {
            background-color: #4285F4;
            color: white;
        }

        .status-cancelled {
            background-color: #EA4335;
            color: white;
        }

        /* Order ID style */
        .order-id {
            font-weight: 500;
            color: var(--gpay-primary);
        }

        /* Amount style */
        .amount {
            font-weight: 500;
        }

        /* Responsive styles */
        @media screen and (max-width: 768px) {
            table {
                width: 95%;
                margin: 20px auto;
            }

            th, td {
                padding: 12px 8px;
                font-size: 14px;
            }

            /* Hide less important columns on mobile */
            .responsive-hide {
                display: none;
            }
        }

        /* Theme toggle */
        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: var(--gpay-surface);
            border: 1px solid var(--gpay-border);
            color: var(--gpay-text);
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px var(--gpay-shadow);
        }

        .theme-toggle:hover {
            box-shadow: 0 4px 8px var(--gpay-shadow);
        }
    </style>
</head>
<body>
    <jsp:include page="Customersidenavbar.jsp"></jsp:include>
    <button class="theme-toggle" onclick="toggleTheme()">
        <i class="fas fa-moon"></i>
        <span>Toggle Theme</span>
    </button>

    <div class="content">
        <h3><u>View All Orders Placed</u></h3>
        <h3>Total No Of Orders Placed : <c:out value="${count}"/></h3>

        <table>
            <tr>
                <th>ORDER ID</th>
                <th>CUSTOMER ID</th>
                <th>PRODUCT ID</th>
                <th>EMAIL</th>
                <th>AMOUNT</th>
                 <th>ORDER STATUS</th>
                <th class="responsive-hide">RAZORPAY ORDER ID</th>
            </tr>
            <c:forEach items="${clist}" var="c">
                <tr>
                    <td><span class="order-id"><c:out value="${c.orderId}"/></span></td>
                    <td><c:out value="${c.customerId}"/></td>
                    <td><c:out value="${c.productid}"/></td>
                    
                    <td><c:out value="${c.email}"/></td>
                    <td><span class="amount">Rs. <c:out value="${c.amount}"/></span></td>
                    <td>
                        <c:choose>
                            <c:when test="${c.orderStatus eq 'paid'}">
                                <span class="status-badge status-completed"><c:out value="${c.orderStatus}"/></span>
                            </c:when>
                            <c:when test="${c.orderStatus eq 'created'}">
                                <span class="status-badge status-cancelled"><c:out value="Not Paid"/></span>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${c.orderStatus}"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="responsive-hide"><c:out value="${c.razorpayOrderId}"/></td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <script>
        function toggleTheme() {
            const body = document.body;
            if (body.getAttribute('data-theme') === 'light') {
                body.removeAttribute('data-theme');
                localStorage.setItem('theme', 'dark');
            } else {
                body.setAttribute('data-theme', 'light');
                localStorage.setItem('theme', 'light');
            }
        }

        // Set theme on load
        document.addEventListener('DOMContentLoaded', () => {
            const savedTheme = localStorage.getItem('theme');
            if (savedTheme === 'light') {
                document.body.setAttribute('data-theme', 'light');
            }
        });
    </script>
</body>
</html>