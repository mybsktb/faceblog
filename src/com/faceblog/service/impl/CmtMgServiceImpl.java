package com.faceblog.service.impl;

import java.util.List;
import java.util.Map;

import com.faceblog.dao.CmtMgDaoInterface;
import com.faceblog.dao.impl.CmtMgDaoImpl;
import com.faceblog.entity.Comment;
import com.faceblog.entity.SplitPage;
import com.faceblog.service.CmtMgServiceInterface;

public class CmtMgServiceImpl implements CmtMgServiceInterface {
	CmtMgDaoInterface cmd = new CmtMgDaoImpl();
	@Override
	public SplitPage getComment(int userID,String artiName, String readed,int curpage) {
		// TODO Auto-generated method stub
		return cmd.getComment(userID,artiName, readed,curpage);
	}

	@Override
	public boolean insertComment(Comment comment) {
		// TODO Auto-generated method stub
		return cmd.insertComment(comment);
	}

	@Override
	public boolean deleteComment(String artiID) {
		// TODO Auto-generated method stub
		return cmd.deleteComment(artiID);
	}

	@Override
	public List<Map<String, Object>> getComment(String commentID) {
		// TODO Auto-generated method stub
		return cmd.getComment(commentID);
	}

	@Override
	public String getContent(String commentID) {
		// TODO Auto-generated method stub
		return cmd.getContent(commentID);
	}

	@Override
	public boolean updateComment(Comment comment) {
		// TODO Auto-generated method stub
		return cmd.updateComment(comment);
	}

	@Override
	public void updateComment(String commentID) {
		// TODO Auto-generated method stub
		cmd.updateComment(commentID);
	}
	
}
