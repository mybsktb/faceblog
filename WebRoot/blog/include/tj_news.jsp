<%@ page language="java" 
	import="java.util.*" 
	import="com.faceblog.dao.*" 
	import="com.faceblog.common.*" 
	import="com.faceblog.util.*" 
	import="com.faceblog.entity.*" 
	import="com.faceblog.dao.impl.*" 
	pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

   <div class="tj_news">
      <h2>
        <p class="tj_t1">最新文章</p>
      </h2>
      <ul>
      	<%
      		// 获取用户名
    		String userIdStr = request.getParameter("userId");
      		// Article对象
      		Article article = new Article();
    		// 获取用户ID
   		  	int userId = StringUtil.stringToInt(userIdStr);
    		// 封装Article对象
    		article.setUser_id(userId);
    		// 获取最新文章
      		NewsMgDaoInterface newsMgDaoImpl = new NewsMgDaoImpl();
      		List<Map<String,Object>> lastArticles = newsMgDaoImpl.getLastArticles(article);
      		if (lastArticles != null){
    			int count = 1;
      			for(Map<String,Object> map : lastArticles){
      				// 如果记录数大于给定数，跳出
      				if(count>Const.NUM_R_L_ARTICLE){
      					break;
      				}%>
      				<li><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=map.get("ARTI_ID")%>&ARTI_CTR=<%=map.get("ARTI_CTR")%>&ARTI_CATEID=<%=map.get("ARTI_CATEID")%>&userId=<%=map.get("ARTI_USERID")%>"><%=map.get("ARTI_NAME") %></a></li>
      			<%
      			count++;
      			}
      		}
      	%>
      </ul>
      <h2>
        <p class="tj_t2">推荐文章</p>
      </h2>
      <ul>
          	<%
    		// 获取推荐文章
      		List<Map<String,Object>> recommandArticles = newsMgDaoImpl.getRecommandArticles(article);
      		if (recommandArticles != null){
    			int count = 1;
      			for(Map<String,Object> map : recommandArticles){
      				// 如果记录数大于给定数，跳出
      				if(count>Const.NUM_R_L_ARTICLE){
      					break;
      				}%>
      				<li><a href="<%=basePath%>blog/ArtAttr?ARTI_ID=<%=map.get("ARTI_ID")%>&ARTI_CTR=<%=map.get("ARTI_CTR")%>&ARTI_CATEID=<%=map.get("ARTI_CATEID")%>&userId=<%=map.get("ARTI_USERID")%>"><%=map.get("ARTI_NAME") %></a></li>
      			<%
      			count++;
      			}
      		}
      		%>
      </ul>
    </div>