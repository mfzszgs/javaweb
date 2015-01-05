package com.suweiyue.www;
import java.io.* ;
import javax.servlet.* ;
import javax.servlet.http.* ;
public class CheckServlet extends HttpServlet{
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		this.doPost(request,response) ;
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
		request.setCharacterEncoding("utf-8") ;
		response.setContentType("text/html") ;
		PrintWriter out = response.getWriter() ;
		String firstnum = request.getParameter("firstnum");
		String secondnum = request.getParameter("secondnum");
		try{
            int result=Integer.parseInt(link.get(i-1))*Integer.parseInt(link.get(i+1));
			out.print(result) ;
			}
		}catch(Exception e){
			e.printStackTrace() ;
		}finally{
			try{
			}catch(Exception e){}
		}
	}
}
