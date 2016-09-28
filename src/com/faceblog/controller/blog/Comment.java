package com.faceblog.controller.blog;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.dao.impl.NewsMgDaoImpl;

public class Comment extends HttpServlet{
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String artid=request.getParameter("art");
		String message=request.getParameter("message");
		String fromid=request.getParameter("userfrom");
		String userid=request.getParameter("userid");
		int art=Integer.parseInt(artid);
		int user=Integer.parseInt(userid);
		int from=Integer.parseInt(fromid);
		NewsMgDaoInterface nmi=new NewsMgDaoImpl();
		String tes=null;
			if(message.trim().length()>0){
				if(nmi.comment(art,message,user,from)){
					tes="评论成功";
				}else{
					tes="出现了意外，评论失败";
				}
			}else{
				tes="评论不能为空！";
			}
		PrintWriter out=response.getWriter();
		//而这个结果是test这个字符串
		out.print(tes);
		out.close();
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
