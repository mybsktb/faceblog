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
<script type="text/javascript" src="resources/scripts/ckeditor/ckeditor.js"></script>
<script>
function update_confirm(){
    var r=confirm("你修改的文章将进入待审核状态，确认提交？");
    if(r==true){
       //获取页面的各项数据
       var name= $("input[name='ARTI_NAME']").val();
       var recommend= $("input[name='ARTI_RECOMMEND']:checked").val();
       var author= $("input[name='ARTI_AUTHOR']").val();
       var keyword= $("input[name='ARTI_KEYWORD']").val();
       var cateid= $("select[name='ARTI_CATEID']").val();
       var content = CKEDITOR.instances.ARTI_CONTENT.getData();
       var articleId=${arti.get("ARTI_ID")}; 
       //获取纯文本内容
       var cont =CKEDITOR.instances.ARTI_CONTENT.document.getBody().getText(); 
       if(cont.toString().trim()==""){
           alert("文章内容为空，修改失败！");
           return;
       }
       if(name.toString().trim()==""){
          alert("文章标题为空，修改失败！");
           return;
       }
       if(author.toString().trim()==""){
          alert("文章作者为空，修改失败！");
           return;
       }
       //ajax传递数据   
       $.ajax({
               url:"manager/NewsUpdateServlet",
               type:"POST",
               data:{art_name:name,art_recommend:recommend,art_author:author,art_keyword:keyword,art_cateid:cateid,art_content:content,art_id:articleId},
               dataType:"text",
               success:function(data){
                   alert(data);               
               },                                     
            }); 
    }
    else{ 
        alert("取消修改成功！");
    }
}

</script>
<script>
$(function(){
		$("input[name='ARTI_NAME']").focusout(function(){
	    title = $.trim($("input[name='ARTI_NAME']").val());
	    $("#note").html('');
	    	if(title==''){
				$("#note").append("<img src='<%=basePath%>resources/images/icons/cross_circle.png' /><span>标题不能为空！</span>");	
				$("input[name='ARTI_NAME']").focus();			
			}
			else{
			    $("#note").append("<img src='<%=basePath%>resources/images/icons/tick_circle.png' /><span></span>");
			}
		});
				
		$("input[name='ARTI_AUTHOR']").focusout(function(){
	    author = $.trim($("input[name='ARTI_AUTHOR']").val());
	    $("#noteau").html('');
	    	if(author==''){				
				$("#noteau").append("<img src='<%=basePath%>resources/images/icons/cross_circle.png' /><span>作者不能为空！</span>");
			}
			else{
				$("#noteau").html('');
			}
		});
})
</script>
</head>
<body>
<div id="body-wrapper">
  <!-- Wrapper for the radial gradient background -->
  <div id="sidebar">
    <div id="sidebar-wrapper">
      
      <jsp:include page="/backstage/include/leftSide.jsp"></jsp:include> 
      
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
	<h3>新闻中心--修改文章</h3>
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
        <h3>修改文章</h3>
       <!--  <ul class="content-box-tabs">
          <li><a href="#tab1" class="default-tab">Table</a></li>
          <li><a href="#tab2">Forms</a></li>
        </ul> -->
        <div class="clear"></div>
      </div>
      <!-- End .content-box-header  default-tab-->
      <div class="content-box-content">
        <div class="tab-content default-tab" id="tab2">        
          <form id="fsubmit">
            <fieldset>
            <!-- Set class to "column-left" or "column-right" on fieldsets to divide the form into columns -->
            <p>        
              <label>文章标题</label>
              <input class="text-input small-input" type="text" id="small-input" name="ARTI_NAME" value="${arti.get('ARTI_NAME')}"/><span id="note"></span>
              <!--错误/正确提示 <span class="input-notification success png_bg">Successful message</span> -->
              <!-- Classes for input-notification: success, error, information, attention -->
              <br />
              <!--提示信息   <small>A small description of the field</small>  -->
			 </p> 
			 
            <p>
              <label>推荐：</label>   
              <%String check=(String)request.getAttribute("checked");
              if("true".equals(check)){%>
              	<input type="radio" checked="true"  name="ARTI_RECOMMEND" value=1 /> 是                           
		         &nbsp   &nbsp &nbsp &nbsp  &nbsp 
		        <input type="radio" name="ARTI_RECOMMEND" value=0 /> 否                    
             <% }else{ %>   
	
			   <input type="radio"   name="ARTI_RECOMMEND" value=1 /> 是                           
		        &nbsp   &nbsp &nbsp &nbsp  &nbsp 
		       <input type="radio" checked="true" name="ARTI_RECOMMEND" value=0 /> 否     
		     <%}%>
              <p>
				<label>作者</label> 
				<input class="text-input medium-input datepicker" type="text" id="medium-input" name="ARTI_AUTHOR" value="${arti.get('ARTI_AUTHOR')}" /><span id="noteau"></span>
			    <!-- <span class="input-notification error png_bg">Error message</span>  -->
			  </p>
                           
              <!-- <span class="input-notification error png_bg">Error message</span>  -->
			  </p>
            <p>
              <label>关键字</label>
              <input class="text-input large-input" type="text" id="large-input" name="ARTI_KEYWORD" value="${arti.get('ARTI_KEYWORD')}"/>
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
              <label>所属栏目</label>
              <select name="ARTI_CATEID" class="small-input" id="select_cate_id">
              <%  
            		List<Map<String,Object>> results = (List<Map<String,Object>>) request.getAttribute("cateResults");
            		if(results!=null){
            			for(Map<String,Object> result : results){
             %>
                <option value="<%=result.get("CATE_ID") %>"><%=result.get("CATE_NAME") %></option>
       
               <%
	              	 	}
	               }
               %>                                 
              </select>
            </p>
            <p>
              <label>文章内容</label>
              <textarea  cols="79" rows="15" class="ckeditor" name="ARTI_CONTENT">${arti.get("ARTI_CONTENT")}</textarea>
            </p>
            <p>
              <input class="button" type="button" value="提交" id="submitbuttonclick" onclick="update_confirm()"/>
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
      &#169; Copyright 2010 Your Company | Powered by admin templates | Top </small> </div>
    <!-- End #footer -->
  </div>
  <!-- End #main-content -->
</div>
</body>
 
</html>
