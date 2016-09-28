<%@ page language="java" 
	contentType="text/html; charset=UTF-8" 
	import="java.util.*" 
	import="com.faceblog.util.*"
	import="com.faceblog.entity.*"
	import="com.faceblog.dao.*"
	import="com.faceblog.dao.impl.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
  <div class="links">
    <h2>
      <p>友情链接</p>
    </h2>
    <ul>
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
	      <li><a href="<%=basePath%>blog/Recomm?userId=<%=userId %>"><%=user.getUser_name() %>个人博客</a></li>
      	<%}%>
      	<li><a href="http://bbs.3dst.com/forum-75-1.html">3DST技术社区</a></li>
    </ul>
  </div>