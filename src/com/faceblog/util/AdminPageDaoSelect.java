package com.faceblog.util;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.AdminPage;
/**
 * Dao层分页查询工具类
 */
public class AdminPageDaoSelect {
	private static AdminPage pa = new AdminPage();
	public static AdminPage PageDaoSelect(AdminPage page,String sql,String sql2){
		//获取当前页，关键词，当前展示数据，和数据行数
		List<Map<String, Object>> res = JDBCUtil.doQuery(sql);
		pa.setCurdata(res);
		pa.setCurpage(page.getCurpage());
		pa.setCurdatanum(page.getCurdatanum());
		pa.setKeyword(page.getKeyword());
		//获取最大页
		List<Map<String, Object>> res2 = JDBCUtil.doQuery(sql2);
		int maxpage = res2.size()%page.getCurdatanum() == 0 ? res2.size()/page.getCurdatanum():res2.size()/page.getCurdatanum()+1;
		pa.setMaxpage(maxpage);
		return pa;	
	}
}
