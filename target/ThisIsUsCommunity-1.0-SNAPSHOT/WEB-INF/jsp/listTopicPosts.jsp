<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="html" tagdir="/WEB-INF/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>${topic.topicTitle}</title>
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
</head>
<body>

<script type="text/javascript" color="255,0,0" opacity='0.7' zIndex="-1" count="300" src="//cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.min.js"></script>


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
                        <li class="active"><a href="<c:url value="/index.html"/>"><span class="glyphicon glyphicon-list-alt"></span>社区内容</a></li>
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

<table border="1px" width="100%">
    <c:forEach var="post" items="${pagePost.result}">
        <tr>
            <td colspan="2">${post.postTitle}</td>
        </tr>
        <tr>
            <td width="20%">
                用户：${post.user.userName}<br>
                积分：${post.user.credit}<br>
                时间：<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${post.createTime}"/></td>
            <td>${post.postText}</td>
        </tr>
    </c:forEach>
</table>
<html:PageBar
        pageUrl="/board/listTopicPosts-${topic.topicId}.html"
        pageAttrKey="pagePost"/>



<form action="<c:url value="/board/addPost.html"/>" method="post" onsubmit="return mySubmit()" >
    回复<hr><A NAME="replyZone"/>
    <table border="1px" width="100%">
        <tr>
            <td width="20%">标题</td>
            <td width="80%"><input type="text" name="postTitle" style="width:100%" /></td>
        </tr>
        <tr>
            <td width="20%">内容</td>
            <td width="80%"><textarea style="width:100%;height:100px"  name="postText"></textarea></td>
        </tr>
        <tr>
            <td colspan="2" align="right">
                <input type="submit" value="回复">
                <input type="reset" value="重置">
                <input type="hidden" name="boardId" value="${topic.boardId}"/>
                <input type="hidden" name="topicId" value="${topic.topicId}"/>
            </td>
        </tr>
    </table>
</form>


<script type="text/javascript">
    function mySubmit(){
        {
            var postTitle = document.getgetElementById("post.postTitle");
            if(postTitle.value != null && postTitle.value.length > 50){
                alert("帖子标题最大长度不能超过50个字符，请调整.");
                postTitle.focus();
                return false;
            }

            var postText = document.getElementById("post.postText");
            if(postText.value == null || postText.value.length < 10){
                alert("回复帖子内容不能小于10个字符。");
                postText.focus();
                return false;
            }

            return true;
        }
    }
</script>


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

