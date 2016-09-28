<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@ page language="java" import="com.faceblog.entity.Page"%>
    <base href="<%=basePath%>">
    
    <meta charset="utf-8">
	<title>个人博客</title>
	<meta name="keywords" content="个人博客模板,博客模板,响应式" />
	<meta name="description" content="如影随形主题的个人博客模板，神秘、俏皮。" />
	<link href="<%=basePath%>blog/css/base.css" rel="stylesheet">
	<link href="<%=basePath%>blog/css/index.css" rel="stylesheet">
	<link href="<%=basePath%>blog/css/media.css" rel="stylesheet">
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  	<script type="text/javascript" src="backstage/resources/scripts/jquery-1.3.2.min.js"></script>
  	
</head>
<script type="text/javascript">

	var next = 2;
   $(function(){
	var path='<%=basePath%>';
	$(window).scroll( function() {
	run_interval = setInterval(function(){
	//获取底部元素到顶部的高度
	var offHeight = $("#itnext").offset().top;
	//获取整个可视窗口的高度
	var windowHeight = $(window).height();
	//获取滚动条离窗口顶部的高度
	var	scrollHeight = $(document).scrollTop();
	//滚动距离+窗口可视高度+30
	var	sumHeight = scrollHeight + windowHeight+30;
	//获取当前页数
	var maxpg=<%=request.getAttribute("maxpage")%>+1;
		if(sumHeight>offHeight)
		{
			if(next<maxpg){
			$.ajax({	
		      url:path+"blog/Recomm?userId=<%=request.getAttribute("useid")%>",
		      data:{curre:next},
		      type:"post",
		      //这是请求成功后回调的函数
		      success:function(data){
			      var nex=data.split("||");
			      for(var i=0;i<nex.length-1;i++){
			    // console.log("内容："+nex[i]);
			      var jso=JSON.parse(nex[i]);
			    // console.log("json解析结果："+jso);
			      var id=jso.ARTI_ID;
			      var cateid=jso.ARTI_CATEID;
			      var conten=jso.ARTI_CONTENT;
			      var cont=null;
			      if(conten.length<200){
	            		cont=conten;
	            		}else{
	            		cont=cont.substring(0,200);
	            		}
	             //json进行时间格式转换	
			      var time=jso.ARTI_TIME;
			      var dattime=new Date(time.time);
			      var datStr=dattime.getFullYear()+'-'+dattime.getMonth()+"-"+dattime.getDate();
			      
			      var usname=jso.USER_NAME;
			      var cocont=jso.ARTI_COMMENTCOUNT;
			      var useid=jso.ARTI_USERID;
			      var artau=jso.ARTI_AUTHOR;
			      var arname=jso.ARTI_NAME;
			      var arctr=jso.ARTI_CTR;
			      var caname=jso.CATE_NAME;
			      var html="<div class=\"blogs\"><h3><a href=\""+path+"blog/ArtAttr?ARTI_ID="+id+"&ARTI_CTR="+arctr+"&ARTI_CATEID="+cateid+"&userId="+useid+"\""+" target=\"_blank\">"+arname+"</a></h3><figure><img src=\""+path+"blog/images/01.jpg\" ></figure>"+
			      "<ul> <a href=\""+path+"blog/ArtAttr?ARTI_ID="+id+"&ARTI_CTR="+arctr+"&ARTI_CATEID="+cateid+"&userId="+useid+"\""+" target=\"_blank\" ><p width:469px>&nbsp;&nbsp;"+cont+"</p></a>"+
		          "<a href=\""+path+"blog/ArtAttr?ARTI_ID="+id+"&ARTI_CTR="+arctr+"&ARTI_CATEID="+cateid+"&userId="+useid+"\""+" target=\"_blank\" class=\"readmore\" id=\"look\" >阅读全文&gt;&gt;</a>"+
		          "</ul> <p class=\"autor\"><span>作者："+artau+"</span>"+
		          "<span>分类：【<a href=\""+path+"blog/newlist.jsp?userId="+useid+"&pagenum=1&cateId="+cateid+"\">"+caname+"</a>】</span>"+
		          "<span>浏览（<a>"+arctr+"</a>）</span>"+
		       	  "<span>评论（<a>"+cocont+"</a>）</span></p>"+
		          "<div class=\"dateview\">"+datStr+"</div></div>";
			      $("#blognext").append(html); 
			      
			      }
		      }     
		  	});
		  	next +=1;
		  	$('#nomoreresults').fadeIn();
		  	}
		}
},500);
} );
}); 
</script>


  </head>
  
<body>
	<div class="ibody">
	  <jsp:include page="/blog/include/header.jsp"></jsp:include>
	  <article>
	    <div class="banner">
	      <ul class="texts">
	        <p>The best life is use of willing attitude, a happy-go-lucky life. </p>
	        <p>最好的生活是用心甘情愿的态度，过随遇而安的生活。</p>
	      </ul>
	    </div>
	    <div class="bloglist" id="blognext">
	      <h2>
	        <p><span>推荐</span>文章</p>
	      </h2>
	      
	      
	        <% 
	  			//设置属性 将空值层该属性的内容 放入results中
	            List<Map<String,Object>> results = (List<Map<String,Object>>) request.getAttribute("res");
	            if(results!=null){
	            for(Map<String,Object> result : results){
            	//截取日期年月日
            	String time=result.get("ARTI_TIME").toString().substring(0,10);
            	String content=null;
            	String cont=result.get("ARTI_CONTENT").toString();
            		//截取文章前200字作为推荐文章内容
            		if(cont.length()<200){
            		content=cont;
            		}else{
            		content=cont.substring(0,200);
            		}
	            %> 
	      <div class="blogs">
	        <h3><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&ARTI_CTR=<%=result.get("ARTI_CTR")%>&ARTI_CATEID=<%=result.get("ARTI_CATEID")%>&userId=<%=result.get("ARTI_USERID")%>"><%=result.get("ARTI_NAME")%></a></h3>
	        <figure><img src="<%=basePath%>blog/images/01.jpg" ></figure>
	        <ul> 
	          <p width:469px>&nbsp;&nbsp;<a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&ARTI_CTR=<%=result.get("ARTI_CTR")%>&ARTI_CATEID=<%=result.get("ARTI_CATEID")%>&userId=<%=result.get("ARTI_USERID")%>" target="_blank"><%=content%></a></p>
	          
	          <a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=result.get("ARTI_ID")%>&ARTI_CTR=<%=result.get("ARTI_CTR")%>&ARTI_CATEID=<%=result.get("ARTI_CATEID")%>&userId=<%=result.get("ARTI_USERID")%>" target="_blank" class="readmore" id="look" >阅读全文&gt;&gt;</a>
	        </ul>
	        <p class="autor"><span>作者：<%=result.get("ARTI_AUTHOR") %></span>
	        <span>分类：【<a href="<%=basePath%>blog/newlist.jsp?userId=<%=result.get("ARTI_USERID")%>&pagenum=1&cateId=<%=result.get("ARTI_CATEID")%>"><%=result.get("CATE_NAME")%></a>】</span>
	        <span>浏览（<a><%=result.get("ARTI_CTR")%></a>）</span>
	        <span>评论（<a><%=result.get("ARTI_COMMENTCOUNT")%></a>）</span></p>
	        <div class="dateview"><%=time%></div>
	      </div>
					<%
		              	 	}
		              }
	               %>

	    </div>
	    <div class="loading" id="nomoreresults">文章已加载完毕.</div>
	  </article>
	  <aside>
	  <jsp:include page="/blog/include/blogIndexInformation.jsp"></jsp:include>
	    <div class="bdsharebuttonbox"><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_more" data-cmd="more"></a></div>
	    <jsp:include page="/blog/include/tj_news.jsp"></jsp:include>
	    <jsp:include page="/blog/include/links.jsp"></jsp:include>
	    <div class="copyright">
	      <ul>
	        <p> Design by <a>FaceBlog开发小组</a></p>
<!-- 	        <p>浙ICP备11002373号-1</p> -->
	        </p>
	      </ul>
	    </div>
	  </aside>
	  <script src="blog/js/silder.js"></script>
	  <div class="clear"></div>
	  <!-- 清除浮动 --> 
	</div>
<div id="itnext"></div>
</body>
</html>
