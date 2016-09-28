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
	<!-- reset pwd 页面-java script -->
<script type="text/javascript"
	src="backstage/resources/scripts/jquery-1.7.1.js"></script>
<script type="text/javascript">
	$(function() {
	//0. 参数
	var errorTimeCount=2;//count the time you have tried
	var flagUsername=0;//the check of user name
	$("#email60").click(function(){
		$(this).next("span").html("请打开自己的手机中的时钟倒计时");	
	})
	//2. 判断答案是否正确
	$("#resetPwd").click(function(){
		if(flagUsername==0){
		$("#usernamenull").show();
		return;}
		if(flagUsername==2){
		$("#username0").show();
		return;}
		//alert("yes");
		$.ajax({
		url:"<%=basePath%>checkAnswerServ",
		data:{answer:$("#answer").val(),username:$("#username").val()},
		success:function(data){
		var result=	data.toString().split("&")[0];	
		var info= data.toString().split("&")[1];	
		if(result==1)
			{var flag = confirm(info);
			if(flag)
				window.location.href="login.jsp";
			}
		else{ 
		if(errorTimeCount>=0)
		alert(info+"\n三十分钟内剩余尝试机会"+(errorTimeCount--));
		else{
		window.location.href="login.jsp";
		}}
		}
		})
	}) 
	
	//1. 判断用户名是否存在
	$("#username").focusout(function() {
		
		if($(this).val()==""){
			$("#username1").fadeOut(2000);
			$("#username0").fadeOut(2000);
			$("#usernamenull").fadeIn(1000);
			flagUsername=0;
		}else
		{
			
			$("#usernamenull").hide();
			var url="<%=basePath%>userIsExistedServ";
			$.ajax({
				url : url,
				data : {
					username : $("#username").val()
				},
				success : function(data) {
					var size = data.toString().split("&")[0];//alert(data);
					var questionContent = data.toString().split("&")[1];//alert(questionContent);
					$("#questionContent").hide();
					if (0 == size) {
						$("#username1").hide();
						$("#username0").show();
						$("#usernamenull").hide();
						$("#dropdown").show();
						flagUsername=2;
					} else if (1 == size) {
						$("#username1").show();
						flagUsername=1;
						$("#username1").fadeOut(2000);
						$("#username0").hide();
						$("#usernamenull").hide();
						$("#questionContent").html(questionContent).fadeIn(2000);
						$("#dropdown").hide();
					}
				}

			});
		}});
	})
</script>
</head>

<body>
	<div id="body-wrapper">
		<div id="main-content">
			<!-- Main Content Section with everything -->
			<noscript>
				<!-- Show a notification if the user has disabled javascript -->
				<div class="notification error png_bg">
					<div>
						Javascript is disabled or is not supported by your browser. Please
						<a href="http://browsehappy.com/"
							title="Upgrade to a better browser">upgrade</a> your browser or <a
							href="http://www.google.com/support/bin/answer.py?answer=23852"
							title="Enable Javascript in your browser">enable</a> Javascript
						to navigate the interface properly. Download From <a
							href="http://www.exet.tk">exet.tk</a>
					</div>
				</div>
			</noscript>
			<!-- Page Head -->

			<!-- <h2>Welcome </h2>
	
    <p id="page-intro">What would you like to do?</p>
    <ul class="shortcut-buttons-set">
      <li><a class="shortcut-button" href="#"><span> <img src="resources/images/icons/pencil_48.png" alt="icon" /><br />
        Write an Article </span></a></li>
      <li><a class="shortcut-button" href="#"><span> <img src="resources/images/icons/paper_content_pencil_48.png" alt="icon" /><br />
        Create a New Page </span></a></li>
      <li><a class="shortcut-button" href="#"><span> <img src="resources/images/icons/image_add_48.png" alt="icon" /><br />
        Upload an Image </span></a></li>
      <li><a class="shortcut-button" href="#"><span> <img src="resources/images/icons/clock_48.png" alt="icon" /><br />
        Add an Event </span></a></li>
      <li><a class="shortcut-button" href="#messages" rel="modal"><span> <img src="resources/images/icons/comment_48.png" alt="icon" /><br />
        Open Modal </span></a></li>
    </ul>
	-->
			<!-- End .shortcut-buttons-set -->
			<div class="clear"></div>
			<!-- End .clear -->

			<div class="content-box">
				<!-- Start Content Box -->
				<div class="content-box-header">
					<h3>找回密码</h3>
					<!--  <ul class="content-box-tabs">
          <li><a href="#tab1" class="default-tab">Table</a></li>
          <li><a href="#tab2">Forms</a></li>
        </ul> -->
					<div class="clear"></div>
				</div>
				<!-- End .content-box-header  default-tab-->
				<div class="content-box-content">
					<div class="tab-content default-tab" id="tab2">
						<form action="#" method="post">
							<fieldset class="column-left" >
								<!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
								<p>
									<label>1. 通过安全问题找回密码</label><br /> 用户名 &nbsp&nbsp：<input class="text-input" type="text"
										id="username" name="username" /> <span
										class="input-notification error png_bg" id="username0"
										style="display: none">用户名不存在</span><span
										class="input-notification success png_bg" id="username1"
										style="display: none"></span><span
										class="input-notification error png_bg" id="usernamenull"
										style="display: none">用户名不得为空</span>
								<br />
									<br /> 安全问题： <select name="dropdown" class="small-input" id="dropdown">
										<%
											List<Map<String, Object>> results = (List<Map<String, Object>>) request
													.getAttribute("questionList");
											if (results != null) {
												int i = 0;
												for (Map<String, Object> result : results) {
										%>
										<option value="option<%=i++%>"><%=result.get("QUESTION_CONTENT")%></option>
										<%
											System.out.println(i);
												}
											}
										%>
									</select> 
									<span style="display: none" id="questionContent"> 123</span>
									<br /> <br /> 答案&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp： <input
										class="text-input" type="text" id="answer"
										name="small-input" />&nbsp <input class="button"
										type="button" value="重置密码" id="resetPwd" />
								</p>
								<p>
									<label>2. 通过邮件找回密码</label> <input class="text-input "
										type="text" />&nbsp <input class="button" type="button"
										value="发送邮件" id="email60" /><span>这里做一下那个60秒倒计时</span>
								</p>
								<p>
									<label>3. 通过手机号找回密码</label> <input class="text-input "
										type="text" />&nbsp <input class="button" type="button"
										value="发送短信" />这里做一下那个60秒倒计时
								</p>
								<p>
									<label>4. 请站长吃一个劲脆鸡腿堡</label> <input class="button"
										type="button" value="点击查看站长支付宝账户密码" />
								</p>






							</fieldset>
							<fieldset class="column-left" >
								<h3>常见问题</h3>
								<ul>
								<li><a><b>我是站长，我把自己的密码忘记了怎么办？</b></a><br/></li>
								请与我司售后联系，热线电话110、120以及119.
								<li><a><b>我是普通用户，我的博客给管理员删光了，气死了！还把我密码改了。</a></b></li>
								小case，自己都重新写一遍，写了再删掉，重新写！
								<li><a><b>你们的图片功能还不能上传啊？我的头像为啥是个劲脆鸡腿堡啊？</a></b></li>
								站长吃劲脆鸡腿堡去了~	
								<li><a><b>请问f(x)=x+sin(x)的话,这个函数的1到10的积分怎么做？急，要交卷了。	</a></b></li>
								终于做出来了，汗，做到了下班，幸亏站长去吃劲脆鸡腿堡了，x平方除2的导数是。。。
								</ul>
								
								<br/>
								<br/>
								<br/>
								<h3>在线客服</h3>
								<ul>
								<li><a><b>客服小民</b></a><br/></li>
									
																</ul>
							</fieldset>
							<div class="clear"></div>
							<!-- End .clear -->
						</form>
					</div>
					<!-- End #tab2 -->
				</div>
				<!-- End .content-box-content -->
			</div>
			<div class="clear"></div>
			<div id="footer">
				<small> <!-- Remove this notice or replace it with whatever you want -->
					&#169; Copyright 2010 Your Company | Powered by <a href="#">admin
						templates</a> | <a href="#">Top</a> </small>
			</div>
			<!-- End #footer -->
		</div>
		<!-- End #main-content -->
	</div>
</body>
</html>
