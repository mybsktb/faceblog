package com.faceblog.controller.blog.portal;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.AssessDaoInterface;
import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.dao.impl.AssessDaoImpl;
import com.faceblog.dao.impl.NewsMgDaoImpl;
import com.faceblog.entity.User;

public class HomeRecomServ extends HttpServlet {

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
		
		
			
		NewsMgDaoInterface newsMgDaoInterface = new NewsMgDaoImpl();
		System.out.println("you have enter into the servlet for home recommend by qcm");
		//1. 获取用户ID
		User user = new User();
		int userId=0;
				try {
					userId=(Integer.parseInt(request.getSession().getAttribute("userId").toString().trim()));
					
				} catch (Exception e) {
					// TODO: handle exception
				}
				System.out.println("*************************************");
		user.setUser_id(userId);
		System.out.println(userId);
		AssessDaoInterface a = new AssessDaoImpl();
		List<Double[]> result = a.getUserSort(user);
		List<Double> score =new ArrayList<Double>();
//		String resultS="";
		List<Map<String, Object>> results = new ArrayList<Map<String,Object>>();
		for (Double[] doubles : result) {
//			resultS+=doubles[0]+"\t"+doubles[1]+"\t";
			int arti_id = (int)(double) doubles[0];
			System.out.println(arti_id);
			if(newsMgDaoInterface.selectById(arti_id)!=null)
				results.add(newsMgDaoInterface.selectById(arti_id));
			score.add(doubles[1]);
		}
		//System.out.println(results);
		request.setAttribute("results", results);
		request.setAttribute("score", score);
		request.getRequestDispatcher("homeRecommend.jsp").forward(request, response);
	}

}
