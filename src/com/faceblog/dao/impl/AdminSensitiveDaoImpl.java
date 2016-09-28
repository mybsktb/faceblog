/**
 * 
 */
package com.faceblog.dao.impl;

import java.util.List;
import java.util.Map;

import com.faceblog.dao.AdminSensitiveDaoInterface;
import com.faceblog.entity.AdminPage;
import com.faceblog.util.AdminPageDaoSelect;
import com.faceblog.util.JDBCUtil;

public class AdminSensitiveDaoImpl implements AdminSensitiveDaoInterface {

	@Override
	//敏感词分页查询
	public AdminPage selectSensitive(AdminPage page) {	
		int start = (page.getCurpage()-1)*page.getCurdatanum();
		String sql = "select * from sensitive_tab where word like '"+page.getKeyword()+"%' limit "+start+","+page.getCurdatanum()+"";		
		String sql2 = "select * from sensitive_tab where word like '"+page.getKeyword()+"%'";
		//工具类处理
		AdminPage pa = AdminPageDaoSelect.PageDaoSelect(page, sql, sql2);
		return pa;		
	}

	@Override
	//敏感词详细信息查询
	public List<Map<String, Object>> selectSensitiveSee(int sensitiveid) {
		String sql = "select * from sensitive_tab where sensitive_id = '"+sensitiveid+"'";
		List<Map<String, Object>> res = JDBCUtil.doQuery(sql);
		return res;
	}

	@Override
	//敏感词更新
	public String SensitiveUpda(int id, String word, String time) {
		String sql = "update sensitive_tab set word='"+word+"',createtime='"+time+"' where sensitive_id='"+id+"'";
		boolean res = JDBCUtil.doUpdate(sql);
		if(res){
			return "修改完成";
		}
		return "修改失败";
	}

	@Override
	//敏感词删除
	public String SensitiveDele(int id) {
		String sql = "delete from sensitive_tab where sensitive_id='"+id+"'";
		boolean res = JDBCUtil.doUpdate(sql);
		if(res){
			return "删除完成";
		}
		return "删除失败";
	}

	@Override
	//增加敏感词
	public String SensitiveAdd(String word, String time) {
		String sql = "insert into sensitive_tab (word,createtime) values('"+word+"','"+time+"')";
		boolean res = JDBCUtil.doUpdate(sql);
		if(res){
			return "新增成功";
		}
		return "新增失败";
	}

}
