<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻管理</title>
<%@ include file="../include/head.jsp"%>
<!-- jQuery Datepicker Plugin -->
<script type="text/javascript"
	src="resources/scripts/jquery.datePicker.js"></script>
<script type="text/javascript" src="resources/scripts/jquery.date.js"></script>
<script>
		$(function(){
		$(".deletebutton").attr("disabled",true);
			$(".checkAll").click(function(){
				var _this = $(this); 
				$("tbody :checkbox").attr("checked",_this.is(':checked'));
				$(".deletebutton").attr("disabled",!_this.is(':checked'));
			})			
			$("tbody :checkbox").click(function(){
				//flag表示：自己是否选中
				var flag = $(this).is(":checked");
				//这个result控制的是 checkAll 是否选中
				var result = true;
				var disabled = true;
				//循环
				$("tbody :checkbox").each(function(i,val){
					if(val.checked != flag){
						 result =false;					
						 return false;
					}
				});	
				$("tbody :checkbox").each(function(i,val){
					if(val.checked){
						 disabled = false;				
						 return false;
					}
				});			
				if(result){
					$(".checkAll").attr("checked",flag);
				}else{
					$(".checkAll").attr("checked",false);
				}
				$(".deletebutton").attr("disabled",disabled);	
			}); 

		})		
	</script>
<script type="text/javascript">
$(function(){
     var basePath='<%=basePath%>';
     $(".deletebutton").click(function(){
         var r=confirm("确认删除所选文章？");
         if(r==true){
          //获取table所有复选框，obj为数组
          var obj = document.getElementsByName("checkbox_name");
          //获取文章那一列id
          var titleid = document.getElementsByName("id_name");
          //循环复选框数组          
          for(k in obj){
          //判断checkbox是否被选中
             if(obj[k].checked){
                //获取checkbox被选中那一行文章的id
               var id_name=titleid[k].innerHTML;
                 $.ajax({
                   url:"manager/NewsMgDelServlet",
                   type:"POST",
                   data:{idName:id_name},
                   dataType:"text",
                   success:function(data){
                   // 数据删除成功，刷新页面 
                      alert(data); 
                      location.reload();              
                   },
               }); 
             }
          }
          }
          else{
                alert("取消删除成功！");
                $(":checkbox").attr("checked",false);
                $(".deletebutton").attr("disabled",true);
             }          
     });
  });
  $(function(){   
        $('[name=DeleteArticle]').click(function(){
             var arti_id=$(this).siblings(".btn_selected").val();           
             //alert(arti_id);
             var r=confirm("确认删除该文章？");
             if(r==true){
                $.ajax({
                   url:"manager/NewsMgDelServlet",
                   type:"POST",
                   data:{idName:arti_id},
                   dataType:"text",
                   success:function(data){
                   // 文章删除成功，刷新页面 
                      alert(data); 
                      location.reload();              
                   },
                });
             }
             else{
                alert("取消成功！");     
             } 	 
        });
  });
 </script>
</head>
<body>
<div id="body-wrapper">
  <!-- Wrapper for the radial gradient background -->
  <div id="sidebar">
    <div id="sidebar-wrapper">
       <jsp:include page="/backstage/include/leftSide.jsp">
       <jsp:param value="blog" name="index" />
			<jsp:param value="newsMg" name="msg" />
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
	<h3>新闻中心--文章管理</h3>
    <!-- Page Head -->
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
        <h3>文章管理</h3>
      <!--   <ul class="content-box-tabs">
          <li><a href="#tab1" class="default-tab">Table</a></li>
          <li><a href="#tab2">Forms</a></li>
        </ul> -->
        <div class="clear"></div>
      </div>
      <!-- End .content-box-header -->
      <div class="content-box-content">
        <div class="tab-content default-tab" id="tab1">
          <!-- This is the target div. id must match the href of this div's tab -->
          <!-- 操作提示信息
		  <div class="notification attention png_bg"> <a href="#" class="close"><img src="resources/images/icons/cross_grey_small.png" title="Close this notification" alt="close" /></a>
            <div> This is a Content Box. You can put whatever you want in it. By the way, you can close this notification with the top-right cross. </div>
          </div> -->
          <table>
            <thead>
              <tr>
                <th>
                  <input class="checkAll" type="checkbox" />全选
                </th>
                <th>标题</th>
                <th>所属栏目</th>
                <th>创建时间</th>
                <th>作者</th>
                <th>是否推荐</th>
                <th>审核状态</th>
                <th>评论</th>
                 <th>修改</th>
                <th>删除</th>
              </tr>
            </thead>
            <tfoot>
              <tr>
                <td colspan="9">
                  <div class="bulk-actions align-left">
                    <!-- <select name="dropdown">
                      <option value="option1">Choose an action...</option>
                      <option value="option2">Edit</option>
                      <option value="option3">Delete</option>
                    </select> -->
                 <!--   <a class="button" href="#">删除所选</a> </div>-->
                   <input class="deletebutton" type="button" value="删除所选" style="color:green" /> </div>
                   <div style="float:left;margin:16px 40px">
                   <form action="<%=basePath%>manager/NewsMgServlet" method="get">
                   <input type="text" style="width:80px" class="mytext_class" name="select_name" value="${selName}"/>
                    <input type="submit" value="按标题的关键字查询" />
                  </form>
                  </div>
                
                  <div class="pagination" style="float: right"> 
                  <a href="<%=basePath%>manager/NewsMgServlet?current=1&&select_name=${selName}&recommend=${recommend}&artiCheck=${artiCheck}&cateId=${cateId}" title="First Page">&laquo; 首页</a>
                  <a href="<%=basePath%>manager/NewsMgServlet?current=${pageObj.previous}&select_name=${selName}&recommend=${recommend}&artiCheck=${artiCheck}&cateId=${cateId}" title="Previous Page">&laquo; 上一页</a> 
                  <a href="<%=basePath%>manager/NewsMgServlet?current=${pageObj.currentPage}&select_name=${selName}&recommend=${recommend}&artiCheck=${artiCheck}&cateId=${cateId}" class="number current" title="3">${pageObj.currentPage}</a>
                  <a href="<%=basePath%>manager/NewsMgServlet?current=${pageObj.next}&select_name=${selName}&recommend=${recommend}&artiCheck=${artiCheck}&cateId=${cateId}" title="Next Page">下一页 &raquo;</a>
                  <a href="<%=basePath%>manager/NewsMgServlet?current=${pageObj.maxPage}&select_name=${selName}&recommend=${recommend}&artiCheck=${artiCheck}&cateId=${cateId}" title="Last Page">末页 &raquo;</a> 
                  <span style="color:green">共${pageObj.maxPage}页</span>
                  </div>
                  <!-- End .pagination -->
                  <div class="clear"></div>
                </td>
              </tr>
            </tfoot>
            <tbody>
               <%  
            		List<Map<String,Object>> results = (List<Map<String,Object>>) request.getAttribute("articleResult");
            		if(results!=null){
            			for(Map<String,Object> result : results){
             %>            
              <tr>
                <td>
                  <input type="checkbox" name="checkbox_name"/>
                </td>
                <td style="display:none" name="id_name"><%=result.get("ARTI_ID")%></td>
                <td width="15%" class="selected" name="title_name"> <%=result.get("ARTI_NAME")%> </td>
                <td width="12%" class="selected" name="category_name" ><%=result.get("CATE_NAME")%></td>
                <%String artiCreTime=result.get("ARTI_CREATETIME").toString().substring(0,20).substring(0,19);%>
                <td width="15%"><%=artiCreTime%></td>               
                <td width="9%" class="selected" name="author_name"><%=result.get("ARTI_AUTHOR")%></td>
            <%if("0".equals(result.get("ARTI_RECOMMEND").toString())){ %>            
                <td width="9%" class="selected" name="recommend">不推荐</td>
           <%}else{ %>
                <td width="9%" class="selected" name="recommend">推荐</td>
             <% }
                if("0".equals(result.get("ARTI_CHECK").toString())){
             %>
                <td width="9%" class="selected" name="article_check">未审核</td>
              <%}
               if("1".equals(result.get("ARTI_CHECK").toString())){
               %>
                <td width="9%" class="selected" name="article_check">通过</td>
               <%}
               if("-1".equals(result.get("ARTI_CHECK").toString())){
                %> 
                <td width="9%" class="selected" name="article_check">不通过</td>
               <%} 
               if("-2".equals(result.get("ARTI_CHECK").toString())){
               %> 
               <td width="9%" class="selected" name="article_check">被举报</td>
               <%} %>
                <td><a href="<%=basePath%>manager/cmtMg?artiID=<%=result.get("ARTI_ID")%>"><img height="20" width="20" src="<%=basePath%>/resources/images/icons/comment_48.png" alt="Comment" /></a></td>
               <td> <a href="<%=basePath%>manager/NewsUpdateServlet?articleID=<%=result.get("ARTI_ID")%>" name="tEdit" title="Edit"><img src="<%=basePath%>/resources/images/icons/pencil.png" alt="Edit" /></a></td>
                <td >
                  <!-- Icons -->
                 
                  <a name="DeleteArticle" title="Delete"><img src="<%=basePath%>/resources/images/icons/cross.png" alt="Delete" /></a> 
                  <input class="btn_selected" type="button"  value="<%=result.get("ARTI_ID")%>" style="display:none"/> 
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
          &#169; Copyright 2010 Your Company | Powered by admin templates | Top </small> </div>
    <!-- End #footer -->
  </div>
  <!-- End #main-content -->
</div>
</body>
 
</html>
