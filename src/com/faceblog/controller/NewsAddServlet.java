package com.faceblog.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.dao.impl.NewsMgDaoImpl;
import com.faceblog.entity.Article;
import com.faceblog.util.SensitiveCheck;


public class NewsAddServlet extends HttpServlet {
	private Article arti=new Article();
	private NewsMgDaoInterface articleOper=new NewsMgDaoImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}	
	/* (non-Javadoc)
	 * 用于处理newsMG页面的文章修改请求
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		//获取用户的id
		int userId=Integer.parseInt(request.getSession().getAttribute("userId").toString());
		//获取文章的各类数据
		String name=request.getParameter("art_name");
		String recommend=request.getParameter("art_recommend");
		int reco=0;
		try {
			reco = Integer.parseInt(recommend);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		String author=request.getParameter("art_author");
		String keyword=request.getParameter("art_keyword");
		String cateid=request.getParameter("art_cateid");
		int cate_id=1;
		try {
			cate_id = Integer.parseInt(cateid);
		} catch (NumberFormatException e) {
		}
		String content=request.getParameter("art_content");
		int check=SensitiveCheck.artiCheck(content);
		arti.setArt_check(check);
		//封装article
		arti.setArt_name(name);
		arti.setArt_recommend(reco);
		arti.setAtr_author(author);
		arti.setArt_keyword(keyword);
		arti.setCate_id(cate_id);
		arti.setArt_content(content);
		arti.setUser_id(userId);
		//执行插入文章语句
		boolean result=articleOper.insertArticle(arti);
		String message=null;
		if(result){
			message="文章新增成功";
		}else{
			message="文章新增失败";
		}
		//通过返回信息给ajax
		PrintWriter out =response.getWriter();
		out.print(message);
		out.flush();
		out.close();	
	}
}
