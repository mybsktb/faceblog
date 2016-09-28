<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/backstage/";
%>
<!-- Wrapper for the radial gradient background -->
<script>
	$(function(){
		$("a[name='index']").click(function(){
			$("a[name='index']").attr("class","nav-top-item");
			$(this).attr("class","nav-top-item current");
		});
	})
</script>
<div id="sidebar">
	<div id="sidebar-wrapper">
		<!-- Sidebar with logo and menu -->
		<h1 id="sidebar-title">
			<a href="manager/index">Admin 管理</a>
		</h1>
		<!-- Logo (221px wide) -->
		<a href="manager/index"><img id="logo" src="resources/images/logo2.png"
			style="width:200px" alt="admin 标签" /> </a>
		<!-- Sidebar Profile links -->
		<div id="profile-links">
			你好, <a href="manager/userMg" title="Edit your profile">${sessionScope.userName}</a>,欢迎来到后台<br /> <br />
			<a href="manager/index" title="View the Site">首页</a> | <a href="../login.jsp"

				title="Sign Out">退出登录</a>
		</div>
		<ul id="main-nav">
			<!-- Accordion Menu -->

			<li><a href="manager/index" class="nav-top-item no-submenu"> <!-- Add the class "no-submenu" to menu items with no sub menu -->

					首页 </a>
			</li>
			<li>
			<c:if test="${param.index=='blog'}">
				<a href="#" class="nav-top-item current" name="index"> <!-- Add the class "current" to current menu item -->
					新闻中心 </a>
			</c:if>
			<c:if test="${param.index!='blog'}">
				<a href="#" class="nav-top-item" name="index"> 新闻中心 </a>
			 </c:if>
				<ul>
					<li>
					<c:if test="${param.msg=='cateAdd'}">
						<a class="current" href="${basePath}manager/cateAdd.jsp">新增栏目</a>
					</c:if>
					<c:if test="${param.msg!='cateAdd'}">
						<a href="${basePath}manager/cateAdd.jsp">新增栏目</a> 
					</c:if>					
					</li>

					<li>
					<c:if test="${param.msg=='cateMg'}">
						<a class="current" href="${basePath}manager/cateMg">栏目管理</a>
					</c:if>
					<c:if test="${param.msg!='cateMg'}">
						<a href="${basePath}manager/cateMg">栏目管理</a>
					</c:if>
					</li>

					<li>
					<c:if test="${param.msg=='newsAdd'}">
						<a class="current" href="${basePath}manager/NewsSelCate">新增文章</a>
					</c:if>
					<c:if test="${param.msg!='newsAdd'}">
						<a href="${basePath}manager/NewsSelCate">新增文章</a>
					</c:if>
					</li>
					<li>
					<c:if test="${param.msg=='newsMg'}">
						<a class="current" href="${basePath}manager/NewsMgServlet">文章管理</a>
					</c:if>
					<c:if test="${param.msg!='newsMg'}">
						 <a href="${basePath}manager/NewsMgServlet">文章管理</a> 
					 </c:if> 
					  </li>
					  <li>
						<c:if test="${param.msg=='cmtMg'}">
							<a class="current" href="${basePath}manager/cmtMg">评论管理</a>
						</c:if>
						<c:if test="${param.msg!='cmtMg'}">
					 		<a href="${basePath}manager/cmtMg">评论管理</a> 
					 	</c:if>
					  </li>
					  <!-- Add class "current" to sub menu items also
            <li><a href="#">Manage Comments</a></li>
            <li><a href="#">Manage Categories</a></li>
			 -->
				</ul>
			</li>
			<li>
			<c:if test="${param.index=='user'}">
				<a href="#" class="nav-top-item current" name="index"> 个人中心 </a>
			</c:if>
			<c:if test="${param.index!='user'}">
				 <a href="#" class="nav-top-item" name="index"> 个人中心 </a>
			 </c:if>
				<ul>

					<li>
					<c:if test="${param.msg=='userUpd'}">
						<a class="current" href="${basePath}manager/userMg">个人信息</a>
					</c:if>
					<c:if test="${param.msg!='userUpd'}">
					 	<a href="${basePath}manager/userMg">个人信息</a>
					 </c:if>
					</li>
					<li>
					<c:if test="${param.msg=='pwdPud'}">
						<a class="current" href="${basePath}manager/pwdUpd.jsp">修改密码</a>
					</c:if>
					<c:if test="${param.msg!='pwdPud'}">
					 	<a href="${basePath}manager/pwdUpd.jsp">修改密码</a>
					 </c:if>
					</li>

				</ul>
			</li>
			<!--
        <li> <a href="#" class="nav-top-item"> Image Gallery </a>
          <ul>
            <li><a href="#">Upload Images</a></li>
            <li><a href="#">Manage Galleries</a></li>
            <li><a href="#">Manage Albums</a></li>
            <li><a href="#">Gallery Settings</a></li>
          </ul>
        </li>
        <li> <a href="#" class="nav-top-item"> Events Calendar </a>
          <ul>
            <li><a href="#">Calendar Overview</a></li>
            <li><a href="#">Add a new Event</a></li>
            <li><a href="#">Calendar Settings</a></li>
          </ul>
        </li>
        <li> <a href="#" class="nav-top-item"> Settings </a>
          <ul>
            <li><a href="#">General</a></li>
            <li><a href="#">Design</a></li>
            <li><a href="#">Your Profile</a></li>
            <li><a href="#">Users and Permissions</a></li>
          </ul>
        </li>
		-->
		</ul>
		<!-- End #main-nav -->
		<div id="messages" style="display: none">
			<!-- Messages are shown when a link with these attributes are clicked: href="#messages" rel="modal"  -->
			<h3>3 Messages</h3>
			<p>
				<strong>17th May 2009</strong> by Admin<br /> Lorem ipsum dolor sit
				amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at
				felis aliquet congue. <small><a href="#" class="remove-link"
					title="Remove message">Remove</a> </small>
			</p>
			<p>
				<strong>2nd May 2009</strong> by Jane Doe<br /> Ut a est eget
				ligula molestie gravida. Curabitur massa. Donec eleifend, libero at
				sagittis mollis, tellus est malesuada tellus, at luctus turpis elit
				sit amet quam. Vivamus pretium ornare est. <small><a
					href="#" class="remove-link" title="Remove message">Remove</a> </small>
			</p>
			<p>
				<strong>25th April 2009</strong> by Admin<br /> Lorem ipsum dolor
				sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at
				felis aliquet congue. <small><a href="#" class="remove-link"
					title="Remove message">Remove</a> </small>
			</p>
			<form action="#" method="post">
				<h4>New Message</h4>
				<fieldset>
					<textarea class="textarea" name="textfield" cols="79" rows="5"></textarea>
				</fieldset>
				<fieldset>
					<select name="dropdown" class="small-input">
						<option value="option1">Send to...</option>
						<option value="option2">Everyone</option>
						<option value="option3">Admin</option>
						<option value="option4">Jane Doe</option>
					</select> <input class="button" type="submit" value="Send" />
				</fieldset>
			</form>
		</div>
		<!-- End #messages -->
	</div>
</div>