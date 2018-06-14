<%@ page import="com.domain.Board" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@taglib prefix="html" tagdir="/WEB-INF/tags" %><!--定义前置与tag文件位置-->
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>


<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>板块专区</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Main Style Sheet -->
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>">
    <!--<link href="css/signin.css" rel="stylesheet">-->
    <!-- Modernizr -->
    <script src="<c:url value="/js/vendor/modernizr-2.6.2.min.js" />"></script>

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
                            <a href="<c:url value="/login/doLogout.html"/>"><span class="glyphicon glyphicon-remove">${USER_CONTEXT.userName}(${USER_CONTEXT.credit}),注销${USER_CONTEXT.userType}</span></a>
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

<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">欢迎访问ThisIsUsCommunity</div>
    <div class="panel-body">
        <p>proudly present by you!</p>
    </div>

    <!-- Table -->
    <table  class="table">
        <tr>
            <td colspan="3" bgcolor="#EEEEEE">所有论坛版块</td>
        </tr>
        <tr>
        <tr>
            <c:if test="${USER_CONTEXT.userType == 2}">
                <td>
                    <script>
                        function switchSelectBox(){
                            var selectBoxs = document.all("boardIds");
                            if(!selectBoxs) return ;
                            if(typeof(selectBoxs.length) == "undefined"){//only one checkbox
                                selectBoxs.checked = event.srcElement.checked;
                            }else{//many checkbox ,so is a array
                                for(var i = 0 ; i < selectBoxs.length ; i++){
                                    selectBoxs[i].checked = event.srcElement.checked;
                                }
                            }
                        }
                    </script>
                    <%--<input type="checkbox" onclick="switchSelectBox()"/>--%>
                </td>
            </c:if>
            <td width="20%">版块名称</td>
            <td width="70%">版块简介</td>
            <td width="10%">主题帖数</td>
        </tr>



        <c:forEach var="board" items="${boards}">
            <tr>
                <c:if test="${USER_CONTEXT.userType == 2}">
                    <td><input type="checkbox" name="boardIds" value="${board.boardId}"/></td>
                </c:if>
                <td><a href="<c:url value="/board/listBoardTopics-${board.boardId}.html"/>">${board.boardName}</a></td>
                <td>${board.boardDesc}</td>
                <td>${board.topicNum}</td>
            </tr>
        </c:forEach>
    </table>
</div>

<c:if test="${USER_CONTEXT.userType == 2 || isboardManager}">
    <script>
        function getSelectedBoardIds(){
            var selectBoxs = document.all("boardIds");
            if(!selectBoxs) return null;
            if(typeof(selectBoxs.length) == "undefined" && selectBoxs.checked){
                return selectBoxs.value;
            }else{//many checkbox ,so is a array
                var ids = "";
                var split = ""
                for(var i = 0 ; i < selectBoxs.length ; i++){
                    if(selectBoxs[i].checked){
                        ids += split+selectBoxs[i].value;
                        split = ",";
                    }
                }
                return ids;
            }
        }
        function deleteBoards(){
            var ids = getSelectedBoardIds();
            if(ids){
                var url = "<c:url value="/board/removeBoard.html"/>?boardIds="+ids+"";
                //alert(url);
                location.href = url;
            }
        }

    </script>
    <input type="button" value="删除" onclick="deleteBoards()">
</c:if>



</body>
</html>
