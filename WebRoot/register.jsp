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

<!-- 注册页面-java script -->
<script type="text/javascript"
	src="backstage/resources/scripts/jquery-1.7.1.js"></script>
	<script type="text/javascript" src="backstage/resources/scripts/jquery.js"></script>
	<script type="text/javascript" src="backstage/resources/scripts/ajaxupload.js"></script>
<script type="text/javascript">
	var flagUsername=0;
	var flagPwd=0;
	var flagAnswer=0;
	var flagMotto=0;
	var flagEmail=0;
	var flagTele = 0;
	$(function() {
	
	
		
		//2. 输入用户名是判断是否已存在
		$("#username").focusout(function() {
		
		if($(this).val()==""){
			
			$("#usernamenull").fadeIn(1000);
			flagUsername=0;
			$("#username1").fadeOut(3000);
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
					if (0 == size) {
						$("#username1").hide();
						$("#username0").show();
						$("#username0").fadeOut(4000);
						flagUsername=1;
					} else if (1 == size) {
						$("#username1").show();
						flagUsername=0;
					}
				}

			});
		}});
		//3. 两个密码是否一致
		$("#pwd2").focusout(function() {
			//alert($(this).val());
			var pwd1 = $(this).val();
			var pwd2 = $("#pwd1").val();

			if (pwd1 == pwd2) {
				flagPwd=1;
				$("#pwdSame").show();
				$("#pwdDifferent").hide();
				$("#pwdSame").fadeOut(4000);
				$("#pwdNull").fadeOut(2000);
			} else{
			flagPwd=0;
				$("#pwdDifferent").show();
				$("#pwdNull").fadeOut(2000);}
				if(pwd1==""){
				$("#pwdNull").show();
				$("#pwdDifferent").hide();
				$("#pwdSame").hide();
				}

		});
		//4. 返回登陆按钮，返回登陆界面
		$("#returnLogin").click(function(){
			//alert("<%=basePath%>login.jsp");
			window.location.href="<%=basePath%>login.jsp";
		});
		//5. 显示和隐藏声明
		$("#agree").mouseenter(function() {
			$("#agreement").slideDown();
		});
		$("#agree").mouseout(function() {
			$("#agreement").slideUp();
		});
		//6. 答案不得为空
		$("#answer").focusout(function() {
			//alert("teset");
			if ($(this).val() == "") {
				flagAnswer = 0;
				$("#answerNull").show();
			} else {
				flagAnswer = 1;
				$("#answerNull").fadeOut(1000);
			}
		});

		//7. 个性签名不得为空
		$("#motto").focusout(function() {
			//alert("teset");
			if ($(this).val() == "") {
				$("#mottoNull").show();
				flagMotto = 0;
			} else {
				flagMotto = 1;
				$("#mottoNull").fadeOut(1000);
			}
		});
		//1. 提交前，检查所有不能为空的项，是否同意了免责声明
		$("#submitbt").click(function() {
			if ((flagUsername + flagPwd + flagAnswer + flagMotto+flagEmail+flagTele) == 6) {
				//alert("true");
				$("#register").submit();
			} else {
				alert("请填入相关信息完成注册！");
			}
		});
		//9、验证邮箱是否符合规则
		$("#email").focusout(function(){
			if(!/^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/.test($(this).val())){
				flagEmail=0;
				$("#emailerror").show();
			}else{
				flagEmail =1;
				$("#emailerror").fadeOut(1000);
			}
			
		});
		//10、验证手机号码
		$("#tele").focusout(function(){
			if(!/^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\d{8}$/.test($(this).val())){
				flagTele = 0;
				$("#teleerror").show();
			}else{
				flagTele =1;
				$("#teleerror").fadeOut(1000);
			}
			
		});
			
		
		//8、文件上传
		//addLabProdPic 上传按钮的id
		new AjaxUpload('#addLabProdPic', {
		//upload 连接到地址为/upload的服务
		action: 'upload', 
		//name: 'picFile',
		//设置返回 格式
		responseType: 'json',
		onSubmit : function(file , ext){
		//正则表达式对上传的文件进行判断
			if (ext && /^(jpg|png|bmp|gif)$/.test(ext.toLowerCase())){
				//this.setData({
				//	'picName': file
				//});
			} else {
				alert("请上传格式为 jpg|png|bmp|gif 的图片！");
				return false;				
			}
		},
		//完成上传之后返回的
		onComplete : function(file,response){
			if(response.error) {
				alert(response.error);
				return;
			}
			//给img标签加src属性，将图片显示出来
			$('#viewImg').attr('src',response.picUrl);
			//将属性赋给input标签下隐藏的imgurl，将路径传到数据库里
			$('#imgurl').attr('value',response.picUrl);
		}		
		});

	});
		
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
			<h3 align="center">加入FaceBlog，
				轻松拥有自己的个人网站！&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</h3>
			<br />
			<div class="content-box">
				<!-- Start Content Box -->
				<div class="content-box-header">
					<h3>用户注册</h3>
					<!--  <ul class="content-box-tabs">
          <li><a href="#tab1" class="default-tab">Table</a></li>
          <li><a href="#tab2">Forms</a></li>
        </ul> -->
					<div class="clear"></div>
				</div>
				<!-- End .content-box-header  default-tab-->
				<div class="content-box-content">
					<div class="tab-content default-tab" id="tab2">
						 <form action="<%=basePath%>addUser" id="register" method="post" >  
							<fieldset class="column-left">
								<!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
								<p>
									<label>用户名</label> <input class="text-input" type="text"
										id="username" name="username" /> <span style="color:red">必填</span><span
										class="input-notification success png_bg" id="username0"
										style="display: none">用户名可用</span><span
										class="input-notification error png_bg" id="username1"
										style="display: none">用户名已被注册</span><span
										class="input-notification error png_bg" id="usernamenull"
										style="display: none">用户名不得为空</span>
								</p>
								<p>
									<label>密码</label> <input class="text-input" type="password"
										id="pwd1" name="pwd" /> <span style="color:red">必填</span>
								</p>
								<!-- Classes for input-notification: success, error, information, attention-->
								<p>
									<label>密码重复</label> <input class="text-input " type="password"
										id="pwd2" /> <span style="color:red">必填</span><span
										class="input-notification error png_bg" id="pwdDifferent"
										style="display: none">密码不一致，请重新输入</span><span
										class="input-notification success png_bg" id="pwdSame"
										style="display: none">密码一致</span><span
										class="input-notification error png_bg" id="pwdNull"
										style="display: none">密码为空，请输入密码</span>
								</p>
								<p>
									<label>安全问题</label> <select name="dropdown" class="small-input"
										id="question">
										<%
											List<Map<String, Object>> results = (List<Map<String, Object>>) request
																																					.getAttribute("questionList");
																																			if (results != null) {
																																				int i = 0;
																																				for (Map<String, Object> result : results) {
										%>
										<option value="<%=result.get("QUESTION_ID")%>"><%=result.get("QUESTION_CONTENT")%></option>
										<%
											System.out.println(i);
																																				}
																																			}
										%>
									</select> <span style="color:red">必填</span>
								</p>
								<p>
									<label>答案</label> <input class="text-input" type="text"
										id="answer" name="answer" /> <span style="color:red">必填</span><span
										class="input-notification error png_bg" style="display: none"
										id="answerNull">请输入答案 </span>
								</p>
								<p>
									<label>个性签名</label> <input class="text-input small-input"
										type="text" id="motto" name="motto" /> <span
										style="color:red">必填</span><span
										class="input-notification error png_bg" style="display: none"
										id="mottoNull">请输入个性签名 </span>
								</p>


								<!-- Classes for input-notification: success, error, information, attention -->

								<!--提示信息   <small>A small description of the field</small>  -->


								<!-- <p>
              <label>作者</label>
              <input class="text-input medium-input datepicker" type="text" id="medium-input" name="medium-input" />
              <!-- <span class="input-notification error png_bg">Error message</span>  -->
								<!--  </p>
            <p>
              <label>关键字</label>
              <input class="text-input large-input" type="text" id="large-input" name="large-input" />
            </p>  -->
								<!-- <p>
              <label>Checkboxes</label>
              <input type="checkbox" name="checkbox1" />
              This is a checkbox
              <input type="checkbox" name="checkbox2" />
              And this is another checkbox </p>
            <p>
              <label>Radio buttons</label>
              <input type="radio" name="radio1" />
              This is a radio button<br />
              <input type="radio" name="radio2" />
              This is another radio button </p> -->
								<!-- <p>
              <label>所属栏目</label>
              <select name="dropdown" class="small-input">
                <option value="option1">栏目1</option>
                <option value="option2">栏目2</option>
                <option value="option3">栏目3</option>
                <option value="option4">栏目4</option>
              </select>
            </p> -->

								<br /> <label>个人简介</label>

							</fieldset>
							<fieldset class="column-right">
								<p>
									<label>上传头像</label>
									<img  src="<%=basePath%>blog/images/moren_icon.jpg" id = "viewImg"name="icon" style="width: 95px;height: 95px ;border:1px solid gray;" />	
									<input type="hidden"  id="imgurl" name="imgurl" value="<%=basePath%>blog/images/moren_icon.jpg">
									<br>
									<button id="addLabProdPic">选择图片</button>
								
								
								</p>


								<p>
									<label>职业</label><input class="text-input" type="text" id="job"
										name="job" />
								</p>

								<p>

									<label>籍贯</label><input class="text-input" type="text"
										id="hometown" name="hometown" />
								</p>
								<p>
									<label>手机号</label><input class="text-input" type="text"
										id="tele" name="tele" /><span style="color:red">必填</span>
										<span class="input-notification error png_bg"  id="teleerror" style="display: none">手机号格式错误</span>
								</p>
								<p>
									<label>邮箱</label><input class="text-input" type="text"
										id="email" name="email" /><span style="color:red">必填</span>
										<span class="input-notification error png_bg"  id="emailerror" style="display: none">邮箱格式错误</span>
								</p>

							</fieldset>
							<p>
								<textarea class="text-input textarea " id="introduction"
									name="introduction" cols="79" rows="15"></textarea>
							</p>
							<div class="clear">
								<input type="checkbox" />&nbsp&nbsp <a
									href="javascript:void(0)" id="agree"> 同意 FaceBlog 责任声明 </a>
							</div>
							<div class="clear"></div>
							<div class="clear" style="display: none" id="agreement">
								<br />
								<h3 align="center">FaceBlog 免责申明</h3>
								1. 用户不应该在博客中发表反动，黄色，暴力的文章，要爱党，爱人民群众，爱党员，共青团员，少先队员，还有站长。<br />2.
								我暂时还没想到，本司保留解释权，肖像权。<br />3. 嗯，那就到这吧！<br /> <br />
							</div>
							<hr>
							<p align="center">
								<input class="button" type="button" value="注册" id="submitbt" />&nbsp&nbsp&nbsp&nbsp<input
									class="button" type="button" value="返回登陆" id="returnLogin" />
							</p>
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
