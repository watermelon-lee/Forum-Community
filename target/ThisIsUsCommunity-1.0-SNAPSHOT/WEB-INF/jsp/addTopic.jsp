<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
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


    <title>发表新话题</title>
    <script>
        function mySubmit(){
            with(document){
                var topicTitle = getElementById("topicTitle");
                if(topicTitle.value == null || topicTitle.value.length ==0){
                    alert("话题标题不能为空，请填上.");
                    topicTitle.focus();
                    return false;
                }else if(topicTitle.value.length > 100){
                    alert("话题标题最大长度不能超过100个字符，请调整.");
                    boardName.focus();
                    return false;
                }

                var postText = getElementById("mainPost.postText");
                if(postText.value == null || postText.value.length < 10 ){
                    alert("话题的内容必须大于10个字符");
                    postText.focus();
                    return false;
                }

                return true;
            }

        }
    </script>
</head>
<body>

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
                        <li><a href="<c:url value="/register.jsp"/>"><span class="glyphicon glyphicon-plus"></span>注册</a></li>
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
                <form class="navbar-form navbar-left" role="search">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
                </form>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>


<form action="<c:url value="/board/addTopic.html" />" method="post" onsubmit="return mySubmit()">
    <table border="1px" width="100%">
        <tr>
            <td width="20%">标题</td>
            <td width="80%">
                <input style="width:80%;"  name="topicTitle" value="${topic.topicTitle}">
        </tr>
        <tr>
            <td width="20%">内容</td>
            <td width="80%">
                <textarea style="width:100%;height:400px"  name="mainPost.postText">${topic.mainPost.postText}</textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="right">
                <input type="submit" value="保存">
                <input type="reset" value="重置">
                <input type="hidden" name="boardId" value="${boardId}">
            </td>
        </tr>
    </table>
</form>

<script src="<c:url value="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"/>"></script>
<script>window.jQuery || document.write('<script src="<c:url value="/js/vendor/jquery-1.10.2.min.js"/>"><\/script>')</script>
<script src="<c:url value="/js/plugins.js"/>"></script>
<script src="<c:url value="/js/main.js"/>"></script>

<!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
<script>
    var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
    (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
        g.src=('https:'==location.protocol?'//ssl':'//www')+'.google-analytics.com/ga.js';
        s.parentNode.insertBefore(g,s)}(document,'script'));
</script>

</body>
</html>
