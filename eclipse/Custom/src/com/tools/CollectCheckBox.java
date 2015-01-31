package com.tools;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CollectCheckBox extends HttpServlet {
	
	LinkedList<String> arr = new LinkedList<String>();
	


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		this.doPost(request, response);
		
	
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("运没运行啊。。。");
		HttpSession session = request.getSession();
		int page = (Integer) session.getAttribute("page");
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		arr.add(request.getParameter("choose"));//每点击一次多选框，就将该多选框的对应的id号传给链表
		response.sendRedirect("Processer.jsp");
	}

}
