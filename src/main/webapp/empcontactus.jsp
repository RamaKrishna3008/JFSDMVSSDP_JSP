<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="com.klef.jfsd.springboot.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    Employee emp = (Employee)session.getAttribute("employee");
    if(emp == null) {
        response.sendRedirect("sessionexpiry");
        return;
    }
%> 

<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
    <style>
        .toast {
            visibility: hidden;
            min-width: 250px;
            margin: 0 auto;
            background-color: green;
            color: #fff;
            text-align: center;
            border-radius: 5px;
            padding: 15px;
            position: fixed;
            z-index: 1;
            left: 50%;
            bottom: 30px;
            font-size: 17px;
            transform: translateX(-50%);
        }

        .toast.show {
            visibility: visible;
            animation: fadein 0.5s, fadeout 0.5s 2.5s;
        }

        @keyframes fadein {
            from { bottom: 0; opacity: 0; }
            to { bottom: 30px; opacity: 1; }
        }

        @keyframes fadeout {
            from { bottom: 30px; opacity: 1; }
            to { bottom: 0; opacity: 0; }
        }

        /* Success and Error Colors */
        .toast.success { background-color: #4CAF50; }
        .toast.error { background-color: #f44336; }
    </style>
</head>
<body>
    <%@include file="empnavbar.jsp" %>
    <h3 style="text-align: center;"><u>Contact Us</u></h3>

    <div class="form-container">
        <form method="post" action="sendemail">
            <table>
                <tr>
                    <td><label for="name">Name</label></td>
                    <td><input type="text" id="name" name="name" required/></td>
                </tr>
                <tr>
                    <td><label for="email">Email ID</label></td>
                    <td><input type="email" id="email" name="email" required/></td>
                </tr>
                <tr>
                    <td><label for="subject">Subject</label></td>
                    <td><input type="text" id="subject" name="subject" required/></td>
                </tr>
                <tr>
                    <td><label for="message">Message</label></td>
                    <td>
                        <textarea name="message"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="button-container">
                        <input type="submit" value="Send"/>
                        <input type="reset" value="Clear"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <!-- Toast Notification -->
    <div id="toast" class="toast"></div>

    <script>
        // Function to show toast message
        function showToast(message, type) {
            const toast = document.getElementById("toast");
            toast.className = "toast " + (type === "success" ? "success" : "error");
            toast.textContent = message;
            toast.classList.add("show");

            // Hide the toast after 3 seconds
            setTimeout(() => {
                toast.classList.remove("show");
            }, 3000);
        }

        // Check if a message is available and show it in a toast
        <% if (request.getAttribute("message") != null) { %>
            showToast("<%= request.getAttribute("message") %>", "<%= request.getAttribute("type") %>");
        <% } %>
    </script>
</body>
</html>
