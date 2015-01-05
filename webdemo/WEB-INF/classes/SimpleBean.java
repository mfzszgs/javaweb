package cn.mldn.lxh.demo ;
public class SimpleBean {
	private String name ;
	private int age ;
	/*
	public SimpleBean(){
		System.out.println("=======================") ;
	}
	*/
	public void setName(String name){
		System.out.println("----------------------") ;
		this.name = name ;
	}
	public void setAge(int age){
		System.out.println("**********************8") ;
		this.age = age ;
	}
	public String getName(){
		return this.name ;
	}
	public int getAge(){
		return this.age ;
	}
}
