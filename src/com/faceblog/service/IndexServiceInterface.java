package com.faceblog.service;

import com.faceblog.entity.Count;

public interface IndexServiceInterface {
	Count getCount(int userID);
}
