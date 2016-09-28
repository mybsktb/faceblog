<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page  import="com.faceblog.entity.SplitPage"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	$(function() {
		$(".button").attr("disabled",true);
		$("a[title='Delete']").click(function() {
		var r=confirm("确认删除该评论？");
             if(r==true){
			commentID = $(this).attr("value");
			$(this).parent().parent().remove();
			curPage = $(".number").attr("value");
			$.post("manager/cmtDel?commentID="+commentID, function(data){
				//location.href="manager/cateMg?curPage="+curPage;
				$("#note").html('');
  				if(data=='true'){
					$("#note").append("<img src='${basePath}resources/images/icons/tick_circle.png' /><span>删除成功！</span>");
					$("#note").show().delay(1000).fadeOut("slow");
					window.setTimeout("window.location='manager/cmtMg?curPage="+curPage+"'",2000);
				}
				else{
					$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>删除失败！</span>");
				}
			});
			}
 		});
		$(".button").click(function() {
		var r=confirm("确认删除选中评论？");
             if(r==true){
			var commentID="";
			$("tbody :checked").each(function() {
				id = $(this).attr("value");
				commentID+=','+id;
				$(this).parent().parent().remove();
			});
			commentID=commentID.substring(1);
			$.post("manager/cmtDel?commentID="+commentID, function(data){
				curPage = $(".number").attr("value");
				$("#note").html('');
  				if(data=='true'){
					$("#note").append("<img src='${basePath}resources/images/icons/tick_circle.png' /><span>删除成功！</span>");
					$("#note").show().delay(1000).fadeOut("slow")
					window.setTimeout("window.location='manager/cmtMg?curPage="+curPage+"'",2000);
				}
				else{
					$("#note").append("<img src='${basePath}resources/images/icons/cross_circle.png' /><span>删除失败！</span>");
					}
			});
			}else{
				$(":checked").prop("checked",false);
				$(".button").attr("disabled",true);
			}
		});
		$("#checkAll").click(function() {
			var _this = $(this);
			$("tbody :checkbox").prop("checked", _this.is(':checked'));
			$(".button").attr("disabled",!_this.is(':checked'));
		});
		$("tbody :checkbox").click(function(){
				//这个result控制的是 checkAll 是否选中
				var result = true;
				var disabled = true;
				//循环
				$("tbody :checkbox").each(function(i,val){
					if(!val.checked){
						 	result = false;				
						 return false;
					}
				});
				$("tbody :checkbox").each(function(i,val){
					if(!val.checked){
						 disabled = false;				
						 return false;
					}
				});
				$("#checkAll").prop("checked",result);
				$(".button").attr("disabled",disabled);	
		});
		$("#jump").click(function(){
			location.href="${basePath}manager/cmtMg?curPage="+$("#curpage").val+"&readed=${readed}&artiID=${artiID}";
		}); 
	});
</script>
</head>
<body>
	<div id="body-wrapper">
		<!-- Wrapper for the radial gradient background -->

		<jsp:include page="../include/leftSide.jsp">
			<jsp:param value="blog" name="index" />
			<jsp:param value="cmtMg" name="msg" />
		</jsp:include>

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
			<h3>新闻中心--评论管理</h3>
			<!-- Page Head -->
			<div class="clear"></div>
			<!-- End .clear -->
			<div class="content-box">
				<!-- Start Content Box -->
				<div class="content-box-header">
					<h3>评论管理<span id="note"></span></h3>
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
									<th><input id="checkAll" type="checkbox" />全选</th>
									<th>文章标题</th>
									<th>评论者</th>
									<th>评论</th>
									<th>操作</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="6">
										<div class="bulk-actions align-left">
											<!--   <select name="dropdown">
                      <option value="option1">Choose an action...</option>
                      <option value="option2">Edit</option>
                      <option value="option3">Delete</option>
                    </select> -->
											<input type="button" class="button" value="删除所选"/>
										</div>
										<%
											SplitPage splitPage = (SplitPage) request.getAttribute("splitPage"); 
										%>
										<div class="pagination">
											<a href="${basePath}manager/cmtMg?curPage=1&readed=${readed}&artiID=${artiID}" title="First Page">&laquo; First</a> 
											<a href="${basePath}manager/cmtMg?curPage=${splitPage.curPage-1}&readed=${readed}&artiID=${artiID}" title="Previous Page">&laquo; Previous</a>
											<input  type="text" style="width:20px" value="${splitPage.curPage}" id="curpage"/>
											<input type="button"  value="Jump" id="jump"/> 
											<a href="${basePath}manager/cmtMg?curPage=${splitPage.curPage+1}&readed=${readed}&artiID${artiID}" title="Next Page">Next &raquo;</a>
											<a href="${basePath}manager/cmtMg?curPage=${splitPage.maxPage}&readed=${readed}&artiID=${artiID}" title="Last Page">Last &raquo;</a>
										</div> <!-- End .pagination -->
										<div class="clear"></div>
									</td>
								</tr>
							</tfoot>
							<tbody>
								<c:if test="${!empty splitPage.data}">
									<c:forEach items="${splitPage.data}" var="map">
								<tr>
									<td><input type="checkbox" value="${map.comment_id}"/>
									</td>
									<td>${map.arti_name}</td>
									<td>${get.user_name}</td>
									<td>${map.comment_content}</td>

									<td>
										<!-- Icons --> 
										<a href="manager/reCmtMg?commentid=${map.comment_id}"  title="Edit">
										<img src="resources/images/icons/pencil.png" alt="Edit" /> </a> 
											<a href="javascript:void(0)" title="Delete" value="${map.comment_id}"><img
											src="resources/images/icons/cross.png" alt="Delete" /> </a> 
									</td>
								</tr>
								</c:forEach>
								</c:if>

							</tbody>
						</table>
					</div>
					<!-- End #tab1 -->
				</div>
				<!-- End .content-box-content -->
			</div>
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
