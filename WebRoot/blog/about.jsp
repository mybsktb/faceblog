<%@ page language="java" 
	import="java.util.*" 
	import="com.faceblog.util.*"
	import="com.faceblog.entity.*"
	import="com.faceblog.dao.*"
	import="com.faceblog.dao.impl.*"
	contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<base href="<%= basePath%>"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>关于我</title>
		<meta name="keywords" content="个人博客模板,博客模板,响应式" />
		<meta name="description" content="如影随形主题的个人博客模板，神秘、俏皮。" />
		<link href="<%=basePath%>blog/css/base.css" rel="stylesheet">
		<link href="<%=basePath%>blog/css/about.css" rel="stylesheet">
		<link href="<%=basePath%>blog/css/media.css" rel="stylesheet">
		<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
		<!-- 广告 开始-->
		<link rel="stylesheet" href="<%=basePath%>blog/css/ads.css" type="text/css"/>
		<script src="<%=basePath%>blog/js/jquery-1.10.2.js"></script>
        <script src="<%=basePath%>blog/js/ads.js"></script>
        <!-- 广告结束 -->
	</head>
	<body>
	  <div class="ibody">
	  <jsp:include page="/blog/include/header.jsp"></jsp:include>
	  <article>
	  	<%
	  	// 获取用户ID
	  	String userIdStr = request.getParameter("userId");
    	int userId = -1;
    	userId = StringUtil.stringToInt(userIdStr);
    	User user = new User();
    	user.setUser_id(userId);
    	UserMgDaoInterface userMgdaoImpl = new UserMgDaoImpl();
    	user = userMgdaoImpl.getUserInfoByUserId(user);
	  	%>
	    <h3 class="about_h">您现在的位置是：<a href="<%=basePath%>blog/Recomm?userId=<%=userId %>">首页</a>>
	    <a href="<%=basePath %>blog/about.jsp?userId=<%=userId%>">关于我</a></h3>
	    <div class="about">
	      <h2>Just about me</h2>
	      <ul>
	      <% 
	    	if(user != null){
	      %>
	        <p><%=user.getUser_name() %></p>
	        <p>邮箱：<%=user.getUser_email() %></p>
	        <p>个人简介：<%=user.getUser_motto() %></p>
	        <%} %>
	      </ul>
	      <h2>About my blog</h2>
	      <ul class="blog_a">
	        <p><%=user.getUser_name() %></p>
	        <p>邮箱：<%=user.getUser_email() %></p>
	        <p>个人简介：<%=user.getUser_motto() %></p>
	      </ul>
	    </div>
	  </article>
	  <aside>
	      <jsp:include page="/blog/include/blogIndexInformation.jsp"></jsp:include>
	      <div class="about_c">
	      <p><a href="https://mail.qq.com/cgi-bin/loginpage" target="_blank"><img src="http://rescdn.qqmail.com/zh_CN/htmledition/images/function/qm_open/ico_mailme_22.png" alt="个人博客网站"></a></p>
	      <p> 
	        <!--以下是QQ邮件列表订阅嵌入代码-->
	        <a href="https://mail.qq.com/cgi-bin/loginpage" target="_blank"><img border="0" alt="填写您的邮件地址，订阅我们的精彩内容：" src="http://rescdn.list.qq.com/zh_CN/htmledition/images/qunfa/manage/picMode_light_m.png" /></a> </p>
	    </div>
	  </aside>
	  <script src="<%=basePath %>blog/js/silder.js"></script>
	  <div class="clear"></div>
	  <!-- 清除浮动 --> 
	</div>
	
	<!-- 广告 开始-->
    <div id="ads">
		<div class="closeDiv">
			<a href="javascript:closeAds()"><img src="<%=basePath%>blog/images/close_ads.png" alt="关闭"/></a>
			<a href="javascript:closeAds()">关闭</a>
		</div>
		<div class="imgDiv">
			<div class="imgDiv2"><a href="<%=basePath %>blog/blogHomeLogin.jsp" target="_blank"><img src="<%=basePath%>blog/images/ads_faceblog.png" alt=""/></a></div>
		</div>
	</div>
	<!-- 广告结束 -->
	</body>
</html>