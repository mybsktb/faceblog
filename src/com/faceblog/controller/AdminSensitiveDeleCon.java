package com.faceblog.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.entity.AdminPage;
import com.faceblog.service.AdminSensitiveServiceInterface;
import com.faceblog.service.impl.AdminSensitiveServiceImpl;
import com.faceblog.util.AdminPageParameterMg;

public class AdminSensitiveDeleCon extends HttpServlet {
	/**
	 * 敏感词删除
	 */
	private static final long serialVersionUID = 1L;
	AdminSensitiveServiceInterface ad = new AdminSensitiveServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//批量删除时，获取敏感词ID数组
		String checkbox[] = request.getParameterValues("checkBox");
		//处理
		if (checkbox != null && checkbox.length > 0) {
			for (int i = 0; i < checkbox.length;) {
				int id = Integer.valueOf(checkbox[i]);
				//service层单个删除
				String data = ad.SensitiveDele(id);
				if ("删除完成".equals(data)) {
					//处理完返回信息
					if (i == checkbox.length - 1) {
						PrintWriter out = response.getWriter();
						out.write(data);
						out.flush();
						out.close();
						break;
					} else {//删除下一个敏感词
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
		
		//单个删除时获取敏感词ID
		int id = Integer.valueOf(request.getParameter("newsid"));
		//service层处理
		String res = ad.SensitiveDele(id);
		request.setAttribute("sensitive", res);
		//获取分页参数，工具类处理
		AdminPage ap = AdminPageParameterMg.PageParameterMg(request);
		//service处理
		AdminPage res2 = ad.selectSensitive(ap);
		request.setAttribute("page", res2);
		//返回结果
		request.getRequestDispatcher("/backstage/manager/admin_Sensitive.jsp")
				.forward(request, response);
	}
}
