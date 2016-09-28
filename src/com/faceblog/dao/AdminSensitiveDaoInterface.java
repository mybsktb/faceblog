package com.faceblog.dao;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.AdminPage;

public interface AdminSensitiveDaoInterface {
	//敏感词查询
	public abstract AdminPage selectSensitive(AdminPage page);
	//敏感词详细信息
	public abstract List<Map<String, Object>> selectSensitiveSee(int sensitiveid);
	//敏感词更新
	public abstract String SensitiveUpda(int id,String word,String time);
	//敏感词删除
	public abstract String SensitiveDele(int id);
	//敏感词增加
	public abstract String SensitiveAdd(String word,String time);
}
