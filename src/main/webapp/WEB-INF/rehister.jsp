<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: watermelon
  Date: 18-5-24
  Time: 下午8:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>注册</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Main Style Sheet -->
    <link rel="stylesheet" href="css/main.css">
    <!--<link href="css/signin.css" rel="stylesheet">-->
    <!-- Modernizr -->
    <script src="js/vendor/modernizr-2.6.2.min.js"></script>
    <!-- Respond.js for IE 8 or less only -->
    <!--[if (lt IE 9) & (!IEMobile)]>
    <script src="js/vendor/respond.min.js"></script>
    <![endif]-->

    <script>
        function mycheck(){
            if(document.all("user.password").value != document.all("again").value){
                alert("两次输入的密码不正确，请更正。");
                return false;
            }else
            {
                return true;
            }
        }
    </script>
</head>
<body>

<!--[if lte IE 7]>
<p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
<![endif]-->

<header role="banner">
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html"><img src="img/logo.png" alt="BootStrappin'" width="200px"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="index.html"><span class="glyphicon glyphicon-home"></span>主页</a></li>
                    <li class="active"><a href="#"><span class="glyphicon glyphicon-plus"></span>注册</a></li>
                    <li><a href="#"><span class="glyphicon glyphicon-user"></span>登录</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><span class="glyphicon glyphicon-list-alt"></span>社区<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li role="separator" class="divider"></li>
                            <li><a href="#">社区板块</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="#">社区话题</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">Submit</button>
                </form>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>

<div class="container">
    <form class="form-signin" action="<c:url value="/register.html"/> ">
        <h2 class="form-signin-heading">注册ThisIsUsCommunity～</h2>
        <h3 class="form-signin-heading"></h3>
        <label for="inputUserName" class="sr-only">userName</label>
        <input type="text" id="inputUserName" name="userName" class="form-control" placeholder="姓名" required>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="密码" required>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="email" id="inputEmail" name="again" class="form-control" placeholder="确认密码" required>
        <button class="btn btn-lg btn-primary btn-block" type="reset">重置</button>
        <button class="btn btn-lg btn-primary btn-block" type="submit">注册</button>
    </form>
</div> <!-- /container -->


h
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>

<!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
<script>
    var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
    (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
        g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
        s.parentNode.insertBefore(g,s)}(document,'script'));
</script>

</body>
</html>

<head>
    <title>注册</title>

</head>



