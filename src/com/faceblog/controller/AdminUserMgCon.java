package com.faceblog.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.entity.AdminPage;
import com.faceblog.service.AdminUserServiceInterface;
import com.faceblog.service.impl.AdminUserServiceImpl;
import com.faceblog.util.AdminPageParameterMg;

public class AdminUserMgCon extends HttpServlet {
	/**
	 * 用户管理
	 */
	private static final long serialVersionUID = 1L;
	AdminUserServiceInterface ad = new AdminUserServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取分页参数，工具类处理
		AdminPage ap = AdminPageParameterMg.PageParameterMg(request);
		//service处理
		AdminPage res = ad.usermg(ap);
		request.setAttribute("page", res);
		//返回结果
		request.getRequestDispatcher("/backstage/manager/admin_UserMg.jsp")
				.forward(request, response);
	}
}
