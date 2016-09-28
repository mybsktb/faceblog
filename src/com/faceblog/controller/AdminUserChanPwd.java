package com.faceblog.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.service.AdminUserServiceInterface;
import com.faceblog.service.impl.AdminUserServiceImpl;

public class AdminUserChanPwd extends HttpServlet {
	/**
	 * 管理员改变密码
	 */
	private static final long serialVersionUID = 1L;
	AdminUserServiceInterface ad = new AdminUserServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取参数
		String oldpwd = request.getParameter("oldpwd");
		String newpwd = request.getParameter("newpwd");
		String newpwd2 = request.getParameter("newpwd2");
		//service处理
		String res = ad.chanpwd(5, oldpwd, newpwd, newpwd2);
		//返回结果
		request.setAttribute("admin", res);
		request.getRequestDispatcher("/backstage/manager/admin_ChanPwd.jsp")
				.forward(request, response);
	}
}
