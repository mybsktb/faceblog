<%@ page language="java" 
	import="com.faceblog.dao.impl.*"
	import="com.faceblog.dao.*"
	import="com.faceblog.common.*"
	import="com.faceblog.entity.*"
	contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
	<style>
		tr{
			margin:0px;
			padding:0px;
		}
		.visitor tr td{
 			border:none;
/* 			height:40px; */
/* 			width:40px; */
/* 			margin:10px; */
		}
		.visitor tr td img{
			margin:3px;
			height:40px;
			width:40px;
		}
		.visitor{
			margin:10px 0px 0px 5px;
			border:none;
		}
	</style>
    <p>最近访客</p>
	<table border="1" class="visitor">
		<%
    	int userId = -1;
		// 获取用户ID
    	String userIdStr = request.getParameter("userId");
    	if(Const.EMPTY.equals(userIdStr)){
    		userIdStr = "-1";
    		System.out.println(userIdStr);
    	}
    	try{
    		userId = Integer.parseInt(userIdStr);
    	} catch (NumberFormatException e){
    		System.out.println("最近访客，数值转换异常！！");
    		userId = -1;
    	}
    	
    	User user = new User();
    	user.setUser_id(userId);
    	UserMgDaoInterface userMgDaoimpl = new UserMgDaoImpl();
    	// 获取最近访客数组
    	int [] arr = userMgDaoimpl.getUserVisitor(user);
    	
    	int index = 0;
		for(int k=0;k<Const.NUM_RECENT_LINE;k++){
			%><tr><% 
   			int count = 0;
    		for(int i=index;i<arr.length;i++){
	    		if(arr[i]!=0){
	    			user.setUser_id(arr[i]);
	    			user = userMgDaoimpl.getUserInfoByUserId(user);
	    			// 页面显示用户头像
    				%><td><a href="<%=basePath%>blog/Recomm?userId=<%=user.getUser_id()%>"><img alt="<%=user.getUser_name() %>" src="<%=user.getUser_icon() %>"></a></td>
					<%
		    		count++;
	    		}
				index++;
	    		if(count==Const.NUM_RECENT_V_ONE_LINE){
	    			break;
	    		}
   			}%>
   			</tr>
		<%}%>
	</table>
