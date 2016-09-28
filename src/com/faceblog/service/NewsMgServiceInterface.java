package com.faceblog.service;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.AdminPage;

public interface NewsMgServiceInterface {
	//文章审核查询
	public abstract AdminPage AdSelectNewsMg(AdminPage page);
	//文章详细信息
	public abstract List<Map<String,Object>> AdSelectNewsMg(int newsid);
	//文章审核
	public abstract String AdSelectNewsCheck(int newsid,int check);
}
