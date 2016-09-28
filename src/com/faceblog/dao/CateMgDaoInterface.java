package com.faceblog.dao;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.Cate;
import com.faceblog.entity.SplitPage;

public interface CateMgDaoInterface {
	public SplitPage getCate(Cate cate,int curPage);
	public boolean cateDel(String cateID);
	public boolean cateAdd(Cate cate);
	public boolean cateUpd(Cate cate);
	public List<Map<String, Object>> cateSel(Cate cate);
	/**
	 * 查询所有栏目
	 */
	public List<Map<String,Object>> selectCate(int userId);
}
