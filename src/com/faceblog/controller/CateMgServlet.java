package com.faceblog.controller;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.Cate;
import com.faceblog.entity.SplitPage;
import com.faceblog.service.CateMgServiceInterface;
import com.faceblog.service.impl.CateMgServiceImpl;


public class CateMgServlet extends HttpServlet{
	private CateMgServiceInterface cms = new CateMgServiceImpl();

	protected void doGet(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		doPost(req, resp);
	}

	protected void doPost(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		
		String path = req.getContextPath();
		String basePath = req.getScheme() + "://" + req.getServerName()
				+ ":" + req.getServerPort() + path + "/";

		// 获取页面数据
		Cate cate = new Cate();
		cate.setUser_id(Integer.parseInt(req.getSession().getAttribute("userId").toString()));
		int curPage=1;
	//	String pageSize = req.getParameter("pageSize");
		String curPageStr = req.getParameter("curPage");
		try {
			curPage = Integer.parseInt(curPageStr);
		} catch (NumberFormatException e) {
		}
		// 根据页面数据获取目标数据
		SplitPage result = cms.getCate(cate,curPage);
		// 返回页面
		if(result.getData()!=null&&result.getData().size()>0){
		req.setAttribute("splitPage", result);
		req.getRequestDispatcher("cateMg.jsp").forward(req, resp);
		}else{
			resp.sendRedirect(basePath+"backstage/manager/cateAdd.jsp");
		}
	}
	
}
