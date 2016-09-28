package com.faceblog.filter;

import java.io.File;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.faceblog.common.Const;
import com.faceblog.util.Jsp2HtmlUtil;

/**
 *	页面静态化过滤器
 */
public class StaticHtmlFilter implements Filter {
	// 防止递归
	public static String flag = Const.EMPTY;
	// 个人博客首页
	private static final String RECOMM = "Recomm";
	
	
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)arg0;
		HttpServletResponse response = (HttpServletResponse)arg1;
		
		// 获取用户ID
		String userId = request.getParameter("userId");
		// 获取URL
		String urlStr = request.getRequestURL().toString();
		int index = urlStr.lastIndexOf("/");
		String url = urlStr.substring(0, index);
		String uri = request.getRequestURI();
		System.out.println("uri:  "+uri);
		// 获取参数字符串
		String queryString = request.getQueryString();
		// 获取tomcat下路径
		String path = request.getSession().getServletContext().getRealPath("/blog/statichtml/");
		// 
		String fileName = getFileNameByUrl(urlStr) + "_" + userId + ".html";
		if(Const.EMPTY.equals(flag)){
			// 个人博客首页
			if(Const.BLOG_INDEX_URL.equals(uri)){
				
				File file = new File(path + "/"+ fileName);
				if(file.exists()){
					response.sendRedirect(url + "/statichtml/"+ fileName);
					flag = Const.EMPTY;
					return;
				} else{
					flag = Const.NOT_EMPTY;
					Jsp2HtmlUtil.writeHtml(path + "/"+ fileName, Jsp2HtmlUtil.getHtmlCode(urlStr + "?" + queryString));
					response.sendRedirect(url + "/statichtml/"+ fileName);
					flag = Const.EMPTY;
					return;
				}
			// 关于我
			} else if(Const.BLOG_ABOUT_URL.equals(uri)){

				File file = new File(path + "/"+ fileName);
				if(file.exists()){
					response.sendRedirect(url + "/statichtml/"+ fileName);
					flag = Const.EMPTY;
					return;
				} else{
					flag = Const.NOT_EMPTY;
					Jsp2HtmlUtil.writeHtml(path + "/"+ fileName, Jsp2HtmlUtil.getHtmlCode(urlStr + "?" + queryString));
					response.sendRedirect(url + "/statichtml/"+ fileName);
					flag = Const.EMPTY;
					return;
				}
			}
		}
		arg2.doFilter(arg0, arg1);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
	}
	
	/**
	 * 获取文件名
	 * @param url 
	 * @return 文件名
	 */
	private static String getFileNameByUrl(String url){
		String fileName = "";
		if(url == null){
			return null;
		}
		// 是否带参
		int indexOfQuestMark = url.indexOf("?");
		// 
		int lastIndexOfSlash = url.lastIndexOf("/");
		String str = "";
		if(indexOfQuestMark!=-1){
			str = url.substring(lastIndexOfSlash+1, indexOfQuestMark);
			
		}else{
			str = url.substring(lastIndexOfSlash+1);
		}
		// 处理文件名
		int indexOfPiontJsp = str.indexOf(".jsp");
		if(indexOfPiontJsp!=-1){
			fileName = str.substring(0, indexOfPiontJsp);
		} else{
			fileName = str;
			if(RECOMM.equals(fileName)){
				fileName = "index";
			}
		}
		return fileName;
	}
}
