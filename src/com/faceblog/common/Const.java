package com.faceblog.common;

public class Const {
	// 空字符串
	public static final String EMPTY = "";
	// 非空字符串
	public static final String NOT_EMPTY = "not_empty";
	// 分页，每页显示记录数
	public static final int PAGE_SIZE=5;
	// cookie最大寿命
	public static final int COOKIE_MAXAGE=7*24*60*60;
	// 显示的推荐文章和最新文章的条数
	public static final int NUM_R_L_ARTICLE = 8;
	// 栏目使用最多的前几个
	public static final int NUM_CATE_RANK=4;
	//	文章预览最多显示字数
	public static final int NUM_ARTI_LOOK=100;
	// 个人博客首页
	public static final String BLOG_INDEX_URL = "/faceblog/blog/Recomm";
	// 关于我
	public static final String BLOG_ABOUT_URL = "/faceblog/blog/about.jsp";
	// 最近访客显示行数
	public static final int NUM_RECENT_LINE = 4;
	// 最近访客一行显示个数
	public static final int NUM_RECENT_V_ONE_LINE = 5;
	// 密码加密次数
	public static final int NUM_MD5 = 5;

}
