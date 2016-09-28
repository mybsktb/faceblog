package com.faceblog.controller;

import java.net.HttpRetryException;

import javax.servlet.http.HttpServlet;

import com.faceblog.entity.Cate;
import com.faceblog.entity.SplitPage;
import com.faceblog.service.CateMgServiceInterface;
import com.faceblog.service.CmtMgServiceInterface;
import com.faceblog.service.impl.CateMgServiceImpl;
import com.faceblog.service.impl.CmtMgServiceImpl;
import com.faceblog.util.StringUtil;

public class CmtMgServlet extends HttpServlet{
	private CmtMgServiceInterface cms = new CmtMgServiceImpl();

	protected void doGet(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		doPost(req, resp);
	}

	protected void doPost(javax.servlet.http.HttpServletRequest req,
			javax.servlet.http.HttpServletResponse resp)
			throws javax.servlet.ServletException, java.io.IOException {
		// 获取页面数据
		String artiID = null;
		String readed = null;
		if(!StringUtil.isEmpty(req.getParameter("artiID"))){
			artiID = req.getParameter("artiID");
			req.setAttribute("artiID", artiID);
			}
		if(!StringUtil.isEmpty(req.getParameter("readed"))){
			readed = req.getParameter("readed");
			req.setAttribute("readed", readed);
		}
		int userID = Integer.parseInt(req.getSession().getAttribute("userId").toString());
		int curPage=1;
		String curPageStr = req.getParameter("curPage");
		try {
			curPage = Integer.parseInt(curPageStr);
		} catch (NumberFormatException e) {
		}
		// 根据页面数据获取目标数据
		SplitPage result = cms.getComment(userID,artiID, readed, curPage);
		// 返回页面
		req.setAttribute("splitPage", result);
		req.getRequestDispatcher("/backstage/manager/cmtMg.jsp").forward(req, resp);
	}
}
