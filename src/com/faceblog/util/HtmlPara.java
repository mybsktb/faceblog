package com.faceblog.util;
/**
 * 分页参数处理工具类
 */
public class HtmlPara {
	private static int cur = 1;
	private static int num = 5;
	private static String key = "";

	public static int getCurpage(String strcur) {
		int curpage;
		if (strcur == null) {
			curpage = cur;
		} else {
			curpage = Integer.valueOf(strcur);
		}
		return curpage;
	}

	public static int getCurdatanum(String strcurdatanum) {
		int curdatanum;
		if (strcurdatanum == null) {
			curdatanum = num;

		} else {
			curdatanum = Integer.valueOf(strcurdatanum);
		}
		num = curdatanum;
		return curdatanum;
	}

	public static String getKeyword(String strkeyword) {
		String keyword;
		if (strkeyword == null) {
			keyword = key;
		} else {
			keyword = strkeyword;
		}
		key = keyword;
		return keyword;
	}
}
