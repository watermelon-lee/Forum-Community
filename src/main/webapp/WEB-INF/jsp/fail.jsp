<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>操作失败</title>
</head>
<body>
操作失败!错误信息：${errorMsg}<br>
<input type="button"  value="返回" onClick="window.history.go(-1);">
</body>
</html>
