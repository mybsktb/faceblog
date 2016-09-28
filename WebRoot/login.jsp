<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>FaceBlog | Sign In</title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="backstage/resources/css/reset.css"
	type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="backstage/resources/css/style.css"
	type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="backstage/resources/css/invalid.css"
	type="text/css" media="screen" />
<!--                       Javascripts                       -->
<!-- jQuery -->
<script type="text/javascript"
	src="backstage/resources/scripts/jquery-1.3.2.min.js"></script>
<!-- jQuery Configuration -->
<script type="text/javascript"
	src="backstage/resources/scripts/simpla.jquery.configuration.js"></script>
<!-- Facebox jQuery Plugin -->
<script type="text/javascript"
	src="backstage/resources/scripts/facebox.js"></script>
<!-- jQuery WYSIWYG Plugin -->
<script type="text/javascript"
	src="backstage/resources/scripts/jquery.wysiwyg.js"></script>
	<script type="text/javascript">
	$(function() {
		$("#user").focus();
		
	})
	</script>
</head>
<body id="login">
<%request.getSession().setAttribute("userName", null);
		request.getSession().setAttribute("userId", null);
	 %>
	<div id="login-wrapper" class="png_bg">
		<div id="login-top" style="padding-top:-80px">
			<h1>FaceBlog</h1>
			<!-- Logo (221px width) -->
			<a href="http://www.baidu.com"><img id="logo"
				src="backstage/resources/images/logo.png" style="width:240px" alt="Simpla Admin logo" />
			</a>
		</div>
		<!-- End #logn-top -->
		<div >
		<div id="login-content" >
			<form action="<%=basePath%>login">
				<div class="notification information png_bg">
					<div align="center"><%if(request.getAttribute("info")!=null){%>
                    <span id="info" style="color: #bb0000">${info}</span>
                    <%}else{%>
                    温馨提示：请不要在公用电脑上保存密码<%}%></div>
				</div>
				<p>
					<label>Username</label> <input class="text-input" type="text" name="user" id="user"/>
				</p>
				<div class="clear"></div>
				<p>
					<label>Password</label> <input class="text-input" type="password" name="pwd" />
				</p>
				<div class="clear"></div>
				<p id="remember-password">
					<input type="checkbox" name="loginAsAdmin" /> Login as Administer<a
						href="<%=basePath%>resetPwd"> &nbsp&nbsp&nbsp忘记密码 </a><br> <input type="checkbox" name="rememberMe" checked="true"/>
					Remember me <a href="<%=basePath%>register">&nbsp&nbsp&nbsp3分钟快速注册 </a> 



				</p>
				<div class="clear"></div>
				<p>

					<input class="button" type="submit" value="Sign In" />

				</p>
			</form>
		</div>
		<!-- End #login-content -->
		
	</div>
	<!-- End #login-wrapper -->
</body>
</html>
