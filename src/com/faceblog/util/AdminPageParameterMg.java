package com.faceblog.util;

import javax.servlet.http.HttpServletRequest;

import com.faceblog.entity.AdminPage;
/**
 * con层获取分页参数工具类
 */
public class AdminPageParameterMg {
	private static AdminPage ap = new AdminPage();

	public static AdminPage PageParameterMg(HttpServletRequest request) {
		// 获取分页参数
		String strcur = request.getParameter("curpage");
		String strcurdatanum = request.getParameter("curdatanum");
		String strkeyword = request.getParameter("keyword");
		// 参数处理
		int curpage = HtmlPara.getCurpage(strcur);
		int curdatanum = HtmlPara.getCurdatanum(strcurdatanum);
		String keyword = HtmlPara.getKeyword(strkeyword);
		// 实体类封装
		ap.setCurpage(curpage);
		ap.setCurdatanum(curdatanum);
		ap.setKeyword(keyword);
		// 返回结果
		return ap;
	}

}
