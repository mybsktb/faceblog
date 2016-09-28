<%@page import="com.faceblog.util.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.faceblog.entity.*" %>
<%@ page language="java" import="com.faceblog.dao.impl.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	User user = new User();
	int userId =-1;
	userId=StringUtil.stringToInt( request.getParameter("userId"));
	user.setUser_id(userId);
	UserMgDaoImpl umdi = new UserMgDaoImpl();
	User userforsearch = umdi.getUserInfoByUserId(user);
	if(userforsearch!=null){
		String tel = userforsearch.getUser_tele();
		String telStr = tel.substring(0, 7);
		telStr += "****";
 %>
<div class="avatar"><a style="background: url(<%=userforsearch.getUser_icon() %>) no-repeat ;background-size:163px 163px; " href="<%=basePath%>blog/about.jsp?userId=<%=userforsearch.getUser_id() %>"><span>关于<%=userforsearch.getUser_name() %></span></a></div>
    <div class="topspaceinfo">
      <h1>我是<%=userforsearch.getUser_name()%></h1>
      <p><%=userforsearch.getUser_motto()%></p>
    </div>
    <div class="about_c">
      <p>网名：<%=userforsearch.getUser_name()  %>	</p>
      <p>职业：<%=userforsearch.getUser_job() %></p>
      <p>籍贯：<%=userforsearch.getUser_homtown() %></p>
      <p>电话：<%=telStr%></p>
      <p>邮箱：<%=userforsearch.getUser_email()%></p>
    </div>
<%}%>