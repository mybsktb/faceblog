package com.faceblog.controller.blog.newsList;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.impl.UserMgDaoImpl;
import com.faceblog.entity.User;

public class AddVisitorServ extends HttpServlet {

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
//		System.out.println("you have enter into the serv for adding visitor");
		String visitor = request.getParameter("visitor").trim();
		String host = request.getParameter("host").trim();
		System.out.println("visitor:" + visitor + "host:" + host);
		
		int hostInt=Integer.parseInt(host);
		User user= new User();
		user.setUser_id(hostInt);

		UserMgDaoImpl ue = new UserMgDaoImpl();
		try {
			ue.setUserVisitor(user, visitor);
		} catch (NumberFormatException e) {
			// TODO: handle exception
			System.out.println("用户名为空，userName is null,或者自己评论自己，or you can't evaluate your articles ");
		}
		
	}

}
