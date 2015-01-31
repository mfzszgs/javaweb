package com.wing.www;

import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

public class ConnectionDemo01 {

	public static final String DBDRIVER="org.gjt.mm.mysql.Driver";
	public static final String DBURL="jdbc:mysql://localhost:3306/firstdb";
	public static final String DBUSER="root";
	public static final String DBPASS="s";
	public static void main(String[] args){
		Connection conn=null;
		try{
			Class.forName(DBDRIVER);
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}
		try{
			conn=(Connection) DriverManager.getConnection(DBURL, DBUSER, DBPASS);
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		System.out.println(conn);
		try{
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
}
