<%@page import="com.faceblog.entity.Page"%>
<%@page import="com.faceblog.common.Const"%>
<%@page import="com.faceblog.util.StringUtil"%>
<%@ page language="java" import="java.util.*"
	import="com.faceblog.entity.*" import="com.faceblog.dao.impl.*"
	import="com.faceblog.common.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	int userId = -1;
	userId = StringUtil.stringToInt(request.getParameter("userId"));
	int pagenum = 1;
	pagenum = StringUtil.stringToInt(request.getParameter("pagenum"));
	int cateId = 0;
	cateId = StringUtil.stringToInt(request.getParameter("cateId"));
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>黑色Html5响应式个人博客模板――主题《如影随形》</title>
<meta name="keywords" content="个人博客模板,博客模板,响应式" />
<meta name="description" content="如影随形主题的个人博客模板，神秘、俏皮。" />
<link href="css/baseHome.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/media.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<style type="text/css">
.csschange {
	background: #333;
	color: #FFF;
}
</style>

<meta name="viewport"
	content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
<!--[if lt IE 9]>
	<script src="js/modernizr.js"></script>
	<![endif]-->
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<script>
$(function(){
			$("a[id^='a']").click(function(){

			var assess=$(this).attr("value");
				//alert(assess);
				var _this = $(this);
				var url="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"%>blog/addAssessServ";

				$.ajax({
									url : url,
									data : {
										datas : assess
									},
									success : function() {
										_this.fadeOut(1000);
									}
								})
				

	})
});
</script>

</head>
<body>
	<div class="ibody">

		<jsp:include page="/blog/include/blogHomeHeader.jsp"></jsp:include>
		<article>
			<h2>&nbsp</h2>
			<div class="bloglist">
				<%
					Page page3 = (Page) request.getAttribute("page");
					int j = 0;
					List<Map<String, Object>> results = page3.getData();
					for (Map<String, Object> result : results) {
						j++;
				      	String content=null;
		            	String cont=result.get("ARTI_CONTENT").toString();
		            		//截取文章前200字作为推荐文章内容
		            		if(cont.length()<200){
		            		content=cont;
		            		}else{
		            		content=cont.substring(0,200);
		            		}
		            		String time =result.get("ARTI_TIME").toString().split(" ")[0];
				%>
				
				<div class="newblog">
					<ul style="width:496.8px">
						<h3>
							<a href="<%=basePath %>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>"><%=result.get("ARTI_NAME") %></a>
						</h3>
						<div class="autor">
							<span>作者：<a href="<%=basePath %>blog/Recomm?userId=<%=result.get("ARTI_USERID")%>"><%=result.get("USER_NAME") %></a></span><span>分类：[<a href="<%=basePath %>blog/newlist.jsp?userId=<%=result.get("ARTI_USERID")%>&pagenum=1&cateId=<%=result.get("ARTI_CATEID")%>"><%=result.get("CATE_NAME") %></a>]</span><span>浏览（<a
								><%=result.get("ARTI_CTR") %></a>）</span><span>评论（<a><%=result.get("ARTI_COMMENTCOUNT") %></a>）</span>
						</div>
						  <p style="width:90%;word-wrap:break-word;word-break:break-all">
							<%=content %></p>
							<a
								href="<%=basePath %>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>" target="_blank" class="readmore">全文</a>
								
								 <span><a
							id="a<%=j%>1" href="javascript:void(0)"
							value="user_id=<%=session.getAttribute("userId")%>&arti_id=<%=result.get("ARTI_ID")%>&attitude=agree"
							style="color:orange">点赞</a> </span> <span><a id="a<%=j%>2"
							href="javascript:void(0)"
							value="user_id=<%=session.getAttribute("userId")%>&arti_id=<%=result.get("ARTI_ID")%>&attitude=disagree"
							style="color:red;">讨厌</a> </span> <span><a id="a<%=j%>3"
							href="javascript:void(0)"
							value="user_id=<%=session.getAttribute("userId")%>&arti_id=<%=result.get("ARTI_ID")%>&attitude=tired"
							style="color:black">你滚</a> </span> <span><a id="a<%=j%>4"
							href="javascript:void(0)"
							value="user_id=<%=session.getAttribute("userId")%>&arti_id=<%=result.get("ARTI_ID")%>&attitude=copy">转载</a>
						</span>
						</p>
						
					</ul>
					<figure>
						<img  src="images/007.jpg">
					</figure>
					<div class="dateview"><%=time %></div>
				</div>
				<%} %>
			</div>
			<div align="center" >
			<a href="homeBrowseServ"><b>换一批</b></a><br/><br/>&nbsp;
			</div>
		</article>
		<%@ include file="include/blogHomeAside.jsp"%>
		<script src="js/silder.js"></script>
		<div class="clear"></div>
		<!-- 清除浮动 -->
	</div>
</body>
</html>
