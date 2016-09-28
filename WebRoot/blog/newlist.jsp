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
	<link href="css/base.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/media.css" rel="stylesheet">
	<style type="text/css">
		.csschange{ background: #333; color: #FFF; }
	</style>
	
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
	<!--[if lt IE 9]>
	<script src="js/modernizr.js"></script>
	<![endif]-->
<script type="text/javascript" src="js/jquery-1.10.2.js"></script>
<script type="text/javascript">
		$(function(){
			//1. 判断是不是自己主页，记录最近访客
			var flag=false;
			if(<%=userId%>==<%=session.getAttribute("userId")%>)
			flag = true;
			var addVisitor="<%=basePath%>/blog/addVisitorServ";
			if(!flag){
			//alert("here");
			$.ajax({url:addVisitor,
			data:{visitor:<%=session.getAttribute("userId")%>,host:<%=userId%>},
			success:function(){alert("here");
			}
			});
			};
				var pagenum='<%=pagenum%>';
				$(".page a[title="+pagenum+"]").addClass('csschange').siblings().removeClass('csschange');
				
			$("a[id^='a']").click(function(){
				if(flag) alert("请不要点自己的赞，到别人的主页去看看吧！");
				var assess=$(this).attr("value");//alert(assess);
				var url="<%=basePath%>/blog/addAssessServ";
				var _this=$(this);
				if(!flag)
				$.ajax({url:url,
				data:{datas:assess},
				success:function(){
				_this.fadeOut(1000);
				}
				
				})
			})
			
		});
</script>
</head>
<body>
<div class="ibody">
<jsp:include page="/blog/include/header.jsp"></jsp:include>
 <!--  <header>
    <h1>如影随形</h1>
    <h2>影子是一个会撒谎的精灵，它在虚空中流浪和等待被发现之间;在存在与不存在之间....</h2>
    <div class="logo"><a href="/"></a></div>
    <nav id="topnav"><a href="index.html">首页</a><a href="about.html">关于我</a><a href="newlist.html">慢生活</a><a href="share.html">模板分享</a><a href="new.html">模板主题</a></nav>
  </header> -->
  
  <article>
    <h2 class="about_h">您现在的位置是：<a href="<%=basePath%>blog/Recomm?userId=<%=userId%>">首页</a>><a href="<%=basePath%>blog/newlist.jsp?userId=<%=userId%>&pagenum=1&cateId=0">文章列表</a></h2>
    <div class="bloglist">
    <%
        Article article = new Article();
        article.setUser_id(userId);
        article.setCate_id(cateId);
        NewsMgDaoImpl nmdi = new NewsMgDaoImpl();
        Page pg  = nmdi.getArticlesPage(article, pagenum);
        if(pg.getData()!=null){
        int j=0;
        for(Map<String, Object> i:pg.getData()){
        String articontent= "";
        j++;
        if(i.get("ARTI_CONTENT").toString().length()>Const.NUM_ARTI_LOOK){
        	articontent = i.get("ARTI_CONTENT").toString().substring(0,Const.NUM_ARTI_LOOK);
        	}else{
        	articontent=i.get("ARTI_CONTENT").toString();
        	}
         %>
      <div class="newblog" style="width:90%;">
        <ul>
          <h3><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=i.get("ARTI_ID") %>&userId=<%=userId%>&ARTI_CTR=<%=i.get("ARTI_CTR") %>&ARTI_CATEID=<%=i.get("CATE_ID")%>"><%=i.get("ARTI_NAME") %></a></h3>
          <div class="autor"><span>作者：<%=i.get("ARTI_AUTHOR") %></span><span>分类：[<a href="<%=basePath%>blog/newlist.jsp?userId=<%=userId%>&pagenum=1&cateId=<%=i.get("CATE_ID") %>"><%=i.get("CATE_NAME") %></a>]</span><span>浏览（<a ><%=i.get("ARTI_CTR") %></a>）</span><span>评论（<a ><%=i.get("ARTI_COMMENTCOUNT") %></a>）</span>
          			<span><a id="a<%=j %>1" href="javascript:void(0)" value="user_id=<%=session.getAttribute("userId")%>&arti_id=<%=i.get("ARTI_ID") %>&attitude=agree" style="color:orange" >点赞</a></span>
          			<span><a id="a<%=j %>2"  href="javascript:void(0)" value="user_id=<%=session.getAttribute("userId")%>&arti_id=<%=i.get("ARTI_ID") %>&attitude=disagree" style="color:red;">讨厌</a></span>
          			<span><a id="a<%=j %>3"  href="javascript:void(0)" value="user_id=<%=session.getAttribute("userId")%>&arti_id=<%=i.get("ARTI_ID") %>&attitude=tired" style="color:black">你滚</a></span>
          			<span><a id="a<%=j %>4" href="javascript:void(0)" value="user_id=<%=session.getAttribute("userId")%>&arti_id=<%=i.get("ARTI_ID") %>&attitude=copy" >转载</a></span></div>
          <p style="width:90%;word-wrap:break-word;word-break:break-all"><%=articontent %><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=i.get("ARTI_ID") %>&userId=<%=userId%>&ARTI_CTR=<%=i.get("ARTI_CTR") %>&ARTI_CATEID=<%=i.get("CATE_ID")%>" target="_blank" class="readmore">全文</a></p>
        </ul>
        <figure><img src="images/001.jpg" ></figure>
        <div class="dateview"><%=i.get("ARTI_TIME").toString().substring(0,10) %></div>
      </div>
      <%} }%>
      
    </div>
    <div class="page"><a title="Total record"><b><%=pg.getTotalPage() %></b></a>
    <a href="<%=basePath%>blog/newlist.jsp?userId=<%=userId%>&pagenum=1&cateId=<%=cateId%>"  title="1" class="csschange">1</a>
    <%
   		 int n=1;
    	for(n=2;n<pg.getTotalPage()+1;n++){
     %>
    <a href="<%=basePath%>blog/newlist.jsp?userId=<%=userId%>&pagenum=<%=n %>&cateId=<%=cateId%>" title=<%=n %>><%=n %></a>
    <%}if(pagenum+1<=pg.getTotalPage()){%> 
    <a href="<%=basePath%>blog/newlist.jsp?userId=<%=userId%>&pagenum=<%=pagenum+1 %>&cateId=<%=cateId%>">&gt;</a>
    <%}else{ %>
     <a href="<%=basePath%>blog/newlist.jsp?userId=<%=userId%>&pagenum=<%=pg.getTotalPage()  %>&cateId=<%=cateId%>">&gt;</a>
    <%} %>
    <a href="<%=basePath%>blog/newlist.jsp?userId=<%=userId%>&pagenum=<%=pg.getTotalPage() %>&cateId=<%=cateId%>">&gt;&gt;</a>
    </div>
  
  </article>
  <aside>
  <!-- 这是前四强栏目 -->
  <jsp:include page="/blog/include/blogNewsListClickList.jsp"></jsp:include>
   
    <div class="ph_news">
    <!-- 这是点击排行和文章推荐 -->
    <jsp:include page="/blog/include/blogNewsListRank.jsp"></jsp:include>
      

      <h2>
        <jsp:include page="/blog/include/recentVisitors.jsp"></jsp:include>
      </h2>
    </div>
    <div class="copyright">
      <ul>
        <p> Design by <a>FaceBlog开发小组</a></p>
<!--         <p>蜀ICP备11002373号-1</p> -->
        </p>
      </ul>
    </div>
  </aside>
  <script src="js/silder.js"></script>
  <div class="clear"></div>
  <!-- 清除浮动 --> 
</div>
</body>
</html>

