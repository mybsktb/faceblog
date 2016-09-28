package com.faceblog.entity;

import java.util.List;
import java.util.Map;

/**
 * 页面实体
 * */

public class Page {
	private int totalPage = 0;// 总共页数
	private int currentPage = 1;// 当前页
	private int totalNumber = 1;// 总共的项数
	private int pageSize = 6;// 每页多少项
	private List<Map<String, Object>> data = null;// result集

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrtentPage(int currentPage) {
		// 设置当前页时，若为负数，则设置为1
		if (currentPage <= 0) {
			this.currentPage = 1;
			return;
		}
		// 若总页数不为0（默认值），且当前页大于总页数时，设置当前页为总页数
		if (totalPage != 0 && currentPage > totalPage) {
			this.currentPage = totalPage;
			return;
		}
		// 否则，当前页参数正常设置
		this.currentPage = currentPage;
	}

	public int getTotalNumber() {
		return totalNumber;
	}

	public void setTotalNumber(int totalNumber) {
		// 总的项数不得小于等于0，最少设置成1
		if (totalNumber <= 0) {
			this.totalNumber = 1;
			return;
		}
		this.totalNumber = totalNumber;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		// 每页项数不得小于等于0，否则设置成6；
		if (pageSize <= 0) {
			pageSize = 6;
			return;
		}
		this.pageSize = pageSize;
	}

	public List<Map<String, Object>> getData() {
		return data;
	}

	public void setData(List<Map<String, Object>> data) {
		this.data = data;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		// 总的页面不得小于等于0，否则设置为1
		if (totalPage <= 0) {
			this.totalPage = 1;
			return;
		}
		this.totalPage = totalPage;
	}
}
