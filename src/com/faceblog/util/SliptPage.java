package com.faceblog.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.faceblog.entity.ZHJPage;


/**
 * @author 张宏举
 *封装ZHJPage
 */
public class SliptPage {
	public static ZHJPage setPageValue(String cur,int size,List<Map<String,Object>>selectResult){
		ZHJPage page=new ZHJPage();
		int current=1;
		//字符串转整型
		try {
			current = Integer.parseInt(cur);
		} catch (Exception e) {
		
		}
		//查询结果数据的数目
		int lenth=1;
		if(selectResult!=null){
			lenth=selectResult.size();
		}
		page.setRowCount(lenth);
		//每页数据的数目
		page.setPageSize(size);
		//最大页
		int num=0;
		if(lenth%size==0){
			num=lenth/size;		
		}else{
			num=lenth/size+1;
		}
		page.setMaxPage(num);
		//当前页
		page.setCurrentPage(current);
		//上一页
		int previous=current-1;
        if(previous<1){
           previous=1;
        }
        page.setPrevious(previous);
        //下一页
        int next=current+1;
        if(next>=num){
            next=num;
        }
        //返回封装好的page
		page.setNext(next);
		return page;		
	}
	public static List<Map<String,Object>> setResult(String cur,int size,List<Map<String,Object>>selectResult){
		List<Map<String,Object>> pageResult=new ArrayList<Map<String, Object>>();
		if(selectResult!=null){
		    int lenth=selectResult.size();
		    int current=1;
		    //字符串转整型
		    try {
			    current = Integer.parseInt(cur);
		    } catch (Exception e) {
		
		    }
		    //截取查询结果
		    int startNum=0;
		    if((current-1)>=0){
			    startNum=(current-1)*size;
		    }
		    int j=0;
		    for(int i=startNum;i<lenth;i++){
			    pageResult.add(selectResult.get(i));
			    j++;
			    if(j>=size) break;
		    }
		    //返回截取的查询结果
		    return pageResult;
		}
		else{
			return null;
		}
	}
}
