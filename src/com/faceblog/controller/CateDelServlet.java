package com.faceblog.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.Cate;
import com.faceblog.entity.SplitPage;
import com.faceblog.service.CateMgServiceInterface;
import com.faceblog.service.impl.CateMgServiceImpl;

public class CateDelServlet extends HttpServlet{
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
		String cateID = req.getParameter("cateID");
		// 根据页面数据获取目标数据
		boolean result = cms.cateDel(cateID);
		// 返回
		PrintWriter pw = resp.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();

	}
}
