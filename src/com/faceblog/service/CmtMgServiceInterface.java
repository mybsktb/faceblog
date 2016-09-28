package com.faceblog.service;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.Comment;
import com.faceblog.entity.SplitPage;

public interface CmtMgServiceInterface {
	SplitPage getComment(int userID,String artiName,String readed,int curpage);
	List<Map<String, Object>> getComment(String commentID);
	boolean insertComment(Comment comment);
	boolean deleteComment(String artiID);
	boolean updateComment(Comment comment);
	void updateComment(String commentID);
	public String getContent(String commentID);
}
