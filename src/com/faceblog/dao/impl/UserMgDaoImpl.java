package com.faceblog.dao.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import com.faceblog.dao.UserMgDaoInterface;
import com.faceblog.entity.User;
import com.faceblog.util.JDBCUtil;
import com.faceblog.util.StringUtil;

public class UserMgDaoImpl implements UserMgDaoInterface {
	private String sql = "";
	private static final String TABLE_NAME = "USER_TAB";

	public static String getSql(User user) {
		String result = "";
		if (user.getUser_id() != -1) {
			result = result + " AND USER_ID =" + user.getUser_id() + "";
			;
		}
		if (!StringUtil.isEmpty(user.getUser_name()))
			result = result + " AND USER_NAME ='" + user.getUser_name() + "'";
		if (user.getUser_pwd() != null)
			result = result + " AND USER_PWD ='" + user.getUser_pwd() + "'";
		if (user.getUser_answer() != null)
			result = result + " AND USER_ANSWER ='" + user.getUser_answer()
					+ "'";

		return result;

	}

	@Override
	public List<Map<String, Object>> selectUser(User user) {
		// TODO Auto-generated method stub
		sql = "SELECT * FROM " + this.TABLE_NAME + " WHERE 1=1 ";
		sql += getSql(user);
		return JDBCUtil.doQuery(sql);
	}

	public static void main(String[] args) {
		User u = new User();
		u.setUser_id(1);
		// u.setUser_name("qcm");

		UserMgDaoImpl ue = new UserMgDaoImpl();
		// System.out.println(ue.selectUser(u));

		ue.setUserVisitor(u, "25");

	}
	
	@Override
	public boolean insertUser(User user) {
		// TODO Auto-generated method stub
		int questionid = Integer.parseInt(user.getUser_questionid());
		int question = (int) questionid;

		sql = "INSERT INTO USER_TAB  (USER_ICON,USER_NAME,USER_PWD,USER_QUESTIONID,USER_ANSWER,USER_MOTTO,USER_JOB,USER_HOMETOWN,USER_EMAIL,USER_TELE,USER_INTRO) VALUES ('"
				+ user.getUser_icon()
				+ "','"
				+ user.getUser_name()
				+ "','"
				+ user.getUser_pwd()
				+ "',"
				+ question
				+ ",'"
				+ user.getUser_answer()
				+ "','"
				+ user.getUser_motto()
				+ "','"
				+ user.getUser_job()
				+ "','"
				+ user.getUser_homtown()
				+ "','"
				+ user.getUser_email()
				+ "','"
				+ user.getUser_tele()
				+ "','"
				+ user.getUser_intro() + "')";
		System.out.println(sql);
		return JDBCUtil.doUpdate(sql);
	}

	@Override
	public boolean deleteUser(User user) {
		// TODO Auto-generated method stub
		String sql = "update " + this.TABLE_NAME + " set user_job = '"
				+ user.getUser_job() + "',user_hometown ='"
				+ user.getUser_homtown() + "',user_tele = '"
				+ user.getUser_tele() + "',user_email = '"
				+ user.getUser_email() + "',user_motto = '"
				+ user.getUser_motto() + "',user_intro = '"
				+ user.getUser_intro() + "' where user_id = "
				+ user.getUser_id();
		return JDBCUtil.doUpdate(sql);
	}

	/**
	 * 模式1. 通过用户名重置密码 2.
	 * */
	@Override
	public boolean updateUser(User user, int mode) {
		// TODO Auto-generated method stub
		// UPDATE user_tab SET USER_PWD='123456' WHERE USER_NAME='qcm'
		sql = "UPDATE " + this.TABLE_NAME;
		if (mode == 1) {
			sql = sql + " SET USER_PWD='123456' WHERE USER_NAME='"
					+ user.getUser_name() + "'";
		}
		System.out.println(sql);

		return JDBCUtil.doUpdate(sql);
	}

	/* (non-Javadoc)
	 * @see com.faceblog.dao.UserMgDaoInterface#updateUser(com.faceblog.entity.User)
	 * 修改用户信息
	 */
	@Override
	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		String sql;
		String pwd = user.getUser_pwd();
		if (pwd != null) {
			sql = "update user_tab set user_pwd='" + pwd + "' where user_id="
					+ user.getUser_id();
		} else {
			sql = "update user_tab set user_job='" + user.getUser_job()
					+ "',user_hometown='" + user.getUser_homtown()
					+ "',user_tele= '" + user.getUser_tele()
					+ "', user_email='" + user.getUser_email()
					+ "',user_motto='" + user.getUser_motto()
					+ "',user_intro='" + user.getUser_intro()
					+ "',user_icon='" + user.getUser_icon()
					+ "' where user_id=" + user.getUser_id();
		}
		return JDBCUtil.doUpdate(sql);
	}

	@Override
	public User getUserInfoByUserId(User _user) {
		if (_user == null) {
			return null;
		}
		int userId = _user.getUser_id();
		if (userId == -1) {
			return null;
		}
		String sql = "SELECT USER_ID,USER_NAME,USER_MOTTO,USER_JOB,USER_HOMETOWN,USER_TELE,USER_EMAIL,USER_ICON,USER_INTRO"
				+ " FROM USER_TAB WHERE USER_ID='" + userId + "'";
		User user = new User();
		List<Map<String, Object>> results = JDBCUtil.doQuery(sql);
		if (results == null) {
			return null;
		}

		Map<String, Object> map = results.get(0);
		user.setUser_id((Integer) map.get("USER_ID"));
		user.setUser_name((String) map.get("USER_NAME"));
		user.setUser_motto((String) map.get("USER_MOTTO"));
		user.setUser_job((String) map.get("USER_JOB"));
		user.setUser_homtown((String) map.get("USER_HOMETOWN"));
		user.setUser_tele((String) map.get("USER_TELE"));
		user.setUser_email((String) map.get("USER_EMAIL"));
		user.setUser_intro((String) map.get("USER_INTRO"));
		user.setUser_icon((String) map.get("USER_ICON"));

		return user;
	}

	@Override
	public User getUserId(String userName) {
		// TODO Auto-generated method stub
		sql = "SELECT * FROM " + this.TABLE_NAME + " WHERE USER_NAME = '"
				+ userName + "'";
		System.out.println(sql);
		List<Map<String, Object>> results = JDBCUtil.doQuery(sql);
		int userid = Integer.parseInt(results.get(0).get("USER_ID").toString());
		System.out.println(userid);
		User user = new User();
		user.setUser_name(userName);
		user.setUser_id(Integer.parseInt(results.get(0).get("USER_ID")
				.toString()));
		user.setUser_motto(results.get(0).get("USER_MOTTO").toString());
		user.setUser_job(results.get(0).get("USER_JOB").toString());
		user.setUser_homtown(results.get(0).get("USER_HOMETOWN").toString());
		user.setUser_tele(results.get(0).get("USER_TELE").toString());
		user.setUser_email(results.get(0).get("USER_EMAIL").toString());
		user.setUser_icon(results.get(0).get("USER_ICON").toString());
		System.out.println(user.toString());
		// user.setUser_Name((results.get(0).get("USER_ID").toString()));

		return user;
	}

	@Override
	public void setUserVisitor(User user, String visitor) {
		// TODO Auto-generated method stub
		// 1. is it full?
		int[] visitors = getUserVisitor(user);

		int v;
		if (!StringUtil.isEmpty(visitor))
			v = Integer.parseInt(visitor.trim());
		else {
			System.out.println("visitor is null");
			return;
		}
		if (v == visitors[0])
			return;
		visitors=insertVisitor(visitors, v);
		String result = "";
		for (int i : visitors) {
			result += i + ",";
		}
		result = result.substring(0, result.length() - 1);
		System.out.println(result);
		sql = "UPDATE USER_TAB SET USER_VISITOR='" + result
				+ "' WHERE USER_ID = " + user.getUser_id();
		System.out.println(sql);
		JDBCUtil.doUpdate(sql);

	}

	@Override
	public int[] getUserVisitor(User user) {
		// TODO Auto-generated method stub
		sql = "SELECT USER_VISITOR FROM USER_TAB WHERE USER_ID="
				+ user.getUser_id();
		List<Map<String, Object>> results = JDBCUtil.doQuery(sql);
		Map<String, Object> result;
		String visitor = "";
		try {
			result = results.get(0);
			visitor = result.get("USER_VISITOR").toString();
		} catch (IndexOutOfBoundsException e) {
			// TODO: handle exception
			System.out.println("index out of bounds exception ");
		}
		String visitors[] = visitor.split(",");
		int resultInt[] = new int[24];
		for (int i = 0; i < visitors.length; i++) {
			resultInt[i] = Integer.parseInt(visitors[i]);
		}
		return resultInt;
	}

	

	public static int[] insertVisitor(int[] h,int v) {
		int index = -1;
		// 1. if it's new, add to the first place
		for (int i = 0; i < h.length; i++) {
			if (v == h[i]) {
				index = i;
			}
		}

		for (int i = index != -1 ? index : h.length - 1; i >= 1; i--) {
			h[i] = h[i - 1];
		}
		h[0] = v;
		return h;
		
	}
}
