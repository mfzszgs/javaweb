<%@page contentType="text/html" pageEncoding="GBK"%>
<html>
<head><title>www.suweiyue.com</title>
<body>
<%
    request.setCharacterEncoding("GBK");
    String param1=request.getParameter("name");
    String param2=request.getParameter("password");
%>
<h3>name:<%=param1%></h3>
<h3>password:<%=param2%></h3>
</body>
</html>
