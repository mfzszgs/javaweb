<%@page language="java" import="java.util.LinkedList"  import="com.wing.www.Compute"%>
<html>
<head><title>www.suweiyue.com</title>
</head>
<jsp:useBean id="bean" scope="page" class="com.wing.www.Compute"/>
<jsp:setProperty name="bean" property="*"/>
<body>
<%    
    bean.compute();
%>
<jsp:getProperty name="bean" property="result"/>
</body>
</html>
