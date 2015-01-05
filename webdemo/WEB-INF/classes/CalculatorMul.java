package com.suweiyue.www;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;
public class CalculatorMul extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		this.doPost(request,response) ;
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		request.setCharacterEncoding("GBK") ;
		response.setContentType("text/html") ;
		PrintWriter out = response.getWriter() ;
		String firstnum = request.getParameter("firstnum");
		String secondnum = request.getParameter("secondnum");
		try{
            int result=Integer.parseInt(firstnum)*Integer.parseInt(secondnum);
			out.print(result) ;
			
		}catch(Exception e){
			e.printStackTrace() ;
		}finally{
			try{
			}catch(Exception e){}
		}
	}
}
