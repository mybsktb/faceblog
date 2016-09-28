<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

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
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
<%@ page language="java" import="com.faceblog.entity.Page"%>
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<script>
	$(function(){
		//alert("123");
		$("#user").focus();
	})
</script>
</head>
<body>
<div class="ibody">
  <jsp:include page="include/blogHomeHeaderLogin.jsp"></jsp:include>
  <article><br/>
    
    <div class="bloglist">
      <h2>
        <p><span>推荐</span>文章</p>
      </h2>
      				<%
					Page page2 = (Page) request.getAttribute("page");
					int j = 0;
					List<Map<String, Object>> results = page2.getData();
					for (Map<String, Object> result : results) {
					String time=result.get("ARTI_TIME").toString().substring(0,10);
						j++;
				%>
				<div class="blogs">
					<h3>
						<a href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>"
							><%=result.get("ARTI_NAME")%></a>
					</h3>

					<figure>
						<img src="images/01.jpg">
					</figure>
					<ul>
						<p><a href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>"
							><%=result.get("ARTI_ABSTRACT")%></a></p>

						<a href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>"
							target="_blank" class="readmore">阅读全文&gt;&gt;</a>
					</ul>
					<p class="autor">
						<span>作者：<a
							href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/Recomm?userId=<%=result.get("ARTI_USERID")%>"><%=result.get("USER_NAME")%></a>
						</span> <span>分类：【<a href="/"><%=result.get("CATE_NAME")%></a>】</span> <span>浏览（<%=result.get("ARTI_CTR")%>f）</span> <span>评论（<%=result.get("ARTI_COMMENTCOUNT")%>）</span>

					</p>
					<div class="dateview"><%=time%></div>
				</div>
				<%
					}
				%>
    </div>
  </article>
 <%@ include file="include/blogHomeAsideLogin.jsp"%>
 
  <script src="js/silder.js"></script>
  <div class="clear"></div>
  <!-- 清除浮动 --> 
</div>
</body>
</html>
