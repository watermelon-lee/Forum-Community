<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加论坛版块</title>
    <script>
        function mySubmit(){
            with(document){
                var boardName = getElementById("board.boardName");
                if(boardName.value == null || boardName.value.length ==0){
                    alert("版块名称不能为空，请填上.");
                    boardName.focus();
                    return false;
                }else if(boardName.value.length > 150){
                    alert("版块名称最大长度不能超过50个字符，请调整.");
                    boardName.focus();
                    return false;
                }

                var boardDesc = getElementById("board.boardDesc");
                if(boardDesc.value != null && boardDesc.value.length > 255){
                    alert("版块描述最大长度不能超过255个字符，请调整.");
                    boardDesc.focus();
                    return false;
                }

                return true;
            }

        }
    </script>
</head>
<body>
<%@ include file="includeTop.jsp" %>
<form action="<c:url value="/forum/addBoard.html"/>" method="post" onsubmit="return mySubmit()">
    <table border="1px"  width="100%">
        <tr>
            <td width="20%">版块名称</td>
            <td width="80%"><input  type="text" name="boardName" style="width:60%;"/></td>
        </tr>
        <tr>
            <td width="20%">版块简介</td>
            <td width="80%">
                <textarea style="width:80%;height:120px"  name="boardDesc"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="保存">
                <input type="reset" value="重置">
                <input type="hidden" name="_method" value="PUT">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
