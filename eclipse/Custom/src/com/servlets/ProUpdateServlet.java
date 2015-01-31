package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.ProDAO;

public class ProUpdateServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		int id = Integer.parseInt(session.getAttribute("id").toString());
		String retitle = request.getParameter("retitle");
		String keywords = request.getParameter("keywords");
		System.out.println("keywords"+keywords);
		String keypersons = request.getParameter("keypersons");
		String buildtime = request.getParameter("btime");
		String builder = request.getParameter("builder");
		String abstracts = request.getParameter("abstract");
		String fulltext = request.getParameter("fulltext");
		String translatetext = request.getParameter("translatetext");
		ProDAO prodao = new ProDAO();
				try {
					prodao.updateAllDoc(id,retitle,keywords,keypersons,buildtime,builder,abstracts,fulltext,translatetext);
				} catch (SQLException e) {
			
			e.printStackTrace();
		}
		request.getRequestDispatcher("ProFile.jsp").forward(request, response);

	}

}
