package com.faceblog.dao;

import com.faceblog.entity.Count;

public interface IndexDaoInterface {
	Count getCount(int userID);
}
