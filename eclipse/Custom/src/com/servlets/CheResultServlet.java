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

public class CheResultServlet extends HttpServlet {

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		this.doPost(request, response);
		
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out=response.getWriter();

		HttpSession session = request.getSession();
		ProDAO prodao = new ProDAO();
		int id =Integer.parseInt(request.getParameter("id"));//获得文件id
		String name = request.getParameter("name");
		session.setAttribute("name", name);
		String suggestion = "";
	/*	System.out.println("name:"+name);
		System.out.println("id:"+id);*/
		
		if(name.equals("pass")){
			try {
				prodao.statexToy(id, 3, 4);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("CheResult.jsp").forward(request, response);
		}else if (name.equals("nopass")){
			
			/*try {
				out.println("<html>");//输出的内容要放在body中
				out.println("<body>");
				out.println("请给出意见：");
				//out.println("<input type='text' name='suggestion'>");
				out.println("<textarea rows='3' cols='4' name ='suggestion'></textarea>");
				out.println("<a href=''>提交</a>");
				out.println("</body>");
				out.println("</html>");
				prodao.updateDocSuggestion(id, suggestion);//添加修改意见
				prodao.statexToy(id, 3, 5);//更改文档状态
			} catch (SQLException e) {
				e.printStackTrace();
			}*/
		}
		
		
	}

}
