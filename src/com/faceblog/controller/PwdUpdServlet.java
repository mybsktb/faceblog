package com.faceblog.controller;

import java.io.PrintWriter;
import java.net.HttpRetryException;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.User;
import com.faceblog.service.UserMgServiceInterface;
import com.faceblog.service.impl.UserMgServiceImpl;

public class PwdUpdServlet extends HttpServlet{
	private UserMgServiceInterface ums = new UserMgServiceImpl();

	protected void doGet(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		doPost(req, resp);
	}

	protected void doPost(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		// 获取页面数据
		User user = new User();
		user.setUser_id(Integer.parseInt(req.getSession().getAttribute("userId").toString()));
		user.setUser_pwd(req.getParameter("pwd"));
		// 根据页面数据获取目标数据
		boolean result = ums.updateUser(user);
		// 返回页面
		PrintWriter pw = resp.getWriter();
		pw.print(result);
		pw.flush();
		pw.close();		
	}
}
