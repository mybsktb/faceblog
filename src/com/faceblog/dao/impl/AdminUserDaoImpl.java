package com.faceblog.dao.impl;

import com.faceblog.dao.AdminUserDaoInterface;
import com.faceblog.entity.AdminPage;
import com.faceblog.entity.User;
import com.faceblog.util.AdminPageDaoSelect;
import com.faceblog.util.JDBCUtil;
import com.faceblog.util.StringUtil;

public class AdminUserDaoImpl implements AdminUserDaoInterface {

	@Override
	//增加用户
	public String useradd(User user) {
		//用户名不能重复
		String sqlsele = "select * from user_tab where user_name='"+user.getUser_name()+"'";
		if(JDBCUtil.doQuery(sqlsele).size()>=1){
			return "该用户名已存在";
		}
				
		String sql = "insert into user_tab (USER_NAME) values('"+user.getUser_name()+"')";
		boolean res = JDBCUtil.doUpdate(sql);
		if(!StringUtil.isEmpty(user.getUser_pwd())){
			JDBCUtil.doUpdate("update user_tab set USER_PWD = '"+user.getUser_pwd()+"' where user_name = '"+user.getUser_name()+"'");
		}
		if(!StringUtil.isEmpty(user.getUser_question())){
			int quest = 1;
			String sql2 = "insert into question_tab(question_content) values('"+user.getUser_question()+"')";			
			if(JDBCUtil.doUpdate(sql2)){
				String sql_ques = "select * from question_tab where question_content='"+user.getUser_question()+"'";
				quest = (Integer)JDBCUtil.doQuery(sql_ques).get(0).get("QUESTION_ID");
				}
			JDBCUtil.doUpdate("update user_tab set USER_QUESTIONID = '"+quest+"' where user_name = '"+user.getUser_name()+"'");
		}
		if(!StringUtil.isEmpty(user.getUser_answer())){
			JDBCUtil.doUpdate("update user_tab set USER_ANSWER = '"+user.getUser_answer()+"' where user_name = '"+user.getUser_name()+"'");
		}
		if(!StringUtil.isEmpty(user.getUser_motto())){
			JDBCUtil.doUpdate("update user_tab set USER_MOTTO = '"+user.getUser_motto()+"' where user_name = '"+user.getUser_name()+"'");
		}
		if(!StringUtil.isEmpty(user.getUser_job())){
			JDBCUtil.doUpdate("update user_tab set USER_JOB = '"+user.getUser_job()+"' where user_name = '"+user.getUser_name()+"'");
		}
		if(!StringUtil.isEmpty(user.getUser_homtown())){
			JDBCUtil.doUpdate("update user_tab set USER_HOMETOWN = '"+user.getUser_homtown()+"' where user_name = '"+user.getUser_name()+"'");
		}
		if(!StringUtil.isEmpty(user.getUser_tele())){
			JDBCUtil.doUpdate("update user_tab set USER_TELE = '"+user.getUser_tele()+"' where user_name = '"+user.getUser_name()+"'");
		}
		if(!StringUtil.isEmpty(user.getUser_email())){
			JDBCUtil.doUpdate("update user_tab set USER_EMAIL = '"+user.getUser_email()+"' where user_name = '"+user.getUser_name()+"'");
		}
		if(!StringUtil.isEmpty(user.getUser_intro())){
			JDBCUtil.doUpdate("update user_tab set USER_INTRO = '"+user.getUser_intro()+"' where user_name = '"+user.getUser_name()+"'");
		}
				
		if(res){
			return "增加用户成功";
		}
		return "增加用户失败";
	}

	@Override
	//用户管理
	public AdminPage usermg(AdminPage page) {		
		int start = (page.getCurpage()-1)*page.getCurdatanum();
		String sql = "select a.*,b.question_content from user_tab a,question_tab b where a.user_questionid=b.question_id and user_name like '"+page.getKeyword()+"%' limit "+start+","+page.getCurdatanum()+"";	
		String sql2 = "select * from user_tab where user_name like '"+page.getKeyword()+"%'";
		//工具类处理
		AdminPage pa = AdminPageDaoSelect.PageDaoSelect(page, sql, sql2);
		return pa;
	}

	@Override
	//用户信息重置和删除
	public String userdele(int userid, int flag) {
		if(flag==1){
			String sql = "update user_tab set user_pwd=123456,user_questionid=1,user_answer=123456,user_motto=null,USER_JOB=null,USER_HOMETOWN=null,USER_TELE=null,USER_EMAIL=null,USER_INTRO=null where user_id='"+userid+"'";
			boolean res = JDBCUtil.doUpdate(sql);
			if(res){			
				return "重置成功";
			}
			return "重置失败";
		}
		if(flag==2){
			String sql2 = "delete from user_tab where user_id='"+userid+"'";
			boolean res = JDBCUtil.doUpdate(sql2);
			if(res){
				return "删除成功";
			}
			return "删除失败";
		}
		return "操作失败";
	}

	@Override
	//管理员修改密码
	public String chanpwd(int adid,String oldpwd, String newpwd, String newpwd2) {
		String sql = "select admin_pwd from admin_tab where admin_id = '"+adid+"'";
		if(oldpwd.equals(JDBCUtil.doQuery(sql).get(0).get("admin_pwd"))){
			if(newpwd.equals(newpwd2)){
				String sql2 = "update admin_tab set admin_pwd='"+newpwd+"' where admin_id = '"+adid+"'";
				boolean res = JDBCUtil.doUpdate(sql2);
				if(res){
					return "修改成功";
				}
			}else{
				return "两次密码不一致";
			}
		}else{
			return "原密码不正确";
		}
		
		return "操作失败";
	}
}
