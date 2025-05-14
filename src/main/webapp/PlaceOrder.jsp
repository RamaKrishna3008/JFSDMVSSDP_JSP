<%@page import="com.klef.jfsd.springboot.model.CartItem"%>
<%@ page import="java.util.List" %>
<%@ page import="com.klef.jfsd.springboot.model.Customer" %>

<%
    Customer c = (Customer) session.getAttribute("customer");
    if (c == null) {
        response.sendRedirect("sessionexpiry");
        return;
    }
    
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    String productIds = "";
    if (cart != null && !cart.isEmpty()) {
        productIds = String.join(",", cart.stream().map(item -> String.valueOf(item.getId())).toArray(String[]::new));
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="icon" href="ecommerce.png">
    <title>Payment - ShopEasy</title>
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
            --gpay-success: #34A853;
            --gpay-error: #EA4335;
            --gpay-warning: #FBBC05;
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

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background-color: var(--gpay-surface);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 12px var(--gpay-shadow);
            border: none;
            margin-bottom: 30px;
        }

        .card-header {
            background-color: var(--gpay-primary);
            padding: 20px;
            border-bottom: none;
        }

        .card-header h3 {
            color: white;
            margin: 0;
            font-weight: 500;
            font-size: 20px;
            text-align: center;
        }

        .card-body {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: var(--gpay-text);
            font-weight: 500;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            background-color: var(--gpay-surface);
            border: 1px solid var(--gpay-border);
            border-radius: 8px;
            color: var(--gpay-text);
            font-family: 'Google Sans', sans-serif;
            font-size: 16px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--gpay-primary);
            box-shadow: 0 0 0 2px rgba(66, 133, 244, 0.2);
        }

        .form-control:disabled, .form-control[readonly] {
            background-color: rgba(0, 0, 0, 0.05);
            border-color: var(--gpay-border);
            color: var(--gpay-secondary-text);
        }

        .btn {
            display: inline-block;
            font-weight: 500;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            user-select: none;
            border: 1px solid transparent;
            padding: 12px 24px;
            font-size: 16px;
            line-height: 1.5;
            border-radius: 24px;
            transition: all 0.3s ease;
            cursor: pointer;
            font-family: 'Google Sans', sans-serif;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            color: #fff;
            background-color: var(--gpay-primary);
            border-color: var(--gpay-primary);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 100%;
        }

        .btn-primary:hover {
            background-color: var(--gpay-hover);
            border-color: var(--gpay-hover);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        /* Payment summary section */
        .payment-summary {
            background-color: rgba(66, 133, 244, 0.05);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
        }

        .payment-summary h4 {
            margin-top: 0;
            color: var(--gpay-text);
            font-weight: 500;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .summary-row:last-child {
            margin-bottom: 0;
            padding-top: 10px;
            border-top: 1px solid var(--gpay-border);
            font-weight: 500;
        }

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
            z-index: 1000;
        }

        .theme-toggle:hover {
            box-shadow: 0 4px 8px var(--gpay-shadow);
        }

        /* Secure payment badge */
        .secure-payment {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
            color: var(--gpay-secondary-text);
            font-size: 14px;
        }

        .secure-payment i {
            margin-right: 8px;
            color: var(--gpay-success);
        }

        /* Animation for pay button */
        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }

        .btn-pulse {
            animation: pulse 2s infinite;
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
                margin: 20px auto;
            }
            
            .card-body {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="Customersidenavbar.jsp"></jsp:include>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h3>Complete Your Payment</h3>
        </div>
        <div class="card-body">
            <div class="payment-summary">
                <h4>Order Summary</h4>
                <div class="summary-row">
                    <span>Products</span>
                    <span><%= cart != null ? cart.size() : 0 %> items</span>
                </div>
                <div class="summary-row">
                    <span>Subtotal</span>
                    <span>Rs <%= request.getParameter("amount") %></span>
                </div>
                <div class="summary-row">
                    <span>Shipping</span>
                    <span>Free</span>
                </div>
                <div class="summary-row">
                    <span>Total</span>
                    <span>Rs <%= request.getParameter("amount") %></span>
                </div>
            </div>
            
            <form id="orderForm">
                <input type="hidden" id="customerId" value="<%= c.getId() %>">
                <input type="hidden" id="productIds" value="<%= productIds %>">
                <input type="hidden" id="orderStatus" value="pending">
                <div class="form-group">
                    <label for="amount">Amount to Pay</label>
                    <input type="text" id="amount" class="form-control" value="<%= request.getParameter("amount") %>" readonly>
                </div>
                <button type="button" id="razorpaypayment" class="btn btn-primary btn-pulse">
                    <i class="fas fa-lock" style="margin-right: 8px;"></i>Pay Securely
                </button>
            </form>
            
            <div class="secure-payment">
                <i class="fas fa-shield-alt"></i>
                <span>Secure payment processed by Razorpay</span>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
$(document).ready(function () {
    $('#razorpaypayment').on('click', function () {
        console.log("Initiating Payment...");

        const amount = parseFloat($('#amount').val().trim()) * 100; // Convert to paise
        const customerId = $('#customerId').val();
        const productIds = $('#productIds').val().split(",").map(id => id.trim());

        $.ajax({
            url: '/create-order',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ amount: amount, productIds: productIds }),
            success: function (response) {
                console.log("Order Created: ", response);

                if (!response.id_2) {
                    alert("Order creation failed.");
                    return;
                }

                const options = {
                    key: 'rzp_test_d3yeHrfHXiLZIN',
                    amount: response.amount,
                    currency: "INR",
                    name: "ShopEasy",
                    description: "Order Payment",
                    order_id: response.id_2, 
                    handler: function (razorpayResponse) {
                        console.log("Razorpay Response: ", razorpayResponse);

                        $.ajax({
                            url: '/savePayment',
                            method: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify({
                                razorpay_payment_id: razorpayResponse.razorpay_payment_id,
                                razorpay_order_id: razorpayResponse.razorpay_order_id,
                                razorpay_signature: razorpayResponse.razorpay_signature,
                                amount: amount / 100, 
                                customerId: customerId,
                                product_id: productIds
                            }),
                            success: function (data) {
                                // Show success message with more style
                                const successHtml = `
                                    <div style="text-align: center; padding: 20px;">
                                        <i class="fas fa-check-circle" style="font-size: 64px; color: var(--gpay-success); margin-bottom: 20px;"></i>
                                        <h3>Payment Successful!</h3>
                                        <p>Your order has been placed successfully.</p>
                                        <button onclick="window.location.href='customerhome'" class="btn btn-primary" style="margin-top: 20px;">
                                            Continue Shopping
                                        </button>
                                    </div>
                                `;
                                $(".card-body").html(successHtml);
                                
                                // Redirect after delay
                                setTimeout(function() {
                                    window.location.href = 'customerhome';
                                }, 3000);
                            },
                            error: function (xhr) {
                                alert(xhr.responseText);
                            }
                        });
                    },
                    theme: { color: "#4285f4" }
                };

                const rzp = new Razorpay(options);
                rzp.open();
            },
            error: function () {
                alert("Error creating order.");
            }
        });
    });
});


</script>

</body>
</html>