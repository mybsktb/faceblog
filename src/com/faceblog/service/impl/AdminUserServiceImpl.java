package com.faceblog.service.impl;

import com.faceblog.dao.AdminUserDaoInterface;
import com.faceblog.dao.impl.AdminUserDaoImpl;
import com.faceblog.entity.AdminPage;
import com.faceblog.entity.User;
import com.faceblog.service.AdminUserServiceInterface;

public class AdminUserServiceImpl implements AdminUserServiceInterface {
	AdminUserDaoInterface ad = new AdminUserDaoImpl();

	@Override
	//用户增加
	public String useradd(User user) {
		return ad.useradd(user);
	}

	@Override
	//用户管理
	public AdminPage usermg(AdminPage page) {
		return ad.usermg(page);
	}

	@Override
	//用户删除
	public String userdele(int userid, int flag) {
		return ad.userdele(userid, flag);
	}

	@Override
	//管理员改密码
	public String chanpwd(int adid, String oldpwd, String newpwd, String newpwd2) {
		return ad.chanpwd(adid, oldpwd, newpwd, newpwd2);
	}

}
