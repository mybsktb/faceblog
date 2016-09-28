package com.faceblog.dao.impl;

import java.util.List;
import java.util.Map;

import com.faceblog.dao.AdminMgDaoInterface;
import com.faceblog.entity.Admin;
import com.faceblog.entity.User;
import com.faceblog.util.JDBCUtil;
import com.faceblog.util.StringUtil;

public class AdminMgDaoImpl implements AdminMgDaoInterface {

	private String sql = "";
	private static final String TABLE_NAME = "ADMIN_TAB";

	public static String getSql(Admin admin) {
		String result = "";
		if (admin.getAdmin_id() != -1) {
			result = result + " AND USER_ID =" + admin.getAdmin_id() + "";
			;
		}
		if (!StringUtil.isEmpty(admin.getAdmin_name()))
			result = result + " AND ADMIN_NAME ='" + admin.getAdmin_name()
					+ "'";
		if (admin.getAdmin_pwd()!=null)
			result = result + " AND ADMIN_PWD ='" + admin.getAdmin_pwd() + "'";

		return result;

	}

	@Override
	public List<Map<String, Object>> selectAdmin(Admin admin) {
		// TODO Auto-generated method stub
		sql="SELECT * FROM "+this.TABLE_NAME + " where 1=1 ";
		sql = sql+this.getSql(admin);
		List<Map<String, Object>> results=JDBCUtil.doQuery(sql);
		try {
			System.out.println(results.size());
		} catch (NullPointerException e) {
			// TODO: handle exception
			System.out.println(this.getClass()+"\t空指针异常, 搜索的到数据为空");
		}
		return results;
	}
//	public static void main(String[] args) {
//		Admin u = new Admin();
////		u.setUser_id(1);
//		u.setAdmin_name("qcm");
//		u.setAdmin_pwd("123");
//		AdminMgDaoInterface ue = new AdminMgDaoImpl();
//		System.out.println(ue.selectAdmin(u));
//	}

	@Override
	public boolean insertAdmin(Admin admin) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteAdmin(Admin admin) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateAdmin(Admin admin) {
		// TODO Auto-generated method stub
		return false;
	}

}
