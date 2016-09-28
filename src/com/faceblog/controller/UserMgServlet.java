package com.faceblog.controller;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.SplitPage;
import com.faceblog.entity.User;
import com.faceblog.service.UserMgServiceInterface;
import com.faceblog.service.impl.UserMgServiceImpl;

public class UserMgServlet extends HttpServlet{
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
		// 根据页面数据获取目标数据
		user = ums.getUserInfoByUserId(user);
		// 返回页面
		req.setAttribute("user", user);
		req.getRequestDispatcher("/backstage/manager/userUpd.jsp").forward(req, resp);
	}
}
