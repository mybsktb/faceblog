package com.faceblog.dao.impl;

import java.util.List;
import java.util.Map;

import com.faceblog.dao.IndexDaoInterface;
import com.faceblog.entity.Count;
import com.faceblog.util.JDBCUtil;

public class IndexDaoImpl implements IndexDaoInterface {

	/*
	 * (non-Javadoc)
	 * @see com.faceblog.dao.IndexDaoInterface#getCount(int) 获取相应的文章分类数量
	 */
	public Count getCount(int userID) {
		Count count = new Count();
		// 未审核文章数
		String sql = "select count(*) count from arti_tab where arti_check = 0 and arti_userid="
				+ userID;
		count.setUnCheck(getNumber(sql));
		// 通过审核文章数
		sql = "select count(*) count from arti_tab where arti_check = 1 and arti_userid="
				+ userID;
		count.setCheckOk(getNumber(sql));
		// 未通过审核文章数
		sql = "select count(*) count from arti_tab where arti_check = -1 and arti_userid="
				+ userID;
		count.setCheckFalse(getNumber(sql));
		// 推荐文章数
		sql = "select count(*) count from arti_tab where arti_recommend = 1 and arti_userid="
				+ userID;
		count.setRecommend(getNumber(sql));
		// 被举报文章数
		sql = "select count(*) count from arti_tab where arti_check = -2 and arti_userid="
				+ userID;
		count.setCheckReport(getNumber(sql));
		// 未阅读评论数
		sql = "select count(*) count from comment_tab where comment_commid=0 and comment_readed = 0 and comment_userid="
				+ userID;
		count.setUnSeeComment(getNumber(sql));
		return count;
	}

	/**
	 * 根据sql语句查询数量
	 * 
	 * @param sql
	 *            sql语句
	 * @return 返回相应的数值
	 */
	public int getNumber(String sql) {
		List<Map<String, Object>> result = JDBCUtil.doQuery(sql);
		int number = Integer.parseInt(result.get(0).get("count").toString());
		return number;
	}
}
