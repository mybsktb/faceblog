package com.faceblog.controller;

import java.net.HttpRetryException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.SplitPage;
import com.faceblog.service.CmtMgServiceInterface;
import com.faceblog.service.impl.CmtMgServiceImpl;
import com.faceblog.util.StringUtil;

public class ReCmtMgServlet extends HttpServlet{
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
		String commentID = req.getParameter("commentid");
		// 根据页面数据获取目标数据
		cms.updateComment(commentID);
		List<Map<String, Object>> result = cms.getComment(commentID);
		String content = cms.getContent(commentID);
		// 返回页面
		req.setAttribute("result", result);
		if(content!=null)
		req.setAttribute("content", content);
		req.getRequestDispatcher("/backstage/manager/reCmtMg.jsp").forward(req, resp);
	}
}
