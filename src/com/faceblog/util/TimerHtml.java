package com.faceblog.util;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Timer;
import java.util.TimerTask;

import com.faceblog.common.Const;
import com.faceblog.dao.UserMgDaoInterface;
import com.faceblog.dao.impl.UserMgDaoImpl;
import com.faceblog.entity.User;

public class TimerHtml {
	
    static int count = 0;
    
    public static void showTimer() {
    	//设置执行时间
    	Calendar calendar = Calendar.getInstance();
    	int year = calendar.get(Calendar.YEAR);
    	int month = calendar.get(Calendar.MONTH);
    	int day = calendar.get(Calendar.DAY_OF_MONTH);
    	//定制每天的00:00:00执行
    	calendar.set(year, month, day, 10, 11, 00);
    	Date date = calendar.getTime();
    	Timer timer = new Timer();
    	System.out.println(date);
    	
    	//每天的date时刻执行task, 仅执行一次
    	timer.schedule(new TimerTask() {
            @Override
            public void run() {
        		Map<String,String> urls = new HashMap<String,String>();
        		urls.put("url_index", Const.BLOG_INDEX_URL);
        		urls.put("url_about", Const.BLOG_ABOUT_URL);
        		UserMgDaoInterface userMgDaoImpl = new UserMgDaoImpl();
        		List<Map<String, Object>> users = userMgDaoImpl.selectUser(new User());
        		if(users!=null){
        			for(Map<String ,Object> map : users){
        				int userId = (Integer)map.get("USER_ID");
        				Iterator<Entry<String, String>> it = urls.entrySet().iterator();
        				String url = "";
        				while(it.hasNext()){
        					Entry<String, String> entry = it.next();
        					url = entry.getValue() + "?userId=" + userId;
        					Jsp2HtmlUtil.getHtmlCode(url);
        					++count;
        					System.out.println("时间=" + new Date() + " 执行了" + count + "次");
        				}
        			}
        		}
            }
        }, date);
    }
}
