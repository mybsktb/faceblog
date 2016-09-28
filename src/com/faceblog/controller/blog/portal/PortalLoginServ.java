package com.faceblog.controller.blog.portal;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.common.Const;
import com.faceblog.dao.AdminMgDaoInterface;
import com.faceblog.dao.UserMgDaoInterface;
import com.faceblog.dao.impl.AdminMgDaoImpl;
import com.faceblog.dao.impl.UserMgDaoImpl;
import com.faceblog.entity.Admin;
import com.faceblog.entity.User;
import com.faceblog.util.PwdSecurityUtil;
import com.faceblog.util.StringUtil;

public class PortalLoginServ extends HttpServlet {

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
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";

		// 1. 数据的获取
		String userName = request.getParameter("user");
		User user2 = new User();
		UserMgDaoInterface u = new UserMgDaoImpl();
		user2 = u.getUserId(userName);
		int userId= user2.getUser_id();
		
//		System.out.println(userName);
		// 1.1 根据用户名判断有无存在的cookie//注意cookie名字是用户名加类型如 qcmuser
		Cookie[] cookies = request.getCookies();
		for (int i = 0; i < cookies.length; i++) {
			Cookie c = cookies[i];
			// 1.1.1 如果存在
			if (c.getName().toString().equals(userName + "user")) {
				System.out.println("cookie 跳走");
				request.getSession().setAttribute("userName", userName);
				request.getSession().setAttribute("userId", userId);
				request.getSession().setAttribute("userMotto", user2.getUser_motto());
				request.getSession().setAttribute("userJob", user2.getUser_job());
				request.getSession().setAttribute("userHometown", user2.getUser_homtown());
				request.getSession().setAttribute("userTele", user2.getUser_tele());
				request.getSession().setAttribute("userEmail", user2.getUser_email());
				request.getSession().setAttribute("userIcon", user2.getUser_icon());

//				System.out.println(basePath + "blog/blogHome");
				
				response.sendRedirect(basePath + "blog/blogHome");
				return;
			}
		}
		String pwd="";
		try {
			pwd = request.getSession().getAttribute("pwd").toString();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		if(StringUtil.isEmpty(pwd))
			pwd = request.getParameter("pwd");
//		pwd=PwdSecurityUtil.transMd5(pwd, Const.NUM_MD5);
		
//		System.out.println("password is :"+pwd);
		String remember = request.getParameter("rememberMe");// 未选中为null，选中为on

		boolean userPwdIsRight = false;
		Cookie c;
		// 2. yonghu登陆
		System.out.println("user是用户");
		User user = new User();
		user.setUser_name(userName);
		user.setUser_pwd(pwd);
		c = new Cookie(userName + "user", userName + "&" + pwd);
		
		if (u.selectUser(user).size() == 1) // 替换成判断密码正不正确的语句
			userPwdIsRight = true;

		// 3. 如果密码正确
		if (userPwdIsRight) {
			// 3.1 判断是否要加COOKIE
			if ("on".equals(remember)) {
				c.setMaxAge(Const.COOKIE_MAXAGE);// 期限为7天
				response.addCookie(c);
			}
			// 3.2成功则跳转到页面
			System.out.println("登陆 跳走" + userName);
			request.getSession().setAttribute("userName", userName);
			request.getSession().setAttribute("userId", userId);
			request.getSession().setAttribute("userMotto", user2.getUser_motto());
			request.getSession().setAttribute("userHometown", user2.getUser_homtown());
			request.getSession().setAttribute("userTele", user2.getUser_tele());
			request.getSession().setAttribute("userEmail", user2.getUser_email());
			request.getSession().setAttribute("userIcon", user2.getUser_icon());
			response.sendRedirect(basePath + "blog/blogHome");
			return;
		} else {
			// 3.3失败跳回登陆界面，并提示
			request.setAttribute("info", "用户名或者密码错误，请重新输入");
			request.getRequestDispatcher("blogHomeLogin").forward(request,
					response);

		}
	}

}
