package com.servlets;
import com.beans.DAO;
import com.filter.*;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;





public class UploadServlet extends HttpServlet {

	private ServletContext sc;
	private String savePath;
	
	public void init(ServletConfig config) {
		  // 在web.xml中设置的一个初始化参数
		  savePath = config.getInitParameter("savePath");
		  sc = config.getServletContext();
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		response.setContentType("text/html;charset=GBK");
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException{
		response.setContentType("text/html;charset=GBK");
		
		String newName = null;
		String[] data = new String[2];
		
		DAO dao = new DAO();
		HttpSession session = request.getSession();
		String loginName = (String)session.getAttribute("loginName");//通过loginName找userId
		
		@SuppressWarnings("deprecation")
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload diskFileUpload = new ServletFileUpload(factory);
		//Map<String, String> parameters = new HashMap<String, String>();	// 定义一个HashMap，存放请求参数
		List fileItems;// 得到所有的文件，以及其它请求参数
		try {
			fileItems = diskFileUpload.parseRequest(request);
			Iterator i = fileItems.iterator();
			String title = null;
			int classId = 10;
			
			while (i.hasNext()) {
			    FileItem fi = (FileItem) i.next();

			    if (!fi.isFormField()) {// 如果是文件,进行上传操作
			    	
			    	if (fi.getName() != null && !fi.getName().equals("")){
			    		title = new String(title .getBytes("ISO-8859-1"),"UTF-8");
			    		  System.out.println("上传文件的大小:" + fi.getSize());
			    	      System.out.println("上传文件的类型:" + fi.getContentType());
			    	      System.out.println("上传文件的名称:" + fi.getName()); // fi.getName()返回上传文件在客户端的完整路径名称   
			    	     // File tempFile = new File(fi.getName());  
			    	      String path = sc.getRealPath("/") + savePath;
			    	      System.out.println("文件目录:"+ path);
			    	      File fileDir = new File(path);//检查上传的文件目录是否存在
							if (!fileDir.exists()) {
								fileDir.mkdirs();
							} 
							
							//SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
							System.out.println("当前系统时间为"+dateToString(new Date()));
							int userId = dao.checkUserId(loginName);
							
							newName = userId+"_"+dateToString(new Date())+".pdf";// new Date()为获取当前系统时间
							
							
			    	      //File file = new File(path, tempFile.getName()); //上传文件的保存路径 在这里要把文件换个名字	
			    	      File file = new File(path,newName);
			    	      fi.write(file);
			    	      request.setAttribute("upload.message", "上传文件成功！");
			    	}else{
			    		request.setAttribute("upload.message", "没有选择上传文件！");
			    	}
			    }
			    
			    else{// 如果是请求参数
				    String name = fi.getFieldName();
			    	String value = fi.getString();
			    	if(name.equals("docTitle")){
			    		title = value;
			    	}
			    	else if(name.equals("selectDocClass")){
			    		classId = Integer.parseInt(value);
			    	}
			    	}  
			}
			
			
			System.out.println("title==="+title);
			System.out.println("classId==="+classId);
			
			dao.addDocOne(title, classId, loginName,newName);
			
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("upload.message", "上传文件失败！");
		}
		
		request.getRequestDispatcher("UploaderResult.jsp").forward(request, response);
	
	/*		HttpSession session = request.getSession();
			String title = request.getParameter("docTitle");
			System.out.println("docTitle"+ title);
			int classId = Integer.parseInt(request.getParameter("selectDocClass"));
			String loginName = (String)session.getAttribute("loginName");//通过loginName找userId
			
			response.setContentType("text/html;charset=UTF-8");
			request.setCharacterEncoding("UTF-8");
			
		try {
			DAO dao = new DAO();
			boolean flag = dao.addDocOne(title, classId, loginName);
			session.setAttribute("addDocOneResult",flag);
			response.sendRedirect("UploaderResult.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}*/
	}
	
	public static String dateToString(Date time){
	    SimpleDateFormat formatter;
	    formatter = new SimpleDateFormat ("yyMMddHHmmss");
	    String ctime = formatter.format(time);

	    return ctime;
	}

}
