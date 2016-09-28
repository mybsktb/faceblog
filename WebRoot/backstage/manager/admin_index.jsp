<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.faceblog.util.JDBCUtil"%>
<%@ page language="java" import="com.faceblog.entity.AdminPage"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/backstage/";
String basePath2 = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理</title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath%>resources/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath%>resources/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath%>resources/css/invalid.css" type="text/css" media="screen" />
<!--                       Javascripts                       -->
<!-- jQuery -->
<script type="text/javascript" src="<%=basePath%>resources/scripts/jquery-1.3.2.min.js"></script>
<!-- jQuery Configuration -->
<script type="text/javascript" src="<%=basePath%>resources/scripts/simpla.jquery.configuration.js"></script>
<!-- Facebox jQuery Plugin -->
<script type="text/javascript" src="<%=basePath%>resources/scripts/facebox.js"></script>
<!-- jQuery WYSIWYG Plugin -->
<script type="text/javascript" src="<%=basePath%>resources/scripts/jquery.wysiwyg.js"></script>
</head>
<body>
<div id="body-wrapper">
  <!-- Wrapper for the radial gradient background -->
  <!--动态包含，可以传递参数  -->
  <jsp:include page="/backstage/include/admin_sidebar.jsp">
  	<jsp:param value="index" name="css"/>
  </jsp:include>
  <div id="messages" style="display: none">
        <!-- Messages are shown when a link with these attributes are clicked: href="#messages" rel="modal"  -->
        <h3>系统配置</h3>
		<p> <strong>CPU要求</strong> 英特尔I3以上配置<br />
          这里是一些系统配置的要求说明，比如说内存要求在4G以上。 <small><a href="#" class="remove-link" title="Remove message">更多>></a></small> </p>
        <p> <strong>内存要求</strong> 4G<br />
          这里是一些系统配置的要求说明，比如说内存要求在4G以上。 <small><a href="#" class="remove-link" title="Remove message">更多>></a></small> </p>
        <p> <strong>宽带要求</strong> 10M +<br />
          这里是一些系统配置的要求说明，比如说内存要求在4G以上。  
      </div>
  <!-- End #sidebar -->
  <div id="main-content">
    <!-- Main Content Section with everything -->
    <noscript>
    <!-- Show a notification if the user has disabled javascript -->
    <div class="notification error png_bg">
      <div> Javascript is disabled or is not supported by your browser. Please <a href="http://browsehappy.com/" title="Upgrade to a better browser">upgrade</a> your browser or <a href="http://www.google.com/support/bin/answer.py?answer=23852" title="Enable Javascript in your browser">enable</a> Javascript to navigate the interface properly.
        Download From <a href="http://www.exet.tk">exet.tk</a></div>
    </div>
    </noscript>
    <!-- Page Head -->
   <h2>欢迎来到XX管理后台 </h2>
    <!-- <p id="page-intro">提示：此程序是您建立地区级商家信息门户的首选方案！</p>  -->
	  <p>您现在使用的是<b>中软国际</b>开发的一套用于构建商务信息类门户型网站的专业系统！如果您有任何疑问请点左下解的在线客服进行咨询！</p> 
    <ul class="shortcut-buttons-set">
      <li><a class="shortcut-button" href="<%=basePath2 %>/manager/AdminNewsMg?curpage=1&curdatanum=5&keyword"><span> <img src="<%=basePath%>resources/images/tools.png" alt="icon" /><br />
        文章审核 </span></a></li>
      <li><a class="shortcut-button" href="<%=basePath2 %>manager/AdminUserMg?curpage=1&curdatanum=5&keyword"><span> <img src="<%=basePath%>resources/images/users.png" alt="icon" /><br />
        用户管理 </span></a></li>
      <li><a class="shortcut-button" href="#messages" rel="modal"><span> <img src="<%=basePath%>resources/images/icons/comment_48.png" alt="icon" /><br />
        数据备份 </span></a></li>
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
        <% 
        String sql2 = "select * from arti_tab where arti_check in (0,-2)";
		List<Map<String, Object>> res2 = JDBCUtil.doQuery(sql2);
		
        %>
          <h4>未审核新闻数：<a href="<%=basePath2 %>/manager/AdminNewsMg?curpage=1&curdatanum=5&keyword" style="color:red"><%=res2.size() %>条</a></h4><br/>
		  <h4>今日已完成数：<a href="#" style="color:green"><%=AdminPage.getCheckedsum() %>条</a></h4>
        </div>
        <!-- End #tab3 -->
      </div>
      <!-- End .content-box-content -->
    </div>
    <!-- End .content-box -->
    <div class="content-box column-right">
      <div class="content-box-header">
        <!-- Add the class "closed" to the Content box header to have it closed by default -->
        <h3>使用说明</h3>
      </div>
      <!-- End .content-box-header -->
      <div class="content-box-content">
        <div class="tab-content default-tab">
          <!-- <h4>This box is closed by default</h4> -->
			<p> 一、专业的地区级商家门户建站首选方案！</p>
			<p>二、全站一号通，一次注册，终身使用，一个帐号，全站通用！</p>
			<p>三、分类信息、商家展示（百业联盟）、网上商城、网上名片（网上黄页）、广告张贴、市场联盟、市场资讯七大栏目完美整合。</p>
			<p>四、界面设计精美，后台功能强大。傻瓜式后台操作，无需专业的网站制作知识，只要会打字，就会管理维护网站。 </p>
        </div>
        <!-- End #tab3 -->
      </div>
      <!-- End .content-box-content -->
    </div>
    <!-- End .content-box -->
    <div class="clear"></div>
   
    <div id="footer"> <small>
      <!-- Remove this notice or replace it with whatever you want -->
      &#169; Copyright 2010 Your Company | Powered by <a href="#">admin templates</a> | <a href="#">Top</a> </small> </div>
    <!-- End #footer -->
  </div>
  <!-- End #main-content -->
</div>
</body>
 
</html>

