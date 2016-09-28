package com.faceblog.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.CateMgDaoInterface;
import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.dao.impl.CateMgDaoImpl;
import com.faceblog.dao.impl.NewsMgDaoImpl;
import com.faceblog.entity.Article;
import com.faceblog.util.SensitiveCheck;

public class NewsUpdateServlet extends HttpServlet {
	//用接口创建一个CateMgDaoImpl对象
	private CateMgDaoInterface cateOper=new CateMgDaoImpl();
	//用接口创建一个NewsMgDaoImpl对象
	private NewsMgDaoInterface artiOper=new NewsMgDaoImpl();
	//创建一个Article对象
	private Article arti=new Article();
	
	/* (non-Javadoc)
	 * 用于处理文章管理界面的点击修改按钮，从arti_tab中取对应的数据跳转页面显示出来
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		//执行查询栏目
		int userId=Integer.parseInt(request.getSession().getAttribute("userId").toString());
		List<Map<String,Object>>cateResults=cateOper.selectCate(userId);
		request.setAttribute("cateResults", cateResults);
		
		
		//从页面获取文章的id
		String articleId=request.getParameter("articleID");
		int artiId=0;
		try {
			artiId = Integer.parseInt(articleId);
		} catch (Exception e) {			
		}
		//查找id对应的文章
		arti.setArt__id(artiId);
		List<Map<String,Object>> results=artiOper.selectArticles(arti);
		Map<String,Object> article=null;
        try {
			if (results != null) {
				article = results.get(0);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		String reco=article.get("ARTI_RECOMMEND").toString();
		if("1".equals(reco)){
			request.setAttribute("checked", "true");
		}
		else{
			request.setAttribute("checked", "false");
		}
		request.setAttribute("arti", article);
		request.getRequestDispatcher("/backstage/manager/newsUpdate.jsp").forward(request, response);
		
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
				
		//从文章修改页面获取文章的各项数据
		String artiId=request.getParameter("art_id");
		int articleId=0;
		try {
			articleId = Integer.parseInt(artiId);
		} catch (Exception e) {
		}
		String name=request.getParameter("art_name");
		String recommend=request.getParameter("art_recommend");
		int reco=0;
		try {
			reco = Integer.parseInt(recommend);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		String author=request.getParameter("art_author");
		String keyword=request.getParameter("art_keyword");
		String cateid=request.getParameter("art_cateid");
		int cate_id=1;
		try {
			cate_id = Integer.parseInt(cateid);
		} catch (NumberFormatException e) {
		}
		String content=request.getParameter("art_content");
		//封装article
		arti.setArt__id(articleId);
		arti.setArt_name(name);
		arti.setArt_recommend(reco);
		arti.setAtr_author(author);
		arti.setArt_keyword(keyword);
		arti.setCate_id(cate_id);
		arti.setArt_content(content);
		int check=SensitiveCheck.artiCheck(content);
		arti.setArt_check(check);
		//调用dao层执行修改操作
		boolean result=artiOper.updateArticle(arti);
		String message=null;
		if(result){
			message="文章修改成功";
		}else{
			message="文章修改失败";
		}
		PrintWriter out =response.getWriter();
		out.print(message);
		out.flush();
		out.close();		
	}

}
