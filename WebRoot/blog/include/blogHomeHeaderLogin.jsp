
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path2 = request.getContextPath();
String basePath2 = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path2+"/";
%>

<header>
    <a  href="<%=basePath2%>blog/blogHomeLogin"><img  id="logo"
				src="images/logo2.png" style="width:240px;float:left" alt="Simpla Admin logo" />
			</a>
			
    <div class="clear"></div>
   <nav id="topnav">
		<a id="blogHome" href="blogHome">热门推荐</a><a
			id="browse" href="homeBrowseServ">随机浏览</a><span  id="search"><a href="homeSearch.jsp" >搜索</a></span>
		
			&nbsp;<input id="searchText" style="height:19px;display:none;border-radius:5px" value="请输入关键词，回车进行搜索" size="52" />
<script>
	$(function(){
		$("#search").mouseenter(function(){
			$("#blogHome").hide();
			$("#recommend").hide();
			$("#browse").hide();
			//$("#search").hide();
			$("#searchText").fadeIn(500);
			//alert("123");
		});
		
		
		$("#searchText").mouseout(function(){
		$("#blogHome").fadeIn(500);
			$("#recommend").fadeIn(500);
			$("#browse").fadeIn(500);
			$("#search").fadeIn(500);
			$("#searchText").hide();
			//alert("123");
		});
		
		
		
		$("#searchText").focusin(function(){
			//alert("123");
			$(this).attr("value","");
		})
			
		$("#searchText").keyup(function(e){
			var basePath = '<%=basePath2%>';
			var curKey = e.which;
			if(curKey==13){
				location.href=basePath+"blog/homeSearch.jsp?pagenum=1&searchWord="+$("#searchText").val();
			}
		})
	});
</script>
  </header>
