package com.faceblog.controller;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.Count;
import com.faceblog.service.IndexServiceInterface;
import com.faceblog.service.impl.IndexServiceImpl;

public class IndexServlet extends HttpServlet{
	private IndexServiceInterface is = new IndexServiceImpl();

	protected void doGet(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		doPost(req, resp);
	}

	protected void doPost(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		Count count = new Count();
		int userID = Integer.parseInt(req.getSession().getAttribute("userId").toString());
		// 获取目标数据
		count = is.getCount(userID);
		// 返回页面
		req.setAttribute("count", count);
		req.getRequestDispatcher("index.jsp").forward(req, resp);
	}
}
