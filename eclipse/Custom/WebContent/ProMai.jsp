<%@page import="com.beans.*"%>
<%@page import="java.io.File"%>
<%@page import="java.lang.*"%>

<%@page import="java.sql.ResultSet"%>
<%@ page language="java"
	import="java.util.*,com.beans.Conn,java.sql.*,com.filter.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<script type="text/javascript" src="jquery-1.11.1.js"></script>

<script type="text/javascript">

	$(function(){
    $(".clsTitle").hover(function(){
 $(".clsContent").show();
 },
 function(){
 $(".clsContent").hide();
})
  }) 
</script>

<title>编辑文档</title>
<link rel="stylesheet" type="text/css" href="MainStyle.css" />

<style type="text/css">
<!--
.STYLE7 {
	color: #FF0000;
	font-weight: bold;
}
.STYLE9 {color: #FF0000}
#Layer1 {
	position:absolute;
	width:749px;
	height:501px;
	z-index:1;
	left: 186px;
	top: 89px;
}
-->
</style>
</head>

<body>

<form name="form" method = "post">
	<p>
		<%@ include file="Public/MyTitle.jsp"%>
	</p>
	
	<%
		int id =Integer.parseInt(request.getParameter("id"));
		DAO dao = new DAO();
		List<DocBean> bli = dao.getDoc(id);
		session.setAttribute("id", id);
	 %>
	<div >
	<%
	
		String virtPath = request.getServletPath();//虚拟路径
		System.out.println("虚拟路径："+virtPath);
		System.out.println("当前WEB应用的物理路径："+application.getRealPath("/"));
		String rawUrl = bli.get(0).getRawUrl();//得到当前档案的rawUrl
		String savepath = getServletConfig().getInitParameter("savePath");
		System.out.println("savepath是----"+savepath);
		String url = savepath+"/"+rawUrl;
		System.out.println("url是----"+url);
		
		
		
	%>
         <iframe src="<%=url%>" width="570" height="570"></iframe>
    	<div class="biaoge" style="width:410px;height:470px;">
    
    
    
    
    <table width="100%" border="1" cellpadding="1" cellspacing="0">
      <tr>
        <td colspan="2"><span class="STYLE7">标题：<input type="text" name="retitle" value="<%=bli.get(0).getTitle()%>" style="width: 303px; "></span></td>
      </tr>
      <tr>
        <td><span class="STYLE7">关键词：
            <input type="text" name ="keywords" value ="<%=bli.get(0).getKeyWords()%>" style="width: 94px; "></span></td>
        <td><span class="STYLE7">关键人：
            <input type="text" name ="keypersons" value ="<%=bli.get(0).getKeyPersons()%>" style="width: 94px; ">
          </span></td>
      </tr>
      <tr>
        <td><span class="STYLE7">起草日期：<input type="text" name ="btime" value ="<%=bli.get(0).getBuildTime()%>" style="width: 80px; "></span></td>
        <td><span class="STYLE7">起草人：<input type="text" name = "builder"  value ="<%=bli.get(0).getBuilder()%>"style="width: 101px; "></span></td>
      </tr>
      <tr>
        <td colspan="2"><span class="STYLE7"  >摘要：<textarea name="abstract" cols="50" rows="1" style="width: 345px; height: 22px"><%=bli.get(0).getDocAbstract()%>" </textarea></span></td>
      </tr>
      <tr>
        <td colspan="2" style="height: 200px; ">
        <div class="STYLE7" style="height:200px; overflow-y:scroll; border:0 solid;"> 原文：<br>
          
          <textarea name="fulltext" cols="50" rows="9" ><%=bli.get(0).getFullText()%>
          </textarea>
        </div></td>
        </tr>
        <tr>
        <td colspan="2" style="height: 200px; ">
        <div class="STYLE7" style="height:200px; overflow-y:scroll; border:0 solid;"> 译文：<br>
          
          <textarea name="translatetext" cols="50" rows="9" ><%=bli.get(0).getTranslateText()%>
          </textarea>
        </div></td>
        </tr>
        
        <tr>
        <td   style="height:25px;"><span class="STYLE9">
        	<a href="ProFile.jsp">返回</a> &nbsp;&nbsp;&nbsp;&nbsp;       
         
            <a href="ProResult.jsp?id=<%=request.getParameter("id")%>">提交档案</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <label>
          <input onClick="form.action='ProUpdateServlet';form.submit();" type="submit" name="Submit" value="保存">
          </label>
        </td>
        <td class="clsTitle"  style="height:25px;"><span class="STYLE12">预览档案</span></td>
        </tr>
    </table>
    </div>
   </div>
    <p align="center">&nbsp;</p>
	<p>&nbsp;</p>
	<p align="center">
	  <%@ include file="Public/MyBottom.jsp"%>
</p>
  
</form>
</body>
</html>
    