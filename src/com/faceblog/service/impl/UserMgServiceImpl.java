package com.faceblog.service.impl;

import java.util.List;
import java.util.Map;

import com.faceblog.dao.impl.UserMgDaoImpl;
import com.faceblog.entity.User;
import com.faceblog.service.UserMgServiceInterface;

public class UserMgServiceImpl implements UserMgServiceInterface{
	UserMgDaoImpl umdi =new UserMgDaoImpl();
	@Override
	public List<Map<String, Object>> selectUser(User user) {
		// TODO Auto-generated method stub
		return umdi.selectUser(user);
	}

	@Override
	public boolean insertUser(User user) {
		// TODO Auto-generated method stub
		return umdi.insertUser(user);
	}

	@Override
	public boolean deleteUser(User user) {
		// TODO Auto-generated method stub
		return umdi.deleteUser(user);
	}

	@Override
	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		return umdi.updateUser(user);
	}
	public User getUserInfoByUserId(User user){
		return umdi.getUserInfoByUserId(user);
	}

}
