<%@ page language="java" 
	contentType="text/html; charset=UTF-8" 
	import="com.faceblog.util.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int userId = -1;
userId = StringUtil.stringToInt( request.getParameter("userId"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="utf-8">
		<title>黑色Html5响应式个人博客模板――主题《如影随形》</title>
		<meta name="keywords" content="个人博客模板,博客模板,响应式" />
		<meta name="description" content="如影随形主题的个人博客模板，神秘、俏皮。" />
		<link href="css/base.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<link href="css/media.css" rel="stylesheet">
		<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
	</head>
	<body>
		<div class="ibody">
		  <jsp:include page="/blog/include/header.jsp"></jsp:include>
		  <article>
		    <h2 class="about_h">您现在的位置是：<a href="<%=basePath%>blog/Recomm?userId=<%=userId %>">首页</a>>
		    <a href="<%=basePath%>blog/share.jsp?userId=<%=userId %>">图片鉴赏</a></h2>
		    <p style="text-align:center;font-size:20px;">2.0版本以后开放</p>
		    <!-- <div class="template">
		      <h3>
		        <p><span>个人博客</span>模板</p>
		        <a href="/" class="more">更多>></a> </h3>
		      <ul>
		        <li><a href="/"  target="_blank"><img src="images/t00.jpg"></a><span>黑色Html5个人博客模板主题《如影随形》</span></li>
		        <li><a href="/"  target="_blank"><img src="images/t01.jpg"></a><span>仿新浪博客风格・梅――古典个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/t02.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/t03.jpg"></a><span>Green绿色小清新的夏天-个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/t04.jpg"></a><span>女生清新个人博客网站模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/t05.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/t06.jpg"></a><span>Green绿色小清新的夏天-个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/01.jpg"></a><span>仿新浪博客风格・梅――古典个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/02.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/04.jpg"></a><span>女生清新个人博客网站模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/02.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/03.jpg"></a><span>Green绿色小清新的夏天-个人博客模板</span></li>
		      </ul>
		      <h3>
		        <p><span>企业</span>网站模板</p>
		        <a href="/" class="more">更多>></a> </h3>
		      <ul>
		        <li><a href="/"  target="_blank"><img src="images/01.jpg"></a><span>仿新浪博客风格・梅――古典个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/02.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/03.jpg"></a><span>Green绿色小清新的夏天-个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/04.jpg"></a><span>女生清新个人博客网站模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/02.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/03.jpg"></a><span>Green绿色小清新的夏天-个人博客模板</span></li>
		      </ul>
		      <h3>
		        <p>个人<span>作品</span></p>
		        <a href="/" class="more">更多>></a> </h3>
		      <ul>
		        <li><a href="/"  target="_blank"><img src="images/01.jpg"></a><span>仿新浪博客风格・梅――古典个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/02.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/03.jpg"></a><span>Green绿色小清新的夏天-个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/04.jpg"></a><span>女生清新个人博客网站模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/02.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/03.jpg"></a><span>Green绿色小清新的夏天-个人博客模板</span></li>
		      </ul>
		      <h3>
		        <p><span>国外</span>Html5模板</p>
		        <a href="/" class="more">更多>></a> </h3>
		      <ul>
		        <li><a href="/"  target="_blank"><img src="images/01.jpg"></a><span>仿新浪博客风格・梅――古典个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/02.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/03.jpg"></a><span>Green绿色小清新的夏天-个人博客模板</span></li>
		        <li><a href="/" target="_blank"><img src="images/04.jpg"></a><span>女生清新个人博客网站模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/02.jpg"></a><span>黑色质感时间轴html5个人博客模板</span></li>
		        <li><a href="/"  target="_blank"><img src="images/03.jpg"></a><span>Green绿色小清新的夏天-个人博客模板</span></li>
		      </ul>
		    </div> 
		    <div class="page"><a title="Total record"><b>113</b></a><b>1</b><a href="/">2</a><a href="/">3</a><a href="/">4</a><a href="/">5</a><a href="/">&gt;</a><a href="/">&gt;&gt;</a></div>-->
		  </article>
		  <aside>
		    <jsp:include page="/blog/include/blogNewsListClickList.jsp"></jsp:include>
		    <div class="ph_news">
		      <jsp:include page="/blog/include/blogNewsListRank.jsp"></jsp:include>
		       <!-- <h2>
		        <p>最新评论</p>
		      </h2>
		     <ul class="pl_n">
		        <dl>
		          <dt><img src="images/s8.jpg"> </dt>
		          <dt> </dt>
		          <dd>DanceSmile
		            <time>49分钟前</time>
		          </dd>
		          <dd><a href="/">文章非常详细，我很喜欢.前端的工程师很少，我记得几年前yahoo花高薪招聘前端也招不到</a></dd>
		        </dl>
		        <dl>
		          <dt><img src="images/s7.jpg"> </dt>
		          <dt> </dt>
		          <dd>yisa
		            <time>2小时前</time>
		          </dd>
		          <dd><a href="/">我手机里面也有这样一个号码存在</a></dd>
		        </dl>
		        <dl>
		          <dt><img src="images/s6.jpg"> </dt>
		          <dt> </dt>
		          <dd>小林博客
		            <time>8月7日</time>
		          </dd>
		          <dd><a href="/">博客色彩丰富，很是好看</a></dd>
		        </dl>
		        <dl>
		          <dt><img src="images/003.jpg"> </dt>
		          <dt> </dt>
		          <dd>DanceSmile
		            <time>49分钟前</time>
		          </dd>
		          <dd><a href="/">文章非常详细，我很喜欢.前端的工程师很少，我记得几年前yahoo花高薪招聘前端也招不到</a></dd>
		        </dl>
		        <dl>
		          <dt><img src="images/002.jpg"> </dt>
		          <dt> </dt>
		          <dd>yisa
		            <time>2小时前</time>
		          </dd>
		          <dd><a href="/">我手机里面也有这样一个号码存在</a></dd>
		        </dl>
		      </ul> -->
		      <h2>
		        <jsp:include page="/blog/include/recentVisitors.jsp"></jsp:include>
		      </h2>
		    </div>
		    <div class="copyright">
		      <ul>
		        <p> Design by <a>FaceBlog开发小组</a></p>
<!-- 		        <p>浙ICP备11002373号-1</p> -->
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