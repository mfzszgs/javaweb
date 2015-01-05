<%@page language="java" import="java.util.LinkedList"%>
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
            if(str.equals("*")){
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

