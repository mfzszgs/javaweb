<%@page language="java" import="java.util.LinkedList"%>
<html>
<head><title>www.suweiyue.com</title>
    <script language="javascript">
        var xmlHttp ;
        function createXMLHttp(){
            if(window.XMLHttpRequest){
                xmlHttp = new XMLHttpRequest() ;
            } else {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP") ;
            }
        }
        function mul(firstnum,secondnum){
            createXMLHttp() ;
            xmlHttp.open("POST","../CalculatorMul?firstnum="+firstnum+"&secondnum="+secondnum) ;
            xmlHttp.onreadystatechange = mulCallback;
            xmlHttp.send(null) ;
        }
        function mulCallback(){
            if(xmlHttp.readyState == 4){
                if(xmlHttp.status == 200){
                    
                    var text = xmlHttp.responseText ;
                }
            }
        }
        function getText(){
            return text ;
        }
    </script>

</head>
<%
        LinkedList<String> link = new LinkedList<String>();
        String example =request.getParameter("input");
        StringBuilder stringbuilder = new StringBuilder();
        for (int i = 0; i < example.length(); i++) {
            char c = example.charAt(i);
            if (c == '+' || c == '-' || c == '*' || c == '/') {
                link.add(stringbuilder.toString());
                stringbuilder.delete(0, stringbuilder.length());
                link.add(String.valueOf(c));
            } else {
                stringbuilder.append(c);
            }
        }
        link.add(stringbuilder.toString());

        for(int i=0;i<link.size();i++){
            String str=link.get(i);
            if(str.equals("*"))
            {
                int firstnum=Integer.parseInt(link.get(i-1));
                int secondnum=Integer.parseInt(link.get(i+1));
%>
    <script language="JavaScript">
                mul(<%=firstnum%>,<%=secondnum%>);
                document.write(return getText());
                document.write("java");
    </script>
<%
//                int result=Integer.parseInt(%><script language="JavaScript">//return getText()</script><%//);
                int result=Integer.parseInt(link.get(i-1))*Integer.parseInt(link.get(i+1));
                link.remove(i);
                link.remove(i);
                link.set(--i,Integer.toString(result));
            }else if(str.equals("/")){
                int result=Integer.parseInt(link.get(i-1))/Integer.parseInt(link.get(i+1));
                link.remove(i);
                link.remove(i);
                link.set(--i,Integer.toString(result));
            }
        }

        for(int i=0;i<link.size();i++){
            String str=link.get(i);
            if(str.equals("+")){
                int result=Integer.parseInt(link.get(i-1))+Integer.parseInt(link.get(i+1));
                link.remove(i);
                link.remove(i);
                link.set(--i,Integer.toString(result));

            }else if(str.equals("-")){
                int result=Integer.parseInt(link.get(i-1))-Integer.parseInt(link.get(i+1));
                link.remove(i);
                link.remove(i);
                link.set(--i,Integer.toString(result));
            }
        }
%>
<%=link.getFirst()%>
</html>
