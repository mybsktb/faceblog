package com.faceblog.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.entity.AdminPage;
import com.faceblog.service.NewsMgServiceInterface;
import com.faceblog.service.impl.NewsMgServiceImpl;
import com.faceblog.util.AdminPageParameterMg;


public class AdminNewsMgCon extends HttpServlet{

	/**
	 * 文章查询，查询未审核和被举报的文章
	 */
	private static final long serialVersionUID = 1L;
	NewsMgServiceInterface ns = new NewsMgServiceImpl();
	private String sel = "";
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		doPost(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取页面文章ID
		String strnewsid = request.getParameter("newsid");
		//处理
		if (strnewsid != null) {
			int newsid = Integer.valueOf(strnewsid);
			//数据库查询
			List<Map<String, Object>> res = ns.AdSelectNewsMg(newsid);
			int ch = (Integer)res.get(0).get("ARTI_CHECK");
			String checked="";
			if(ch==0){
				checked="待审核";
			}else if(ch==-2){
				checked="被举报";
			}
			//结果返回
			request.setAttribute("news", res);
			request.setAttribute("check", checked);
			//请求转发，文章详细信息界面
			request.getRequestDispatcher("/backstage/manager/admin_NewsSee.jsp").forward(
					request, response);
			return;
		}
		
		//获取分页参数，工具类处理
		AdminPage ap = AdminPageParameterMg.PageParameterMg(request);
		String selec = request.getParameter("selec");
		if(selec==null){
			selec=sel;
		}
		sel = selec;
		ap.setSelec(selec);
		//service层处理
		AdminPage res = ns.AdSelectNewsMg(ap);
		//结果返回
		request.setAttribute("page", res); 
		request.setAttribute("sele", res.getSelec());
			
		//文章审核界面
		request.getRequestDispatcher("/backstage/manager/admin_NewsMg.jsp").forward(request,
				response);
	}
}
