<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<aside>

	<div class="topspaceinfo">
		<form action="<%=basePath%>blog/portalLoginServ" method="post">

			用户&nbsp<input id="user" type="text" name="user" /><br />
			<br /> 密码&nbsp<input type="password" name="pwd" /><br />
			<br />
			<p align="left">
				&nbsp&nbsp&nbsp&nbsp&nbsp<input type="checkbox" checked="true" name="rememberMe"/>记住我&nbsp<a
					style="color:white" href="<%=basePath%>register">注册</a>&nbsp<a style="color:white"
					href="<%=basePath%>resetPwd">忘记密码</a>
			</p>
			<br />
			&nbsp&nbsp&nbsp&nbsp&nbsp<input type="button" value="登陆个人界面">&nbsp&nbsp<input
				type="submit" value="登陆" />
				<br/><br/>&nbsp&nbsp<span style="color:#B0e000" id="info"><%if(request.getAttribute("info")!=null){%>
                    <b id="info" ><%=request.getAttribute("info")%></b>
                    <%}else{%>
                    <%}%></span>
		</form>
	</div>
	<div class="bdsharebuttonbox">
		<a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a
			href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a
			href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a
			href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a
			href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a
			href="#" class="bds_more" data-cmd="more"></a>
	</div>
    <jsp:include page="/blog/include/tj_news.jsp"></jsp:include>
    <jsp:include page="/blog/include/links.jsp"></jsp:include>
	<div class="copyright">
		<ul>
			<p>
				Design by <a>FaceBlog开发小组</a>
			</p>
<!-- 			<p>蜀ICP备11002373号-1</p> -->
			</p>
		</ul>
	</div>
</aside>
