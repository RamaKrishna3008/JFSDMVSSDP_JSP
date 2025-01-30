<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="ecommerce.png">
<title>ShopEasy</title>
    
    <style>
        /* Basic CSS for toast notification */
        .toast {
        	background-color:red;
            visibility: hidden; 
            min-width: 250px;
            color: #fff;
            text-align: left;
            border-radius: 5px;
            padding: 16px;
            position: fixed;
            z-index: 1;
            top: 17px;
            left: 80%;
            font-size: 17px;
            transition: opacity 0.5s, visibility 0.5s;
        }

        .toast.show {
            visibility: visible;
            opacity: 1;
        }

        .toast-success { background-color: green; }
        .toast-error { background-color: red; }
    </style>
</head>
<body>
  <%@include file="mainnavbar.jsp" %>

  <div id="toast" class="toast <c:out value='${toastClass}'/>">
      <c:out value="${message}"/>
  </div>

  <!-- Employee Login Form -->
  <h3 style="text-align: center;"></h3>
  <div class="form-container">
    <h3 style="text-align: center;"><u>Login</u></h3>
    <form method="post" action="checklogin">
        <table>
            <tr>
                <td><label for="email">Enter Email ID</label></td>
                <td><input type="mail" id="email" name="email" required/></td>
            </tr>
            <tr>
                <td><label for="epwd">Enter Password</label></td>
                <td><input type="password" id="pwd" name="pwd" required/></td>
            </tr>
            <tr>
                <td colspan="2" class="button-container">
                    <input type="submit" value="Login"/>
                    <input type="reset" value="Clear"/>
                </td>
            </tr>
        </table>
    </form>
  </div>

  <script>
      document.addEventListener("DOMContentLoaded", function() {
          const toast = document.getElementById("toast");
          const message = "<c:out value='${message}'/>";
          
          if (message) {
              toast.classList.add("show");
              setTimeout(() => {
                  toast.classList.remove("show");
              }, 3000); 
          }
      });
  </script>
</body>
</html>
