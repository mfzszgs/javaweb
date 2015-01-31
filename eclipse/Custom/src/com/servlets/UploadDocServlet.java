package com.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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

import com.beans.DAO;

public class UploadDocServlet extends HttpServlet {
	
	public static String dateToString(Date time){
	    SimpleDateFormat formatter;
	    formatter = new SimpleDateFormat ("yyMMddHHmmss");
	    String ctime = formatter.format(time);

	    return ctime;
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=GBK");
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=GBK");
		
		DAO dao = new DAO();
		HttpSession session = request.getSession();
		String loginName = session.getAttribute("registerName").toString();
		try {
			   // 用于设定诸如缓存之类的参数，和性能相关
			   // 此处用默认设定
			   DiskFileItemFactory dfif = new DiskFileItemFactory();
			   // 解析表单中的数据
			   ServletFileUpload upload = new ServletFileUpload(dfif);
			   upload.setSizeMax(10 * 1024 * 1024); // 允许上传的最大值
			   List list = upload.parseRequest(request); // 开始解析request对象中的表单数据
			   // list中是FileItem对象
			   // 一个FileItem用于封装一个上传的文件数据
			   if (list.size() >= 1) {
			    FileItem item = (FileItem) list.get(0);
			    //String name = item.getName();//获得上文件的路径名
			    //name = name.substring(name.lastIndexOf("\\") + 1);
			   
			  //  SimpleDateFormat df = new SimpleDateFormat("yyMMddHHmmssZ");//设置日期格式
				String newName = dateToString(new Date())+"_DOC.pdf";// new Date()为获取当前系统时间 
			    String path = "uploadDoc";// 把上传的文件数据写入本地文（服务器端）件文件夹的名字为uploadDoc
			    ServletContext ctx = this.getServletContext();// Sun的标准，服务器实现的API
			    path = ctx.getRealPath(path);
			    File file = new File(path);
			    if(!file.exists()){
			     file.mkdir();
			    }
			    System.out.println(path);
			    System.out.println(newName);
			    item.write(new File(path, newName)); //将文件放到指定的地方
			         
			    int id = dao.checkUserId(loginName);//将新文件名传到数据库
			    dao.addUserDocUrl(id, newName);
			    response.sendRedirect("UploaderDocResult.jsp");
			   }
			  } catch (Exception e) {
			   throw new ServletException("file upload error!", e);
			  }
		   }
	}


