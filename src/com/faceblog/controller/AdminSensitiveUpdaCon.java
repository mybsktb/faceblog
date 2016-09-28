package com.faceblog.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.service.AdminSensitiveServiceInterface;
import com.faceblog.service.impl.AdminSensitiveServiceImpl;

public class AdminSensitiveUpdaCon extends HttpServlet {
	/**
	 * 敏感词更新
	 */
	private static final long serialVersionUID = 1L;
	AdminSensitiveServiceInterface ns = new AdminSensitiveServiceImpl();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取参数
		Date date = new Date();
		//日期格式化
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd- HH-mm-ss");
		int newsid = Integer.valueOf(request.getParameter("newsid"));
		String word = request.getParameter("sensitive");
		String time = df.format(date);
		//service处理
		String res = ns.SensitiveUpda(newsid, word, time);
		//ajax返回结果
		PrintWriter out = response.getWriter();
		out.write(res);
		out.flush();
		out.close();
	}
}
