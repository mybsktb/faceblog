package com.faceblog.entity;

public class Article {
	//文章默认ID设置为-1，是找不到的，如果人为设置为大于0的则可以找到
	private int art__id = -1;
	private String art_name;
	private int cate_id=-1;
	private String art_createtime;
	private String art_updatetime;
	private int user_id=-1;
	private int art_ctr;
	private String art_keyword;
	private String art_content;
	private int art_check;
	private String art_abstract;
	private int art_recommend;
	private String atr_author;

	public String getAtr_author() {
		return atr_author;
	}

	public void setAtr_author(String atrAuthor) {
		atr_author = atrAuthor;
	}

	public int getArt__id() {
		return art__id;
	}

	public void setArt__id(int art__id) {
		this.art__id = art__id;
	}

	public String getArt_name() {
		return art_name;
	}

	public void setArt_name(String art_name) {
		this.art_name = art_name;
	}

	public int getCate_id() {
		return cate_id;
	}

	public void setCate_id(int cate_id) {
		this.cate_id = cate_id;
	}

	public String getArt_createtime() {
		return art_createtime;
	}

	public void setArt_createtime(String art_createtime) {
		this.art_createtime = art_createtime;
	}

	public String getArt_updatetime() {
		return art_updatetime;
	}

	public void setArt_updatetime(String art_updatetime) {
		this.art_updatetime = art_updatetime;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getArt_ctr() {
		return art_ctr;
	}

	public void setArt_ctr(int art_ctr) {
		this.art_ctr = art_ctr;
	}

	public String getArt_keyword() {
		return art_keyword;
	}

	public void setArt_keyword(String art_keyword) {
		this.art_keyword = art_keyword;
	}

	public String getArt_content() {
		return art_content;
	}

	public void setArt_content(String art_content) {
		this.art_content = art_content;
	}

	public int getArt_check() {
		return art_check;
	}

	public void setArt_check(int art_check) {
		this.art_check = art_check;
	}

	public String getArt_abstract() {
		return art_abstract;
	}

	public void setArt_abstract(String art_abstract) {
		this.art_abstract = art_abstract;
	}

	public int getArt_recommend() {
		return art_recommend;
	}

	public void setArt_recommend(int art_recommend) {
		this.art_recommend = art_recommend;
	}

}
