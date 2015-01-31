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

public class Manager_newsClassServlet extends HttpServlet {


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		int id =  (Integer) session.getAttribute("id");
		String newsclass = request.getParameter("newsclass");
		PubDAO pubdao = new PubDAO();
		try {
			pubdao.updateNewsClass(id, newsclass);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("Manager_newsClass.jsp").forward(request, response);
	}

}
