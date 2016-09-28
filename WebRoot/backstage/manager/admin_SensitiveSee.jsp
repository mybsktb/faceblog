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
function deleall(){
	var basePath2 = '<%=basePath2%>';
	var news = $("#newsid").val(); 
	var sen = $("input[name='sensitive']").val(); 
	
	$("#h3news img").remove();
	$("#h3news span").remove();		
	$.ajax({
			url:basePath2 + "manager/AdminSensitiveUpda",
			data:{newsid:news,sensitive:sen},
			success:function(data){
				scrollTo(0, 0);
				if(("修改完成"== data)){
					$("#h3news").append("<img src='<%=basePath %>resources/images/true.png' width='20px' height='20px' />");
					$("#h3news").append("<span style='color:green;font-size:100%'>"+data+"</span>");
					
				}else{
					$("#h3news").append("<img src='<%=basePath %>resources/images/false.png' width='20px' height='20px' />");
					$("#h3news").append("<span style='color:red;font-size:100%'>"+data+"</span>");
				}	
				$("#h3news").append("<a href='<%=basePath2 %>/manager/AdminSensitiveMg'><span style='color:blue;font-size:100%' >返回</span></a>");
		}
	});
}
</script>
</head>
<body>
<div id="body-wrapper">
  <!-- Wrapper for the radial gradient background -->
  <jsp:include page="/backstage/include/admin_sidebar.jsp">
  	<jsp:param value="newscenter" name="css"/>
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
    <!-- Main Content Section with everything -->
    <noscript>
    <!-- Show a notification if the user has disabled javascript -->
    <div class="notification error png_bg">
      <div> Javascript is disabled or is not supported by your browser. Please <a href="http://browsehappy.com/" title="Upgrade to a better browser">upgrade</a> your browser or <a href="http://www.google.com/support/bin/answer.py?answer=23852" title="Enable Javascript in your browser">enable</a> Javascript to navigate the interface properly.
        Download From <a href="http://www.exet.tk">exet.tk</a></div>
    </div>
    </noscript>
    <!-- Page Head -->
	<h3>文章管理--敏感词汇管理</h3>
    <!-- End .shortcut-buttons-set -->
    <div class="clear"></div>
    <!-- End .clear -->
    <div class="content-box">
      <!-- Start Content Box -->
      <div class="content-box-header">
        <h3 id="h3news">敏感词汇编辑	</h3>
    
        <div class="clear"></div>
      </div>
      <!-- End .content-box-header  default-tab-->
      <div class="content-box-content">
        <div class="tab-content default-tab" id="tab2">
          <form action="#" method="post">
            <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>
            <% 
            	List<Map<String, Object>> res =(List<Map<String, Object>>) request.getAttribute("news");
            %>
            <input type="text" style="display: none" id="newsid" value="<%=res.get(0).get("sensitive_id") %>"/>
            	
              <label>敏感词汇</label>
              <input  class="text-input small-input" type="text" id="small-input" name="sensitive" value="<%=res.get(0).get("word") %>"/>
              <br />
			 </p>  
            <p>
              <label>创建时间</label>
              <input disabled="false" class="text-input medium-input datepicker" type="text" id="medium-input" name="time" value="<%=res.get(0).get("createtime") %>"/>
              <!-- <span class="input-notification error png_bg">Error message</span>  -->
			  </p>
            
            <p>
              <input class="button" type="button" value="修改" onclick="deleall()"/>
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
