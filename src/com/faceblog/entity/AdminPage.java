package com.faceblog.entity;

import java.util.List;
import java.util.Map;
/**
 *分页实体类
 */

public class AdminPage {
	private int curpage;
	private int maxpage;
	private int curdatanum;
	private String keyword;
	private List<Map<String,Object>> curdata;
	private static int checkedsum;
	private String selec;
	
	
	
	public String getSelec() {
		return selec;
	}
	public void setSelec(String selec) {
		this.selec = selec;
	}
	public static int getCheckedsum() {
		return checkedsum;
	}
	public static void setCheckedsum(int checkedsum) {
		AdminPage.checkedsum = checkedsum;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
		
	public int getCurpage() {
		return curpage;
	}
	public void setCurpage(int curpage) {
		this.curpage = curpage;
	}
	public int getMaxpage() {
		return maxpage;
	}
	public void setMaxpage(int maxpage) {
		this.maxpage = maxpage;
	}
	public int getCurdatanum() {
		return curdatanum;
	}
	public void setCurdatanum(int curdatanum) {
		this.curdatanum = curdatanum;
	}
	public List<Map<String, Object>> getCurdata() {
		return curdata;
	}
	public void setCurdata(List<Map<String, Object>> curdata) {
		this.curdata = curdata;
	}
}
