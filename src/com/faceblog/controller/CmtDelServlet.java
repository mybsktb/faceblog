package com.faceblog.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;

import com.faceblog.service.CmtMgServiceInterface;
import com.faceblog.service.impl.CmtMgServiceImpl;

public class CmtDelServlet extends HttpServlet{
	private CmtMgServiceInterface cms = new CmtMgServiceImpl();

	protected void doGet(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		doPost(req, resp);
	}

	protected void doPost(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		// 获取页面数据
		String commentID = req.getParameter("commentID");
		// 根据页面数据获取目标数据
		boolean result = cms.deleteComment(commentID);
		// 返回
		PrintWriter pw = resp.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();

	}
}
