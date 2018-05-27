<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户锁定及解锁</title>
</head>
<body>
<%@ include file="includeTop.jsp" %>
<form action="${context}/forum/userLockManage.html" method="post" >
    <table border="1px" width="100%">
        <tr>
            <td width="20%">用户</td>
            <td width="80%"><select name="userName">
                <option>请选择</option>
                <c:forEach var="user" items="${users}">
                    <option value="${user.userName}">${user.userName}</option>
                </c:forEach>
            </select></td>
        </tr>
        <tr>
            <td width="20%">锁定/解锁</td>
            <td width="80%">
                <input type="radio" name="locked" value="1" />锁定
                <input type="radio" name="locked" value="0" />解锁
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="保存">
                <input type="reset" value="重置">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
