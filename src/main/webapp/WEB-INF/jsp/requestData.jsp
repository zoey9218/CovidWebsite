<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Request Data</title>
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
<body>



<table id="table" data-search="true" data-toggle="table" data-sort-order="desc" class="table table-striped table-hover sortable">
    <thead>
    <tr>
        <th scope="row" data-field="amount" data-sortable="true" >Amount</th>
        <th scope="row" data-field="reason" data-sortable="true" >Reason</th>
        <th scope="row" data-field="date" data-sortable="true" >Date</th>
        <th scope="row" data-field="activated" data-sortable="true">Activated?</th>
        <th scope="row" data-field="activateRequest" data-sortable="true">Activate Request</th>
        <th scope="row" data-field="deactivateRequest" data-sortable="true">Deactivate Request</th>
    </tr>
    </thead>

    <c:forEach items="${requestForm}" var="request">
        <tr>
            <td>${request.amount}</td>
            <td>${request.reason}</td>
            <td>${request.date}</td>
            <c:if test="${request.active}">
                <td>Yes</td>
            </c:if>
            <c:if test="${!request.active}">
                <td>No</td>
            </c:if>

            <td><a href="/activate/${request.id}"><button class="btn btn-success"></button></a></td>
            <td><a href="/deactivate/${request.id}"><button class="btn btn-danger"></button></a></td>
        </tr>
    </c:forEach>
</table>


</body>
</html>