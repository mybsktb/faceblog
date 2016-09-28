<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//根据参数值，设置样式
String cate = request.getParameter("cate");
String css = request.getParameter("css");
%>
<script>
	function change(num){
		$("li[name='sidebarcss']>a").attr("class","nav-top-item");
		$("li[id='"+num+"']>a").attr("class","nav-top-item current");
	}
</script>
  <div id="sidebar">
    <div id="sidebar-wrapper">
      <!-- Sidebar with logo and menu -->
      <h1 id="sidebar-title"><a href="#">Admin 管理</a></h1>
      <!-- Logo (221px wide) -->
      <a href=""><img id="logo" src="<%=basePath%>backstage/resources/images/logo.png" alt="admin 标签" /></a>
      <!-- Sidebar Profile links -->
      <div id="profile-links"> 你好, <a href="#" title="Edit your profile">${sessionScope.userName}</a>,欢迎来到后台<br />
        <br />
        <a href="<%=basePath%>backstage/manager/admin_index.jsp" title="View the Site">首页</a> | <a href="<%=basePath%>login.jsp" title="Sign Out">退出登录</a> </div>
      <ul id="main-nav">
        <!-- Accordion Menu -->
        <li name="sidebarcss" id="1">
        <%
            	if("index".equals(css)){
        %> 
        <a href="<%=basePath%>backstage/manager/admin_index.jsp" class="nav-top-item no-submenu current" onclick="change(1)">
          <!-- Add the class "no-submenu" to menu items with no sub menu -->
          首页 </a>   
        <% }else{%>
        <a href="<%=basePath%>backstage/manager/admin_index.jsp" class="nav-top-item no-submenu" onclick="change(1)">
          <!-- Add the class "no-submenu" to menu items with no sub menu -->
          首页 </a>
        <%	} %>       
          </li>
        <li name="sidebarcss" id="2"> 
        <%
            	if("newscenter".equals(css)){
        %>
        <a href="#" class="nav-top-item current" onclick="change(2)">
          <!-- Add the class "current" to current menu item -->
          文章管理 </a>
        <% }else{%>
        <a href="#" class="nav-top-item" onclick="change(2)">
          <!-- Add the class "current" to current menu item -->
          文章管理 </a>
        <%	} %> 
          <ul>
            <li>
            <%
            	if("newsmg".equals(cate)){
            %>
            		<a class="current" href="<%=basePath%>manager/AdminNewsMg?curpage=1&curdatanum=5&keyword&selec">文章审核</a>
            <% }else{%>
            		<a href="<%=basePath%>manager/AdminNewsMg?curpage=1&curdatanum=5&keyword&selec">文章审核</a>
            <%	} %>         
            </li>
            <li>
            <%
            	if("wordmg".equals(cate)){
            %>
            		<a class="current" href="<%=basePath%>manager/AdminSensitiveMg?curpage=1&curdatanum=5&keyword">敏感词汇管理</a>
            <% }else{%>
            		<a href="<%=basePath%>manager/AdminSensitiveMg?curpage=1&curdatanum=5&keyword">敏感词汇管理</a>
            <%	} %>
            
            </li>
           
          </ul>
        </li>
        <li name="sidebarcss" id="3"> 
        <%
            	if("usercenter".equals(css)){
        %>
        <a href="#" class="nav-top-item current" onclick="change(3)"> 用户管理 </a>
        <% }else{%>
        <a href="#" class="nav-top-item" onclick="change(3)"> 用户管理 </a>
        <%	} %>
        
          <ul>
            <li>  
            <%
            	if("useradd".equals(cate)){
            %>
            		<a class="current" href="<%=basePath%>backstage/manager/admin_UserAdd.jsp">增加用户</a>
            <% }else{%>
            		<a href="<%=basePath%>backstage/manager/admin_UserAdd.jsp">增加用户</a>
            <%	} %>
            </li>
            <li>    
             <%
            	if("usermg".equals(cate)){
            %>
            		 <a class="current" href="<%=basePath%>/manager/AdminUserMg?curpage=1&curdatanum=5&keyword">用户管理</a>
            <% }else{%>
            		 <a href="<%=basePath%>/manager/AdminUserMg?curpage=1&curdatanum=5&keyword">用户管理</a>
            <%	} %>
            </li>
			<li>			
			<%
            	if("pwd".equals(cate)){
            %>
            		 <a class="current" href="<%=basePath %>backstage/manager/admin_ChanPwd.jsp">修改密码</a>
            <% }else{%>
            		 <a href="<%=basePath %>backstage/manager/admin_ChanPwd.jsp">修改密码</a>
            <%	} %>
			</li>
          </ul>
        </li>
		
      </ul>
	  
    </div>
  </div>