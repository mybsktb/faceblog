package com.faceblog.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.entity.AdminPage;
import com.faceblog.service.AdminUserServiceInterface;
import com.faceblog.service.impl.AdminUserServiceImpl;
import com.faceblog.util.AdminPageParameterMg;

public class AdminUserDeleCon extends HttpServlet {
	/**
	 * 删除用户和重置用户信息
	 */
	private static final long serialVersionUID = 1L;
	AdminUserServiceInterface ad = new AdminUserServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//批量删除或重置时，获取用户ID数组，checked 1是重置，2是删除
		String checkbox[] = request.getParameterValues("checkBox");
		String checked = request.getParameter("check");
		//处理
		if (checkbox != null && checkbox.length > 0) {
			for (int i = 0; i < checkbox.length;) {
				int userid = Integer.valueOf(checkbox[i]);
				int flag = Integer.valueOf(checked);
				//service单个处理
				String data = ad.userdele(userid, flag);
				if (!"操作失败".equals(data)) {
					//处理完成，ajax返回结果
					if (i == checkbox.length - 1) {
						PrintWriter out = response.getWriter();
						out.write(data);
						out.flush();
						out.close();
						break;
					} else {//处理下一个用户
						i++;
					}
				} else {//出错时返回信息
					PrintWriter out = response.getWriter();
					out.write("第" + (i + 1) + "个用户" + data);
					out.flush();
					out.close();
					break;
				}
			}
			return;
		}

		//单个删除或重置时获取参数
		int userid = Integer.valueOf(request.getParameter("userid"));
		int flag = Integer.valueOf(request.getParameter("flag"));
		//service处理
		String res = ad.userdele(userid, flag);
		request.setAttribute("user", res);
		//获取分页参数，工具类处理
		AdminPage ap = AdminPageParameterMg.PageParameterMg(request);
		//service处理
		AdminPage res2 = ad.usermg(ap);
		request.setAttribute("page", res2);
		//返回结果
		request.getRequestDispatcher("/backstage/manager/admin_UserMg.jsp")
				.forward(request, response);
	}
}
