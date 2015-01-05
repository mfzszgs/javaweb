package org.lxh.ajaxdemo ;
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
		String userid = request.getParameter("userid") ;
		try{
			if(true){
				if(userid.equals("wing")){ 
					out.print("true") ;
				} else {
					out.print("false") ;
				}
			}
		}catch(Exception e){
			e.printStackTrace() ;
		}finally{
			try{
			}catch(Exception e){}
		}
	}
}
