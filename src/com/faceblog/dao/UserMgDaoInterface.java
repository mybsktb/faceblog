package com.faceblog.dao;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.User;

public interface UserMgDaoInterface {
		public List<Map<String, Object>> selectUser(User user) ;
		public boolean insertUser(User user);
		public boolean deleteUser(User user );
		public boolean updateUser(User user,int mode);
		public boolean updateUser(User user);
		/** 通过用户名获取用户信息*/
		public User getUserInfoByUserId(User user);
		/** 输入用户名获得用户对象*/
		public User getUserId(String userName);
		/** 添加最近访客记录*/
		public void setUserVisitor(User user,String visitor);
		/** 获得最近访客*/
		public int[] getUserVisitor(User user);
		
}