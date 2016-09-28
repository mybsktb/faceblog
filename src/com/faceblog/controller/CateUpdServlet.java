package com.faceblog.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.Cate;
import com.faceblog.service.CateMgServiceInterface;
import com.faceblog.service.impl.CateMgServiceImpl;

public class CateUpdServlet extends HttpServlet{
	private CateMgServiceInterface cms = new CateMgServiceImpl();

	protected void doGet(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		doPost(req, resp);
	}

	protected void doPost(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		// 获取页面数据
		Cate cate = new Cate();
		String catename = req.getParameter("catename").trim();
		int cateid = Integer.parseInt(req.getParameter("cateid").toString());
		cate.setCate_id(cateid);
		cate.setCate_name(catename);
		cate.setUser_id(Integer.parseInt(req.getSession().getAttribute("userId").toString()));
		// 根据页面数据获取目标数据
		boolean result = cms.cateUpd(cate);
		// 返回页面
		PrintWriter pw = resp.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();		
	}
}
