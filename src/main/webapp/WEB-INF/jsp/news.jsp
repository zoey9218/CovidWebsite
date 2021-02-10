<%@ page import="java.net.http.HttpResponse" %>
<html>

<head>
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

    <style><%@include file="../css/main.css"%></style>
    <style><%@include file="../css/news.css" %></style>


    <style>
        #nav img{
            width: 170px;
            height: 30px;
        }

    </style>

    <title>News</title>
</head>
<body>
<header id = 'bal'>

    <a href="/welcome/${account.userName}" id="nav">
        <img src="/images/nav3.png" alt="picture">
    </a>


</header>

<h1>News</h1>

<aside id="column1"></aside>
<aside id="column2"></aside>
<aside id="column3"></aside>
<aside id="column4"></aside>

<script>

    fetch('https://gnews.io/api/v3/search?max=8&image=required&country=us&q=coronavirus|covid-19&token=333e86a5d1adfb9bbd72331f0ee913f0')
        .then(function (response) {
            return response.json();
        })
        .then(function (data) {
            var i;
            var c = 0;
            for (i = 0; i < data.articleCount; i++) {
                if (c < 4) {
                    c = c + 1;
                } else {
                    c = 1;
                }
                document.getElementById("column" + c).innerHTML = document.getElementById("column" + c).innerHTML +
                    "<article><h2><a id=\"source" + i + "\"></a></h2><a id=\"url" + i + "\"><img id=\"image" + i + "\"><h4 id=\"title" + i +
                    "\"></h4></a><p id=\"description" + i +
                    "\"></p></article>";

                document.getElementById("source" + i).innerHTML = data.articles[i].source.name;
                document.getElementById("source" + i).href = data.articles[i].source.url;
                document.getElementById("url" + i).href = data.articles[i].url;
                document.getElementById("image" + i).src = data.articles[i].image;
                document.getElementById("title" + i).innerHTML = data.articles[i].title;
                document.getElementById("title" + i).href = data.articles[i].url;
                document.getElementById("description" + i).innerHTML = data.articles[i].description;
            }
            console.log(data);
        })

</script>
</body>
</html>