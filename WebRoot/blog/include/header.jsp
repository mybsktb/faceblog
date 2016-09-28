<%@ page language="java" 
	import="java.util.*" 
	import="com.faceblog.util.*"
	import="com.faceblog.entity.*"
	import="com.faceblog.dao.*"
	import="com.faceblog.dao.impl.*"
	pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  <header>
  	<%
	// 获取用户ID
	String userIdStr = request.getParameter("userId");
  	int userId = -1;
  	userId = StringUtil.stringToInt(userIdStr);
  	User user = new User();
  	user.setUser_id(userId);
  	UserMgDaoInterface userMgdaoImpl = new UserMgDaoImpl();
  	user = userMgdaoImpl.getUserInfoByUserId(user);
  	if(user != null){
  	%>
    <h1 style="float:left"><%=user.getUser_name() %></h1>
    <p style="float:right;color:orange">I:<%=session.getAttribute("userId") %> N:<%=session.getAttribute("userName") %> 
    <a href="<%=basePath%>blog/blogHome" style="color:orange">返回首页</a> 
    <a href="<%=basePath%>blog/Recomm?userId=<%=session.getAttribute("userId") %>" style="color:orange">个人博客</a> 
    <a href="<%=basePath%>blog/redirectToBack" style="color:orange">进入后台</a> 
    <a href="<%=basePath%>blog/blogHomeLoadOut" style="color:orange">退出</a> &nbsp<br/>dont forget to add a filter here</p>
    <div class="clear"></div>
    <h2 style="float:left"><%=user.getUser_motto() %></h2>
    <%} %>
    <div class="clear"></div>
    <div class="logo"><a href="<%=basePath%>blog/Recomm?userId=<%=session.getAttribute("userId")%>"></a></div>
    <nav id="topnav">
    	<a href="<%=basePath%>blog/Recomm?userId=<%=userId %>">首页</a>
    	<a href="<%=basePath %>blog/newlist.jsp?userId=<%=userId %>&pagenum=1&cateId=0">文章列表</a>
    	<a href="<%=basePath %>blog/share.jsp?userId=<%=userId %>">图片鉴赏</a>
    	<a href="<%=basePath %>blog/about.jsp?userId=<%=userId%>">关于我</a>
    </nav>
  </header><div class="clear"></div>