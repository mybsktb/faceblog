package com.faceblog.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.entity.AdminPage;
import com.faceblog.service.AdminSensitiveServiceInterface;
import com.faceblog.service.impl.AdminSensitiveServiceImpl;
import com.faceblog.util.AdminPageParameterMg;

public class AdminSensitiveMgCon extends HttpServlet {
	/**
	 * 敏感词管理
	 */
	private static final long serialVersionUID = 1L;
	AdminSensitiveServiceInterface ns = new AdminSensitiveServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取界面敏感词ID，返回敏感词编辑界面
		String strnewsid = request.getParameter("newsid");
		if (strnewsid != null) {
			int newsid = Integer.valueOf(strnewsid);
			//service层处理
			List<Map<String, Object>> res = ns.selectSensitiveSee(newsid);
			request.setAttribute("news", res);
			//返回敏感词编辑界面
			request.getRequestDispatcher(
					"/backstage/manager/admin_SensitiveSee.jsp").forward(
					request, response);
			return;
		}
		
		//获取分页参数，工具类处理
		AdminPage ap = AdminPageParameterMg.PageParameterMg(request);
		//service层处理
		AdminPage res = ns.selectSensitive(ap);
		request.setAttribute("page", res);
		//返回结果
		request.getRequestDispatcher("/backstage/manager/admin_sensitive.jsp")
				.forward(request, response);
	}
}
