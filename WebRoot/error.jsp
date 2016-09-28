<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'tes.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
   <h1>服务器出现了问题，可是，站长去吃劲脆鸡腿堡了！~ </h1> <br>
   ${user.user_id}<br/>  
   ${user.user_name}<br/>
   ${sentence} <br/>
   <%for(int i =0;i<2;i++) {%>
   <tr>
   	<td><% %></td>
   	<td>${user.user_name }</td>
   </tr>
   <%} %>
   <hr>
   <table>
   <tbody>
   <c:forEach items="${results}" var = "user">
   <tr>
   	<td>${user.user_id }</td>
   	<td>${user.user_name }</td>
   </tr>
   </c:forEach>
   </tbody>
   </table>
  </body>
</html>
