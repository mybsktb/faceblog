package com.faceblog.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.Comment;
import com.faceblog.service.CmtMgServiceInterface;
import com.faceblog.service.impl.CmtMgServiceImpl;

public class ReCmtUpdServlet extends HttpServlet{
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
		Comment comment = new Comment();
		String content = req.getParameter("content").trim();
		comment.setComment_content(content);
		int commentid = Integer.parseInt(req.getParameter("commentid"));
		comment.setComment_id(commentid);
		// 根据页面数据获取目标数据
		boolean result = cms.updateComment(comment);
		// 返回页面
		PrintWriter pw = resp.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();		
	}
}
