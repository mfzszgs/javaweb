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

public class UploadUpdateServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		response.setContentType("text/html;charset=GBK");
		HttpSession session = request.getSession();
		int id = Integer.parseInt(session.getAttribute("id").toString());
		String title = request.getParameter("docTitle");
		int classId =  Integer.parseInt(request.getParameter("selectDocClass").toString()) ;
		
		response.setContentType("text/html;charset=GBK");
		request.setCharacterEncoding("GBK");
		
		//request.getParameter("updocTitle");
		System.out.println("idºÅ£º"+id);
		System.out.println("classidºÅ£º"+classId);
		System.out.println("titleºÅ£º"+title);
		//Integer.parseInt(request.getParameter("upselectDocClass"));
		
		DAO dao = new DAO();
		try {
			dao.updateDoc(id, title, classId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("Uploader.jsp").forward(request, response);
		
	
	}


		
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=GBK");
		this.doGet(request, response);
	}
			
}
		
