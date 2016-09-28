<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
	<title>文章阅读</title>
	<meta name="keywords" content="个人博客模板,博客模板,响应式" />
	<meta name="description" content="如影随形主题的个人博客模板，神秘、俏皮。" />
	<link href="<%=basePath%>blog/css/base.css" rel="stylesheet">
	<link href="<%=basePath%>blog/css/style.css" rel="stylesheet">
	<link href="<%=basePath%>blog/css/media.css" rel="stylesheet">
	<link href="<%=basePath%>blog/css/basic-contact.css" rel="stylesheet"> 
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0"> 
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ page language="java" import="com.faceblog.entity.ConverTime"%>
    <script type="text/javascript" src="blog/js/jquery-1.7.1.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script>
 	var path='<%=basePath%>';
 	//按钮操作后触发
 	 function commen(){
  		var mess=document.getElementById("message").value;
  		var artid=document.getElementById("artid").value;
  		var userfrom=document.getElementById("userfrom").value;
  		var userid=document.getElementById("userid").value;
		  $.ajax({	
		  	  //这是用发送请求到哪的路径
		      url:path+"blog/Comment",
		      //type:"pose"
		      //这是发送数据到控制层 
		      data:{message:mess,userfrom:userfrom,art:artid,userid:userid},
		      //这是请求成功后回调的函数
		      success:function(data){
		    	  if(data=="评论成功"){
				      // 重载页面
				      location.reload();
		    	  } else{
				      //找到class=info元素的内容设置显示字符串为html后面那个
				      $("#info").html("<span>"+data+"</span>");
		    	  }
		      }
		});
	}
/*   })   */
	</script>	
	<!-- 评论开始 -->
	<script type="text/javascript">
		var flag = true;
		function clearContent(){
			if(flag==true){
				$("#message").val("");
				flag = false;
			}
			$(".button").css('display','inline')
		}
		function clearAll(){
			$("#message").val("");
		}
	</script>
	<!-- 评论结束 -->
  </head>
  
  <body>
<div class="ibody" >
 <jsp:include page="/blog/include/header.jsp"></jsp:include>
  <article>
  	<%
  	String userId = request.getParameter("userId");
  	%>
    <h2 class="about_h">您现在的位置是：<a href="<%=basePath%>blog/Recomm?userId=<%=userId %>">首页</a>><a href="javascript:void(0)">文章阅读</a></h2>
     <% 
		//设置属性 将空值层该属性的内容 放入results中
       List<Map<String,Object>> results = (List<Map<String,Object>>) request.getAttribute("resaut");
       if(results!=null){
        for(Map<String,Object> result : results){
        	String time=result.get("ARTI_TIME").toString().substring(0,10);
       %>
    <div class="index_about">
    
      <h2 class="c_titile" ><%=result.get("ARTI_NAME")%></h2>
      <p class="box_c"><span class="d_time">发布时间：<%=time %></span><span>作者：<%=result.get("ARTI_AUTHOR") %></span><span>点击量（<%=result.get("ARTI_CTR") %>）</span><span>评论览（<%=result.get("ARTI_COMMENTCOUNT")%>）</span></p>
      <ul class="infos" >
        <%=result.get("ARTI_CONTENT") %>
      </ul>
      <input type="text"  style="display:none" id="artid" value="<%=result.get("ARTI_ID")%>">
      <div class="keybq">
        <p><span>关键字词</span>：<%=result.get("ARTI_KEYWORD") %></p>
      </div>
      <%
      }
      }
       %>

      <div class="nextinfo">
        <%  
       List<Map<String,Object>> onAndNex = (List<Map<String,Object>>) request.getAttribute("onAndNex");
       String onornex=null;
       int i=0;
       if(onAndNex!=null){
	       for(Map<String,Object> onnex : onAndNex){
	       	   i++;
		       if(i==1){
		      		 onornex="下一篇";
		       }
		       if(i==2){
		       		onornex="上一篇";
		       }
       %> 
        <p><%=onornex%>：<a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=onnex.get("ARTI_ID")%>&ARTI_CTR=<%=onnex.get("ARTI_CTR")%>&ARTI_CATEID=<%=onnex.get("ARTI_CATEID")%>&userId=<%=onnex.get("ARTI_USERID")%>"><%=onnex.get("ARTI_NAME") %></a></p>
        <%
        	}
        }
         %>
      </div>
      
      <!-- 评论开始 -->
      <div id="comment">
      <%
      if(session.getAttribute("userId")!=null){
      %>
      	<div class="comment-header">
      		<h1><b>内容点评</b>&nbsp;&nbsp;<span style="color:red" id="info"  ></span><a href="javascript:clearAll()">清空</a></h1> 
      	</div>
   		<div class="comment-content">
	      	<textarea id="message" onfocus="clearContent()" >请在此输入评论</textarea>
	      	<input type="text"  style="display:none" id="userfrom" value="<%=session.getAttribute("userId")%>">
	      	<input type="text"  style="display:none" id="userid" value="<%=request.getAttribute("userid")%>">
   		</div>
   		<div class="comment-footer">
   			<span>用户名：&nbsp;<%=session.getAttribute("userName")%></span>
   			<a href='javascript:commen()' class='button'>评论</a>
   		</div>
      	<%}else{
      		%>
			<p>请<a href="register">登录</a>后再评论</p>     		
      		<%
      	} %>
      </div>
      <hr>
      <div id="recentComment">
      	<div class="recent-comment-header">
      		<h1><b>最新评论</b></h1>
      	</div>
      	<div class="recent-comment-detail">
      		<%
      		List<Map<String,Object>> latc=(List<Map<String,Object>>) request.getAttribute("latcom");
            if(latc!=null){
            	if(latc.size()==0){
            		%>
                	<p style="text-align:center;">没有相关评论</p>
                <%
            	}
      	    	for(Map<String,Object> lat : latc){
      			      String cont=lat.get("COMMENT_CONTENT").toString();
      		      	  String time=lat.get("COMMENT_TIME").toString();
      		      	  ConverTime ct=new ConverTime();
      		      	  String intime=ct.conve(time);%>
    	        <ul class="pl_n">
        		  <dl>
			          <dt><img src="<%=lat.get("USER_ICON")%>"> </dt>
			          <dt> </dt>
			          <dd><a href="blog/Recomm?userId=<%=lat.get("USER_ID") %>"><%=lat.get("USER_NAME")%></a>
			            <time><%=intime%></time>
			          </dd>
			          <dd><span style="color:black;"><%=cont%></span></dd>
		          </dl>
		       </ul>
      	    	<%}
            }
      		%>
      	</div>
      </div>
      <!-- 评论结束 -->
      <div class="otherlink">
        <h2>相关文章</h2>
        <ul>
        <%
        List<Map<String,Object>> reve = (List<Map<String,Object>>) request.getAttribute("reven");
        if(reve!=null){
       		for(Map<String,Object> rev : reve){
        %>
        
          <li><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=rev.get("ARTI_ID") %>&ARTI_CTR=<%=rev.get("ARTI_CTR") %>&ARTI_CATEID=<%=rev.get("ARTI_CATEID") %>&userId=<%=rev.get("ARTI_USERID") %>" title="<%=rev.get("ARTI_NAME") %>"><%=rev.get("ARTI_NAME") %></a></li>
       <% 
       		}
       }
       %>
        </ul>
      </div>
    </div>
  </article>
  <aside>
   <jsp:include page="/blog/include/blogNewsListClickList.jsp"></jsp:include>
   
    <div class="ph_news">
     
	<jsp:include page="/blog/include/blogNewsListRank.jsp"></jsp:include>
      <h2>
        <p>最新评论</p>
      </h2>
   
   <jsp:include page="/blog/include/latComm.jsp"></jsp:include>

      <h2>
        <jsp:include page="/blog/include/recentVisitors.jsp"></jsp:include>
      </h2>
    </div>
    <div class="copyright">
      <ul>
        <p> Design by <a href="/">DanceSmile</a></p>
        <p>蜀ICP备11002373号-1</p>
      </ul>
    </div>
  </aside>
  <script src="<%=basePath%>blog/js/silder.js"></script>
  <div class="clear"></div>
  <!-- 清除浮动 --> 
</div>
</body>
</html>