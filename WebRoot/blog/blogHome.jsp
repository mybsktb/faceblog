<%@page import="com.faceblog.entity.Page"%>
<%@page import="com.faceblog.util.*"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	int userId = 1;
  	//userId = StringUtil.stringToInt( request.getParameter("userId"));
  	int pagenum=1;
  	//pagenum=StringUtil.stringToInt(request.getParameter("pagenum"));
  	int cateId =1;
  	//cateId = StringUtil.stringToInt(request.getParameter("cateId"));
%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>FaceBlog</title>
<meta name="keywords" content="个人博客模板,博客模板,响应式" />
<meta name="description" content="如影随形主题的个人博客模板，神秘、俏皮。" />
<link href="css/baseHome.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/media.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/normalize.css" />
<meta name="viewport"
	content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">

<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]--><script>
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
		<%@ include file="include/blogHomeHeader.jsp"%>
		<article>
			<br />

			<div class="bloglist">
				<h2>
					<p>
						<span>推荐</span>文章
					</p>
				</h2>

				<%
					Page page2 = (Page) request.getAttribute("page");
					int j = 0;
					List<Map<String, Object>> results = page2.getData();
					for (Map<String, Object> result : results) {
					String time=result.get("ARTI_TIME").toString().substring(0,10);
					String content=null;
            	String cont=result.get("ARTI_CONTENT").toString();
            		//截取文章前200字作为推荐文章内容
            		if(cont.length()<200){
            		content=cont;
            		}else{
            		content=cont.substring(0,200);
            		}
						j++;
				%>
				<div class="blogs">
					<h3>
						<a href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>"
							><%=result.get("ARTI_NAME")%></a> &nbsp总分 <%=result.get("score") %>
					</h3>

					<figure>
						<img src="images/01.jpg">
					</figure>
					<ul>
						<p><a href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>"
							><%=content%></a></p>

						<a
							href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>"
							target="_blank" class="readmore">阅读全文&gt;&gt;</a>
					</ul>
					<p class="autor">
						<span>作者：<a
							href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/Recomm?userId=<%=result.get("ARTI_USERID")%>"><%=result.get("USER_NAME")%></a>
						</span> <span>分类：
						【<a href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/newlist.jsp?userId=<%=result.get("ARTI_USERID")%>&pagenum=1&cateId=<%=result.get("ARTI_CATEID")%>"><%=result.get("CATE_NAME")%></a>】
						
						</span> <span>浏览（<%=result.get("ARTI_CTR")%>）</span> <span>评论（<%=result.get("ARTI_COMMENTCOUNT")%>）</span> <span><a
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
					<div class="dateview"><%=time%></div>
				</div>
				<%
					}
				%>



			</div>

			<div class="page">
				总页数<a title="Total record"><b><%=page2.getTotalPage()%></b> </a>
				<%
					for (int i = 0; i < page2.getTotalPage(); i++) {
						if ((i + 1) != page2.getCurrentPage()) {
				%>
				<a
					href="<%=request.getScheme() + "://"
							+ request.getServerName() + ":"
							+ request.getServerPort()
							+ request.getContextPath() + "/"%>/blog/blogHome?currentPage=<%=i + 1%>"><%=i + 1%></a>
				<%
					} else {
				%>
				<b><%=page2.getCurrentPage()%></b>
				<%
					}
					}
					if (page2.getCurrentPage() != page2.getTotalPage()) {
				%>
				<a
					href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>/blog/blogHome?currentPage=<%=page2.getCurrentPage() + 1%>">&gt;</a>
				<a
					href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>/blog/blogHome?currentPage=<%=page2.getTotalPage()%>">&gt;&gt;</a>
				<%
					}
				%>
			</div>

		</article>
		<%@ include file="include/blogHomeAside.jsp"%>

		<script src="js/silder.js"></script>
		<div class="clear"></div>
		<!-- 清除浮动 -->
	</div>
</body>
</html>
