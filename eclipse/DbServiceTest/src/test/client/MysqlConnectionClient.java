package test.client;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import test.server.ConnectionDelegation;
import test.server.ResultSetDelegation;
import test.server.StatementDelegation;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MysqlConnectionClient {

	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost:3306/customsdb";
	/*
	 * private static final String URL =
	 * "jdbc:mysql://192.168.1.79:3306/customsdb";
	 */
	private static final String USER = "root";
	private static final String PASSWORD = "s";

	public static void main(String args[]) throws Exception {
		URL url = new URL("http://localhost:10101/mysql?wsdl");

		// Qualified name of the service:
		// 1st arg is the service URI
		// 2nd is the service name published in the WSDL
		QName qname = new QName("http://server.test/",
				"ConnectionDelegationImplService");
  
		// Create, in effect, a factory for the service.
		Service service = Service.create(url, qname);

		// Extract the endpoint interface, the service "port".
		
//		MysqlConnectionServer db = service.getPort(MysqlConnectionServer.class);
		ConnectionDelegation conn = service.getPort(ConnectionDelegation.class);
		
		try {
		conn.getConnect(DRIVER, URL, USER, PASSWORD);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(conn!=null)System.out.println("!NULL");
		int i=1;
		List<String> li = new ArrayList<String>();
		StatementDelegation stmt = null;
		ResultSetDelegation rs = null;
		String sql = null;
		try {
		if (!conn.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if(i == 0){
				sql = "select ColumnName from newscolumn";
			}
			else{
				sql = "select ColumnName from newscolumn where id = '"+i+"'";
			}
			stmt = conn.createStatement();
			stmt.setConn(conn);
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			rs.setConn(conn);
			while(rs.next()){
				li.add(rs.getString("ColumnName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
//  			conn.closeRs();
//			conn.closeStmt();
//			conn.close();

			rs.close();
			stmt.close();
			conn.close();
			System.out.println(li);
		}
		
	}
}
