package com.faceblog.controller.blog.newsList;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.output.NullWriter;

import com.faceblog.dao.AssessDaoInterface;
import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.dao.impl.AssessDaoImpl;
import com.faceblog.dao.impl.NewsMgDaoImpl;
import com.faceblog.entity.Article;
import com.faceblog.entity.Assess;

public class AddAssessServ extends HttpServlet {

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

		System.out.println("********** you have enter add assess servlet");
		String datas = request.getParameter("datas");
//		System.out.println(datas);
		String dataStrings[] = datas.split("&");
		Assess assess = new Assess();
		assess.setAssessUserId(Integer.parseInt(dataStrings[0].split("=")[1]
				.toString()));
		assess.setAssessArtiId(Integer.parseInt(dataStrings[1].split("=")[1]
				.toString()));
		String attitude = dataStrings[2].split("=")[1];
		// 0. 判断文章是不是 这个用户的， 否则 直接结束
		NewsMgDaoInterface newsMgDaoInterface = new NewsMgDaoImpl();
		Article article = new Article();
		article.setArt__id(Integer.parseInt(dataStrings[1].split("=")[1]
				.toString()));
		List<Map<String, Object>> resultsList = newsMgDaoInterface
				.selectArticles(article);
		System.out.println("*****" + resultsList);
		if (resultsList != null) {
			for (Map<String, Object> map : resultsList) {
				if (map != null)
					if ("0".equals(map.get("ARTI_COPY").toString().trim())) {
						if (dataStrings[0].split("=")[1]
								.toString()
								.trim()
								.equals(map.get("ARTI_USERID").toString()
										.trim())) {
							System.out
									.println("you cant assess your own articles");
							return;
						}
					}
			}
		}

		// 1. 判断该用户之前有无阅读过此篇文章
		AssessDaoInterface a = new AssessDaoImpl();
		boolean flag = false;
		try {
			// 1.1 index out of bounds exception means it's not exist
			Map<String, Object> result = a.selectAssess(assess).get(0);
			flag = true;
		} catch (IndexOutOfBoundsException e) {
			// TODO: handle exception
			flag = false;
		}
		// 2.if it's not existed, add a data
		if (!flag) {
			a.insertAssess(assess);
		}
		// 3. insert the attitude
		if ("agree".equals(attitude))
			assess.setAssessAgree(2);
		if ("disagree".equals(attitude))
			assess.setAssessDisagree(-2);
		if ("tired".equals(attitude))
			assess.setAssessTired(-0.5f);
		if ("copy".equals(attitude))
			assess.setAssessCopy(4);

		// 4. update it
		a.updateAssess(assess);
	}

}
