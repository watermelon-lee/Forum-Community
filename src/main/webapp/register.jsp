<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@taglib prefix="html" tagdir="/WEB-INF/tags" %><!--定义前置与tag文件位置-->

<%--
  Created by IntelliJ IDEA.
  User: watermelon
  Date: 18-5-24
  Time: 下午8:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>注册</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Main Style Sheet -->
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>">
    <!--<link href="css/signin.css" rel="stylesheet">-->
    <!-- Modernizr -->
    <script src="<c:url value="/js/vendor/modernizr-2.6.2.min.js" />"></script>
    <!-- Respond.js for IE 8 or less only -->
    <!--[if (lt IE 9) & (!IEMobile)]>
    <![endif]-->
    <script src="<c:url value=" /js/vendor/respond.min.js" />"></script>


</head>
<body>

<script type="text/javascript" color="255,0,0" opacity='0.7' zIndex="-2" count="300" src="//cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.min.js"></script>


<header role="banner">
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<c:url value="/index.html"/> "><img src="<c:url value="/img/logo.png"/>" alt="ThisUsCommunity'" width="200px"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <%--<li><a href="<c:url value="/index.html"/> "><span class="glyphicon glyphicon-home"></span>主页</a></li>--%>
                    <c:if test="${!empty USER_CONTEXT.userName}">
                        <li>
                            <a href="<c:url value="/login/doLogout.html"/>"><span class="glyphicon glyphicon-remove">${USER_CONTEXT.userName}(${USER_CONTEXT.credit}),注销${USER_CONTEXT.userType}</a>
                        </li>
                    </c:if>
                    <c:if test="${empty USER_CONTEXT.userName}">
                        <li><a href="<c:url value="/login.jsp"/>"><span class="glyphicon glyphicon-upload"></span>登录</a></li>
                        <li class="active"><a href="<c:url value="/register.jsp"/>"><span class="glyphicon glyphicon-plus"></span>注册</a></li>
                    </c:if>
                    <li><a href="<c:url value="/index.html"/>"><span class="glyphicon glyphicon-list-alt"></span>社区内容</a></li>
                    <c:if test="${USER_CONTEXT.userType==2}">
                        <li>
                            <a href="<c:url value="/forum/addBoardPage.html"/>"><span class="glyphicon glyphicon-edit"></span>新建版块</a>
                        </li>
                        <li>
                            <a href="<c:url value="/forum/setBoardManagerPage.html"/>"><span class="glyphicon glyphicon-user"></span>管理员设置</a>
                        </li>
                        <li>
                            <a href="<c:url value="/forum/userLockManagePage.html"/>"><span class="glyphicon glyphicon-lock"></span>用户锁定/解锁</a>
                        </li>


                    </c:if>
                </ul>
                <form class="navbar-form navbar-left" role="search" action="<c:url value="/forum/searchTopic.html"/>">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search" name="topicName">
                    </div>
                    <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
                </form>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>


<div  style="position:absolute;top: 10%;left: 39%">
    <img src="<c:url value="/img/user.png"/>">
</div>
<div class="container" style="position: absolute;top: 40%; left: 36%; width: 400px;" >
    <form class="form-signin" action="<c:url value="/register.html"/> " method="post" enctype="multipart/form-data">
        <c:if test="${!empty errorMsg1 }">
            <div style="color: #00b3ee">${errorMsg1}</div>
        </c:if>
        <c:if test="${!empty errorMsg2 }">
            <div style="color: #00b3ee">${errorMsg2}</div>
        </c:if>
        <h2 class="form-signin-heading">Welcome to ThisIsUsCommunity</h2>
        <h3 class="form-signin-heading"></h3>
        <label for="inputUserName" class="sr-only">userName</label>
        <input type="text" id="inputUserName" name="userName" class="form-control" placeholder="用户名" required>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" name="password" class="form-control" placeholder="密码" required>
        <label for="inputPasswordAgdin" class="sr-only">Password</label>
        <input type="password" id="inputPasswordAgdin" name="again" class="form-control" placeholder="确认密码" required>
        <label for="inputAvatar" class="sr-only">Password</label>
        <input id="inputAvatar" type="file" name="avatar">
        <button class="btn btn-lg btn-primary btn-block" type="reset">重置</button>
        <button class="btn btn-lg btn-primary btn-block" type="submit">注册</button>
    </form>
</div> <!-- /container -->




</body>
</html>




