<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.faceblog.entity.AdminPage" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/backstage/";
String basePath2 = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻管理</title>
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
<style>
.disableHref{
    cursor:default;
    color:gray;
    text-decoration:none;
}
em{
 background-color:white;
 display: none;
 
}
</style>
<script>
$(document).ready(function(){
 $("tr[trname] td").hover(function() {
 $(this).find("em").animate({opacity: "show", top: "-75"}, "slow");
  
 }, function() {
 $(this).find("em").animate({opacity: "hide", top: "-85"}, "fast");
  
 });
});
function conf(nu,id){
	
	if(nu==2){
		var r = confirm("用户信息将会被删除！！！确定删除？？？");
		if(r&id!=0){
			location.href="<%=basePath2 %>/manager/AdminUserDele?userid="+id+"&flag=2";
		}
		if(r&id==0){
			deleall(nu);
		}
	}else if(nu==1){
		var r = confirm("用户名不变，其他信息恢复初始值！！！确定重置？？？");
		if(r&id!=0){
			location.href="<%=basePath2 %>/manager/AdminUserDele?userid="+id+"&flag=1";		
		}
		if(r&id==0){
			deleall(nu);
		}
	}
}

function clear(ch){
	$("#h3news img").remove();
	$("#h3news span").remove();
	if(ch==null){
	var cur = $("input[name='curdatanum']").val();
	var keys = $("input[name='keyword']").val();
	location.href="<%=basePath2%>manager/AdminUserMg?curpage=1&curdatanum="+cur+"&keyword="+keys+"";							
	}
}
function deleall(ch){
	var basePath2 = '<%=basePath2%>';
	var checked  = ch; 
	var check = $(":checkbox[name='checkbox']");
	var checkbox = new Array();
	var num = 0;
	for(var i=0;i<check.length;i++){
		if(check[i].checked){			
			checkbox[num] = check[i].value;
			++num;
			}		
	}			
	$.ajax({
			url:basePath2 + "manager/AdminUserDele",
			data:{checkBox:checkbox,check:checked},
			success:function(data){

				if(!("操作失败"== data)){
					$("#h3news").append("<img src='<%=basePath %>resources/images/true.png' width='20px' height='20px' />");
					$("#h3news").append("<span style='color:green;font-size:100%'>"+data+"</span>");
					setTimeout("clear(null)",1000);
				}else{
					$("#h3news").append("<img src='<%=basePath %>resources/images/false.png' width='20px' height='20px' />");
					$("#h3news").append("<span style='color:red;font-size:100%'>"+data+"</span>");
					setTimeout("clear(null)",1000);
				}	
		}
	});
}
$(function(){
	var flag = true;
	$("input[class='check-all1']").click(function(){	
		$(":checkbox[name='checkbox']").attr("checked",flag);
		if(flag){
			$("#pi a[name='piliang']").remove();
			$("#pi").prepend("<a name='piliang' class='button' href='javascript:void(0);' onclick='conf(2,0)' >批量删除</a>");
			$("#pi").append("<a name='piliang' class='button' href='javascript:void(0);' onclick='conf(1,0)' >批量重置</a>");
		
		}else{
			$("a[name='piliang']").removeAttr("onclick");
			$("a[name='piliang']").attr("class","disableHref");
		}
		flag = !flag;
	});
	
	$(":checkbox[name='checkbox']").click(function(){
		var check = $(":checkbox[name='checkbox']");
		for(var i=0;i<check.length;i++){
			if(check[i].checked){
				$("#pi a[name='piliang']").remove();
				$("#pi").prepend("<a name='piliang' class='button' href='javascript:void(0);' onclick='conf(2,0)' >批量删除</a>");
				$("#pi").append("<a name='piliang' class='button' href='javascript:void(0);' onclick='conf(1,0)' >批量重置</a>");
				break; 
			}else{
				$("a[name='piliang']").removeAttr("onclick");
				$("a[name='piliang']").attr("class","disableHref");
			}
		}
		for(var i=0;i<check.length;i++){
			if(!check[i].checked){				
				$("input[class='check-all1']").attr("checked",false);
				flag = true;
				return;
			}
		}
		$("input[class='check-all1']").attr("checked",true);
		flag = false;		
		return
	});
});
</script>
</head>
<body>
<div id="body-wrapper">
  delea<!-- Wrapper for the radial gradient background -->
  <jsp:include page="/backstage/include/admin_sidebar.jsp">
  	<jsp:param value="usermg" name="cate"/>
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
	<h3>用户管理--用户管理</h3>
    <!-- End .shortcut-buttons-set -->
    <div class="clear"></div>
    <!-- End .clear -->
    <div class="content-box">
      <!-- Start Content Box -->
      <div class="content-box-header">
        <h3 id="h3news">用户管理	&nbsp;&nbsp;&nbsp;
		<% 
			String news = (String)request.getAttribute("user");		
			if(news != null){
				if(!"操作失败".equals(news)){
		%> 
		<img src="<%=basePath %>resources/images/true.png" width="20px" height="20px"/>      
		<span style="color:green;font-size:100%" ><%=news %></span>
		<%
			}else{
		%>
		<img src="<%=basePath %>resources/images/false.png" width="20px" height="20px"/>      
		<span style="color:red;font-size:100%" ><%=news %></span>
		<% 
			}
			%>
		<script>
			setTimeout("clear(1)", 1500);
		</script>
	<%	}
		%>
        </h3>
      
        <div class="clear"></div>
      </div>
      <!-- End .content-box-header -->
      <div class="content-box-content">
        <div class="tab-content default-tab" id="tab1">
          
          <table>
            <thead>
              <tr>
                <th>
                  <input class="check-all1" type="checkbox" />全选
                </th>
                <th>用户名</th>
                <th>密保问题</th>
                <th>密保答案</th>
                <th>个性签名</th>
                <th>职业</th>
                <th>籍贯</th>
                <th>电话</th>
                <th>邮箱</th>
                <th>个人简介</th>
                <th>操作</th>
              </tr>
            </thead>
            <tfoot>
              <tr>
                <td colspan="10">
                   <div class="bulk-actions align-left" id="pi">
                    <a name="piliang" class="disableHref" href="javascript:void(0);" >批量删除</a>&nbsp;&nbsp;&nbsp;
                    <a name="piliang" class="disableHref" href="javascript:void(0);" >批量重置</a>
                    </div>
          
                  <% 
                  	AdminPage pag = (AdminPage)request.getAttribute("page");
            		int curpage = pag.getCurpage();
            		int maxpage = pag.getMaxpage();
                  %>
                  <div class="pagination"> 
                 <form action="<%=basePath2 %>/manager/AdminUserMg">
                                            用 户 名 搜 索 <input type="text" name="keyword" style="width:60px" value="<%=pag.getKeyword() %>"/>&nbsp;&nbsp;&nbsp;
                                            每 页 <input type="text" name="curdatanum" style="width:40px" value="<%=pag.getCurdatanum() %>"/> 条 数 据 &nbsp;
                  <input class="button" type="submit" value="确定">
                  <input type="text" value="<%=curpage %>" style="display: none" name="curpage"/>
              
                 <%
                  	if(curpage != 1){ 
                  %>
                  <a href="<%=basePath2 %>/manager/AdminUserMg?curpage=1" title="First Page">&laquo; 首页</a>
                  <a href="<%=basePath2 %>/manager/AdminUserMg?curpage=<%=curpage-1 %>" title="Previous Page">&laquo; 上一页</a> 
                  <% }%>
                  <% 
                  	if(curpage != maxpage){
                  %>
                  <a href="<%=basePath2 %>/manager/AdminUserMg?curpage=<%=maxpage %>" title="Last Page">末页 &raquo;</a> 
                  <a href="<%=basePath2 %>/manager/AdminUserMg?curpage=<%=curpage+1 %>" title="Next Page">下一页 &raquo;</a>                  
                  <%} %>
                  
                                             当前第<%=curpage %>页/共<%=maxpage %>页
                  </form><br/>
                  </div>
                  <!-- End .pagination -->
                  <div class="clear"></div>
                </td>
              </tr>
            </tfoot>
            <tbody>
            <%
				List<Map<String, Object>> res = pag.getCurdata();	            
            	if(res !=null){
            		for(Map<String, Object> result : res){
            %>
              <tr trname="<%=result.get("USER_ID") %>">
                <td>
                  <input type="checkbox" name="checkbox" value="<%=result.get("USER_ID") %>" />
                </td>
                 <td>
                <em><%=result.get("USER_NAME") %></em>
                <input disabled="false" type="text" size="6" value="<%=result.get("USER_NAME") %>" />	
                </td>
                <td>
                <em><%=result.get("question_content") %></em>
                <input disabled="false" type="text" size="6" value="<%=result.get("question_content") %>" />
                </textarea>
                </td>
                <td>
                <em><%=result.get("USER_ANSWER") %></em>
                <input disabled="false" type="text" size="6" value="<%=result.get("USER_ANSWER") %>" />
                </td>
                <td>
                <em><%=result.get("USER_MOTTO") %></em>
                <input disabled="false" type="text" size="6" value="<%=result.get("USER_MOTTO") %>" />
                </td>
                <td>
                <em><%=result.get("USER_JOB") %></em>
                <input disabled="false" type="text" size="6" value="<%=result.get("USER_JOB") %>" />
                </td>
                <td>
                <em><%=result.get("USER_HOMETOWN") %></em>
                <input disabled="false" type="text" size="6" value="<%=result.get("USER_HOMETOWN") %>" />
                </td>
                <td>
                <em><%=result.get("USER_TELE") %></em>
                <input disabled="false" type="text" size="6" value="<%=result.get("USER_TELE") %>" />
                </td>
                <td>
                <em><%=result.get("USER_EMAIL") %></em>
                <input disabled="false" type="text" size="6" value="<%=result.get("USER_EMAIL") %>" />
                </td>
                <td>
                <em><%=result.get("USER_INTRO") %></em>
                <input disabled="false" type="text" size="6" value="<%=result.get("USER_INTRO") %>" />
                </td>
                <td>
                  <!-- Icons -->
                  <a onclick="conf(1,<%=result.get("USER_ID")%>)" href="javascript:void(0)" title="重置"><img src="<%=basePath %>resources/images/icons/hammer_screwdriver.png" alt="重置" /></a>  
                  <a onclick="conf(2,<%=result.get("USER_ID")%>)" href="javascript:void(0)" title="删除"><img src="<%=basePath %>resources/images/icons/cross.png" alt="删除" /></a> 
                 </td>
              </tr>
            <% 
             	}
            }
            %>
            </tbody>
          </table>
        </div>
        <!-- End #tab1 -->
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
