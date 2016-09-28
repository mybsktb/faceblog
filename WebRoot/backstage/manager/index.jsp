<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page  import="com.faceblog.entity.Count" %>
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
</head>

<body>
	<div id="body-wrapper">
		<!-- Wrapper for the radial gradient background -->
		<jsp:include page="../include/leftSide.jsp" ></jsp:include>
		<div id="messages" style="display: none">
			<!-- Messages are shown when a link with these attributes are clicked: href="#messages" rel="modal"  -->
			<h3>系统配置</h3>
			<p>
				<strong>CPU要求</strong> 英特尔I3以上配置<br /> 这里是一些系统配置的要求说明，比如说内存要求在4G以上。
				<small><a href="#" class="remove-link"
					title="Remove message">更多>></a> </small>
			</p>
			<p>
				<strong>内存要求</strong> 4G<br /> 这里是一些系统配置的要求说明，比如说内存要求在4G以上。 <small><a
					href="#" class="remove-link" title="Remove message">更多>></a> </small>
			</p>
			<strong>宽带要求</strong> 10M +<br /> 这里是一些系统配置的要求说明，比如说内存要求在4G以上。
		</div>
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
			<h2>欢迎来到${sessionScope.userName}管理后台</h2>
			<!-- <p id="page-intro">提示：此程序是您建立地区级商家信息门户的首选方案！</p>  -->
			<p>
				您现在使用的是<b>我们</b>开发的一套用于构建商务信息类门户型网站的专业系统！如果您有任何疑问请点左下解的在线客服进行咨询！
			</p>
			<ul class="shortcut-buttons-set">
				<li><a class="shortcut-button" href="../blog/portalLoginServ?user=${sessionScope.userName}"><span>
							<img src="resources/images/icons/comment_48.png" alt="icon" /><br />
							进入个人博客 </span> </a></li>
				<li><a class="shortcut-button" href="manager/NewsSelCate"><span>
							<img src="resources/images/icons/pencil_48.png" alt="icon" /><br />
							新增文章 </span> </a></li>
				<li><a class="shortcut-button" href="manager/cateAdd.jsp"><span>
							<img src="resources/images/icons/paper_content_pencil_48.png"
							alt="icon" /><br /> 新增栏目 </span> </a></li>
				<!-- <li><a class="shortcut-button" href="#"><span> <img src="resources/images/icons/image_add_48.png" alt="icon" /><br />
        Upload an Image </span></a></li>
      <li><a class="shortcut-button" href="#"><span> <img src="resources/images/icons/clock_48.png" alt="icon" /><br />
        Add an Event </span></a></li> -->
			</ul>

			<!-- End .shortcut-buttons-set -->
			<div class="clear"></div>
			<div class="content-box column-left">
				<div class="content-box-header">
					<h3>新闻消息</h3>
				</div>
				<!-- End .content-box-header -->
				<div class="content-box-content">
					<div class="tab-content default-tab">
						<h4>
							未审核新闻数：<a href="${basePath}manager/NewsMgServlet?artiCheck=0" style="color:red">${count.unCheck}条</a>
						</h4><br />
						<h4>
							通过审核新闻数：<a href="${basePath}manager/NewsMgServlet?artiCheck=1" style="color:red">${count.checkOk}条</a>
						</h4><br />
						<h4>
							未通过审核新闻数：<a href="${basePath}manager/NewsMgServlet?artiCheck=-1" style="color:red">${count.checkFalse}条</a>
						</h4><br />
						<h4>
							推荐新闻数：<a href="${basePath}manager/NewsMgServlet?recommend=1" style="color:red">${count.recommend}条</a>
						</h4><br />
						<h4>
							被举报新闻数：<a href="${basePath}manager/NewsMgServlet?artiCheck=-2" style="color:red">${count.checkReport}条</a>
						</h4><br />
						<h4>
							未阅读评论数：<a href="manager/cmtMg?readed=0" style="color:red">${count.unSeeComment}条</a>
						</h4>
					</div>
					<!-- End #tab3 -->
				</div>
				<!-- End .content-box-content -->
			</div>
			<!-- End .content-box -->
			
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
