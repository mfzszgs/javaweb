package test.server;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.jws.WebService;

@WebService(endpointInterface = "test.server.ConnectionDelegation")
public class ConnectionDelegationImpl implements ConnectionDelegation {

	private Connection conn;
	private StatementDelegation stmt;
	private ResultSetDelegation rs;

	ConnectionDelegationImpl() {
	}

	ConnectionDelegationImpl(Connection conn) {
		this.conn = conn;
	}

	@Override
	public void getConnect(String dbdriver, String dburl, String dbuser,
			String dbpassword) throws SQLException {
		try {
			Class.forName(dbdriver);
			System.out.println("驱动加载！");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			conn = DriverManager.getConnection(dburl, dbuser, dbpassword);
			System.out.println("连接成功！");
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try {
			if (!conn.isClosed())
				System.out.println("Succeeded connecting to the Database!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean isClosed() throws SQLException {
		return conn.isClosed();
	};

	@Override
	public StatementDelegation createStatement() throws SQLException {
		stmt = new StatementDelegation(conn.createStatement());
		return stmt;
	}

	@Override
	public void close() throws SQLException {
		conn.close();
	}

	@Override
	public ResultSetDelegation executeQuery(String sql) throws SQLException {
		rs = stmt.executeQuery2(sql);
		return rs;
	}

	@Override
	public void closeStmt() throws SQLException {
		stmt.close2();
	}

	@Override
	public boolean next() throws SQLException {
		return rs.next2();
	}

	@Override
	public void closeRs() throws SQLException {
		rs.close2();
	}

	@Override
	public String getString(String string) throws SQLException {
		return rs.getString2(string);
	}

}
