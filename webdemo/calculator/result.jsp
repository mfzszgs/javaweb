<%@page language="java" import="java.util.LinkedList"  import="java.io.BufferedReader" import="java.io.DataOutputStream" import="java.io.IOException" import="java.io.InputStreamReader" import="java.net.HttpURLConnection" import="java.net.URL" import="java.net.URLEncoder"%>
<html>
<head><title>www.suweiyue.com</title>
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

        String GET_URL = "http://localhost:8080/demo/Calculator";                    
        for(int i=0;i<link.size();i++){
            String str=link.get(i);
            if(str.equals("*"))
            {
                int firstnum=Integer.parseInt(link.get(i-1));
                int secondnum=Integer.parseInt(link.get(i+1));
                int result=0;
                String getURL = GET_URL + "Mul?firstnum="+firstnum+"&secondnum="+secondnum; 
                URL getUrl = new URL(getURL); 
                HttpURLConnection connection = (HttpURLConnection) getUrl.openConnection(); 
                connection.connect(); 
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream())); 
                String lines; 
                if ((lines = reader.readLine()) != null) { 
                    result=Integer.parseInt(lines);
                } 
                reader.close(); 
                connection.disconnect(); 
//                int result=Integer.parseInt(link.get(i-1))*Integer.parseInt(link.get(i+1));
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
