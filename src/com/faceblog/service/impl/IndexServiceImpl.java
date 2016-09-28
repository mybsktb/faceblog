package com.faceblog.service.impl;

import com.faceblog.dao.IndexDaoInterface;
import com.faceblog.dao.impl.IndexDaoImpl;
import com.faceblog.entity.Count;
import com.faceblog.service.IndexServiceInterface;

public class IndexServiceImpl implements IndexServiceInterface{
	IndexDaoInterface id = new IndexDaoImpl();
	public Count getCount(int userID){
		return id.getCount(userID);
	}
}
