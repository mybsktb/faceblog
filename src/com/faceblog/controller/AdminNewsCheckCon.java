package com.faceblog.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.entity.AdminPage;
import com.faceblog.service.NewsMgServiceInterface;
import com.faceblog.service.impl.NewsMgServiceImpl;
import com.faceblog.util.AdminPageParameterMg;

public class AdminNewsCheckCon extends HttpServlet {

	/**
	 * 文章审核处理，单个审核，批量审核
	 */
	private static final long serialVersionUID = 1L;
	NewsMgServiceInterface ns = new NewsMgServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取批量审核时的文章ID数组，checked是1时审核通过，-1不通过
		String checkbox[] = request.getParameterValues("checkBox");
		String checked = request.getParameter("check");
		//处理
		if (checkbox != null && checkbox.length > 0) {
			for (int i = 0; i < checkbox.length;) {
				int newsid = Integer.valueOf(checkbox[i]);
				int check = Integer.valueOf(checked);
				//service单个文章审核处理
				String data = ns.AdSelectNewsCheck(newsid, check);
				if (!"审核未完成".equals(data)) {
					//全处理完，返回ajax成功数据
					if (i == checkbox.length - 1) {
						PrintWriter out = response.getWriter();
						out.write(data);
						out.flush();
						out.close();
						break;
					} else {//处理下一个文章审核
						i++;
					}
				} else {//出错时返回提示信息
					PrintWriter out = response.getWriter();
					out.write("第" + (i + 1) + "个文章" + data);
					out.flush();
					out.close();
					break;
				}
			}
			return;
		}

		//获取单个文章审核处理时的参数
		int newsid = Integer.valueOf(request.getParameter("newsid"));
		int check = Integer.valueOf(request.getParameter("check"));
		//service层处理
		String res = ns.AdSelectNewsCheck(newsid, check);
		
		//获取分页参数，工具类处理
		AdminPage ap = AdminPageParameterMg.PageParameterMg(request);
		//service层处理
		AdminPage res2 = ns.AdSelectNewsMg(ap);
		
		//处理结果返回
		request.setAttribute("page", res2);
		request.setAttribute("checked", res);
		//请求转发
		request.getRequestDispatcher("/backstage/manager/admin_NewsMg.jsp")
				.forward(request, response);
	}
}
