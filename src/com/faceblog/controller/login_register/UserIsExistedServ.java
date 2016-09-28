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
import com.faceblog.dao.impl.QuestionDaoImpl;
import com.faceblog.dao.impl.UserMgDaoImpl;
import com.faceblog.entity.User;

public class UserIsExistedServ extends HttpServlet {

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
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//1. 获取用户名
		String username = request.getParameter("username");
		//2. 根据用户名搜索数据库有无存在
		UserMgDaoInterface u = new UserMgDaoImpl();
		User user = new User();
		user.setUser_name(username);
		List<Map<String, Object>> results = u.selectUser(user);
		int userSize = 0;
		String questionContent=" ";
		if(results.size()==1)
		{	
			userSize=1;
			Map<String, Object>result = results.get(0);
			String questionId = result.get("USER_QUESTIONID").toString(); 
			int id=Integer.parseInt(questionId);
			QuestionDaoImpl q=new QuestionDaoImpl();
			List<Map<String, Object>> questions = (List<Map<String, Object>>) q.selectQuestion(id);
			Map<String, Object> question = (Map<String, Object>) questions.get(0);
			questionContent = question.get("QUESTION_CONTENT").toString();
		}
		//3. 返回搜索到用户的数量 0 或  1 
		System.out.println(questionContent);
		PrintWriter out = response.getWriter();
		out.print(userSize+"&"+questionContent);
		out.flush();
		out.close();
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

		doGet(request, response);
	}

}
