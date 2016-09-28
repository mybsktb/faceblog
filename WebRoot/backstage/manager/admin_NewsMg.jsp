<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
</style>
<script>
function sele(){
	var sele = $("#sele").val();
	var cur = $("input[name='curdatanum']").val();
	var keys = $("input[name='keyword']").val();
	location.href="<%=basePath2%>manager/AdminNewsMg?curpage=1&keyword="+keys+"&curdatanum="+cur+"&selec="+sele+" ";							
}
function clear(){
	$("#h3news img").remove();
	$("#h3news span").remove();
	var cur = $("input[name='curdatanum']").val();
	var keys = $("input[name='keyword']").val();
	location.href="<%=basePath2%>manager/AdminNewsMg?curpage=1&keyword="+keys+"&curdatanum="+cur+" ";							
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
			url:basePath2 + "manager/AdminNewsCheck",
			data:{checkBox:checkbox,check:checked},
			success:function(data){
			//alert(data);
				if(!("审核未完成"== data)){
					$("#h3news").append("<img src='<%=basePath %>resources/images/true.png' width='20px' height='20px' />");
					$("#h3news").append("<span style='color:green;font-size:100%'>"+data+"</span>");
					for(var i=0;i<checkbox.length;i++){
						$("tr[trname='"+checkbox[i]+"']").remove();
					}
					setTimeout("clear()",1000);
				}else{
					$("#h3news").append("<img src='<%=basePath %>resources/images/false.png' width='20px' height='20px' />");
					$("#h3news").append("<span style='color:red;font-size:100%'>"+data+"</span>");
					setTimeout("clear()",1000);
				}	
		}
	});
}
$(function(){
	var flag = true;
	$("input[class='check-all1']").click(function(){	
		$(":checkbox[name='checkbox']").attr("checked",flag);
		if(flag){
			$("a[name='piliang']").attr("class","button");
		}else{
			$("a[name='piliang']").attr("class","disableHref");
		}
		flag = !flag;
	});
	
	$(":checkbox[name='checkbox']").click(function(){
		var check = $(":checkbox[name='checkbox']");
		for(var i=0;i<check.length;i++){
			if(check[i].checked){
				$("a[name='piliang']").attr("class","button");
				break;
			}else{
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
  	<jsp:param value="newsmg" name="cate"/>
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
	<h3>文章管理--文章审核</h3>
    
    <!-- End .shortcut-buttons-set -->
    <div class="clear"></div>
    <!-- End .clear -->
    <div class="content-box">
      <!-- Start Content Box -->
      <div class="content-box-header">
        <h3 id="h3news">文章审核	&nbsp;&nbsp;&nbsp;
		<% 
			String news = (String)request.getAttribute("checked");		
			if(news != null){
				if(!"审核未完成".equals(news)){
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
			setTimeout("clear()", 1500);
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
           <% 
                  	AdminPage pag = (AdminPage)request.getAttribute("page");
            		int curpage = pag.getCurpage();
            		int maxpage = pag.getMaxpage();
           %>
            <thead>
              <tr>
                <th>
                  <input class="check-all1" type="checkbox" />全选
                </th>
                <th>标题</th>
                <th>所属栏目</th>
                <th>创建时间</th>
                <th>作者
                <input type="text" onchange="sele()" name="keyword" style="width:60px" value="<%=pag.getKeyword() %>"/>
                </th>
                <th>审核状态
                <select id="sele" onchange="sele()" name="selec">
               		<option value=""></option>
               		 <% 
                	if("0".equals(request.getAttribute("sele"))){
                	%>
                	<option selected="true" value="0">待审核</option>
                	<%}else{ %><option value="0">待审核</option><% }%>
                	
                	<% 
                	if("-2".equals(request.getAttribute("sele"))){
                	%>
                	<option selected="true" value="-2">被举报</option>
                	<%}else{ %><option value="-2">被举报</option><% }%>
                </select>
                </th>
                <th>操作</th>
              </tr>
            </thead>
            <tfoot>
              <tr>
                <td colspan="8">
                  <div class="bulk-actions align-left">
                    <a name="piliang" class="disableHref" href="javascript:void(0);" onclick="deleall(1)"  >批量审核通过</a>&nbsp;&nbsp;&nbsp;
                    <a name="piliang" class="disableHref" href="javascript:void(0);" onclick="deleall(-1)" >批量审核不通过</a>
                    </div>
                 
                  <div class="pagination"> 
                <%--  <form action="<%=basePath2 %>/manager/AdminNewsMg"> --%>
                                            <%-- 作 者  关 键 词 <input type="text" onchange="sele()" name="keyword" style="width:60px" value="<%=pag.getKeyword() %>"/>&nbsp;&nbsp;&nbsp; --%>
                                            每 页 展 示 <input type="text" onchange="sele()" name="curdatanum" style="width:40px" value="<%=pag.getCurdatanum() %>"/> 条 数 据 &nbsp;
                  <!-- <input class="button" type="submit" value="确定"> -->
                  <input type="text" value="<%=curpage %>" style="display: none" name="curpage"/>

                   <%
                  	if(curpage != 1){ 
          		  %>
                  <a href="<%=basePath2 %>/manager/AdminNewsMg?curpage=1" title="First Page">&laquo; 首页</a>
                  <a href="<%=basePath2 %>/manager/AdminNewsMg?curpage=<%=curpage-1 %>" title="Previous Page">&laquo; 上一页</a> 
                  <% }%>
                  <% 
                  	if(curpage != maxpage){
                  %>
                  <a href="<%=basePath2 %>/manager/AdminNewsMg?curpage=<%=maxpage %>" title="Last Page">末页 &raquo;</a> 
                  <a href="<%=basePath2 %>/manager/AdminNewsMg?curpage=<%=curpage+1 %>" title="Next Page">下一页 &raquo;</a>                  
                  <%} %>  
                                             当前第<%=curpage %>页/共<%=maxpage %>页
                  <!-- </form> --><br/>
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
              <tr trname="<%=result.get("ARTI_ID") %>">
                <td>
                  <input type="checkbox" name="checkbox" value="<%=result.get("ARTI_ID") %>" />
                </td>
                <td><%=result.get("ARTI_NAME") %></td>
                <td><a href="#" title="title"><%=result.get("cate_name") %></a></td>
                <td><%=result.get("ARTI_CREATETIME") %></td>
                <td><%=result.get("ARTI_AUTHOR") %></td>
                <td>
                	<% 
                		int check = (Integer)result.get("ARTI_CHECK");
                		if(check==0){%>
                		<%="待审核" %>
                	<% }else if(check==-2){%>
                	<span style="color:red"><%="被举报" %></span><% }%>
                </td>
                <td>
                  <!-- Icons -->
                  <a href="<%=basePath2 %>/manager/AdminNewsMg?newsid=<%=result.get("ARTI_ID")%>" title="查看全文"><img src="<%=basePath %>resources/images/icons/pencil.png" alt="查看全文" /></a> 
                  <a href="<%=basePath2 %>/manager/AdminNewsCheck?newsid=<%=result.get("ARTI_ID")%>&check=1" title="通过"><img src="<%=basePath %>resources/images/icons/tick_circle.png" alt="通过" /></a>  
                  <a href="<%=basePath2 %>/manager/AdminNewsCheck?newsid=<%=result.get("ARTI_ID")%>&check=-1" title="不通过"><img src="<%=basePath %>resources/images/icons/cross.png" alt="不通过" /></a> 
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
