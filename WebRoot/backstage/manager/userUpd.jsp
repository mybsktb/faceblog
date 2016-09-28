<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.faceblog.entity.User"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理</title>
<%@ include file="../include/head.jsp"%>
<!-- jQuery Datepicker Plugin -->

<!-- <script type="text/javascript"
	src="resources/scripts/jquery.datePicker.js"></script>
<script type="text/javascript" src="resources/scripts/jquery.date.js"></script> -->
<script type="text/javascript" src="resources/scripts/jquery.js"></script>
<script type="text/javascript" src="resources/scripts/ajaxupload.js"></script>
<script >
	$(function(){
		$("input[name='name']").attr("disabled",true);
		$(".button").click(function(){		
				job = $("input[name='job']").val();
				hometown = $("input[name='hometown']").val();
				tele = $("input[name='tele']").val();
				email = $("input[name='email']").val();
				motto = $("input[name='motto']").val();
				intro = $("textarea[name='intro']").val();
				icon = $("input[name='imgurl']").val();
				$.ajax({
				url:'manager/userUpd',
				data:{"icon":icon,"job":job,"hometown":hometown,"tele":tele,"email":email,"motto":motto,"intro":intro},
				success:function(data){
					$("#note").html('');
					if(data=='true'){
						$("#note").append("<img src='${basePath}resources/images/icons/tick_circle.png' /><span>修改成功！</span>");
						$("#note").show().delay(2000).fadeOut("slow");
						}
					else{
						$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>修改失败！</span>");
						$("#note").show();
						}
					}
				});	
		});
		
		//addLabProdPic 上传按钮的id
		new AjaxUpload('#addLabProdPic', {
		//upload 连接到地址为/upload的服务
		action: '/faceblog/upload', 
		//name: 'picFile',
		//设置返回 格式
		responseType: 'json',
		onSubmit : function(file , ext){
		//正则表达式对上传的文件进行判断
			if (ext && /^(jpg|png|bmp|gif)$/.test(ext.toLowerCase())){
				/* this.setData({
					'picName': file
				}); */
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
	})
</script>
</head>
<body>
	<div id="body-wrapper">
		<!-- Wrapper for the radial gradient background -->

		<jsp:include page="../include/leftSide.jsp">
			<jsp:param value="user" name="index" />
			<jsp:param value="userUpd" name="msg" />
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
			<h3>个人中心--个人信息</h3>
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
					<h3>个人信息
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
									<!--错误/正确提示 <span class="input-notification success png_bg">Successful message</span> -->
									<!-- Classes for input-notification: success, error, information, attention -->
									<br />
									<!--提示信息   <small>A small description of the field</small>  -->
								</p>
								 <p>
									<label>修改头像</label>
									<img  src="${user.user_icon}" id = "viewImg"  style="width: 95px;height: 95px ;border:1px solid gray;" />	
									<input type="hidden"  id="imgurl" name="imgurl" value="${user.user_icon}"/>
									<br/>
									<button id="addLabProdPic">选择图片</button>
									
								
								</p>
								<p>
									<label>职业</label> <input class="text-input small-input"
										type="text" id="large-input" name="job" value="${user.user_job}"/>
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
									<label>所在地</label> <input class="text-input small-input"
										type="text" id="large-input" name="hometown" value="${user.user_homtown}"/>
								</p>
								<p>
									<label>联系电话</label> <input class="text-input small-input"
										type="text" id="large-input" name="tele" value="${user.user_tele}"/>
								</p>
								<p>
									<label>邮箱</label> <input class="text-input small-input"
										type="text" id="large-input" name="email" value="${user.user_email}"/>
								</p>
								<p>
									<label>个性签名</label> <input
										class="text-input medium-input datepicker" type="text"
										id="medium-input" name="motto" value="${user.user_motto}"/>
									<!-- <span class="input-notification error png_bg">Error message</span>  -->
								</p>
								<p>
									<label>自我介绍</label>
									<textarea class="text-input textarea wysiwyg" id="textarea"
										name="intro" cols="79" rows="15" >${user.user_intro}</textarea>
								</p>
								<p>
									<input class="button" type="button" value="修改" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
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
					&#169; Copyright 2010 Your Company | Powered by <a href="#">admin
						templates</a> | <a href="#">Top</a> </small>
			</div>
			<!-- End #footer -->
		</div>
		<!-- End #main-content -->
	</div>
</body>

</html>
