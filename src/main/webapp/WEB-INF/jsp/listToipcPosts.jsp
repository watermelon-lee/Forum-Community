<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="html" tagdir="/WEB-INF/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${topic.topicTitle}</title>
</head>
<body>
<%@ include file="includeTop.jsp" %>
<div style="float=right"><a href="#replyZone">回复</a></div>
<table border="1px" width="100%">
    <c:forEach var="post" items="${pagedPost.result}">
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
        pageUrl="/board/listTopicPosts-${boardForm.topicId}.html"
        pageAttrKey="pagedPost"/>

<script>
    function mySubmit(){
        with(document){
            var postTitle = getElementById("post.postTitle");
            if(postTitle.value != null && postTitle.value.length > 50){
                alert("帖子标题最大长度不能超过50个字符，请调整.");
                postTitle.focus();
                return false;
            }

            var postText = getElementById("post.postText");
            if(postText.value == null || postText.value.length < 10){
                alert("回复帖子内容不能小于10个字符。");
                postText.focus();
                return false;
            }

            return true;
        }

    }
</script>
<form action="<c:url value="/board/addPost.html"/>" method="post" onsubmit="return mySubmit()">
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
                <input type="submit" value="保存">
                <input type="reset" value="重置">
                <input type="hidden" name="boardId" value="${topic.boardId}"/>
                <input type="hidden" name="topic.topicId" value="${topic.topicId}"/>
            </td>
        </tr>
    </table>
</form>
</body>
</html>

