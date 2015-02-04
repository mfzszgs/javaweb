package com.mfzszgs.mysql.server;

import java.sql.Connection;
import java.sql.DriverManager;
import javax.jws.WebService;

@WebService(endpointInterface = "com.mfzszgs.mysql.server.MysqlConnectionServer")
public class MysqlConnectionServerImpl implements MysqlConnectionServer {
	private Connection con;

	public Connection getMysqlConnection(String dbdriver, String dburl,
			String dbuser, String dbpassword) throws Exception {
		// TODO Auto-generated method stub
		
		
		Class.forName(dbdriver);
		System.out.println("驱动加载！");
		con = DriverManager.getConnection(dburl, dbuser, dbuser);
		return con;
	}
}
