package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import com.beans.ChDAO;
import com.beans.DAO;
import com.beans.EditDAO;
import com.beans.ProDAO;
import com.beans.PubDAO;
import com.beans.DocBean;
import com.beans.NewsBean;



public class SearchServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		response.setContentType("text/html;charset=UTF-8");
		this.doPost(request, response);
	}
	

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		String keyword = request.getParameter("keyword");
		DAO dao = new DAO();
		ProDAO prodao = new ProDAO();
		ChDAO chdao = new ChDAO();
		PubDAO pubdao = new PubDAO();
		EditDAO edao = new EditDAO();
		
		if(request.getParameter("jsp").equals("Uploader")){//档案上传人员搜索
			try {

				LinkedList<DocBean> li = dao.uploadgetDocByKey(keyword);
				ListIterator<DocBean> aIter=li.listIterator();
				DocBean docb= new DocBean();
				request.setAttribute("SearchList", li);
				request.setAttribute("aIter",aIter);
				request.setAttribute("docb", docb);
			
				request.getRequestDispatcher("UpSearchResult.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(request.getParameter("jsp").equals("Processer")){//众包人员“找档案”搜索
			int classId = Integer.parseInt(request.getParameter("selectDocClass").toString());	
			try {
				
				LinkedList<DocBean> li = dao.proGetDocByKC(keyword,classId);
				ListIterator<DocBean> aIter=li.listIterator();
				DocBean docb= new DocBean();
				request.setAttribute("SearchList", li);
				request.setAttribute("aIter",aIter);
				request.setAttribute("docb", docb);
			
				request.getRequestDispatcher("ProSearchResult.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}else if(request.getParameter("jsp").equals("ProFile")){//众包人员“我的档案”搜索
			int stateId = Integer.parseInt(request.getParameter("selectDocState").toString());	
			try {
				int uid = Integer.parseInt(session.getAttribute("uid").toString()) ;
			
				LinkedList<DocBean> li = prodao.proGetDocByKS(keyword,stateId,uid);
				ListIterator<DocBean> aIter=li.listIterator();
				DocBean docb= new DocBean();
				request.setAttribute("SearchList", li);
				request.setAttribute("aIter",aIter);
				request.setAttribute("docb", docb);
				request.getRequestDispatcher("ProFileSearchResult.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(request.getParameter("jsp").equals("Checker")){//校审人员搜索
			int userId = Integer.parseInt(request.getParameter("selectProName").toString());//为0时搜索所有众包人员
			int classId = Integer.parseInt(request.getParameter("selectDocClass").toString());//为0时搜索所有档案类型
			try {
			
				LinkedList<DocBean> li = chdao.cheGetDocByKCN(keyword, classId, userId);
				ListIterator<DocBean> aIter=li.listIterator();
				DocBean docb= new DocBean();
				request.setAttribute("SearchList", li);
				request.setAttribute("aIter",aIter);
				request.setAttribute("docb", docb);
				request.getRequestDispatcher("ChSearchResult.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
		}
		out.flush();
		out.close();
	}else if(request.getParameter("jsp").equals("Publisher")){//新闻发布人员搜索
		int columnId = Integer.parseInt(request.getParameter("selectNewCol").toString());	
		try {
			//System.out.println("columnId:"+columnId + "keyword:"+keyword);
			LinkedList<NewsBean> li = pubdao.pubGetNewsByKC(keyword, columnId);
			System.out.println("li的长度是："+li.size());
			ListIterator<NewsBean> aIter=li.listIterator();
			NewsBean newb= new NewsBean();
			request.setAttribute("SearchList", li);
			request.setAttribute("aIter",aIter);
			request.setAttribute("newb", newb);
		
			request.getRequestDispatcher("PubSearchResult.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}else if(request.getParameter("jsp").equals("Editor")){//主编档案搜索，可以按关键字，类别，时间段搜索
		int classId = Integer.parseInt(request.getParameter("selectDocClass").toString());	
		try {
			String builder = request.getParameter("builder");
			String startBt = request.getParameter("startBt");
			String endBt = request.getParameter("endBt");
			
			LinkedList<DocBean> li = edao.editGetDocByKCBT(keyword, classId, builder, startBt, endBt);
			ListIterator<DocBean> aIter=li.listIterator();
			DocBean docb= new DocBean();
			request.setAttribute("SearchList", li);
			request.setAttribute("aIter",aIter);
			request.setAttribute("docb", docb);
		
			request.getRequestDispatcher("EditSearchResult.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
	
}

