package com.faceblog.dao;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.Article;
import com.faceblog.entity.Assess;
import com.faceblog.entity.User;

public interface AssessDaoInterface {
	public List<Map<String, Object>> selectAssess(Assess assess);

	// 根据用户获得他的评论 by qcm
	public List<Map<String, Object>> selectAssessByUser(User user);
	// 根据文章获取评论过这篇文章的用户 by qcm
	public List<Map<String, Object>> selectAssessByArti(Article article);
	// 根据用户获得推荐文章
	public List<Double[]> getUserSort(User user) ;
	
	public boolean insertAssess(Assess assess);

	public boolean deleteAssess(Assess assess);

	public boolean updateAssess(Assess assess);
}
