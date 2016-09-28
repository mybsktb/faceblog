package com.faceblog.dao.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.faceblog.common.Const;
import com.faceblog.dao.NewsMgDaoInterface;
import com.faceblog.entity.AdminPage;
import com.faceblog.entity.Article;
import com.faceblog.entity.Page;
import com.faceblog.entity.ZHJPage;
import com.faceblog.util.AdminPageDaoSelect;
import com.faceblog.util.PageUtil;
import com.faceblog.util.JDBCUtil;
import com.faceblog.util.StringUtil;

public class NewsMgDaoImpl implements NewsMgDaoInterface {
private String sql;
private static final String TABLE_NAME="ARTI_TAB";
private int num = 0;
@Override
//文章审核查询
public AdminPage AdSelectNewsMg(AdminPage page) {	
	int start = (page.getCurpage()-1)*page.getCurdatanum();
	String sql = "select a.*,b.cate_name from arti_tab a,cate_tab b where a.arti_cateid=b.cate_id and arti_check in (0,-2) and arti_author like '"+page.getKeyword()+"%' limit "+start+","+page.getCurdatanum()+"";	
	String sql2 = "select * from arti_tab where arti_check in (0,-2) and arti_author like '"+page.getKeyword()+"%'";
	//工具类处理
	AdminPage pa = AdminPageDaoSelect.PageDaoSelect(page, sql, sql2);
	return pa;
}

@Override
//文章审核
public String AdSelectNewsCheck(int newsid, int check) {
	String sql = "update arti_tab set arti_check ='"+check+"' where arti_id='"+newsid+"'";
	boolean res = JDBCUtil.doUpdate(sql);
	
	if(res){
		//记录今日完成数
		++num;
		AdminPage.setCheckedsum(num);
		if(check==1){
			return "审核完成,通过";
		}else if(check==-1){
			return "审核完成,不通过";
		}				
	}
	return "审核未完成";
}

@Override
//文章详细信息
public List<Map<String, Object>> AdSelectNewsMg(int newsid) {
	String sql = "select a.*,b.cate_name from arti_tab a,cate_tab b where a.arti_id = '"+newsid+"'";
	return JDBCUtil.doQuery(sql);
}

	/* (non-Javadoc)
	 * @see com.faceblog.dao.NewsMgDaoInterface#selectArticles(com.faceblog.entity.Article)
	 * 搜索文章均不为模糊搜索，需另外写
	 */
	@Override
	public List<Map<String, Object>> selectArticles(Article article) {
		// TODO Auto-generated method stub
		//1. 空的文章，未设置参数的文章，搜索所有
		sql="SELECT * FROM "+TABLE_NAME +" WHERE 1=1 ";
		//2. if id!=-1,-1是默认值，不是-1代表人为在article中加了id
		if(article.getArt__id()!=-1)
			sql+=" AND ARTI_ID = "+article.getArt__id();
		//3. if 名字不为空，非模糊搜索，要模糊需另外写
		if(!StringUtil.isEmpty(article.getArt_name()))
			sql+=" AND ARTI_NAME = '"+article.getArt_name()+"'";
		//4. if 栏目id不为空，默认为-1，其他表示人为设置过
		if(article.getCate_id()!=-1)
			sql+=" AND ARTI_CATEID = "+article.getCate_id();
		//5. if 作者id不为空，默认为-1，其他表示人为设置过
		if(article.getUser_id()!=-1)
			sql+=" AND ARTI_USERID = "+article.getUser_id();
		 
		return JDBCUtil.doQuery(sql);
		
	}
	@Override
	public List<Map<String, Object>> getArticles(Article article) {
		// TODO Auto-generated method stub
		return null;
	}
	
	/* (non-Javadoc)
	 * @see com.faceblog.dao.NewsMgDaoInterface#getRecommandArticles(com.faceblog.entity.Article)
	 * 获得推荐文章，输入文章：判断是否推荐，是否通过审核，是否是该用户的文章
	 */
	@Override
	public List<Map<String, Object>> getRecommandArticles(Article article) {
		
		if(article == null){
			return null;
		}
		// TODO Auto-generated method stub
		String sql = "SELECT * FROM ARTI_TAB WHERE ARTI_RECOMMEND='1' AND ARTI_CHECK='1' ";
		
		if(article.getUser_id() != -1){
			sql += "AND ARTI_USERID='"+ article.getUser_id() +"'";
		}
		
		sql += " ORDER BY ARTI_TIME DESC";
		
		return JDBCUtil.doQuery(sql);
	}
	@Override
	public List<Map<String, Object>> getLastArticles(Article article) {
		String sql = "SELECT * FROM ARTI_TAB WHERE ARTI_CHECK='1' ";
				
		if(article.getUser_id() != -1){
			sql += "AND ARTI_USERID='"+ article.getUser_id() +"'";
		}
		
		sql += " ORDER BY ARTI_TIME DESC";
		
		// TODO Auto-generated method stub
		return JDBCUtil.doQuery(sql);
	}
	
	/*
	 * 主界面获取推荐文章
	 */
	public Page recom(int curr,int useid) {
		Page pg=new Page();
		//设置每页几条内容
		pg.setPageSize(4);
		//将当前页设置进Page中
		pg.setCurrtentPage(curr);
		String sql="select ARTI_AUTHOR,ARTI_CATEID,ARTI_COMMENTCOUNT,ARTI_ID,ARTI_NAME,USER_NAME,CATE_NAME,ARTI_TIME,ARTI_USERID,ARTI_CTR,ARTI_CONTENT from arti_tab ar,cate_tab ca,user_tab us where ar.ARTI_CATEID=ca.CATE_ID and ar.ARTI_USERID=us.USER_ID and ar.ARTI_USERID="+useid+" and arti_recommend=1 ORDER BY ARTI_CREATETIME asc";
		return PageUtil.selectPage(pg, sql);
	}

	/**
	 * 文章列表界面获取右边栏推荐文章
	 */
	@Override
	public List<Map<String, Object>> getRankArticles(Article article,int number){
		if(number==1){
			String sql="select ARTI_NAME,ARTI_ID,CATE_NAME,CATE_ID,ARTI_TIME,ARTI_USERID,ARTI_CTR,ARTI_CONTENT from arti_tab ar,cate_tab ca where ar.ARTI_CATEID=ca.CATE_ID and arti_recommend=1  AND ARTI_CHECK=1 AND ARTI_USERID="+article.getUser_id()+" ORDER BY ARTI_CREATETIME asc limit 0,"+Const.NUM_R_L_ARTICLE+"";
			return JDBCUtil.doQuery(sql);		
		}
		if(number==2){
			String sql="select ARTI_NAME,ARTI_ID,CATE_NAME,CATE_ID,ARTI_TIME,ARTI_USERID,ARTI_CTR,ARTI_CONTENT from arti_tab ar,cate_tab ca where ar.ARTI_CATEID=ca.CATE_ID  AND ARTI_CHECK=1 AND ARTI_USERID="+article.getUser_id()+" ORDER BY ARTI_CTR desc limit 0,"+Const.NUM_R_L_ARTICLE+"";
			return JDBCUtil.doQuery(sql);
		}
		if(number==3){
			String sql = "select ARTI_NAME,ARTI_ID,USER_NAME,CATE_NAME,ARTI_TIME,ARTI_USERID,ARTI_CTR,ARTI_CONTENT from arti_tab ar,cate_tab ca ,user_tab us where ar.ARTI_CATEID=ca.CATE_ID AND us.USER_ID=ar.ARTI_USERID AND ARTI_USERID="+article.getUser_id()+" ORDER BY ARTI_TIME desc";
			return JDBCUtil.doQuery(sql);
		}
		return null;
		
	}
	/* (non-Javadoc)
	 * 文章列表界面分页处理
	 */
	@Override
	public Page getArticlesPage(Article article,int number) {
		Page pg = new Page();
		pg.setCurrtentPage(number);
		pg.setPageSize(Const.PAGE_SIZE);
		String sqlstr = "";
		if(article.getCate_id()!=-1&&article.getCate_id()!=0){
			sqlstr = " AND ARTI_CATEID=" +article.getCate_id()+"";
		}
		String sql="select ARTI_COMMENTCOUNT,ARTI_NAME,ARTI_ID,ARTI_AUTHOR,USER_NAME,CATE_NAME,CATE_ID,ARTI_TIME,ARTI_USERID,ARTI_CTR,ARTI_CONTENT from arti_tab ar,cate_tab ca ,user_tab us where ar.ARTI_CATEID=ca.CATE_ID AND us.USER_ID=ar.ARTI_USERID "+sqlstr+"  AND ARTI_CHECK=1 AND ARTI_USERID="+article.getUser_id()+" ORDER BY ARTI_TIME desc";
		//System.out.println(sql);
		return PageUtil.selectPage(pg, sql);
	}
	

	
	
	/* 文章的插入
	 */
	public boolean insertArticle(Article article) {		
		String sql="INSERT INTO `arti_tab` (`ARTI_NAME`, `ARTI_CATEID`, `ARTI_TIME`, `ARTI_USERID`, `ARTI_KEYWORD`, `ARTI_CONTENT`,  `ARTI_RECOMMEND`, `ARTI_CREATETIME`, `ARTI_AUTHOR`,ARTI_CHECK)" +
				" VALUES('"+article.getArt_name().trim()+"',"+article.getCate_id()+",NOW(),"+article.getUser_id()+",'"+article.getArt_keyword().trim()+"','"+article.getArt_content()+"',"
				+article.getArt_recommend()+",NOW(),'"+article.getAtr_author()+"',"+article.getArt_check()+")";
		return JDBCUtil.doUpdate(sql);
		
	}
	/* 
	 * 点击主页阅读全文后获取的数据
	 */
	public List<Map<String, Object>> articlAppre(int catid,int artctr) {
		String sql="SELECT ARTI_ID,ARTI_COMMENTCOUNT,USER_NAME,ARTI_NAME,ARTI_TIME,ARTI_USERID,ARTI_CTR,ARTI_KEYWORD,ARTI_CONTENT,ARTI_AUTHOR from ARTI_TAB,user_tab us WHERE ARTI_TAB.ARTI_USERID=us.USER_ID and ARTI_ID="+catid;
		String sql2="UPDATE arti_tab set ARTI_ctr="+artctr+" where ARTI_ID="+catid;
		JDBCUtil.doUpdate(sql2);
		//获取用户评论内容
		String sql1="select comment_content,COMMENT_TIME from comment_tab where COMMENT_ARTIID="+catid+" ORDER BY COMMENT_TIME ";
		List<Map<String, Object>> said = JDBCUtil.doQuery(sql1);
		//评论量
		int commVolu=said.size();
		String sql3="UPDATE arti_tab set ARTI_COMMENTCOUNT="+commVolu+" where ARTI_ID="+catid;
		JDBCUtil.doUpdate(sql3);
		return JDBCUtil.doQuery(sql);
	}
	/* (non-Javadoc)
	 * 用于后台的查询文章
	 */
	@Override
	public List<Map<String, Object>> selectArti(Article article,int userId) {
		String sql="SELECT CATE_NAME,ARTI_ID,ARTI_NAME,ARTI_CATEID,ARTI_CREATETIME,ARTI_AUTHOR,ARTI_RECOMMEND,ARTI_CHECK FROM arti_tab,cate_tab where arti_tab.ARTI_CATEID=cate_tab.CATE_ID AND arti_tab.ARTI_USERID="+userId+" ORDER BY ARTI_TIME DESC";
		return JDBCUtil.doQuery(sql);
	}
	/* (non-Javadoc)
	 * 后台复合查询文章
	 */
	@Override
	public List<Map<String, Object>> selectLikeArti(String selectName,int userId) {
		String sql="SELECT CATE_NAME,ARTI_ID,ARTI_NAME,ARTI_CATEID,ARTI_CREATETIME,ARTI_AUTHOR,ARTI_RECOMMEND,ARTI_CHECK FROM arti_tab,cate_tab where arti_tab.ARTI_CATEID=cate_tab.CATE_ID AND arti_tab.ARTI_USERID="+userId+" AND ARTI_NAME like '%"+selectName+"%' ORDER BY ARTI_TIME DESC";
		return JDBCUtil.doQuery(sql);
	}
	/* (non-Javadoc)
	 * 根据id删除文章
	 */
	@Override
	public boolean deleteArticle(String artiId) {
		artiId=artiId.trim();
		String sql="DELETE from arti_tab WHERE ARTI_ID="+artiId;
		return JDBCUtil.doUpdate(sql);
	}
	/* (non-Javadoc)
	 * 文章的修改
	 */
	@Override
	public boolean updateArticle(Article article) {
		String sql="UPDATE arti_tab SET ARTI_NAME='"+article.getArt_name().trim()+"', ARTI_RECOMMEND="+article.getArt_recommend()+", ARTI_AUTHOR='"+article.getAtr_author().trim()+"'," +
				"ARTI_KEYWORD='"+article.getArt_keyword().trim()+"',ARTI_CATEID="+article.getCate_id()+"," +
				"ARTI_CONTENT='"+article.getArt_content()+"',ARTI_CHECK="+article.getArt_check()+",ARTI_TIME=NOW() WHERE ARTI_ID="+article.getArt__id();
		return JDBCUtil.doUpdate(sql);
	}

	/* (non-Javadoc)
	 *前章与后一章
	 */
	@Override
	public List<Map<String, Object>> onAndNex(int artid) {
		// TODO Auto-generated method stub
		String sql="select ARTI_USERID,ARTI_CATEID,ARTI_ID,ARTI_NAME,ARTI_CTR from arti_tab where ARTI_ID=(select ARTI_ID from arti_tab where ARTI_ID<"+artid+" ORDER BY ARTI_ID desc limit 1) or ARTI_ID=(select ARTI_ID from arti_tab where ARTI_ID>"+artid+" ORDER BY ARTI_ID asc limit 1)";
		return JDBCUtil.doQuery(sql);
	}

	/* 
	 * 提交评论
	 */
	@Override
	public boolean comment(int artid, String mess,int userid,int fromid) {
		Date now = new Date(); 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		String time = dateFormat.format(now); 
		String sql="INSERT into comment_tab(comment_userid,comment_content,comment_time,comment_artiid,comment_fromuserid) VALUES ("+userid+",'"+mess+"','"+time+"',"+artid+","+fromid+")";
		return JDBCUtil.doUpdate(sql);
	}
	/**
	 * @param check
	 * 用于查询通过审核，未通过审核，待审核的文章
	 */
	@Override
	public List<Map<String, Object>> selectCheckArticle(int check,int userId) {
		String sql="SELECT CATE_NAME,ARTI_ID,ARTI_NAME,ARTI_CATEID,ARTI_CREATETIME,ARTI_AUTHOR,ARTI_RECOMMEND,ARTI_CHECK FROM arti_tab,cate_tab where arti_tab.ARTI_CATEID=cate_tab.CATE_ID AND ARTI_CHECK="+check+" AND arti_tab.ARTI_USERID="+userId+" ORDER BY ARTI_TIME DESC";
		return JDBCUtil.doQuery(sql);
	}
	/**
	 * @param 
	 * 用于查询推荐和不推荐的文章
	 */
	@Override
	public List<Map<String, Object>> selectRecoArticle(int reco,int userId) {
		String sql="SELECT CATE_NAME,ARTI_ID,ARTI_NAME,ARTI_CATEID,ARTI_CREATETIME,ARTI_AUTHOR,ARTI_RECOMMEND,ARTI_CHECK FROM arti_tab,cate_tab where arti_tab.ARTI_CATEID=cate_tab.CATE_ID AND ARTI_RECOMMEND="+reco+" AND arti_tab.ARTI_USERID="+userId+" ORDER BY ARTI_TIME DESC";
		return JDBCUtil.doQuery(sql);
	}


	@Override
	public List<Map<String, Object>> revele(int catid,int artid) {
		String sql="select ARTI_ID,ARTI_NAME,ARTI_CTR,ARTI_CATEID,ARTI_USERID from arti_tab where ARTI_CATEID="+catid+" and not ARTI_ID="+artid+" and ARTI_CHECK=1 ORDER BY ARTI_CREATETIME limit 0,6";	

		return JDBCUtil.doQuery(sql);
	}

	@Override
	public List<Map<String, Object>> selectCateArticle(int cateId, int userId) {
		String sql="SELECT CATE_NAME,ARTI_ID,ARTI_NAME,ARTI_CATEID,ARTI_CREATETIME,ARTI_AUTHOR,ARTI_RECOMMEND,ARTI_CHECK FROM arti_tab,cate_tab where arti_tab.ARTI_CATEID=cate_tab.CATE_ID AND ARTI_CATEID="+cateId+" AND arti_tab.ARTI_USERID="+userId+" ORDER BY ARTI_TIME DESC";
		return JDBCUtil.doQuery(sql);
	}

	/* 获取最新评论
	 */
	@Override
	public List<Map<String, Object>> latCom(int artid) {
		String sql="select COMMENT_TIME,COMMENT_CONTENT,COMMENT_FROMUSERID,USER_NAME,USER_ICON,USER_ID from comment_tab com,user_tab us where com.COMMENT_FROMUSERID=us.USER_ID and COMMENT_ARTIID="+artid+" ORDER BY comment_time desc limit 0,6";
		return JDBCUtil.doQuery(sql);
	}

	@Override
	public List<Map<String, Object>> selectLikeArti(String selectName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Map<String, Object>> selectArti(Article article) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * 搜索页面的分页处理
	 */
	@Override
	public Page pageForSearch(Article article,int number) {
		Page pg = new Page();
		pg.setCurrtentPage(number);
		pg.setPageSize(Const.PAGE_SIZE);
		String sql = "SELECT * FROM user_tab us,arti_tab ar ,cate_tab ca WHERE (us.USER_NAME LIKE '%"+article.getArt_name()+"%' OR ar.ARTI_NAME LIKE '%"+article.getArt_name()+"%')AND us.USER_ID=ar.ARTI_USERID and ar.ARTI_CATEID=ca.CATE_ID and ar.ARTI_CHECK=1 ORDER BY ar.ARTI_TIME DESC ";
		return PageUtil.selectPage(pg, sql);
	}

	@Override
	public Map<String, Object> selectById(int id) {
		// TODO Auto-generated method stub
		sql="SELECT * FROM recommend WHERE ARTI_ID =" +id;
		List<Map<String, Object>> results = JDBCUtil.doQuery(sql);
		Map<String, Object> result=null;
		try {
			result = results.get(0);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("NewsMgDaoImpl:selectById:arti_id is not existed by qcm");
		}
		
		
		return result;
	}
	
	
}
