package com.beans;

import java.sql.*;

import javax.servlet.http.*;

/*封装分页程序*/

public class Pagination {
	private String strPage = null;// page参数变量
	private int current_Pages;// 当前页数
	private int page_record; // 设置每页显示记录数
	private int total_Pages;// 总页数
	/**
	 * 取得xxx.jsp页面文件里的xxx.jsp?page=<%=current_Pages-1%>或是page=<%=current_Pages+1
	 * %>的值给变量strPage
	 * @param request
	 * @param page为跳转到的页号
	 * @return strPage
	 */
	public String strPage(HttpServletRequest request, String page) {
		try {
			strPage = request.getParameter(page);// request对象取得page的值
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return strPage;
	}

	/**
	 * 设置要显示的当前页数
	 * @param strPage
	 * @return current_Pages（返回页面数）
	 */
	public int current_Pages(String strPage) {
		try {
			if (strPage == null) { // 默认没有就设置是第一页
				current_Pages = 1;
			}
			else {
				current_Pages = Integer.parseInt(strPage);// 取得strPage的整数值
				if (current_Pages < 1) // 如果小于1,同样返回是第一页
					current_Pages = 1;
			}
		}
		catch (Exception e) {
			System.out.print("current_Pages");
		}
		return current_Pages;// 返回页面数
	}

	/**
	 * @param page_record
	 *            设置每页要显示的记录数
	 */
	public void setPage_record(int page_record) {
		this.page_record = page_record;
	}
	
	/**
	 * 取得总页数
	 * @param total_record
	 *            总记录数（查询数据库获得）
	 * @return total_Pages 返回总页数
	 */
	public int getTotal_Pages(int total_record) {
		int test;// 变量
		test = total_record % page_record;// 取得余数
		if (test == 0)
			total_Pages = total_record / page_record;// 每页显示的整数
		else
			total_Pages = total_record / page_record + 1;// 不是整数就加一
		return total_Pages;
	}

	/**
	 * 结果集的返回
	 * @param rs
	 *            结果集
	 * @param current_Pages
	 *            页数 
	 * @return rs 结果集
	 */
	public ResultSet getPageSet(ResultSet rs, int current_Pages) {
		if (current_Pages == 1) {
			return rs;// 如果就一页，就返回这个rs
		}
		else {
			int i = 1;
			try {
				while (rs.next()) {
					i = i + 1;
					if (i > ((current_Pages - 1) * page_record))
						break;// 退出
				}
				return rs;// 从退出开始将结果集返回
			}
			catch (Exception e) {
				System.out.print(e.getMessage());
			}
		}
		return rs;
	}
	
}