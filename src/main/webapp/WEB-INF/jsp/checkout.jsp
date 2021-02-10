<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Webjars for Bootstrap and Jquery -->

<head>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <style><%@include file="../css/registration.css"%></style>
    <style><%@include file="../css/navBar.css"%></style>
    <title>Checkout</title>
</head>

<body>
<header id = 'bal'>

    <a href="/welcome/${account.userName}" id="nav">
        <img src="/images/nav3.png" alt="picture">
    </a>
    <nav>
        <ul id = "nav__links">


            <li><a href = "/donation/${account.userName}"> Donation Center </a></li>
            <li><a href = "/request/${account.userName}" > Request </a></li>
            <li><a href = '/testing/${account.userName}'> Testing Center </a> </li>
            <li><a href = "/edit/${account.email}"> ${account.userName} </a></li>
            <li><a href = "/login"> Logout </a></li>

        </ul>
    </nav>

</header>


<%--@elvariable id="creditCardForm" type=""--%>
<form:form method="POST" modelAttribute="creditCardForm">
    <div class="MyForm form-group">
        <h1>Payment Information</h1>

        <span>${tooMuch} ${ccpaymentNumber}</span>
        <form:input type="text" class="MyInput" id="paymentAmount" placeholder="$" path="paymentAmount"/>

        <span>${ccnameEmpty}</span>
        <form:input type="text" class="MyInput" id="ccName" placeholder="Card Holder" path="ccName"/>

        <span>${ccnumberEmpty}</span>
        <form:input type="text" class="MyInput" id="ccNumber" path="ccNumber" placeholder="Credit Card Number"/>

        <span>${cvcEmpty}</span>
        <form:input type="text" class="MyInput" id="cc_CVC" placeholder="CVC" path="cc_CVC"/>

        <span>${ccdateEmpty}</span>
        <form:input type="date" class="MyInput" id="ccDate" placeholder="Expiration Date" path="ccDate"/>


        <form:button type="submit" class="from-control">Submit</form:button>


    </div>

    <div>

        <img src="/images/pay2.png" alt="picture">
    </div>



</form:form>


</body>
</html>

