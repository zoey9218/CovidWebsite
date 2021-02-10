<%@ page import="com.CSCI4050.TermProject.CovidWebsite.entities.RequestEntity" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Donation</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <!--  ----------------------------------------------- -->
    <link href="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.css" rel="stylesheet">

    <script src="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.js"></script>
    <!-- ---------------------------------------------------- -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <style><%@include file="../css/navBar.css"%></style>
    <style><%@include file="../css/donation.css"%></style>
</head>
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
<body>
<span style="margin-left:830px; color:green">${successful}</span>
<table id="table" data-search="true" data-toggle="table" data-sort-order="desc" class="table table-striped table-hover sortable">
    <thead>
    <tr>
        <th scope="row" data-field="userName" data-sortable="true" >Username</th>
        <th scope="row" data-field="amount" data-sortable="true" >Amount</th>
        <th scope="row" data-field="reason" data-sortable="true">Reason</th>
        <th scope="row" data-field="date" data-sortable="true">Date</th>
        <th scope="row" data-field="donate" data-sortable="false">Donate</th>
    </tr>
    </thead>
    <c:forEach items="${requestForm}" var="request">


       <c:if test = "${request.active}" >

        <tr>
            <td>${request.account.userName}</td>
            <td>${request.amount}</td>
            <td>${request.reason}</td>
            <td>${request.date}</td>
            <td><a href="/donate/${account.userName}/${request.id}"><button class="btn btn-secondary"></button></a></td>
        </tr>

        </c:if>
    </c:forEach>


</table>

</body>
</html>