<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page isELIgnored="false" %>
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

    <title>操作失败</title>
</head>
<body>
操作失败!错误信息：${errorMsg}<br>
<input type="button"  value="返回" onClick="window.history.go(-1);">


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
