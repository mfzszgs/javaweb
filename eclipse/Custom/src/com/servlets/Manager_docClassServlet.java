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

public class Manager_docClassServlet extends HttpServlet {


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
		String docclass = request.getParameter("docclass");
		DAO dao = new DAO();
		try {
			dao.updateDocClass(id, docclass);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("Manager_docClass.jsp").forward(request, response);
	}

}
