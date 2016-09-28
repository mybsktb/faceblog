package com.faceblog.controller.blog;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.dao.impl.NewsMgDaoImpl;
import com.faceblog.entity.Article;
import com.faceblog.entity.Page;

public class Recomm extends HttpServlet{
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String useid=request.getParameter("userId");
		int use=Integer.parseInt(useid);
		int curr=1;
		NewsMgDaoInterface ndi=new NewsMgDaoImpl();
		//将空 及初始页数传给dao层 并将获取到的值 放入pg中
		Page pg=ndi.recom(curr,use);
		//将界面的内容 放入resu中 以便界面获取
		List<Map<String,Object>> resu=pg.getData();
		//设置属性 将界面内容设置成属性 供界面调用
		request.setAttribute("res", resu);
		//将Page设置成属性供界面调用
		request.setAttribute("Page", pg);
		//获取最大页数
		int max=pg.getTotalPage();
		int currp=pg.getCurrentPage();
		request.setAttribute("curren", currp);
		request.setAttribute("maxpage", max);
		request.setAttribute("useid", use);
		List<Map<String, Object>> pgdata = pg.getData();
		request.getRequestDispatcher("/blog/index.jsp").forward(request, response);
		
		
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String useid=request.getParameter("userId");
		String curre=request.getParameter("curre");
		int curr=1;
		int use = 0;
		try{
		curr=Integer.parseInt(curre);
		use=Integer.parseInt(useid);
		}catch(NumberFormatException e){
		}
		NewsMgDaoInterface ndi=new NewsMgDaoImpl();
		//将空 及初始页数传给dao层 并将获取到的值 放入pg中
		Page pg=ndi.recom(curr,use);
		//将界面的内容 放入resu中 以便界面获取
		List<Map<String,Object>> resu=pg.getData();
		//设置属性 将界面内容设置成属性 供界面调用
		String str="";
		String spil="||";
		request.setAttribute("res", resu);
		for(Map<String, Object> result : resu){
			JSONObject json=JSONObject.fromObject(result);
			str+=json.toString()+spil;
		}
		PrintWriter out=response.getWriter();
		//而这个结果是test这个字符串
		out.print(str);
		out.close();
		
	}

}

