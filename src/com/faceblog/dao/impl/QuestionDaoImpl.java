package com.faceblog.dao.impl;

import java.util.List;
import java.util.Map;

import com.faceblog.util.JDBCUtil;
/**
 * 两种用法
 * 1. 不带参数，获得所有的安全问题
 * 2. 带问题编号，得到编号对应的问题
 * */
public class QuestionDaoImpl {
	private String sql = "";
	public List<Map<String, Object>> selectQuestion(int questionId) {
		sql = "select * from QUESTION_TAB WHERE QUESTION_ID = "+questionId;
		return JDBCUtil.doQuery(sql);
	}
	public List<Map<String, Object>> selectQuestion() {
		sql = "select * from QUESTION_TAB ";
		return JDBCUtil.doQuery(sql);
	}
	public static void main(String[] args) {
		QuestionDaoImpl q = new QuestionDaoImpl();
		System.out.println(q.selectQuestion(1));
		System.out.println(q.selectQuestion());
	}
}
