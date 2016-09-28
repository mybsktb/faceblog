package com.faceblog.controller.login_register;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
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

/**
 * 110行附近，修改主页位置 88行，同上
 * */
public class LoginServ extends javax.servlet.http.HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Constructor of the object.
	 */
	public LoginServ() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

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

		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";

		// 1. 数据的获取
		String userName = request.getParameter("user");
		String loginAsAdmin = request.getParameter("loginAsAdmin");// 未选中为null，选中为on
		String userId = "-1";
		
		// 1.0.1 根据 获得用户ID
		User user = new User();
		String pwd = request.getParameter("pwd");
		pwd=PwdSecurityUtil.transMd5(pwd, Const.NUM_MD5);
		String info2 = "";
		if ("on".equals(loginAsAdmin)) {
			AdminMgDaoInterface a = new AdminMgDaoImpl();
			Admin admin = new Admin();
			admin.setAdmin_name(userName);
			List<Map<String, Object>> results = a.selectAdmin(admin);
			try {
				Map<String, Object> result = results.get(0);
				userId = result.get("ADMIN_ID").toString();
			} catch (IndexOutOfBoundsException e) {
				// TODO: handle exception
				info2 = "用户不存在！";
			}

		} else {
			UserMgDaoInterface u = new UserMgDaoImpl();
			user.setUser_name(userName);
			List<Map<String, Object>> results = u.selectUser(user);
			try {
				Map<String, Object> result = results.get(0);
				userId = result.get("USER_ID").toString();
				//1.0.2封装一个User对象
				user.setUser_id(Integer.parseInt(userId));
			} catch (IndexOutOfBoundsException e) {
				// TODO: handle exception
				info2 = "用户不存在！";
			}//end try catch
		}

		// 1.1 根据用户名判断有无存在的cookie//注意cookie名字是用户名加类型如 qcmuser
		Cookie[] cookies = request.getCookies();
		for (int i = 0; i < cookies.length; i++) {
			Cookie c = cookies[i];
			// 1.1.1 如果存在
			if (c.getName()
					.toString()
					.equals(("on".equals(loginAsAdmin) ? "admin" : "user")+cnToUnicode(userName))) {
				System.out.println("cookie 跳走");
				request.getSession().setAttribute("userName", userName);
				request.getSession().setAttribute("userId", userId);
				request.getSession().setAttribute("pwd", pwd);
				if ("on".equals(loginAsAdmin)) {
					response.sendRedirect(basePath
							+ "backstage/manager/admin_index.jsp");
					return;
				} else {
					response.sendRedirect(basePath
							+ "backstage/manager/index");
					return;

				}
			}
		}

		
		String remember = request.getParameter("rememberMe");// 未选中为null，选中为on
		System.out.println("user pwd remember admin\t" + userName + pwd
				+ remember + loginAsAdmin);

		boolean userPwdIsRight = false;
		Cookie c;
		// 2. 判断是否为管理员登陆
		if ("on".equals(loginAsAdmin)) {
			System.out.println("admin是管理员");
			// 2.1 封装为管理员
			Admin admin = new Admin();
			admin.setAdmin_name(userName);
			admin.setAdmin_pwd(pwd);
			c = new Cookie( "admin"+cnToUnicode(userName), userName + "&" + pwd);
			AdminMgDaoInterface a = new AdminMgDaoImpl();
			if (a.selectAdmin(admin).size() == 1) // 替换成判断密码正不正确的语句
				userPwdIsRight = true;
		} else {
			System.out.println("user是用户");
			
			user.setUser_name(userName);
			user.setUser_pwd(pwd);
			c = new Cookie("user"+ cnToUnicode(userName) , userName + "&" + pwd);
			UserMgDaoInterface u = new UserMgDaoImpl();
			if (u.selectUser(user).size() == 1) // 替换成判断密码正不正确的语句
				userPwdIsRight = true;
		}

		// 3. 如果密码正确
		if (userPwdIsRight) {
			// 3.1 判断是否要加COOKIE
			if ("on".equals(remember)) {
				c.setMaxAge(Const.COOKIE_MAXAGE);// 期限为7天
				response.addCookie(c);
			}
			// 3.2成功则跳转到页面
			System.out.println("登陆 跳走");
			request.getSession().setAttribute("userName", userName);
			request.getSession().setAttribute("userId", userId);
			request.getSession().setAttribute("pwd", pwd);
			if ("on".equals(loginAsAdmin))
				response.sendRedirect(basePath + "backstage/manager/admin_index.jsp");
			else
				response.sendRedirect(basePath + "backstage/manager/index");
		} else {
			// 3.3失败跳回登陆界面，并提示
			if (StringUtil.isEmpty(info2))
				request.setAttribute("info", "Username or Password is wrong!");
			else
				request.setAttribute("info", info2);

			request.getRequestDispatcher("login.jsp")
					.forward(request, response);

		}

	}

	/**
	 * Initialization of the servlet. <br>
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

	private static String cnToUnicode(String cn) {
	    char[] chars = cn.toCharArray();
	    String returnStr = "";
	    for (int i = 0; i < chars.length; i++) {
	      returnStr += "\\u" + Integer.toString(chars[i], 16);
	    }
	    returnStr=returnStr.replace("\\", "");
	    System.out.println(returnStr);
	    return returnStr;
	}
}
