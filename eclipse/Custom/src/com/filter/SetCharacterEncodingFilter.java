package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;



import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class SetCharacterEncodingFilter extends HttpServlet implements Filter {
private FilterConfig filterConfig;
private String targetEncoding=null;
public void init(FilterConfig filterConfig)throws ServletException{
   this.filterConfig=filterConfig;
   this.targetEncoding=this.filterConfig.getInitParameter("encoding");
  
}
public void doFilter(ServletRequest request, ServletResponse response,
    FilterChain filterChain) {
   // TODO Auto-generated method stub
   try{
    //�ڿ���̨���Ŀ�����
    System.out.println("targetEncoding:"+targetEncoding+"\n");
    //ִ�б��룬ʵ�ʵĴ�������
    request.setCharacterEncoding(targetEncoding);
    filterChain.doFilter(request,response);
   }
   catch (ServletException sx)
   {
    filterConfig.getServletContext().log(sx.getMessage());
   
   }
   catch (IOException iox){
    filterConfig.getServletContext().log(iox.getMessage());
   }

} 
public void destroy() {
   //�����Դ
   this.filterConfig=null;
   this.targetEncoding=null;
  
}
}
