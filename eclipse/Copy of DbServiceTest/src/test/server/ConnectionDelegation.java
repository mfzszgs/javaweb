package test.server;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService(endpointInterface = "test.server.ConnectionDelegation")
public class ConnectionDelegation {

	private Connection conn;
	private StatementDelegation stmt;
	private ResultSetDelegation rs;

	ConnectionDelegation() {
	}

	ConnectionDelegation(Connection conn) {
		this.conn = conn;
	}

	@WebMethod
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

	@WebMethod
	public boolean isClosed() throws SQLException {
		return conn.isClosed();
	};

	@WebMethod
	public StatementDelegation createStatement() throws SQLException {
		stmt = new StatementDelegation(conn.createStatement());
		return stmt;
	}

	@WebMethod
	public void close() throws SQLException {
		conn.close();
	}

	@WebMethod
	public ResultSetDelegation executeQueryStmt(String sql) throws SQLException {
		rs = stmt.executeQuery2(sql);
		return rs;
	}

	@WebMethod
	public void closeStmt() throws SQLException {
		stmt.close2();
	}

	@WebMethod
	public boolean next1() throws SQLException {
		return rs.next2();
	}

	@WebMethod
	public void closeRs() throws SQLException {
		rs.close2();
	}

	@WebMethod
	public String getString1(String string) throws SQLException {
		return rs.getString2(string);
	}

	public class StatementDelegation {

		private Statement stmt;

		public StatementDelegation() {
		}

		public StatementDelegation(Statement stmt) {
			this.stmt = stmt;
		}

		public ResultSetDelegation executeQuery(String sql) throws SQLException {
			return executeQueryStmt(sql);
		};

		public void close() throws SQLException {
			closeStmt();
		};

		//
		public ResultSetDelegation executeQuery2(String sql)
				throws SQLException {
			return new ResultSetDelegation(stmt.executeQuery(sql));
		};

		public void close2() throws SQLException {
			stmt.close();
		};

	}

	public class ResultSetDelegation {

		private ResultSet rs;

		ResultSetDelegation() {
		}

		ResultSetDelegation(ResultSet rs) {
			this.rs = rs;
		}

		public boolean next() throws SQLException {
			return next1();
		};

		public void close() throws SQLException {
			closeRs();
		}

		public String getString(String string) throws SQLException {
			return getString1(string);
		};

		// after deploy
		public boolean next2() throws SQLException {
			return rs.next();
		};

		public void close2() throws SQLException {
			rs.close();
		}

		public String getString2(String string) throws SQLException {
			return rs.getString(string);
		};
	}

}
