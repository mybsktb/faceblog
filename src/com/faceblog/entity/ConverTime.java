package com.faceblog.entity;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ConverTime {
	//获取的时间
	private String onTime;
	
	public String conve(String onTime){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now=new Date();
		String time=sdf.format(now);
		Date ontime=null;
		Date nowtime=null;
		try {
			ontime=sdf.parse(onTime);
			nowtime=sdf.parse(time);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String intime=null;
		//天
		long day=(nowtime.getTime()-ontime.getTime())/(24*60*60*1000);
		if(day>1&&day<10){
			intime=day+"天前";
		}
		if(day<1){
			//小时
			long h=(nowtime.getTime()-ontime.getTime())/(60*60*1000);
			intime=h+"小时前";
			if(h<1){
				//分钟
				long m=(nowtime.getTime()-ontime.getTime())/(60*1000);
				intime=m+"分前";
			if(m<1){
				long s=(nowtime.getTime()-ontime.getTime())/(1000);
				intime="刚刚";
			}
		 }
		}else{
			 intime=onTime.substring(0,10);
		 }
		return intime;
	}
}
