package com.faceblog.service;

import com.faceblog.entity.AdminPage;
import com.faceblog.entity.User;

public interface AdminUserServiceInterface {
	//用户增加
	public abstract String useradd(User user);
	//用户管理
	public abstract AdminPage usermg(AdminPage page);
	//用户删除和重置
	public abstract String userdele(int userid,int flag);
	//管理员改密码
	public abstract String chanpwd(int adid,String oldpwd,String newpwd,String newpwd2);
}
