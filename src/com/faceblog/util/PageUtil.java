package com.faceblog.util;

import java.util.List;
import java.util.Map;

import com.faceblog.entity.Page;

/**
 * 该常用类用以页面的读取
 * 输入：三个
 * 		page对象：1. 当前页，2. 每页项数（默认为6），
 * 		3. 一个sql语句，包括表名和条件和排序字段, 
 * 		比如： "SELECT * FROM 表名 WHERE 1=1 AND CATE_ID = '01' 
 * 		+" order by user_answer ""
 * 输出：
 * 		page对象：1. 总页数，2. 总的项数， 3. result结果集  
 * */
public class PageUtil {

	public static Page selectPage(Page page, String selectSql) {
		List<Map<String, Object>> selcSql=JDBCUtil.doQuery(selectSql);
		if(StringUtil.isEmpty(selectSql))
		{
			System.out.println("测试输出，类名为 pageutil"+"\tpage常用类，输入的sql语句为空");
		}
//		int i=page.getPageSize();
		String sql = selectSql + " LIMIT "+(page.getCurrentPage()-1)*page.getPageSize()+","+page.getPageSize();
		List<Map<String ,Object>> results= JDBCUtil.doQuery(sql);//得到结果集
		//总共内容数量
		int dasiz = 0;
		try {
			dasiz=selcSql.size();
			page.setTotalNumber(dasiz);//计算总项数
		} catch (NullPointerException e) {
			// TODO: handle exception
			System.out.println("pageutil 出现空指针异常，可能sql语句有错，查出来结果集为空");
			page.setTotalNumber(1);
		}
        int pagMax=(dasiz%page.getPageSize()==0)?(dasiz/page.getPageSize()):(dasiz/page.getPageSize()+1);;
        page.setTotalPage(pagMax);//计算总页数
        page.setData(results);

        return page;
        
	}
	
//	public static void main(String[] args) {
//		Page page = new Page();
//		page.setCurrtentPage(1);
//		page.setPageSize(6);
//		String searchSql="SELECT * FROM USER_TAB WHERE 1=1 ";
//		page=PageUtil.selectPage(page, searchSql);
//		System.out.println(page.getData());
//	}

}
