<%@page import="com.faceblog.util.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.faceblog.entity.*" %>
<%@ page language="java" import="com.faceblog.dao.impl.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
			Article article = new Article();
			int userId =StringUtil.stringToInt( request.getParameter("userId"));
			article.setUser_id(userId);
			NewsMgDaoImpl nmdi = new NewsMgDaoImpl();
			List<Map<String, Object>> newslist = nmdi.getRankArticles(article,1);
			List<Map<String, Object>> ranklist =  nmdi.getRankArticles(article,2);
 %>
<h2>
        <p>点击排行</p>
      </h2>
      <ul class="ph_n">
      	<%
			if(ranklist!=null){
			for(int i=0; i<ranklist.size();i++){
				if(i<3){
		 %>
        <li><span class="num<%=i+1%>"><%=i+1%></span><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=ranklist.get(i).get("ARTI_ID") %>&userId=<%=userId%>&ARTI_CTR=<%=ranklist.get(i).get("ARTI_CTR") %>&ARTI_CATEID=<%=ranklist.get(i).get("CATE_ID")%>"><%=ranklist.get(i).get("ARTI_NAME") %></a></li>
       <%}else{ %>
        <li><span><%=i+1%></span><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=ranklist.get(i).get("ARTI_ID") %>&userId=<%=userId%>&ARTI_CTR=<%=ranklist.get(i).get("ARTI_CTR") %>&ARTI_CATEID=<%=ranklist.get(i).get("CATE_ID")%>"><%=ranklist.get(i).get("ARTI_NAME") %></a></li>
       
        <%}}} %>
      </ul>
         <h2>
        <p>文章推荐</p>
      </h2>
      <ul>
      <%
			if(newslist!=null){
			for(int i=0; i<newslist.size();i++){
		
		 %>
      <li><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=newslist.get(i).get("ARTI_ID") %>&userId=<%=userId%>&ARTI_CTR=<%=newslist.get(i).get("ARTI_CTR") %>&ARTI_CATEID=<%=newslist.get(i).get("CATE_ID")%>"><%=newslist.get(i).get("ARTI_NAME") %></a></li>
      <%}}%>
      </ul>