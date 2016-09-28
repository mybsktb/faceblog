<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.faceblog.entity.User"%>
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
		$("input[name='artiname']").attr("disabled",true);
		$("input[name='fromuser']").attr("disabled",true);
		$("input[name='content']").attr("disabled",true);
		$("#update").click(function(){		
			content = $("textarea[name='content']").val();
			commentid = $("#update").attr("commentid");
			if($.trim(content)==''){
				$("#note").html('');
				$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>回复内容不能为空！</span>");
				}
			else{
				$.post("manager/reCmtUpd?content="+content+"&commentid="+commentid, function(data){
					$("#note").html('');
					if(data=='true'){
						$("#note").append("<img src='${basePath}resources/images/icons/tick_circle.png' /><span>修改成功！</span>");
						$("#note").show().delay(1000).fadeOut("slow");
						window.setTimeout("window.location='manager/cmtMg'", 2000);
						}
					else{
						$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>修改失败！</span>");
						$("#note").show();
						}
				});
				}	
		});
		$("#recomment").click(function(){		
			content = $("textarea[name='content']").val();
			commentid = $("#recomment").attr("commentid");
			if($.trim(content)==''){
				$("#note").html('');
				$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>回复内容不能为空！</span>");
				}
			else{
				$.post("manager/reCmtAdd?content="+content+"&commentid="+commentid, function(data){
					$("#note").html('');
					if(data=='true'){
						$("#note").append("<img src='${basePath}resources/images/icons/tick_circle.png' /><span>回复成功！</span>");
						$("#note").show().delay(1000).fadeOut("slow");
						window.setTimeout("window.location='manager/cmtMg'", 2000);
						}
					else{
						$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>回复失败！</span>");
						$("#note").show();
						}
				});
				}	
		});
		
	})
</script>
</head>
<body>
	<div id="body-wrapper">
		<!-- Wrapper for the radial gradient background -->

		<jsp:include page="../include/leftSide.jsp">
			<jsp:param value="blog" name="index" />
			<jsp:param value="cmtMg" name="msg" />
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
			<h3>新闻中心--评论管理</h3>
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
					<h3>评论回复
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
							<fieldset>
								<!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
								<p>
									<label>文章标题:</label> <label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									${result.get(0).get('arti_name')}</label>
									<!--错误/正确提示 <span class="input-notification success png_bg">Successful message</span> -->
									<!-- Classes for input-notification: success, error, information, attention -->
									<br />
									<!--提示信息   <small>A small description of the field</small>  -->
								</p>
								<p>
									<label>评论者:</label><label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									${result.get(0).get('user_name')}</label>
								</p>
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
								<p>
									<label>评论:</label> <label>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									${result.get(0).get('comment_content')}</label>
								</p>
								
								<p>
									<label>回复</label>
									<textarea class="text-input textarea wysiwyg" id="textarea"
										name="content" cols="79" rows="5" >
										<%
										if(request.getAttribute("content")!=null) {
										%>
										${content}
										<%
										}
										 %>
										</textarea>
								</p>
								<p>
										<%
										if(request.getAttribute("content")!=null) {
										%>
										<input id="update" class="button" type="button" value="修改" commentid="${result.get(0).get('comment_id')}"/>
										<%
										}else{
										 %>
										<input id="recomment" class="button" type="button" value="回复 " commentid="${result.get(0).get('comment_id')}"/>
										<%
										}
										 %>
										 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
										 <span id="note"></span>
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
					&#169; Copyright 2010 Your Company | Powered by admin
						templates | Top </small>
			</div>
			<!-- End #footer -->
		</div>
		<!-- End #main-content -->
	</div>
</body>

</html>
