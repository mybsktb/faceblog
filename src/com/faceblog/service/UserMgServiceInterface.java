package com.faceblog.service;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.User;

public interface UserMgServiceInterface {
	public List<Map<String, Object>> selectUser(User user) ;
	public boolean insertUser(User user);
	public boolean deleteUser(User user );
	public boolean updateUser(User user);
	public User getUserInfoByUserId(User user);
}
