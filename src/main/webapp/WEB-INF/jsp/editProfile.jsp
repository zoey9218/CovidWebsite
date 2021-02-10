<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Webjars for Bootstrap and Jquery -->

<head>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link rel = "stylesheet" href = "https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <style><%@include file="../css/navBar.css"%></style>
    <style><%@include file="../css/profile1.css" %></style>
    <title>Profile Editor</title>
</head>

<header id = 'bal'>

    <a href="/welcome/${accountInstance.userName}" id="nav">
        <img src="/images/nav3.png" alt="picture">
    </a>
    <nav>
        <ul id = "nav__links">


            <li><a href = "/donation/${accountInstance.userName}"> Donation Center </a></li>
            <li><a href = "/request/${accountInstance.userName}" > Request </a></li>
            <li><a href = '/testing/${accountInstance.userName}'> Testing Center </a> </li>
            <li><a href = "/edit/${accountInstance.email}"> ${accountInstance.userName} </a></li>


        </ul>
    </nav>

</header>
<body>


<%--@elvariable id="editProfile" type=""--%>
<div class=grid>

    <img id=huru src="/images/pro.png">
    <div id=turu>
        <p> @${accountInstance.userName}<br> ${accountInstance.firstName} ${accountInstance.lastName} </p>

    </div>

    <ul id=bara>
        <li data-tab-target="#home" class="active tab" ><i class="fa fa-user-circle-o"></i> Profile</li>
        <li data-tab-target="#pass" class=" tab"><i class="fa fa-lock"></i> Password</li>
    </ul>

</div>



<div class ="tab-content">
<form:form method="POST" modelAttribute="editProfile">

        <div id="home" data-tab-content class="active">
    <div  class="aside  form-group">
    <label for="firstName">First Name:</label><br>
    <p class="error">${firstNameEmpty}</p>
    <form:input type="text" class="MyInput" id="firstName" path="firstName"
                placeholder='${accountInstance.firstName}'/><br>
    <label for="lastName">Last Name:</label><br>
    <p class="error">${lastNameEmpty}</p>
    <form:input type="text" class="MyInput" id="lastName" path="lastName"
                placeholder='${accountInstance.lastName}'/><br>
    <label for="age">Age:</label><br>
    <p class="error">${ageEmpty}</p>
    <form:input type="text" class="MyInput" id="firstName" path="age" placeholder='${accountInstance.age}'/><br>
    <label for="userName">Username:</label><br>
    <p class="error">${userNameEmpty} ${usernameExists}</p>
    <form:input type="text" class="MyInput" id="userName" path="userName"
                placeholder='@${accountInstance.userName}'/><br>
    <label for="email">Email:</label><br>
    <p class="error">${emailExists} ${emailEmpty}</p>
    <form:input type="email" class="MyInput" id="email" path="email" placeholder='${accountInstance.email}'/><br>


    <form:button type="submit" class="from-control">Submit</form:button>


    </div>
        </div>

        <div id="pass" data-tab-content>
    <div  class= "aside  form-group">
    <label for="currentPassword">Current Password:</label><br>
    <p class="error">${currentPasswordNoMatch}</p>
    <p class="error">${currentPasswordEmpty}</p>
    <form:password class="MyInput" id="currentPassword" path="currentPassword"/><br>

    <label for="password">New Password:</label><br>
    <p class="error">${passwordEmpty}</p>
    <p class="error">${confirmPasswordNoMatch}</p>
    <form:password class="MyInput" id="password" path="password"/><br>

    <label for="confirmPassword">Confirm Password:</label><br>
    <p class="error">${confirmPasswordEmpty}</p>
    <form:password class="MyInput" id="confirmPassword" path="confirmPassword"/><br>

    </div>
        </div>


</form:form>

    <script>
        const tabs = document.querySelectorAll('[data-tab-target]')
        const tabContents = document.querySelectorAll('[data-tab-content]')

        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                const target = document.querySelector(tab.dataset.tabTarget)
                tabContents.forEach(tabContent => {
                    tabContent.classList.remove('active')
                })
                tabs.forEach(tab => {
                    tab.classList.remove('active')
                })
                tab.classList.add('active')
                target.classList.add('active')
            })
        })

    </script>
</div>

<div class = 'image'>
    <img src="/images/side2.png">
</div>

</body>
</html>



