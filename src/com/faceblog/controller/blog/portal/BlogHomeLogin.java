package com.faceblog.controller.blog.portal;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.entity.Page;
import com.faceblog.util.PageUtil;

public class BlogHomeLogin extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 得到一个第几页，得到一个每页个数，
		int currentPage=1;
		try {
			currentPage=Integer.parseInt(request.getParameter("currentPage").toString());
		} catch (Exception e) {
			// TODO: handle exception
			
		}
		Page page= new Page();
		page.setCurrtentPage(currentPage);
		page.setPageSize(6);
		String sql="SELECT * FROM ARTI_SCORE9 ORDER BY SCORE DESC";
		
		page=PageUtil.selectPage(page,sql);
		request.setAttribute("page", page);
		
		request.getRequestDispatcher("blogHomeLogin.jsp").forward(request, response);
		System.out.println(page.getData());
		
	}

}