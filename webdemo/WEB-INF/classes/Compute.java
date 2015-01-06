package com.wing.www;

import java.io.IOException;
import java.util.LinkedList;

public class Compute {

	private String url;
	private int result;
	private String input;
	public void setUrl(String str){
		url=str;
	}
	public void setInput(String str){
		input=str;
	}
	public int getResult(){
		return result;
	}
	
	public void compute() throws IOException {
		LinkedList<String> link = new LinkedList<String>();
		StringBuilder stringbuilder = new StringBuilder();
		for (int i = 0; i < input.length(); i++) {
			char c = input.charAt(i);
			if (c == '+' || c == '-' || c == '*' || c == '/') {
				link.add(stringbuilder.toString());
				stringbuilder.delete(0, stringbuilder.length());
				link.add(String.valueOf(c));
			} else {
				stringbuilder.append(c);
			}
		}
		link.add(stringbuilder.toString());

		for (int i = 0; i < link.size(); i++) {
			String str = link.get(i);
			if (str.equals("*")) {
				Operator operator=new Operator();
				operator.setFirstNum(Integer.parseInt(link.get(i - 1)));
				operator.setSecondNum(Integer.parseInt(link.get(i + 1)));
				operator.setUrl(url);
				operator.setOpera("Mul");
                link.remove(i);
                link.remove(i);
                link.set(--i,Integer.toString(operator.getResult()));
			}else if(str.equals("/")){
				Operator operator=new Operator();
				operator.setFirstNum(Integer.parseInt(link.get(i - 1)));
				operator.setSecondNum(Integer.parseInt(link.get(i + 1)));
				operator.setUrl(url);
				operator.setOpera("Div");
                link.remove(i);
                link.remove(i);
                link.set(--i,Integer.toString(operator.getResult()));
            }
		}
		
		for (int i = 0; i < link.size(); i++) {
			String str = link.get(i);
			if (str.equals("+")) {
				Operator operator=new Operator();
				operator.setFirstNum(Integer.parseInt(link.get(i - 1)));
				operator.setSecondNum(Integer.parseInt(link.get(i + 1)));
				operator.setUrl(url);
				operator.setOpera("Add");
                link.remove(i);
                link.remove(i);
                link.set(--i,Integer.toString(operator.getResult()));
			}else if(str.equals("-")){
				Operator operator=new Operator();
				operator.setFirstNum(Integer.parseInt(link.get(i - 1)));
				operator.setSecondNum(Integer.parseInt(link.get(i + 1)));
				operator.setUrl(url);
				operator.setOpera("sub");
                link.remove(i);
                link.remove(i);
                link.set(--i,Integer.toString(operator.getResult()));
            }
		}
		result=Integer.parseInt(link.getFirst());
	}
}
