package com.faceblog.service;

import com.faceblog.entity.Cate;
import com.faceblog.entity.SplitPage;

public interface CateMgServiceInterface {
	SplitPage getCate(Cate cate,int curPage);
	boolean cateDel(String cateID);
	boolean cateAdd(Cate cate);
	boolean cateUpd(Cate cate);
}
