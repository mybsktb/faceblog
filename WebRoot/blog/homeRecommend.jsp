<%@page import="com.faceblog.common.Const"%>
<%@page import="com.faceblog.util.StringUtil"%>
<%@ page language="java" 
	import="java.util.*"  	
	import= "com.faceblog.entity.*" 
	import="com.faceblog.dao.impl.*" 
	import= "com.faceblog.common.*" 
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

  	int userId = -1;
  	userId = StringUtil.stringToInt( request.getParameter("userId"));
  	int pagenum=1;
  	pagenum=StringUtil.stringToInt(request.getParameter("pagenum"));
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
		.csschange{ background: #333; color: #FFF; }
	</style>
	
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
	<!--[if lt IE 9]>
	<script src="js/modernizr.js"></script>
	<![endif]-->
	<script type="text/javascript" src="js/jquery-1.10.2.js"></script>
	<script type="text/javascript" >
		$(function(){
			$("#clue").fadeOut(6000);
		})
	</script>

</head>
<body>
<div class="ibody">
  
<jsp:include page="/blog/include/blogHomeHeader.jsp"></jsp:include>
  <article>
    <h2>&nbsp</h2>
    <p id="clue" align="center">温馨提示：多参与点赞反对，让我们了解你的喜好，系统会推荐你可能喜欢的文章</p><br/><br/>
    <div class="bloglist">
      <% 
      	List<Map<String,Object>> results = (List<Map<String, Object>>) request.getAttribute("results"); 
      	List<Double> score = (List<Double>)request.getAttribute("score");
      	int i=-1;
      	for(Map<String,Object> result:results){
      	i++;
      	String time = result.get("ARTI_TIME").toString().split(" ")[0];
      	String content=null;
            	String cont=result.get("ARTI_CONTENT").toString();
            		//截取文章前200字作为推荐文章内容
            		if(cont.length()<200){
            		content=cont;
            		}else{
            		content=cont.substring(0,200);
            		}
      %>
      <div class="newblog">
        <ul>
          <h3><a href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>"
							><%=result.get("ARTI_NAME") %> 预计评分<%=score.get(i) %></a></h3>
          <div class="autor"><span>作者：<%=result.get("USER_NAME") %></span><span>分类：[<a href="<%=basePath %>blog/newlist.jsp?userId=<%=result.get("ARTI_USERID")%>&pagenum=1&cateId=<%=result.get("ARTI_CATEID")%>"><%=result.get("CATE_NAME") %></a>]</span><span>浏览（<a style="color:black"><%=result.get("ARTI_CTR") %></a>）</span><span>评论（<a style="color:black"><%=result.get("ARTI_COMMENTCOUNT") %></a>）</span></div>

          <p><%=content %><a href="<%=request.getScheme() + "://" + request.getServerName()
						+ ":" + request.getServerPort()
						+ request.getContextPath() + "/"%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&userId=<%=result.get("ARTI_USERID")%>"
							 target="_blank" class="readmore">全文</a></p>
        </ul>
        <figure><img src="images/007.jpg" ></figure>
        <div class="dateview"><%=time %></div>
      </div>
      <%} %>
    </div>
  </article>
  
<%@ include file="include/blogHomeAside.jsp"%>
  <script src="js/silder.js"></script>
  <div class="clear"></div>
  <!-- 清除浮动 --> 
</div>
</body>
</html>
