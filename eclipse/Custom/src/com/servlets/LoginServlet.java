package com.servlets;

/*1.通过loginName判断在数据库里找到该用户
2.找到该用户的类别返回给servlet
3.通过该类别选择跳转到相应的用户主界面*/

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.DAO;
import com.beans.UsersBean;

public class LoginServlet extends HttpServlet {
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
		try {
			String path = null;
			HttpSession session = request.getSession();
			String loginName = request.getParameter("loginName");
			String password = request.getParameter("password");
			
			DAO dao = new DAO();
			int i = dao.checkUserClass(loginName);
			int id =dao.checkUserId(loginName);
			System.out.println("loginName----"+loginName+"i---"+i+"id-----"+id);
			boolean flag = dao.checkUser(loginName, password);//检查是否能登录成功
			if (flag) {
				session.setAttribute("loginName", loginName);//在session中设置loginName的值
				switch(i){
				case 1:path = "Manager.jsp";break;
				case 2:path = "Uploader.jsp";break;
				case 3:List<UsersBean> user= dao.getUser(id);
						if(user.get(0).getAuthority()==0){
							path = "ProcesserFail.jsp";
						}else if(user.get(0).getAuthority()==1){
							path = "Processer.jsp";
						}
				break;//针对众包人员，若校审通过，才能跳转到众包人员界面
				case 4:path = "Checker.jsp";break;
				case 5:path = "Publisher.jsp";break;
				case 6:path = "Scholar.jsp";break;
				case 7:path = "Editor.jsp";break;
				}	
			} else {
				path = "LoginFail.jsp";
			}
			request.getRequestDispatcher(path).forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	/*	LoginBean lb = new LoginBean();
		lb.setName(username);
		lb.setPassword(password);
		boolean flag = lb.isValidate();
		if (flag) {
			session.setAttribute("name", lb.getName());
			path = "success.jsp";
		} else {
			path = "fail.jsp";
		}*/
		

	}
}