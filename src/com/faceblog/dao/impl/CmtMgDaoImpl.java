package com.faceblog.dao.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.faceblog.common.Const;
import com.faceblog.dao.CmtMgDaoInterface;
import com.faceblog.entity.Comment;
import com.faceblog.entity.SplitPage;
import com.faceblog.util.JDBCUtil;
import com.faceblog.util.StringUtil;

public class CmtMgDaoImpl implements CmtMgDaoInterface {

	/* (non-Javadoc)
	 * @see com.faceblog.dao.CmtMgDaoInterface#getComment(int, java.lang.String, java.lang.String, int)
	 * 根据参数获取相应的评论
	 */
	@Override
	public SplitPage getComment(int userID, String artiID, String readed, int curPage) {
		// TODO Auto-generated method stub
		SplitPage sp = new SplitPage();
		// 查询所有符合条件的评论
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		String sql = "select u.user_name,c.comment_id,a.arti_id,a.arti_name,c.comment_content,c.comment_commid,c.comment_fromuserid from arti_tab a,comment_tab c,user_tab u where a.arti_id=c.comment_artiid and u.user_id=c.comment_fromuserid ";
		if (!StringUtil.isEmpty(artiID))
			sql += "and c.comment_artiid ="+artiID;
		if (!StringUtil.isEmpty(readed)){
			sql += "and c.comment_readed = " + readed;
		}
		sql+= " and c.comment_userid="+ userID+" and c.comment_commid=0 order by c.comment_time desc";
		result = JDBCUtil.doQuery(sql);
		// 数据为空则返回空的SplitPage
		if (result == null) {
			return sp;
		}
		// 数据总条数
		int totalNum = result.size();
		sp.setTotalNum(totalNum);
		// 每页数据条数
		int pageSize = Const.PAGE_SIZE;
		sp.setPageSize(pageSize);
		// 最大页数
		int maxPage = totalNum % pageSize == 0 ? (totalNum / pageSize)
				: (totalNum / pageSize + 1);
		sp.setMaxPage(maxPage);
		// 当前页面
		if (curPage < 1)
			curPage = 1;
		if (curPage > maxPage)
			curPage = maxPage;
		sp.setCurPage(curPage);
		// 当前页面数据
		int startNum = (curPage - 1) * pageSize;
		String newSql = sql + " limit " + startNum + "," + pageSize;
		List<Map<String, Object>> data = JDBCUtil.doQuery(newSql);
		sp.setData(data);

		return sp;
	}

	/* (non-Javadoc)
	 * @see com.faceblog.dao.CmtMgDaoInterface#insertComment(com.faceblog.entity.Comment)
	 * 添加评论回复
	 */
	@Override
	public boolean insertComment(Comment comment) {
		// TODO Auto-generated method stub
		//获取当前时间
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		String date = sdf.format(new Date());
		String sql = "insert into comment_tab(comment_userid,comment_content,comment_time,comment_check,comment_artiid,comment_readed,comment_commid,comment_fromuserid) value("
				+ comment.getComment_userid()
				+ ",'"
				+ comment.getComment_content()
				+ "','"
				+ date
				+ "',0,"
				+ comment.getComment_artiid()
				+ ",0,"
				+ comment.getComment_commid()
				+ ","
				+ comment.getComment_fromuserid() + ")";
		return JDBCUtil.doUpdate(sql);
	}

	/* (non-Javadoc)
	 * @see com.faceblog.dao.CmtMgDaoInterface#deleteComment(java.lang.String)
	 * 根据ID删除评论
	 */
	@Override
	public boolean deleteComment(String commentID) {
		// TODO Auto-generated method stub
		String sql = "delete from comment_tab where comment_id in ("+commentID+")";
		return JDBCUtil.doUpdate(sql); 
	}

	/* (non-Javadoc)
	 * @see com.faceblog.dao.CmtMgDaoInterface#getComment(java.lang.String)
	 * 根据评论ID获取评论信息
	 */
	@Override
	public List<Map<String, Object>> getComment(String commentID) {
		// TODO Auto-generated method stub
		String sql = "select u.user_name,c.comment_id,a.arti_id,a.arti_name,c.comment_content,c.comment_commid,c.comment_fromuserid from arti_tab a,comment_tab c,user_tab u where a.arti_id=c.comment_artiid and u.user_id=c.comment_fromuserid ";
		sql+= " and c.comment_id="+commentID;
		return JDBCUtil.doQuery(sql);
	}
	public String getContent(String commentID){
		String sql = "select comment_content from comment_tab where comment_commid="+commentID;
		List<Map<String, Object>> result = JDBCUtil.doQuery(sql); 
		if(result!=null&&result.size()>0)
			return result.get(0).get("comment_content").toString();
		else 
			return null;
	}

	
	/* (non-Javadoc)
	 * @see com.faceblog.dao.CmtMgDaoInterface#updateComment(com.faceblog.entity.Comment)
	 * 评论回复的修改
	 */
	@Override
	public boolean updateComment(Comment comment) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		String date = sdf.format(new Date());
		String sql = "update comment_tab set comment_content = '"+comment.getComment_content()+"',comment_time='"+date+"' where comment_commid = "+comment.getComment_id();
		return JDBCUtil.doUpdate(sql);
	}

	@Override
	public void updateComment(String commentID) {
		// TODO Auto-generated method stub
		String changeSql = "update comment_tab set comment_readed = 1 where comment_id = "+commentID;
		JDBCUtil.doUpdate(changeSql);
		
	}
}
