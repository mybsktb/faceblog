package com.faceblog.dao;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.Admin;

public interface AdminMgDaoInterface {
	public List<Map<String, Object>> selectAdmin(Admin admin) ;
	public boolean insertAdmin(Admin admin);
	public boolean deleteAdmin(Admin admin );
	public boolean updateAdmin(Admin admin);
}
