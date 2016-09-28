<%@page import="com.faceblog.util.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.faceblog.entity.*" %>
<%@ page language="java" import="com.faceblog.dao.impl.*" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Cate cate = new Cate();
	int userId =StringUtil.stringToInt( request.getParameter("userId"));
	int pagenum =1;
	pagenum =StringUtil.stringToInt( request.getParameter("pagenum"));
	cate.setUser_id(userId);
	CateMgDaoImpl cmdi = new CateMgDaoImpl();
	List<Map<String, Object>> list = cmdi.cateSel(cate);
	if(list!=null){
	for(int i=0; i<list.size();i++){
 %>

<div class="rnav">
      <li class="rnav<%=i+1%>"><a href="<%=basePath%>blog/newlist.jsp?userId=<%=userId%>&pagenum=1&cateId=<%=list.get(i).get("CATE_ID")%>"><%=list.get(i).get("CATE_NAME")%></a></li>
    
    </div>
    <%} }%>
