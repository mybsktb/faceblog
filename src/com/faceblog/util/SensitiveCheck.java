package com.faceblog.util;

import java.util.List;
import java.util.Map;
/**
 * 敏感词自动检测工具类，0是未审核，-1是未通过
 */
public class SensitiveCheck {
	private static final int SENSITIVE_NUM = 5;

	public static int artiCheck(String content) {
		String sql = "select * from sensitive_tab";
		List<Map<String, Object>> res = JDBCUtil.doQuery(sql);
		int size = res.size();
		String sensitive;
		int number = 0;
		for (int i = 0; i < size; i++) {
			sensitive = (String) res.get(i).get("word");
			while (content.indexOf(sensitive) >= 0) {
				number++;
				content = content.replaceFirst("\\" + sensitive, "");
				if (number >= SENSITIVE_NUM) {
					return -1;
				}
			}
		}
		return 0;
	}
}
