package com.faceblog.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.service.NewsMgServiceInterface;
import com.faceblog.service.impl.NewsMgServiceImpl;

public class AdminNewsSeeCheckCon extends HttpServlet {
	/**
	 * 文章详细信息界面审核
	 */
	private static final long serialVersionUID = 1L;
	NewsMgServiceInterface ns = new NewsMgServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取参数
		int newsid = Integer.valueOf(request.getParameter("newsid"));
		int check = Integer.valueOf(request.getParameter("check"));
		//service层处理
		String res = ns.AdSelectNewsCheck(newsid, check);
		//ajax返回结果
		PrintWriter out = response.getWriter();
		out.write(res);
		out.flush();
		out.close();
	}
}
