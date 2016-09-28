package com.faceblog.controller.login_register;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.faceblog.common.Const;
import com.faceblog.dao.UserMgDaoInterface;
import com.faceblog.dao.impl.UserMgDaoImpl;
import com.faceblog.entity.User;
import com.faceblog.util.PwdSecurityUtil;

public class AddUser extends HttpServlet {

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
	
		User user = new User();
		user.setUser_name(request.getParameter("username"));
		String pwd=request.getParameter("pwd");
		pwd=PwdSecurityUtil.transMd5(pwd,Const.NUM_MD5);
		user.setUser_pwd(pwd);
		user.setUser_questionid(request.getParameter("dropdown"));
		user.setUser_answer(request.getParameter("answer"));
		user.setUser_motto(request.getParameter("motto"));
		user.setUser_job(request.getParameter("job"));
		user.setUser_homtown(request.getParameter("hometown"));
		user.setUser_email(request.getParameter("email"));
		user.setUser_tele(request.getParameter("tele"));
		user.setUser_intro(request.getParameter("introduction"));
		user.setUser_icon(request.getParameter("imgurl"));
		System.out.println(user.toString());
		

		UserMgDaoInterface u = new UserMgDaoImpl();
		boolean result = u.insertUser(user);
		System.out.println("123");
		if (result) {
			request.setAttribute("info", "注册成功,"+request.getParameter("username"));
			request.getRequestDispatcher("login.jsp")
					.forward(request, response);
		}
		else {
			
			request.getRequestDispatcher("register").forward(request, response);
		}
	}

}
