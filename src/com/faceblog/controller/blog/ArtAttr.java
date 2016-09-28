package com.faceblog.controller.blog;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.*;
import com.faceblog.dao.impl.*;
import com.faceblog.entity.Assess;

public class ArtAttr extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

//				String userName = request.getParameter("user");
				//获取界面的值 文章ID
				String artid=request.getParameter("ARTI_ID");
				//文章点击量
				String artctr=request.getParameter("ARTI_CTR");
				//相关文章
				String catid=request.getParameter("ARTI_CATEID");
				
				String userid=request.getParameter("userId");
				int art=0;
				int artCtr=0;
				int cat=0;
				try{
				art=Integer.parseInt(artid);
				artCtr=Integer.parseInt(artctr)+1;
				cat=Integer.parseInt(catid);
				}catch(NumberFormatException e){
					
				}
				NewsMgDaoInterface nmi=new NewsMgDaoImpl();
				//调用dao层方法  并获得返回回来的值
				List<Map<String,Object>> resu=nmi.articlAppre(art,artCtr);
				//获取前一章内容与后一章内容
				List<Map<String,Object>> onAndnext=nmi.onAndNex(art);
				//获取相关文章
				List<Map<String,Object>> revelent=nmi.revele(cat,art);
				//获取最新评论
				List<Map<String,Object>> latcomm=nmi.latCom(art);
				request.setAttribute("resaut", resu);
				request.setAttribute("onAndNex",onAndnext);
				request.setAttribute("reven",revelent);
				request.setAttribute("latcom", latcomm);
				request.setAttribute("userid", userid);
				// 09 20 裘丛民新增 关于评价表 开始
				String userId=null;
				try{
				userId = request.getSession().getAttribute("userId").toString();
				System.out.println("yonghuID" + userId + "\tart id=" + artid);
				}catch(NullPointerException e){
					userId="-1";
				}
				// 用户ID 阅读了 文章 ID 阅读次数为1
				Assess assess = new Assess();
				assess.setAssessUserId(Integer.parseInt(userId));
				assess.setAssessArtiId(Integer.parseInt(artid));
				AssessDaoInterface a = new AssessDaoImpl();
				a.insertAssess(assess);
				// 09 20 裘丛民新增 关于评价表 结束
				request.getRequestDispatcher("/blog/new.jsp").forward(request, response);

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
