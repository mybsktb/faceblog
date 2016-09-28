<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<!-- jQuery Datepicker Plugin -->
<script type="text/javascript" src="<%=basePath%>resources/scripts/jquery.datePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>resources/scripts/jquery.date.js"></script>
<script>
	function show(){
		$("#mess").removeAttr("style");
		$("#showbutton").attr("style","display:none");
		$("#nonebutton").removeAttr("style");
	}
	function none(){
		$("#mess").attr("style","display:none");
		$("#showbutton").removeAttr("style");
		$("#nonebutton").attr("style","display:none");
	}
	function clear(){
	$("#h3news img").remove();
	$("#h3news span").remove();							
	}
$(function(){
	$("#icon").change(function(){
		$("#preview").attr("src",$("#icon").val());
	});
});
	
</script>
</head>
<body>
<div id="body-wrapper">
  <!-- Wrapper for the radial gradient background -->
  <jsp:include page="/backstage/include/admin_sidebar.jsp">
  	<jsp:param value="useradd" name="cate"/>
  	<jsp:param value="usercenter" name="css"/>
  </jsp:include>
      <!-- End #main-nav -->
      <div id="messages" style="display: none">
        <!-- Messages are shown when a link with these attributes are clicked: href="#messages" rel="modal"  -->
        <h3>3 Messages</h3>
        <p> <strong>17th May 2009</strong> by Admin<br />
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet congue. <small><a href="#" class="remove-link" title="Remove message">Remove</a></small> </p>
        <p> <strong>2nd May 2009</strong> by Jane Doe<br />
          Ut a est eget ligula molestie gravida. Curabitur massa. Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est. <small><a href="#" class="remove-link" title="Remove message">Remove</a></small> </p>
        <p> <strong>25th April 2009</strong> by Admin<br />
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet congue. <small><a href="#" class="remove-link" title="Remove message">Remove</a></small> </p>
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
          </select>
          <input class="button" type="submit" value="Send" />
          </fieldset>
        </form>
      </div>
      <!-- End #messages -->
    </div>
  </div>
  <!-- End #sidebar -->
  <div id="main-content">
     
    <!-- Page Head -->
	<h3>用户管理--增加用户</h3>
   
    <!-- End .shortcut-buttons-set -->
    <div class="clear"></div>
    <!-- End .clear -->
    <div class="content-box">
      <!-- Start Content Box -->
      <div class="content-box-header">
        <h3 id="h3news">增加用户 &nbsp;
        
    <%
	String user = (String) request.getAttribute("useradd");    
	if(user != null){
		if("增加用户成功".equals(user)){
    %>
    <img src="<%=basePath %>resources/images/true.png" width="20px" height="20px" />
    <span style="color:green;font-size:100%" ><%=user%></span>
    <%	
	}else{
    %>
    <img src="<%=basePath %>resources/images/false.png" width="20px" height="20px" />
    <span style="color:red;font-size:100%" ><%=user%></span>
    <% 
   		} 
   	%>
   	<script>
			setTimeout("clear()", 1500);
	</script>
   	<%
    } 
    %>
    </h3>
       
        <div class="clear"></div>
      </div>
      <!-- End .content-box-header  default-tab-->
      <div class="content-box-content">
        <div class="tab-content default-tab" id="tab2">
          <form action="<%=basePath2 %>manager/AdminUserAdd" method="post"> 
            <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
              <label>用户名</label>
              <input class="text-input small-input" type="text" id="name" name="username" />           
            </p>
            <p>
            <input class="button" stype="button" onclick="show()" id="showbutton" value="显示详细信息》》">
            <input style="display: none" class="button" stype="button" onclick="none()" id="nonebutton" value="隐藏详细信息》》">
            </p>
            <div id="mess"  style="display: none" >
            <p>
              <label>密码</label>
              <input class="text-input small-input" type="text" id="pwd" name="pwd" />           
            </p>
            <p>
              <label>密保问题</label>
              <input class="text-input small-input" type="text" id="question" name="question" />           
            </p>
            <p>
              <label>密保答案</label>
              <input class="text-input small-input" type="text" id="answer" name="answer" />           
            </p>
            <p>
              <label>个性签名</label>
              <input class="text-input small-input" type="text" id="motto" name="motto" />           
            </p>
            <p>
              <label>职业</label>
              <input class="text-input small-input" type="text" id="job" name="job" />           
            </p>
            <p>
              <label>籍贯</label>
              <input class="text-input small-input" type="text" id="home" name="home" />           
            </p>
            <p>
              <label>电话</label>
              <input class="text-input small-input" type="text" id="tel" name=tel />           
            </p>
            <p>
              <label>邮箱</label>
              <input class="text-input small-input" type="text" id="email" name="email" />           
            </p>
            <%-- <p>
            <form action="<%=basePath2 %>manager/AdminUpload" method="post" enctype="multipart/form-data">
              <label>头像</label>
              	请选择图片：<input type="file" id="icon" name="icon" />  
              	<input class="button" type="submit" value="上传">
            </form>  
            </p> --%>
            <!-- <p><img id="preview" src="" width="80" height="80" /></p> -->
            <p>
              <label>自我介绍</label>
              <input class="text-input small-input" type="text" id="intro" name="intro" />           
            </p>
            </div>
            <p>
              <input class="button" type="submit" value="注册" />              
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
    <div id="footer"> <small>
      <!-- Remove this notice or replace it with whatever you want -->
      &#169; Copyright 2010 Your Company | Powered by <a href="#">admin templates</a> | <a href="#">Top</a> </small> </div>
    <!-- End #footer -->
  </div>
  <!-- End #main-content -->
</div>
</body>
 
</html>
