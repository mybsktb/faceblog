package com.faceblog.controller.login_register;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.UserMgDaoInterface;
import com.faceblog.dao.impl.UserMgDaoImpl;
import com.faceblog.entity.User;

public class CheckAnswerServ extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println(request.getCharacterEncoding());
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		// 1. get the answer
		String answer = request.getParameter("answer");
		String username = request.getParameter("username");
		System.out.println(username);

		// 2. compare the answer with the answer in the database
		User user = new User();
		user.setUser_name(username);
		user.setUser_answer(answer);
		UserMgDaoInterface u = new UserMgDaoImpl();
		List<Map<String, Object>> results = u.selectUser(user);
		System.out.println(results.size());

		PrintWriter out = response.getWriter();
		// 3.1 if success, reset pwd to 123456, and redirect to login page
		if (results.size() == 1) {
			System.out.println(u.updateUser(user, 1));
			out.print(1+"&密码重置成功，跳转到登陆界面");
		} 
		// 3.2 if fail, retrun fail.
		else {
			out.print(2+"&答案错误，请重新输入");
		}

		out.flush();
		out.close();
	}

}
