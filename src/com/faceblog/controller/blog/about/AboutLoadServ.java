package com.faceblog.controller.blog.about;

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

public class AboutLoadServ extends HttpServlet {

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
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//1. 读取博主的信息
		String username ="qcmtest";
		
		//2. 获得用户个人简介
		UserMgDaoInterface u = new UserMgDaoImpl();
		User user = new User();
		user.setUser_name(username);
		List<Map<String, Object>> results = (List<Map<String, Object>>) u.selectUser(user);
		System.out.println(results);
		Map<String, Object> result = results.get(0);
		request.setAttribute("about", result.get("USER_ABOUT"));
		request.getRequestDispatcher("about.jsp").forward(request, response);
		
	}

}
