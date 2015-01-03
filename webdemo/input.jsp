<html>
<head>
    <title>www.suweiyue.com</title>
</head>
<body>
    <%
        int number1;
        number1=Integer.parseInt(request.getParameter("number1"));
        int number2;
        number2=Integer.parseInt(request.getParameter("number2"));
        String symbol=request.getParameter("symbol");
    %>
    <%  
        if(symbol.equals("+")){ 
    %>
    <%=number1+number2%>
    <%
        }
        else if(symbol.equals("-")){
    %>
    <%=number1-number2%>
    <%
        }
        else if(symbol.equals("×")){
    %>
    <%=number1*number2%>
    <%
        }
        else if(symbol.equals("/")){
    %>
    <%=number1/number2%>
    <%
        }
    %>
</body>
</html>
