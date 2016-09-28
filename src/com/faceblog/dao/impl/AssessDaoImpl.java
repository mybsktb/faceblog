package com.faceblog.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.StringTokenizer;

import com.faceblog.dao.AssessDaoInterface;
import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.entity.Article;
import com.faceblog.entity.Assess;
import com.faceblog.entity.User;
import com.faceblog.util.JDBCUtil;

/**
 * 1. 用户第一次阅读全文时，新建一条数据
 * */
public class AssessDaoImpl implements AssessDaoInterface {
	private String sql = "";

	@Override
	public List<Map<String, Object>> selectAssess(Assess assess) {
		// TODO Auto-generated method stub
		sql = "SELECT * FROM ASSESS_TAB WHERE ASSESS_USERID="
				+ assess.getAssessUserId() + " AND ASSESS_ARTIID = "
				+ assess.getAssessArtiId();
		System.out.println(sql);
		return JDBCUtil.doQuery(sql);

	}

	public List<Double[]> getUserSort(User user) {
		AssessDaoInterface a = new AssessDaoImpl();
		// System.out.println(a.selectAssessByUser(user).size());
		List<Map<String, Object>> results = a.selectAssessByUser(user);
		List<Map<String, Object>> temp = null;
		List<Double[]> scores = new ArrayList<Double[]>();
		List<Double[]> scoresUser = new ArrayList<Double[]>();
		Set<Double> articleList = new HashSet<Double>();
		Article tempa = new Article();
		//System.out.println("current user:" + 3);
		for (Map<String, Object> map : results) {
			//System.out.println("article:" + map.get("ASSESS_ARTIID"));
			int i = Integer
					.parseInt(map.get("ASSESS_ARTIID").toString().trim());
			tempa.setArt__id(i);
			// 搜索对同一篇文章进行过评论的用户
			temp = a.selectAssessByArti(tempa);
			double score_user = getAssessScore(map);
			Double[] score_user_ = new Double[] {
					stringToDouble(map.get("ASSESS_ARTIID").toString()),
					stringToDouble(map.get("ASSESS_USERID").toString()),
					score_user };
			scoresUser.add(score_user_);
			for (Map<String, Object> map2 : temp) {
				// double userScore=0;
				double score = getAssessScore(map2);
				Double[] score_ = new Double[] {
						stringToDouble(map.get("ASSESS_ARTIID").toString()),
						stringToDouble(map2.get("ASSESS_USERID").toString()),
						score };
				if (Integer.parseInt(map2.get("ASSESS_USERID").toString()) != (user
						.getUser_id())) {
					scores.add(score_);
					articleList.add(Double.parseDouble(map2
							.get("ASSESS_ARTIID").toString()));
				}
			}
		}

		List<Double[]> distanceSum = new ArrayList<Double[]>();
		for (Double[] doubles : scoresUser) {
			if (articleList.contains(doubles[0])) {
				for (Double[] doubles2 : scores) {
					if (Math.abs(doubles2[0]) == Math.abs(doubles[0])) {
						Double distance[] = { doubles2[1],
								Math.pow((doubles2[2] - doubles[2]), 2.0) };
						distanceSum.add(distance);
					}
				}
			} else
				continue;
		} // end outer for

		// 计算平均距离，相关系数
		Map<Integer, Double> distanceSum2 = new HashMap<Integer, Double>();
		for (Double[] doubles : distanceSum) {
			double keys = doubles[0];
			Integer key = (int) keys;
			if (distanceSum2.get(key) == null) {
				distanceSum2.put(key, doubles[1]);
			} else {
				double value = distanceSum2.get(key);
				distanceSum2.put(key, doubles[1] + value);
			}

		}
		System.out.println("User\tRelativeFactor");
		for (Entry<Integer, Double> entry : distanceSum2.entrySet()) {
			double value = Math.sqrt(distanceSum2.get(Integer.parseInt(entry
					.getKey().toString())));
			value = 1 / (1 + value);
			distanceSum2
					.put(Integer.parseInt(entry.getKey().toString()), value);
			
			System.out.println(entry.getKey()
					+ "\t" + entry.getValue());
		}

		// System.out.println(distanceSum2.toString());
		// 筛选用户没有看过的，有相关系数的用户看过的文章，进行分数的预估
		// 1. 得到这些文章
		System.out.println("*****************************");
		System.out.println("userId\tartiId\tscore");
		Set<Integer> articleRecom = new HashSet<Integer>();
		List<Double[]> artiRecFactor = new ArrayList<Double[]>();
		for (Entry<Integer, Double> entry : distanceSum2.entrySet()) {
			User user2 = new User();
			user2.setUser_id(entry.getKey());
			// 2. 得到该用户的所有阅读过的文章
			List<Map<String, Object>> tempUserRelate = a
					.selectAssessByUser(user2);
			for (Map<String, Object> map : tempUserRelate) {
				if (!articleList.contains(stringToDouble(map.get(
						"ASSESS_ARTIID").toString()))) {
					System.out.println(map.get("ASSESS_USERID").toString()
							+ "\t" + map.get("ASSESS_ARTIID").toString() + "\t"
							+ getAssessScore(map));
					articleRecom.add((int) stringToDouble(map.get(
							"ASSESS_ARTIID").toString()));
					Double[] temp4 = new Double[] {
							stringToDouble(map.get("ASSESS_ARTIID").toString()),
							stringToDouble(map.get("ASSESS_USERID").toString()),
							getAssessScore(map) };
					artiRecFactor.add(temp4);
					// System.out.println(stringToDouble(map.get("ASSESS_ARTIID").toString()));
				}
			}
		}// end for
		Map<Integer, Double> artiRecFactorResult = new HashMap<Integer, Double>();
		// System.out.println("here:"+distanceSum2.get(1));
		//System.out.println(articleRecom.toString());
		//int j =1;
		//System.out.println(distanceSum2.get(j));
		System.out.println("*************************");
		System.out.println("article\tpredicted score");
		// 读取用户的相关系数，在新文章里加估计评分，得到预估评分的文章排序
		// 分数乘以相关系数相加，然后除以相关系数之和
		String resultString="";
		List<Double[]> result=new ArrayList<Double[]>();
		for (int i : articleRecom) {
			double sum=0;
			double factorSum=0;
			for (Double[] doubles : artiRecFactor) {
				if (i == ((int) ((double) doubles[0]))){
					//System.out.print(doubles[0] + "\t" + doubles[1]);
					//System.out.print((Integer)(int)(double)doubles[1]);
					//System.out.print("\t"+doubles[2]+"*"+distanceSum2.get((Integer)(int)(double)doubles[1]));
					double temp4=doubles[2]*distanceSum2.get((Integer)(int)(double)doubles[1]);
					//System.out.println("\t\t"+temp4);
					sum+=temp4;
					factorSum+=distanceSum2.get((Integer)(int)(double)doubles[1]);
				}
			}
			//System.out.println(i+":\t"+sum/factorSum);
			Double[] temp4= new Double[]{(double) i,(sum/factorSum)};
			result.add(temp4);
		}
		for (int i = 0; i < result.size(); i++) {
			Double[] temp5;
			//System.out.println(i);
			for (int j = i+1; j < result.size(); j++) {
				//System.out.println("\t"+j);
				if(result.get(i)[1]<result.get(j)[1]){
					temp5=result.get(i);
					result.set(i, result.get(j));
					result.set(j, temp5);
				}
			}
		}
		for (Double[] doubles : result) {
			System.out.println(doubles[0]+"\t"+doubles[1]);
		}
		//System.out.println(resultString);
		return result;

	}

	public static void main(String[] args) {
		User user = new User();
		user.setUser_id(3);
		AssessDaoImpl a = new AssessDaoImpl();

		a.getUserSort(user);

	} // end main

	public static double stringToDouble(String data) {
		double result = Double.parseDouble(data.trim());
		return result;
	}

	public static double getAssessScore(Map<String, Object> map2) {
		double score = stringToDouble(map2.get("ASSESS_READED").toString());
		score += stringToDouble(map2.get("ASSESS_AGREE").toString());
		score += stringToDouble(map2.get("ASSESS_DISAGREE").toString());
		score += stringToDouble(map2.get("ASSESS_COMMENT").toString());
		score += stringToDouble(map2.get("ASSESS_COPY").toString());
		score += stringToDouble(map2.get("ASSESS_TIRED").toString());

		return score;

	}

	/**
	 * 输入：用户，文章ID
	 * */
	@Override
	public boolean insertAssess(Assess assess) {
		// TODO Auto-generated method stub
		// 1. 文章是否为转载

		int arti_id = assess.getAssessArtiId();
		Article article = new Article();
		article.setArt__id(arti_id);
		NewsMgDaoInterface n = new NewsMgDaoImpl();
		List<Map<String, Object>> results = n.selectArticles(article);
		Map<String, Object> result = results.get(0);
		String arti_copy = result.get("ARTI_COPY").toString();

		if ("1".equals(arti_copy)) {
			arti_id = Integer.parseInt(result.get("ARTI_COPYID").toString());
			assess.setAssessArtiId(arti_id);
		}
		// 2. 判断有没有这条数据，一个用户对一篇文章的评价只有一条数据
		AssessDaoInterface A = new AssessDaoImpl();
		results = A.selectAssess(assess);
		if (results.size() >= 1) {
			return false;
		}

		// 3. 如果没有，增加一条，阅读全文得1分
		assess.setAssessReaded(1);
		sql = "INSERT INTO ASSESS_TAB(ASSESS_USERID,ASSESS_ARTIID,ASSESS_READED) VALUES("
				+ assess.getAssessUserId()
				+ ","
				+ assess.getAssessArtiId()
				+ "," + assess.getAssessReaded() + ")";
		System.out.println(sql);
		return JDBCUtil.doUpdate(sql);
	}

	@Override
	public boolean deleteAssess(Assess assess) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateAssess(Assess assess) {
		// TODO Auto-generated method stub
		sql = "UPDATE ASSESS_TAB SET ";
		if (assess.getAssessAgree() != 0)
			sql += "ASSESS_AGREE = 2,";

		if (assess.getAssessDisagree() != 0)
			sql += "ASSESS_DISAGREE = -2,";
		if (assess.getAssessComment() != 0)
			sql += "ASSESS_COMMENT = 0.5,";
		if (assess.getAssessCopy() != 0)
			sql += "ASSESS_COPY = 4,";
		if (assess.getAssessTired() != 0)
			sql += "ASSESS_TIRED = -0.5,";
		if (assess.getAssessReaded() != 0)
			sql += "ASSESS_READED = 1,";
		sql = sql.substring(0, sql.length() - 1);
		System.out.println(sql);
		sql += " WHERE ASSESS_USERID=" + assess.getAssessUserId()
				+ " AND ASSESS_ARTIID=" + assess.getAssessArtiId();
		System.out.println(sql);

		return JDBCUtil.doUpdate(sql);
	}

	@Override
	public List<Map<String, Object>> selectAssessByUser(User user) {
		// TODO Auto-generated method stub

		sql = "SELECT * FROM ASSESS_TAB WHERE ASSESS_USERID="
				+ user.getUser_id();

		return JDBCUtil.doQuery(sql);
	}

	@Override
	public List<Map<String, Object>> selectAssessByArti(Article article) {
		// TODO Auto-generated method stub
		sql = "SELECT * FROM ASSESS_TAB WHERE ASSESS_ARTIID="
				+ article.getArt__id();
		return JDBCUtil.doQuery(sql);
	}

}
