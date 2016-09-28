package com.faceblog.service.impl;

import java.util.List;
import java.util.Map;

import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.dao.impl.NewsMgDaoImpl;
import com.faceblog.entity.AdminPage;
import com.faceblog.service.NewsMgServiceInterface;

public class NewsMgServiceImpl implements NewsMgServiceInterface {
	NewsMgDaoInterface nm = new NewsMgDaoImpl();

	@Override
	//文章审核查询
	public AdminPage AdSelectNewsMg(AdminPage page) {
		return nm.AdSelectNewsMg(page);
	}

	@Override
	//文章审核
	public String AdSelectNewsCheck(int newsid, int check) {
		return nm.AdSelectNewsCheck(newsid, check);
	}

	@Override
	//文章详细信息
	public List<Map<String, Object>> AdSelectNewsMg(int newsid) {
		return nm.AdSelectNewsMg(newsid);
	}

}
