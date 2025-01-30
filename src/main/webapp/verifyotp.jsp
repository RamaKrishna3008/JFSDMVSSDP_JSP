<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
</head>
<body>
  <%@include file="mainnavbar.jsp" %>
    <h3 style="text-align: center;"></h3>
    <div class="form-container">
        <form id="otpForm" method="post" action="insertcustomer">
            <h3 style="text-align: center;"><u>OTP Verification</u></h3>
            <table>
                <tr>
                    <td><label for="otp">Enter OTP</label></td>
                    <td><input type="number" id="otp" name="otp" required/></td>
                </tr>
                <tr>
                    <td colspan="2" class="button-container">
                        <input type="submit" value="Login" onclick="validateOtp()"/>
                        <input type="reset" value="Clear"/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <script>
        const serverOtp = "${otp}";

        function validateOtp() {
            const userOtp = document.getElementById("otp").value;

            if (userOtp === serverOtp) {
                document.getElementById("otpForm").submit();
            } else {
                alert("Invalid OTP. Please try again.");
            }
        }
    </script>
</body>
</html>
