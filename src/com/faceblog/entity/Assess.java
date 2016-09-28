package com.faceblog.entity;

public class Assess {
	private int assessId;
	private int assessUserId;
	private int assessArtiId;
	private float assessReaded = 0;
	private float assessAgree = 0;
	private float assessDisagree = 0;
	private float assessComment = 0;
	private float assessCopy = 0;
	private float assessTired = 0;

	public int getAssessId() {
		return assessId;
	}

	public void setAssessId(int assessId) {
		this.assessId = assessId;
	}

	public int getAssessUserId() {
		return assessUserId;
	}

	public void setAssessUserId(int assessUserId) {
		this.assessUserId = assessUserId;
	}

	public int getAssessArtiId() {
		return assessArtiId;
	}

	public void setAssessArtiId(int assessArtiId) {
		this.assessArtiId = assessArtiId;
	}

	public float getAssessReaded() {
		return assessReaded;
	}

	public void setAssessReaded(float assessReaded) {
		if (assessReaded == 0) {
			this.assessReaded = 0;
		} else {
			this.assessReaded = 1;
		}

	}

	public float getAssessAgree() {
		return assessAgree;
	}

	public void setAssessAgree(float assessAgree) {
		if (assessAgree == 0) {
			this.assessAgree = 0;
		} else {
			this.assessAgree = 2;
		}
	}

	public float getAssessDisagree() {
		return assessDisagree;
	}

	public void setAssessDisagree(float assessDisagree) {
		if (assessDisagree == 0) {
			this.assessDisagree = 0;
		} else {
			this.assessDisagree = -2;
		}
	}

	public float getAssessComment() {
		return assessComment;
	}

	public void setAssessComment(float assessComment) {
		if (assessComment == 0) {
			this.assessComment = 0;
		} else {
			this.assessComment = 0.5f;
		}
	}

	public float getAssessCopy() {
		return assessCopy;
	}

	public void setAssessCopy(float assessCopy) {
		if (assessCopy == 0) {
			this.assessCopy = 0;
		} else {
			this.assessCopy = 4;
		}
	}

	public float getAssessTired() {
		return assessTired;
	}

	public void setAssessTired(float assessTired) {
		if (assessTired == 0) {
			this.assessTired = 0;
		} else {
			this.assessTired = -0.5f;
		}
	}

}
