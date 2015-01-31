package com.servlets;

import java.io.IOException;

import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.DAO;
import com.beans.ProDAO;

public class ProChStaServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		this.doPost(request, response);
	
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		DAO dao = new DAO();
		ProDAO prodao = new ProDAO();
		
		int id = 0;
		String loginName = (String)session.getAttribute("loginName");/*通过loginName得到该用户的Id*/
		String[] arr = request.getParameterValues("choose");
		try {
			int uid = dao.checkUserId(loginName);		
			for(int i=0;i<arr.length;i++){
				id = Integer.parseInt(arr[i]);
				prodao.updateDoc(id, uid);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect("ProFile.jsp");
	
	}

}
