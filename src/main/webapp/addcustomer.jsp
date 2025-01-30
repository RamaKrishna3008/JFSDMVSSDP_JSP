<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    
    <link type="text/css" rel="stylesheet" href="css/style.css">
    <link rel="icon" href="ecommerce.png">
	<title>ShopEasy</title>
</head>

<body>
  <%@include file="mainnavbar.jsp" %>
  
    <h3 style="text-align: center;"></h3>
    <div class="form-container">

        <form:form modelAttribute="customer" method="post" action="verifyotp">
            <h3 style="text-align: center;"><u>Customer Registration</u></h3>
            <table>

                <tr>
                    <td><label>Name</label></td>
                    <td><form:input path="name" required="required"></form:input></td>
                </tr>
                <tr>
                    <td><label>Gender</label></td>
                    <td>
                        <form:radiobutton path="gender" id="genderMale" value="Male" required="required"/>
                        <label for="genderMale">Male</label>

                        <form:radiobutton path="gender" id="genderFemale" value="Female" required="required"/>
                        <label for="genderFemale">Female</label>

                        <form:radiobutton path="gender" id="genderOthers" value="Others" required="required"/>
                        <label for="genderOthers">Others</label>
                    </td>
                </tr>
                <tr>
                    <td><label>Email ID</label></td>
                    <td><form:input path="email" required="required"/></td>
                </tr>
                <tr>
                    <td><label>Password</label></td>
                    <td><form:password path="password" required="required"/></td>
                </tr>
                <tr>
                    <td><label>Address</label></td>
                    <td><form:input path="address" required="required"/></td>
                </tr>
                <tr>
                    <td><label>Contact No</label></td>
                    <td><form:input path="contactno" required="required"/></td>
                </tr>
                <tr>
                    <td colspan="2" class="button-container">
                        <input type="submit" value="Add"/>
                        <input type="reset" value="Clear"/>
                    </td>
                </tr>
            </table>
        </form:form>

    </div>
</body>
</html>
