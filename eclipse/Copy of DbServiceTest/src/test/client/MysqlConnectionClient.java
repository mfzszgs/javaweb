package test.client;

import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import test.server.ConnectionDelegation;
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
		System.out.println("!!!!!!!!!!!!!!");
		URL url = new URL("http://localhost:10101/mysql?wsdl");

		QName qname = new QName("http://server.test/",
				"ConnectionDelegationImplService");

		Service service = Service.create(url, qname);

		ConnectionDelegation conn = service.getPort(ConnectionDelegation.class);
		System.out.println("!!!!!!!!!!!!!!");
		try {
			System.out.println("a");
			conn.getConnect(DRIVER, URL, USER, PASSWORD);
			System.out.println("b");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("!!!!!!!!!!!!!!");
		if (conn != null)
			System.out.println("!NULL");
		int i = 1;
		List<String> li = new ArrayList<String>();
		ConnectionDelegation.StatementDelegation stmt = null;
		ConnectionDelegation.ResultSetDelegation rs = null;
		String sql = null;
		try {
			if (!conn.isClosed())
				System.out.println("Succeeded connecting to the Database!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (i == 0) {
				sql = "select ColumnName from newscolumn";
			} else {
				sql = "select ColumnName from newscolumn where id = '" + i
						+ "'";
			}
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);// 要执行的SQL语句
			while (rs.next()) {
				li.add(rs.getString("ColumnName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// conn.closeRs();
			// conn.closeStmt();
			// conn.close();

			rs.close();
			stmt.close();
			conn.close();
			System.out.println(li);
		}

	}
}
