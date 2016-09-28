package com.faceblog.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.dao.impl.NewsMgDaoImpl;

public class NewsMgDelServlet extends HttpServlet {
	private NewsMgDaoInterface articleOper=new NewsMgDaoImpl();
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {		
	}
	
	/* (non-Javadoc)
	 * 用于文章的批量删除
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String articleId=request.getParameter("idName");
		boolean result=articleOper.deleteArticle(articleId);
		String message=null;
		if(result){
			message="文章删除成功";
		}else{
			message="文章删除失败";
		}
		PrintWriter out =response.getWriter();
		out.print(message);
		out.flush();
		out.close();	
		
	}
}
