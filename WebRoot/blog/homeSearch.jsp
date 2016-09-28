<%@ page language="java" 
	import="java.util.*" 
	import="com.faceblog.util.*"
	import="com.faceblog.entity.*"
	import="com.faceblog.common.*"
	import="com.faceblog.dao.*"
	import="com.faceblog.dao.impl.*"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>黑色Html5响应式个人博客模板――主题《如影随形》</title>
<meta name="keywords" content="个人博客模板,博客模板,响应式" />
<meta name="description" content="如影随形主题的个人博客模板，神秘、俏皮。" />
<link href="css/baseHome.css" rel="stylesheet">
<link href="css/index.css" rel="stylesheet">
<link href="css/media.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
<!--[if lt IE 9]>
<script src="js/modernizr.js"></script>
<![endif]-->
</head>
<body>
<div class="ibody">
  <jsp:include page="include/blogHomeHeader.jsp"></jsp:include>
  <article><br/>
    
    <div class="bloglist">
      <h2>
        <p><span>搜索</span>结果</p>
      </h2>
      <%
     	 String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
      		
      		Article art = new Article();
      		int pagenum = 1;
      		int  userId = 0;
      		try{
      		pagenum = Integer.parseInt(request.getParameter("pagenum"));
      		userId =  Integer.parseInt(request.getParameter("userId"));
      		}catch(NumberFormatException ex){
      		}
      		Page pg = new Page();
      		String searchword = request.getParameter("searchWord");
      		art.setArt_name(searchword);
      		NewsMgDaoImpl nmdi = new NewsMgDaoImpl();
      		pg = nmdi.pageForSearch(art, pagenum);
      		for(Map<String, Object> i:pg.getData()){
      		String articontent = "";
      		if(i.get("ARTI_CONTENT").toString().length()>Const.NUM_ARTI_LOOK){
        	articontent = i.get("ARTI_CONTENT").toString().substring(0,Const.NUM_ARTI_LOOK)+"...";
        	}else{
        	articontent=i.get("ARTI_CONTENT").toString();
        	}
      		
       %>
      	 <div class="newblog" style="width:90%;">
		        <ul>
			          <h3><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=i.get("ARTI_ID") %>&userId=<%=i.get("ARTI_USERID")%>&ARTI_CTR=<%=i.get("ARTI_CTR") %>&ARTI_CATEID=<%=i.get("CATE_ID")%>"><%=i.get("ARTI_NAME") %></a></h3>
			          <div class="autor"><span>作者：<%=i.get("USER_NAME") %></span><span>分类：[<a href="<%=basePath%>blog/newlist.jsp?userId=<%=i.get("ARTI_USERID")%>&pagenum=1&cateId=<%=i.get("CATE_ID") %>"><%=i.get("CATE_NAME") %></a>]</span><span>浏览（<a href="javascript:void(0)"><%=i.get("ARTI_COMMENTCOUNT") %></a>）</span><span>评论（<a href="javascript:void(0)"><%=i.get("ARTI_CTR") %></a>）</span></div>
			          <p style="width:93%;word-wrap:break-word;word-break:break-all"><%=articontent %><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=i.get("ARTI_ID") %>&userId=<%=i.get("ARTI_USERID")%>&ARTI_CTR=<%=i.get("ARTI_CTR") %>&ARTI_CATEID=<%=i.get("CATE_ID")%>"  target="_blank" class="readmore">全文</a></p>
		        </ul>
		        <figure>
		        		<img src="images/001.jpg" >
		        </figure>
		        <div class="dateview"><%=i.get("ARTI_TIME").toString().substring(0,10) %></div>
   		 </div>
   		 <%} %>
         <div class="page">
			   	<a title="Total record"><b><%=pg.getTotalPage() %></b></a>
			    <a href="<%=basePath%>blog/homeSearch.jsp?pagenum=1&searchWord=<%=searchword %>"  title="1" class="csschange">1</a>
			    <%
   		 			int n=1;
    				for(n=2;n<pg.getTotalPage()+1;n++){
     			%>
			    <a href="<%=basePath%>blog/homeSearch.jsp?pagenum=<%=n %>&searchWord=<%=searchword %>"  title="<%=n%>"><%=n%></a>
				<%} if(pagenum+1<=pg.getTotalPage()){%>
			    <a href="<%=basePath%>blog/homeSearch.jsp?pagenum=<%=pagenum+1 %>&searchWord=<%=searchword %>">&gt;</a>
    			<%}else{ %>
    			<a href="<%=basePath%>blog/homeSearch.jsp?pagenum=<%=pg.getTotalPage() %>&searchWord=<%=searchword %>">&gt;</a>
    			<%} %>
    			<a href="<%=basePath%>blog/homeSearch.jsp?pagenum=<%=pg.getTotalPage() %>&searchWord=<%=searchword %>">&gt;&gt;</a>
    	</div>
  </article>

 <jsp:include page="include/blogHomeAside.jsp"></jsp:include>
 
  <script src="js/silder.js"></script>
  <div class="clear"></div>
  <!-- 清除浮动 --> 
</div>
</body>
</html>
