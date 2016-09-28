<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="com.faceblog.entity.ConverTime"%>
<%
      List<Map<String,Object>> latc=(List<Map<String,Object>>) request.getAttribute("latcom");
      if(latc!=null){
	      for(Map<String,Object> lat : latc){
			      String cont=lat.get("COMMENT_CONTENT").toString();
			      int contsiz=cont.length();
			      String conten=null;
	      if(contsiz<20){
	      		  conten=cont;
	      	}else{
	      		  conten=cont.substring(0,20)+"...";
	      	}
	      	String time=lat.get("COMMENT_TIME").toString();
	      	ConverTime ct=new ConverTime();
	      	String intime=ct.conve(time);
       %>
      <ul class="pl_n">
        <dl>
          <dt><img src="<%=lat.get("USER_ICON")%>"> </dt>
          <dt> </dt>
          <dd><a href="blog/Recomm?userId=<%=lat.get("USER_ID")%>"><%=lat.get("USER_NAME")%></a>
            <time><%=intime%></time>
          </dd>
          <dd><%=conten%></dd>
        </dl>
      </ul>
      <%
      }
      } 
      %>
