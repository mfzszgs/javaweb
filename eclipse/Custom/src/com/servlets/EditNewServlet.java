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

public class EditNewServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		this.doPost(request, response);
	
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int id = Integer.parseInt(session.getAttribute("id").toString());//获得新闻id号
		int uid = Integer.parseInt(session.getAttribute("uid").toString());//获得新闻作者id号
		String title = request.getParameter("Title");
		int columnId = Integer.parseInt(request.getParameter("selectNewCol"));
		//String inputDate = request.getParameter("inputdate");
		String keywords = request.getParameter("keywords");
		String fullText = request.getParameter("fulltext");
		fullText = fullText.replace("<br>", "\n");
		fullText = fullText.replace("&nbsp;", " ");
		//int authorId = Integer.parseInt(request.getParameter("uid"));
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		try {
			DAO dao = new DAO();
			PubDAO pubdao = new PubDAO();
			pubdao.editNews(id, title, keywords, columnId, fullText);
			response.sendRedirect("Publisher.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	}

}
