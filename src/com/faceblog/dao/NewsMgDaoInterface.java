package com.faceblog.dao;


import java.util.List;
import java.util.Map;

import com.faceblog.entity.AdminPage;


import com.faceblog.entity.Article;
import com.faceblog.entity.Page;

/**
 * @author lenovo
 *
 */

public interface NewsMgDaoInterface {

	//文章审核查询
	public abstract AdminPage AdSelectNewsMg(AdminPage page);
	//文章详细信息
	public abstract List<Map<String,Object>> AdSelectNewsMg(int newsid);
	//文章审核
	public abstract String AdSelectNewsCheck(int newsid,int check);

	
	/**
	 * 获取文章
	 * @param article
	 * @return
	 */
	public List<Map<String,Object>> getArticles(Article article);
	
	/**
	 * 获取推荐文章
	 * @param article
	 * @return
	 */
	public List<Map<String,Object>> getRecommandArticles(Article article);
	
	/**
	 * 获取最新文章
	 * @param article
	 * @return
	 */
	public List<Map<String,Object>> getLastArticles(Article article);
	
	/**
	 * 裘丛民
	 * */
	public List<Map<String,Object>> selectArticles(Article article); 
	
	/**
	 * 博客主界面获取推荐文章
	 */
	public Page recom(int curr,int useid);
	/**
	 * 增加文章
	 */
	public boolean insertArticle(Article article);
	
	/**
	 *获取点击阅读文章后跳转界面内的内容
	 */
	public List<Map<String,Object>> articlAppre(int catid,int artctr);
	/**
	 * 文章列表界面获取右边栏推荐文章
	 */
	public List<Map<String, Object>> getRankArticles(Article article,int number);
	
	/**
	 * 文章列表界面分页处理
	 */
	public Page getArticlesPage(Article article,int number);


	/**
	 * 用于后台查询文章
	 */
	public List<Map<String, Object>> selectArti(Article article,int userId);
	/**
	 * 用于后台复合查询文章
	 */
	public List<Map<String, Object>> selectLikeArti(String selectName,int userId);	
	
	/**
	 * 根据id删除文章
	 * 
	 */
	public boolean deleteArticle(String arti_id);
	
	/**
	 * 文章的修改
	 */
	public boolean updateArticle(Article article);
	
	/**
	 * 前一章与后一章  传入当前章ID
	 */
	public List<Map<String,Object>> onAndNex(int artid);
	
	/**
	 * 提交评论
	 */
	public boolean comment(int artid,String mess,int userid,int fromid);

	/**
	 * @param check
	 * 用于查询通过审核，未通过审核，待审核的文章
	 */
	public List<Map<String, Object>> selectCheckArticle(int check,int userId);
	/**
	 * @param 
	 * 用于查询推荐和不推荐的文章
	 */
	public List<Map<String, Object>> selectRecoArticle(int reco,int userId);
	
	/**
	 * @param 栏目id
	 * @param userId
	 * @return
	 * 用于栏目id查询文章
	 */
	public List<Map<String, Object>> selectCateArticle(int cateId,int userId);
	/**
	 * 查询相关文章
	 */
	public List<Map<String, Object>> revele(int catid,int artid);

	List<Map<String, Object>> selectLikeArti(String selectName);
	List<Map<String, Object>> selectArti(Article article);

	
	/**
	 *获取最新评论
	 */
	public List<Map<String, Object>> latCom(int artid);

	public Page pageForSearch(Article article,int number);

	/**
	 * 通过文字id查询单个文章map
	 * */
	public Map<String, Object> selectById(int id); 
}
