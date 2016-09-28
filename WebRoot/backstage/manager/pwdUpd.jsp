<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.faceblog.entity.User"%>
<%@ page import="com.faceblog.util.RegexUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理</title>
<%@ include file="../include/head.jsp"%>
<!-- jQuery Datepicker Plugin -->
<script type="text/javascript"
	src="resources/scripts/jquery.datePicker.js"></script>
<script type="text/javascript" src="resources/scripts/jquery.date.js"></script>
<script >
	$(function(){
		$("input[name='first']").focus();
		$("input[name='first']").focusout(function(){
			first = $.trim($("input[name='first']").val());
			if(first==''){
				$("#note").html('');
				$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>密码不能为空！</span>");
				$("input[name='first']").val("").focus();
			}else if(/^[0-9A-Za-z]{6,}$/.test(first)){
				$("input[name='second']").focus();
			}else{
				$("#note").html('');
				$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>密码格式不正确！</span>");
				$("input[name='first']").val("").focus();
			}
		});
		
		$(".button").click(function(){		
				first = $.trim($("input[name='first']").val());
				second = $.trim($("input[name='second']").val());
				$("#note").html('');
				if(first==''){
					$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>密码不能为空！</span>");
					$("input[name='first']").val("").focus();
				}else{
					if(first!=second){
					$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>两次输入密码不同！</span>");
					$("input[name='second']").val("");
					$("input[name='first']").val("").focus();
					}else{
						$.ajax({
							url:'manager/pwdUpd',
							data:{"pwd":first},
							success:function(data){
								$("#note").html('');
								if(data=='true'){
									$("#note").append("<img src='${basePath}resources/images/icons/tick_circle.png' /><span>修改成功！</span>");
									$("#note").show().delay(2000).fadeOut("slow");
									$("input[name='second']").val("");
									$("input[name='first']").val("").focus();
								}
								else{
									$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>修改失败！</span>");
									$("#note").show();
								}
							}
						});	
						
					}
				}
		});
	})
</script>
</head>
<body>
	<div id="body-wrapper">
		<!-- Wrapper for the radial gradient background -->

		<jsp:include page="../include/leftSide.jsp">
			<jsp:param value="user" name="index" />
			<jsp:param value="pwdUpd" name="msg" />
		</jsp:include>

		<!-- End #sidebar -->
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
			<h3>个人中心--修改密码</h3>
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
					<h3>修改密码
					<span id="note"></span>
					</h3>
					<!--  <ul class="content-box-tabs">
          <li><a href="#tab1" class="default-tab">Table</a></li>
          <li><a href="#tab2">Forms</a></li>
        </ul> -->
					<div class="clear"></div>
				</div>
				<!-- End .content-box-header  default-tab-->
				<div class="content-box-content">
					<div class="tab-content default-tab" id="tab2">
							<form>
								<!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
								<fieldset>
								<p>
									<label>新密码</label> <input class="text-input small-input"
										type="password" id="small-input" name="first"/>&nbsp <span style="color:red">*密码由6位字母或数字组成</span>
									<!--错误/正确提示 <span class="input-notification success png_bg">Successful message</span> -->
									<!-- Classes for input-notification: success, error, information, attention -->
									<br />
									<!--提示信息   <small>A small description of the field</small>  -->
								</p>
								<p>
									<label>重复输入</label> <input class="text-input small-input"
										type="password" id="large-input" name="second" />
								</p>
								<p>
									<input class="button" type="button" value="修改" />
								</p>
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
