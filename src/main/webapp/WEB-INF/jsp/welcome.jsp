<html>
<head>
    <title>Welcome</title>
    <style><%@include file="../css/welcome.css"%></style>
    <style><%@include file="../css/navBar.css"%></style>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@700&display=swap" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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

<div class = grid>
    <div id = card1>
        <h3 class = headstuff>Welcome,<br> ${account.firstName}!</h3>
        <p id=" divider1">Practice social distancing by putting space
            between yourself and others. Continue to practice healthy habits,
            like washing your hands for at least twenty seconds and staying home if you are sick,
            to help slow the spread of <a href = https://www.cdc.gov/coronavirus/2019-ncov/index.html style="color:#817ffe;">#COVID19</a>.</p>
        <a href ="https://www.cdc.gov/coronavirus/2019-ncov/index.html"> <button id = butt1>Resources</button></a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href ="https://dawgcheck.uga.edu/"> <button id = butt2>Self-check</button></a>

    </div>



</div>

<div class = 'g2' >

    <div class="container">
        <h2>COVID -19 Cases in <span id="country"></span></h2>
        <div class="board">
            <div class="card a"><i class="fa fa-tachometer"></i><h5>Active Cases</h5><span id="active"></span></div>
            <div class="card ca"><i class="fa fa-th-list"></i><h5>Total Cases</h5><span id="cases"></span></div>
            <div class="card cr"><i class="fa fa-times-circle"></i><h5>Critical Cases</h5><span id="critical"></span></div>
            <div class="card d"><i class="fa fa-times"></i><h5>Total Deaths</h5><span id="death"></span></div>
            <div class="card r"><i class="fa fa-check-square-o"></i><h5>Recovered Cases</h5><span id="recovered"></span></div>
            <div class="card t"><i class="fa fa-eye"></i><h5>Total Tests Done</h5><span id="tests"></span></div>
        </div>
    </div>
</div>

<div class = 'g2' >

    <div class = card5>

<%--        <form action="/news">--%>
<%--            <input type="submit" class=butt3 value="US News"/>--%>
<%--        </form>--%>

    <a href ="/news/${account.userName}"><button class="butt3" > <i class="fa fa-newspaper-o"></i><br> US Covid-19 <br> News</button></a>

    </div>

</div>

<script type="text/javascript">
<%--    fetch(htt--%>
    fetch('https://corona.lmao.ninja/v2/countries/France')
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            console.log(data);
            document.getElementById("country").innerHTML = data.country;
            document.getElementById("active").innerHTML = data.active.toLocaleString();
            document.getElementById("cases").innerHTML = data.cases.toLocaleString();
            document.getElementById("critical").innerHTML = data.critical.toLocaleString();
            document.getElementById("death").innerHTML = data.deaths.toLocaleString();
            document.getElementById("recovered").innerHTML = data.recovered.toLocaleString();
            document.getElementById("tests").innerHTML = data.tests.toLocaleString();
            document.getElementById("flag").src = data.countryInfo.flag;
        });
</script>
</body>
</html>