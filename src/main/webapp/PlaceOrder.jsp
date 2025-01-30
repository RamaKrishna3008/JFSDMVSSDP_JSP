<%@ page import="com.klef.jfsd.springboot.model.Customer" %>
<%
    Customer c = (Customer) session.getAttribute("customer");
    if (c == null) {
        response.sendRedirect("sessionexpiry");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Google+Sans:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="preload" href="https://checkout.razorpay.com/v1/checkout.js" as="script">
    <script defer src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <link rel="icon" href="ecommerce.png">
    <title>ShopEasy - Payment</title>
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
            background-color: var(--gpay-background);
            font-family: 'Google Sans', sans-serif;
            color: var(--gpay-text);
            min-height: 100vh;
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
            z-index: 1000;
        }

        .theme-toggle:hover {
            background-color: var(--gpay-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px var(--gpay-shadow);
        }

        .payment-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .payment-card {
            width: 100%;
            max-width: 500px;
            background-color: var(--gpay-surface);
            box-shadow: 0 4px 6px var(--gpay-shadow);
            border: 1px solid var(--gpay-border);
            border-radius: 28px;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .card-header {
            background-color: var(--gpay-surface);
            border-bottom: 1px solid var(--gpay-border);
            border-top-left-radius: 28px !important;
            border-top-right-radius: 28px !important;
            padding: 24px;
            transition: background-color 0.3s ease;
        }

        .card-header h3 {
            margin: 0;
            font-weight: 500;
            font-size: 24px;
            color: var(--gpay-text);
            transition: color 0.3s ease;
        }

        .card-body {
            padding: 24px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            font-weight: 500;
            color: var(--gpay-secondary-text);
            margin-bottom: 8px;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .form-control {
            background-color: var(--gpay-background);
            border: 1px solid var(--gpay-border);
            color: var(--gpay-text);
            border-radius: 12px;
            padding: 12px;
            height: auto;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background-color: var(--gpay-background);
            border-color: var(--gpay-primary);
            color: var(--gpay-text);
            box-shadow: 0 0 0 2px rgba(66, 133, 244, 0.2);
        }

        .form-control[readonly] {
            background-color: var(--gpay-background);
            opacity: 0.8;
        }

        .input-group-text {
            background-color: var(--gpay-background);
            border: 1px solid var(--gpay-border);
            color: var(--gpay-secondary-text);
            border-radius: 12px 0 0 12px;
            transition: all 0.3s ease;
        }

        #razorpaypayment {
            background-color: var(--gpay-primary);
            border: none;
            border-radius: 24px;
            padding: 12px 24px;
            font-weight: 500;
            font-size: 16px;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: white;
            width: 100%;
        }

        #razorpaypayment:hover {
            background-color: var(--gpay-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px var(--gpay-shadow);
        }

        .input-group .form-control {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }

        @media screen and (max-width: 768px) {
            .theme-toggle {
                top: 10px;
                right: 10px;
                padding: 8px 16px;
                font-size: 12px;
            }

            .payment-card {
                margin: 10px;
            }

            .card-header {
                padding: 16px;
            }

            .card-body {
                padding: 16px;
            }
        }
    </style>
</head>
<body>
    <button class="theme-toggle" onclick="toggleTheme()" aria-label="Toggle Theme">
        <span id="theme-icon">☽</span>
    </button>

    <div class="container payment-container">
        <div class="card payment-card">
            <div class="card-header">
                <h3 class="text-center">Complete Your Payment</h3>
            </div>
            <div class="card-body">
                <form id="orderForm">
                    <div class="form-group">
                        <label for="customerId">Customer ID</label>
                        <input type="number" id="customerId" class="form-control" value="<%= c.getId() %>" readonly>
                    </div>
                    <input type="hidden" id="orderStatus" value="pending">
                    <div class="form-group">
                        <label for="amount">Payment Amount</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">Rs</span>
                            </div>
                            <input type="text" id="amount" class="form-control" value="${amount}" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email">Customer Email</label>
                        <input type="email" id="email" class="form-control" value="<%= c.getEmail() %>" readonly>
                    </div>
                    <input type="hidden" id="razorpayOrderId" value="">
                    <button type="button" id="razorpaypayment" class="btn btn-primary">Pay Now</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Theme toggle functionality
        function toggleTheme() {
            const html = document.documentElement;
            const currentTheme = html.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            html.setAttribute('data-theme', newTheme);
            localStorage.setItem('theme', newTheme);
            
            const themeIcon = document.getElementById("theme-icon");
            themeIcon.textContent = newTheme === 'dark' ? 'light' : 'dark';
        }

        // Set initial theme
        document.addEventListener('DOMContentLoaded', function() {
            const savedTheme = localStorage.getItem('theme') || 'dark';
            document.documentElement.setAttribute('data-theme', savedTheme);
            const themeIcon = document.getElementById("theme-icon");
            themeIcon.textContent = savedTheme === 'dark' ? 'light' : 'dark';
        });

        // Razorpay payment functionality
        $(document).ready(function () {
            $('#razorpaypayment').on('click', function () {
                const amount = parseFloat($('#amount').val());
                const customerId = $('#customerId').val();
                const email = $('#email').val();

                if (isNaN(amount) || amount <= 0) {
                    alert('Invalid Amount');
                    return;
                }

                const amountInPaise = Math.round(amount * 100);

                $.ajax({
                    url: '/create-order',
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ amount: amount }),
                    success: function (response) {
                        $('#razorpayOrderId').val(response.id);

                        const options = {
                            key: 'rzp_test_d3yeHrfHXiLZIN',
                            amount: amountInPaise,
                            currency: "INR",
                            name: "ShopEasy",
                            description: `Order for Customer ${customerId}`,
                            order_id: response.id,
                            handler: function (response) {
                                $.ajax({
                                    url: '/savePayment',
                                    method: 'POST',
                                    contentType: 'application/json',
                                    data: JSON.stringify({
                                        razorpay_payment_id: response.razorpay_payment_id,
                                        razorpay_order_id: response.razorpay_order_id,
                                        razorpay_signature: response.razorpay_signature,
                                        amount: amount,
                                        customerId: customerId
                                    }),
                                    success: function () {
                                        alert('Payment Successful!');
                                        window.location.href = 'customerhome';
                                    },
                                    error: function () {
                                        alert('Payment Failed');
                                    }
                                });
                            },
                            prefill: { email: email },
                            theme: { color: "#4285f4" }
                        };

                        const rzp = new Razorpay(options);
                        rzp.open();
                    },
                    error: function () {
                        alert('Error creating order. Please try again.');
                    }
                });
            });
        });
    </script>
</body>
</html>