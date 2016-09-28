package com.faceblog.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.entity.User;
import com.faceblog.service.AdminUserServiceInterface;
import com.faceblog.service.impl.AdminUserServiceImpl;

public class AdminUserAddCon extends HttpServlet {

	/**
	 * 增加用户
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
		String username = request.getParameter("username");
		String pwd = request.getParameter("pwd");
		String question = request.getParameter("question");
		String answer = request.getParameter("answer");
		String motto = request.getParameter("motto");
		String job = request.getParameter("job");
		String home = request.getParameter("home");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");
		String intro = request.getParameter("intro");
		//实体类封装
		User user = new User();
		user.setUser_answer(answer);
		user.setUser_email(email);
		user.setUser_homtown(home);
		user.setUser_intro(intro);
		user.setUser_job(job);
		user.setUser_motto(motto);
		user.setUser_name(username);
		user.setUser_pwd(pwd);
		user.setUser_question(question);
		user.setUser_tele(tel);
		//service处理
		String res = ad.useradd(user);
		//返回结果
		request.setAttribute("useradd", res);
		request.getRequestDispatcher("/backstage/manager/admin_UserAdd.jsp")
				.forward(request, response);
	}
}
