package com.faceblog.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.dao.impl.NewsMgDaoImpl;
import com.faceblog.entity.Article;
import com.faceblog.entity.ZHJPage;
import com.faceblog.util.SliptPage;


public class NewsMgServlet extends HttpServlet{
	private NewsMgDaoInterface artiOper=new NewsMgDaoImpl();
	private Article arti=new Article();
	private ZHJPage page=new ZHJPage();
	private int size=5;
	
	/* (non-Javadoc)
	 * 用于处理4个请求，分页，复合查询
	 * 后台的首页：请求1：文章的审核状态
	 *         请求2：文章的推荐状态
	 *         请求3：文章是否被举报
	 * 栏目管理页面：请求4：点击栏目跳到文章管理界面显示该栏目的所有文章        
	 * 
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		//获取用户的id
		int userId=Integer.parseInt(request.getSession().getAttribute("userId").toString());
		//获取当期页
		String cur=request.getParameter("current");
		if(cur==null){
			cur="1";
		}
		//获取栏目的id
		String cateId=request.getParameter("cateId");
		//获取查询框的字符串
		String selectName=request.getParameter("select_name");
		//获取文章是否通过，0未审核，1通过，-1未通过，-2被举报
		String artiCheck=request.getParameter("artiCheck");
		//获取文章是否推荐
		String artiReco=request.getParameter("recommend");
		int check=2;
		if(artiCheck!=null){
		    try {
			    check = Integer.parseInt(artiCheck);
		    } catch (Exception e) {			
		    }
		}
		
		int recommend=2;
		try {
			recommend = Integer.parseInt(artiReco);
		} catch (Exception e) {
			
		}
		
		List<Map<String, Object>> selectResult=null;
		//判断混合查询的栏目名是否为空，以此来选择查询方式
		if(selectName==null||"".equals(selectName.trim())){
			selectResult= artiOper.selectArti(arti,userId);
	    }else{
	    	selectResult=artiOper.selectLikeArti(selectName,userId);
	    }
		//0未审核，1通过，-1未通过，-2被举报
        if(check==0||check==1||check==-1||check==-2){
        	selectResult= artiOper.selectCheckArticle(check,userId);
        	request.setAttribute("artiCheck", artiCheck);
		}
        //0不推荐，1推荐
        if(recommend==0||recommend==1){
        	selectResult=artiOper.selectRecoArticle(recommend,userId);
        	request.setAttribute("recommend", recommend);
        }
        //根据栏目决定是否以栏目来查询文章
        if(cateId!=null&&!("".equals(cateId))){
        	int cateid=0;
        	try {
        		cateid = Integer.parseInt(cateId);
		    } catch (Exception e) {			
		    }
		    List<Map<String,Object>>selResult=artiOper.selectCateArticle(cateid,userId);
		    if(selResult!=null){
		    	selectResult=selResult;
		    }
		    request.setAttribute("cateId",cateId);
        }
		request.setAttribute("selName",selectName);
		//调用工具类封装page
		page=SliptPage.setPageValue(cur, size, selectResult);
		//调用工具类获取页面所需要的数据，并请求转发
		request.setAttribute("articleResult", SliptPage.setResult(cur, size, selectResult));
		request.setAttribute("pageObj", page);
		
		request.getRequestDispatcher("newsMG.jsp").forward(request, response);
		
	}
	
	
	
	
	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		
	}

}
