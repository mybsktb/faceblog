package com.faceblog.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.faceblog.common.Const;
import com.faceblog.dao.CateMgDaoInterface;
import com.faceblog.entity.Cate;
import com.faceblog.entity.SplitPage;
import com.faceblog.util.JDBCUtil;

public class CateMgDaoImpl implements CateMgDaoInterface {
	/* (non-Javadoc)
	 * @see com.faceblog.dao.CateMgDaoInterface#getCate(com.faceblog.entity.Cate, int)
	 * 查询所有栏目并分页
	 */
	public SplitPage getCate(Cate cate,int curPage){
		SplitPage sp = new SplitPage();
		//查询用户的所有栏目
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
		String sql = "select * from cate_tab where cate_userid ="+cate.getUser_id()+" order by cate_id desc";
		result=JDBCUtil.doQuery(sql);
		//数据为空则返回空的SplitPage
		if(result==null){
			return sp;
		}
		//数据总条数
		int totalNum = result.size();
		sp.setTotalNum(totalNum);
		//每页数据条数
		int pageSize = Const.PAGE_SIZE;
		sp.setPageSize(pageSize);
		//最大页数
		int maxPage = totalNum % pageSize == 0 ? (totalNum/pageSize):(totalNum/pageSize+1);
		sp.setMaxPage(maxPage);
		//当前页面
		if(curPage<1)
			curPage=1;
		if(curPage>maxPage)
			curPage=maxPage;
		sp.setCurPage(curPage);
		//当前页面数据
		int startNum = (curPage-1)*pageSize;
		String newSql = sql + " limit "+startNum+","+pageSize;
		List<Map<String,Object>> data = JDBCUtil.doQuery(newSql);
		sp.setData(data);
		
		return sp;
	}
	/* (non-Javadoc)
	 * @see com.faceblog.dao.CateMgDaoInterface#cateDel(java.lang.String)
	 * 栏目删除
	 */
	public boolean cateDel(String cateID){
		String sql = "delete from cate_tab where cate_id in ("+cateID+")";
		boolean result = JDBCUtil.doUpdate(sql);
		return result;
	}
	/* (non-Javadoc)
	 * @see com.faceblog.dao.CateMgDaoInterface#cateAdd(com.faceblog.entity.Cate)
	 * 添加栏目
	 */
	public boolean cateAdd(Cate cate){
		String checkSql = "select * from cate_tab where cate_name = '"+cate.getCate_name()+"' and cate_userid="+cate.getUser_id();
		List<Map<String,Object>> data = JDBCUtil.doQuery(checkSql);
		//判断是否已存在同名栏目
		if(data.size()>=1)
			return false;
		else {
			String sql = "insert cate_tab(cate_name,cate_userid) value ('"
					+ cate.getCate_name() + "'," + cate.getUser_id() + ")";
			return JDBCUtil.doUpdate(sql);
			
		}
	}
	/* (non-Javadoc)
	 * @see com.faceblog.dao.CateMgDaoInterface#cateUpd(com.faceblog.entity.Cate)
	 * 栏目名的修改
	 */
	public boolean cateUpd(Cate cate){
		String checkSql = "select * from cate_tab where cate_id = '"+cate.getCate_id()+"' and cate_userid="+cate.getUser_id();
		List<Map<String,Object>> data = JDBCUtil.doQuery(checkSql);
		//判断是否已存在同名栏目
		if(data.size()>=1){
			String sql = "update cate_tab set cate_name = '"+cate.getCate_name()+"' where cate_id = "+cate.getCate_id();
			return JDBCUtil.doUpdate(sql);
		}else {
			return false;
			
		}
	}
	/* (non-Javadoc)
	 * @see com.faceblog.dao.CateMgDaoInterface#cateSel(com.faceblog.entity.Cate)
	 */
	@Override
	public List<Map<String, Object>> cateSel(Cate cate) {
		//查找文章使用最多的N个栏目
		String sql = "select * from (select CATE_NAME,CATE_ID, ARTI_CATEID,ARTI_NAME,COUNT(ARTI_CATEID) count  from  arti_tab,cate_tab where ARTI_USERID= "+cate.getUser_id()+" and " +
				"CATE_ID = ARTI_CATEID AND ARTI_CHECK=1 group by  ARTI_CATEID) x  order by x.count DESC LIMIT 0,"+Const.NUM_CATE_RANK+"";
		System.out.println(sql);
		return JDBCUtil.doQuery(sql);
	}
	/* (non-Javadoc)
	 * 用于文章新增页面下拉表查询所有栏目
	 */
	@Override
	public List<Map<String, Object>> selectCate(int userId) {
		String sql = "select * from cate_tab where CATE_USERID="+userId;
		return JDBCUtil.doQuery(sql);
	}
	
}
