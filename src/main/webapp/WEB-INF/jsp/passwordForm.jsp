
<%@ page import="java.net.URLDecoder" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>

    <!-- Required MetaFiles -->
    <meta name="content-type" content="text-html" charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="keywords" content="keyword1, keyword2, keyword3">
    <meta name="description" content="this is my page">
    <!-- Webjars for Bootstrap and Jquery -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <style><%@include file="../css/resetPassword.css"%></style>
    <style><%@include file="../css/navBar.css"%></style>
    <title>Reset your Password</title>

</head>

<body>
<header>
<%--    <a href="/welcome" id="nav_link">--%>
<%--        <img src="/images/nav_logo.PNG" alt="picture">--%>
<%--    </a>--%>
</header>
<%--@elvariable id="resetPassword" type=""--%>
<form:form modelAttribute="resetPassword" >
<div class="form-group container" id="positionOfLogin">
    <div>
        <br>
        <div style="color:black; font-size: 20px"><b>${title}</b></div><br>

        <span style="color: red">${passwordNoMatch}</span><br>

        <form:password
                    class="form-control MyInput"
                    id="password"
                    style="display: inline; width: 300px;"
                    placeholder="Enter your new password"
                    path="password"/>

        <form:password
                class="form-control MyInput"
                id="confirmPassword"
                style="display: inline; width: 300px;"
                placeholder="Confirm your password"
                path="confirmPassword"/>
<%--        Do another form:password here with new variable i put into account Entity later--%>

        <div>
            <form:button type="submit" style="text-align: center" class="form-control MyButton">Change Password</form:button>
        </div>

    </div>
    </form:form>


</body>
</html>