package com.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.DAO;
import com.beans.DocBean;
import com.beans.ProDAO;
import com.beans.PubDAO;

public class DelServlet extends HttpServlet {
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html");
		int id =Integer.parseInt(request.getParameter("id"));
		DAO dao = new DAO();
		ProDAO prodao = new ProDAO();
		PubDAO pubdao = new PubDAO();
		
		if(request.getParameter("jsp").equals("Uploader")){
			try {
				String rawUrl = dao.getDoc(id).get(0).getRawUrl(); //根据id找到上传的文件名
				ServletContext ctx = this.getServletContext();
				String path = "uploads";
				path = ctx.getRealPath(path)+ "\\"+rawUrl;
				System.out.println("路径为"+path);
				File file = new File(path); 
				    if (file.isFile() && file.exists()) {  
				        file.delete();  
				    } 
				 //获取文件的存放路径

				dao.delFromBasicinfo(id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("Uploader.jsp").forward(request, response);	
		}
		else if(request.getParameter("jsp").equals("ProFile")){
			try {
				prodao.delFromProFile(id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("ProFile.jsp").forward(request, response);
		}
		else if(request.getParameter("jsp").equals("Publisher")){
			try {
				pubdao.delFromNews(id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("Publisher.jsp").forward(request, response);
		}
		else if(request.getParameter("jsp").equals("Manager_userInfo")){
			try {
				List<DocBean> daoli = dao.getDocByUser(id);
				if(daoli.size()!=0){
					request.getRequestDispatcher("Manager_userInfo.jsp").forward(request, response);
					System.out.println("不能删除，该用户还有包在处理！");
				}
				dao.delFromUser(id);//删除某一个用户，如果该用户有包在处理，则不能删除
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("Manager_userInfo.jsp").forward(request, response);
		}

		/*int id = request.getParameter("");
		dao.delFromBasicinfo(id);*/
	}

}
