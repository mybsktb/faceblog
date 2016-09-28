package com.faceblog.controller;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.Comment;
import com.faceblog.service.CmtMgServiceInterface;
import com.faceblog.service.impl.CmtMgServiceImpl;

public class ReCmtAddServlet extends HttpServlet{
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
		String commentid = req.getParameter("commentid");
		comment.setComment_commid(Integer.parseInt(commentid));
		comment.setComment_fromuserid(Integer.parseInt(req.getSession().getAttribute("userId").toString()));
		
		Map<String,Object> data = cms.getComment(commentid).get(0);
		comment.setComment_artiid((Integer)data.get("arti_id"));
		comment.setComment_userid((Integer)data.get("comment_fromuserid"));
		
		
		
		// 根据页面数据获取目标数据
		boolean result = cms.insertComment(comment);
		// 返回页面
		PrintWriter pw = resp.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();		
	}
}
