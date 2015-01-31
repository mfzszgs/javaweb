package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.DAO;
import com.beans.PubDAO;

public class AddNewServlet extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String title = request.getParameter("Title");
		int columnId = Integer.parseInt(request.getParameter("selectNewCol"));
		String inputDate = request.getParameter("inputdate");
		String keywords = request.getParameter("keywords");
		String fullText = request.getParameter("fulltext");
		fullText = fullText.replace("<br>", "\n");
		fullText = fullText.replace("&nbsp;", " ");
		int authorId = Integer.parseInt(request.getParameter("uid"));
		
		System.out.println("authorId:"+authorId);
		
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		try {
			PubDAO pubdao = new PubDAO();
			boolean flag = pubdao.addNews(title, authorId, keywords, inputDate, columnId, fullText);
			session.setAttribute("addnewResult",flag);
			response.sendRedirect("NewAddResult.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
