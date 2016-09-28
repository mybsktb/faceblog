<%@page import="com.faceblog.util.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<script>
function show(){
			if($.trim($("#small-input").val())==''){
				$("#note").html('');
				$("#note").append("<img class='upimg' src='${basePath}resources/images/icons/cross_circle.png' /><span class='upspan'>栏目名不能为空！</span>");
				$("#note").show();
				$("#small-input").val('');
				$("#small-input").focus();
			}
			else{
				cateName = $("#small-input").val();
				$.ajax({
				url:'manager/cateAdd',
				data:{catename:cateName},
				success:function(data){
					$("#note").html('');
					if(data=='true'){
						$("#note").append("<img src='${basePath}resources/images/icons/tick_circle.png' /><span>添加成功！</span>");
						$("#note").show().delay(1000).fadeOut("slow");
						$("#small-input").val("").focus();
					}
					else{
						$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>添加失败！栏目已存在！</span>");
						$("#note").show();
						$("#small-input").select();
						}
					}
				});
			}
		}
$(function(){
	 $("#small-input").focus();
	$("#small-input").keydown(function(){
		 if (event.keyCode == "13") {//keyCode=13是回车键
               	show();
             }
	});
	 $(".button").click(function(){
	 	 show();
	 });

	})
</script>
</head>
<body>
	<div id="body-wrapper">
		<!-- Wrapper for the radial gradient background -->

		<jsp:include page="../include/leftSide.jsp">
			<jsp:param value="blog" name="index" />
			<jsp:param value="cateAdd" name="msg" />
		</jsp:include>

		<div id="main-content">

			<!-- Page Head -->
			<h3>新闻中心--新增栏目</h3>
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

					<h3>
						新增栏目
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
					<form action="javascript:void(0)">
							<fieldset>
								<!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
								<p>
									<label>栏目名称</label> <input class="text-input small-input"
										type="text" id="small-input" name="catename"/>
									<!--  <span class="input-notification success png_bg">Successful message</span> -->
									<!-- Classes for input-notification: success, error, information, attention -->
									<!-- <br />
              <small>A small description of the field</small> </p> -->								
										<input class="button" type="button" value="提交" />
									</p>
							</fieldset>
					</form>
							<div class="clear"></div>
							<!-- End .clear -->
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
