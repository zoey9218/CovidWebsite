
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
    <style><%@include file="../css/login.css"%></style>
    <style><%@include file="../css/main.css"%></style>
    <title>Login</title>

</head>
<body>
<header>
        <div class="area" >
            <ul class="circles">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
            </ul>
        </div>
</header>
<%--@elvariable id="login" type=""--%>
<div class="context">
<form:form modelAttribute="login" >
    <div class="form-group container" id="positionOfLogin">
        <div>

            <p style="text-align:center; margin-right:20px"><br>${notVerified} ${invalidEmailPassword} ${suspended}</p>
            <form:input type="email"
                   class="form-control MyInput"
                   id="email"
                   style="display: inline; width: 300px;"
                   placeholder="email@example.com"
            path="email"/>
        <div>
            <form:input type="password"
                        name="password"
                   class="form-control MyInput"
                   id="password"
                   placeholder="password"
            path="password"/>
        </div>

        <div>
            <form:button type="submit" style="text-align: center" class="form-control MyButton">Login</form:button>
        </div>

            <div id="forget_password">
                <a href="/send_Email">Forgot your password?</a>
            </div>
            <div class="login_signup">
                <p id="register_page">Need an account?  >>
                <a href="/registration">Sign Up</a>
                </p>
            </div>
        </div>
</form:form>
    </div>
</body>
</html>