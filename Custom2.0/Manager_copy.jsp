<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>My JSP 'Manager.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="MyStyle.css" />
<link rel="stylesheet" type="text/css" href="manager.css" />

<script type="text/javascript" src="jquery-1.11.1.js"></script>
<script type="text/javascript">
	function zvTab(){ 
	    $(".tab ul li").each(function(index){ 
	        $(this).mouseover(function(){ 
	            var t = $(this); 
	            timeoutid = setTimeout(function(){ 
	                $(".tab ul li.current").removeClass("current"); 
	                t.addClass("current"); 
	                $(".tab div.current").removeClass("current"); 
	                $(".tab div").eq(index).addClass("current"); 
	            },300); 
	        }).mouseout(function(){ 
	            clearTimeout(timeoutid); 
	        }); 
	    }); 
	  
	}
	
</script>




</head>

<body>
	<p>
		<%@ include file="Public/MyTitle.jsp"%>
	</p>

	<div class="tab">
		<ul class="clearfix">
			<li class="current"><a href="#">标签1</a></li>
			<li><a href="#">标签2</a></li>
			<li><a href="#">标签3</a></li>
		</ul>
		<div class="current">
			<img src="images/logo.png" alt="11.jpg" />
		</div>
		<div>
			<img src="images/logo1.png" alt="22.jpg" />
		</div>
		<div>
			<img src="images/pass1.png" alt="33.jpg" />
		</div>
	</div>
	
	
	
	
	
	






	<p>
		<%@ include file="Public/MyBottom.jsp"%>
	</p>
</body>
</html>
