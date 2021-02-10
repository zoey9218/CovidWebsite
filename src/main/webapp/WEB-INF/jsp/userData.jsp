<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>UserData</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <!--  ----------------------------------------------- -->
    <link href="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.css" rel="stylesheet">

    <script src="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.js"></script>
    <!-- ---------------------------------------------------- -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>
<%--<a href="/welcome">--%>
<%--    <img src="/images/nav_logo.PNG" alt="picture">--%>
<%--</a>--%>
<body>



<table id="table" data-search="true" data-toggle="table" data-sort-order="desc" class="table table-striped table-hover sortable">
    <thead>
    <tr>
        <th scope="row" data-field="firstName" data-sortable="true" >First Name</th>
        <th scope="row" data-field="lastName" data-sortable="true" >Last Name</th>
        <th scope="row" data-field="userName" data-sortable="true" >Username</th>
        <th scope="row" data-field="email" data-sortable="true">Email</th>
        <th scope="row" data-field="age" data-sortable="true">Age</th>
        <th scope="row" data-field="createdDate" data-sortable="true">Date Created</th>
        <th scope="row" data-field="suspended" data-sortable="true">Suspended?</th>
        <th scope="row" data-field="suspend" data-sortable="false">Suspend User</th>
        <th scope="row" data-field="unsuspend" data-sortable="false">Unsuspend User</th>
        <th scope="row" data-field="delete" data-sortable="false">Delete</th>
    </tr>
    </thead>

    <c:forEach items="${accountForm}" var="account">
        <tr>
            <td>${account.firstName}</td>
            <td>${account.lastName}</td>
            <td>${account.userName}</td>
            <td>${account.email}</td>
            <td>${account.age}</td>
            <td>${account.createdDate}</td>
            <td>${account.suspended}</td>
            <td><a href="/suspend?email=${account.email}"><button class="btn btn-secondary"></button></a></td>
            <td><a href="/unsuspend?email=${account.email}"><button class="btn btn-success"></button></a></td>
            <%-- <td><a href="/userData/delete/${account.email}"><button></button></a></td> --%>
            <td><a href="/delete?email=${account.email}"><button class="btn btn-primary"></button></a></td>
        </tr>
    </c:forEach>
</table>

</body>
</html>