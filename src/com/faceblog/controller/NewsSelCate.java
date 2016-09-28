package com.faceblog.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.CateMgDaoInterface;
import com.faceblog.dao.impl.CateMgDaoImpl;

public class NewsSelCate extends HttpServlet{
	
	private CateMgDaoInterface cateOper=new CateMgDaoImpl();
	
	/* (non-Javadoc)
	 * 用于新增文章页面下拉列表查询栏目
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//执行查询栏目
		int userId=Integer.parseInt(request.getSession().getAttribute("userId").toString());
		List<Map<String,Object>>cateResults=cateOper.selectCate(userId);
		if(null==cateResults||cateResults.isEmpty()){
			request.getRequestDispatcher("/backstage/manager/cateAdd.jsp").forward(request, response);
		}
		request.setAttribute("cateResults", cateResults);
		request.getRequestDispatcher("/backstage/manager/newsAdd.jsp").forward(request, response);
	
	}	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
	
		
	}
	

}
