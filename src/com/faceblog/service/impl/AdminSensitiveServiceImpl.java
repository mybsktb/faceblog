package com.faceblog.service.impl;

import java.util.List;
import java.util.Map;

import com.faceblog.dao.AdminSensitiveDaoInterface;
import com.faceblog.dao.impl.AdminSensitiveDaoImpl;
import com.faceblog.entity.AdminPage;
import com.faceblog.service.AdminSensitiveServiceInterface;

public class AdminSensitiveServiceImpl implements
		AdminSensitiveServiceInterface {
	AdminSensitiveDaoInterface ad = new AdminSensitiveDaoImpl();

	@Override
	//敏感词查询
	public AdminPage selectSensitive(AdminPage page) {
		return ad.selectSensitive(page);
	}

	@Override
	//敏感词详细信息
	public List<Map<String, Object>> selectSensitiveSee(int sensitiveid) {
		return ad.selectSensitiveSee(sensitiveid);
	}

	@Override
	//敏感词更新
	public String SensitiveUpda(int id, String word, String time) {
		return ad.SensitiveUpda(id, word, time);
	}

	@Override
	//敏感词删除
	public String SensitiveDele(int id) {
		return ad.SensitiveDele(id);
	}

	@Override
	//敏感词增加
	public String SensitiveAdd(String word, String time) {
		return ad.SensitiveAdd(word, time);
	}

}
