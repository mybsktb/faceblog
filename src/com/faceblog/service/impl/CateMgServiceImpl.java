package com.faceblog.service.impl;

import com.faceblog.dao.CateMgDaoInterface;
import com.faceblog.dao.impl.CateMgDaoImpl;
import com.faceblog.entity.Cate;
import com.faceblog.entity.SplitPage;
import com.faceblog.service.CateMgServiceInterface;

public class CateMgServiceImpl implements CateMgServiceInterface {
	private CateMgDaoInterface cmd = new CateMgDaoImpl();
	public SplitPage getCate(Cate cate,int curPage){
		return cmd.getCate(cate,curPage);
	}
	public boolean cateDel(String cateID){
		return cmd.cateDel(cateID);
	}
	public boolean cateAdd(Cate cate){
		return cmd.cateAdd(cate);
	}
	public boolean cateUpd(Cate cate){
		return cmd.cateUpd(cate);
	}
}
