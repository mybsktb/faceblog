package com.faceblog.entity;

/**
 * @author 张宏举
 *
 */
public class ZHJPage {
	//最大页数
	private int maxPage;
	//当前第几页
	private int currentPage;
	//数据的数目，即行数
	private int rowCount;
	//每页的数据数目
	private int pageSize;
	//上一页
	private int previous;
	//下一页
	private int next;
	
	
	public int getPrevious() {
		return previous;
	}
	public void setPrevious(int previous) {
		this.previous = previous;
	}
	public int getNext() {
		return next;
	}
	public void setNext(int next) {
		this.next = next;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	

}
