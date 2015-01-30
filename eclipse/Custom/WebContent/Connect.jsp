<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>常用链接</title>
	<link rel="stylesheet" type="text/css" href="MyStyle.css"/>
    <style type="text/css">
<!--
.STYLE1 {font-size: 18px}
.STYLE2 {font-size: 36px}
.STYLE3 {font-size: 36}
.STYLE4 {font-size: large}
.STYLE5 {color: #FF0000}
.STYLE7 {color: #00FF00}
.STYLE10 {color: #F0F0F0}
.STYLE12 {font-size: large; color: #FF0000; }
-->
    </style>
</head>
  
  <body>
  	<form>
	  	 <p>
	  	   <%@ include file="Public/MyTitle.jsp"%>
         </p>
  	  <p align="center" class="STYLE12"><a href="http://guangzhou.customs.gov.cn/publish/portal31/" class="STYLE5" >广州海关</a> </p>
	  	 <p align="center" class="STYLE12"><a href="http://www.qgtong.com/dfgg/haiguan/gzhg/Index.html" class="STYLE5" >全关通信息网</a>      </p>
	  	 <p align="center" class="STYLE12"><a href="http://map.sogou.com/#city=%u5e7f%u5dde&lq=%u5E7F%u5DDE%u6D77%u5173&uids=1_D1000052257200&c=12614287,2629897,15&where=12612218.75,2628617.1875,12616351.5625,2631179.6875,0&page=1,10" class="STYLE5">广州海关搜狗地图</a>  	    </p>
	  	 <p align="center" class="STYLE12"><a href="http://www.customs.gov.cn/publish/portal0/tab39267/info443364.htm" class="STYLE5">广州海关开门听意见</a> 	           </p>
	  	 <p>
	  	   <%@ include file="Public/MyBottom.jsp"%>
      </p>
  	</form>
  </body>
</html>
