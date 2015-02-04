package com.mfzszgs.mysql.server;

import java.sql.Connection;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;

@WebService
@SOAPBinding(style = Style.RPC)
public interface MysqlConnectionServer {
	@WebMethod
	public Connection getMysqlConnection(String dbdriver, String dburl,
			String dbuser, String dbpassword) throws Exception;
}
