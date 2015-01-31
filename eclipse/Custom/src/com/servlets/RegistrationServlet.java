package com.servlets;
import com.beans.DAO;
import com.beans.UsersBean;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class RegistrationServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/html;charset=GBK");
		this.doPost(req, resp);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		    response.setContentType("text/html;charset=GBK");
				UsersBean ub = new UsersBean();//将用户注册的信息数据封装在ub用户对象中
				ub.setLoginName(request.getParameter("loginName"));
				ub.setAddress(request.getParameter("address"));
				ub.setEmail(request.getParameter("Email"));
				ub.setName(request.getParameter("realName"));
				ub.setOfficeNumber(request.getParameter("officeNumber"));
				ub.setOrganization(request.getParameter("organization"));
				ub.setPassword(request.getParameter("password"));
				ub.setPhoneNumber(request.getParameter("phoneNumber"));
				ub.setPostCode(request.getParameter("postCode"));
				ub.setUserClass(Integer.parseInt(request.getParameter("userClass")));
				ub.setSexId(Integer.parseInt(request.getParameter("sexId")));
				
				response.setContentType("text/html;charset=GBK");
				request.setCharacterEncoding("GBK");
				PrintWriter out = response.getWriter();
				/*out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
				out.println("<HTML>");
				out.println(" <HEAD><TITLE>用户注册结果</TITLE></HEAD>");
				out.println(" <BODY>");*/
				int result = 1;
				DAO dao = new DAO();
				int i = dao.userIsExist(ub.getLoginName());
				
				System.out.println("-------用户ID："+ub.getUserClass());
				
				
				
				
				
				if(i!=0){
					result = 2;
				}
				else if(i==0){
					boolean flag = dao.addUser(ub);
						if (flag) {
							if((ub.getUserClass())==3){//如果是众包人员，进入校审页面
								result = 3;
							}
							else{
								result = 0;
							}
							/*out.print("<script type='text/javascript' language='javascript'> alert('用户注册成功!');return false;</script>");
							out.println("用户注册成功!");*/
						}else{
							result = 1;
							/*out.print("<script type='text/javascript' language='javascript'> alert('用户注册失败!');return false;</script>");
							out.println("用户注册失败!");*/
						}
				}
				request.getSession().setAttribute("registrationResult", result);
				request.getSession().setAttribute("registerName", ub.getLoginName());
				
				response.sendRedirect("RegistrationResult.jsp");
				out.flush();
				out.close();
			    
		} 
}


