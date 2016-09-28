package com.faceblog.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;

public class Jsp2HtmlUtil {
	private static long star = 0;
	private static long end = 0;
	private static long ttime = 0;

	/**
	 * @param httpUrl 请求的URL
	 * @return html代码字符串
	 */
	public static String getHtmlCode(String httpUrl) {
		Date before = new Date();
		// 开始时间
		star = before.getTime();
		String htmlCode = "";
		try {
			InputStream in;
			URL url = new URL(httpUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection = (HttpURLConnection) url.openConnection();
			connection.setRequestProperty("User-Agent", "Mozilla/4.0");
			connection.connect();
			in = connection.getInputStream();
			BufferedReader breader = new BufferedReader(new InputStreamReader(in, "utf-8"));
			String currentLine;
			while ((currentLine = breader.readLine()) != null) {
				htmlCode += currentLine;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			Date after = new Date();
			//结束时间
			end = after.getTime();
			// 计算执行时间
			ttime = end - star;
			System.out.println("执行时间:" + ttime/1000f + "秒");
		}
		return htmlCode;
	}

	/**
	 * @param filePath 生成的html文件存放位置
	 * @param info 写入html文件中的信息
	 */
	public static synchronized void writeHtml(String filePath, String info) {
		PrintWriter pw = null;
		try {
			File writeFile = new File(filePath);
			
			if (!writeFile.exists()) {
				writeFile.createNewFile();
			} else {
				writeFile.delete();
				writeFile.createNewFile();
			}
			pw = new PrintWriter(new OutputStreamWriter(new FileOutputStream(filePath, true),"utf-8"));
			System.out.println("页面静态化成功!");
			pw.println(info);
			pw.close();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			pw.close();
		}
	}
}  
