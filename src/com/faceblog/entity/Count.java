package com.faceblog.entity;

public class Count {
	// 通过审查文章数
	private int checkOk;
	// 未通过文章数
	private int checkFalse;
	// 未审查文章数
	private int unCheck;
	// 推荐文章数
	private int recommend;
	// 被举报文章数
	private int checkReport;
	// 未阅读评论数
	private int unSeeComment;

	public int getCheckOk() {
		return checkOk;
	}

	public void setCheckOk(int checkOk) {
		this.checkOk = checkOk;
	}

	public int getCheckFalse() {
		return checkFalse;
	}

	public void setCheckFalse(int checkFalse) {
		this.checkFalse = checkFalse;
	}

	public int getUnCheck() {
		return unCheck;
	}

	public void setUnCheck(int unCheck) {
		this.unCheck = unCheck;
	}

	public int getCheckReport() {
		return checkReport;
	}

	public void setCheckReport(int checkReport) {
		this.checkReport = checkReport;
	}

	public int getUnSeeComment() {
		return unSeeComment;
	}

	public void setUnSeeComment(int unSeeComment) {
		this.unSeeComment = unSeeComment;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}

}
