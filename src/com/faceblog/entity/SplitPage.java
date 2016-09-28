package com.faceblog.entity;

import java.util.List;
import java.util.Map;

import com.faceblog.common.Const;

public class SplitPage {
	//总页数
	private int maxPage;
	//当前页
	private int curPage;
	//总数据数
	private int totalNum;
	//每页数据树
	private int pageSize;
	//当前页数据
	List<Map<String,Object>> data;
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getCurPage() {
		if(curPage<1)
			curPage=1;
		if(curPage>maxPage)
			curPage=maxPage;
			
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}
	public int getPageSize() {
		if(pageSize==0)
			pageSize=Const.PAGE_SIZE;
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public List<Map<String, Object>> getData() {
		return data;
	}
	public void setData(List<Map<String, Object>> data) {
		this.data = data;
	}
	
}
