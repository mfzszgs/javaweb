package test.server;

import java.sql.SQLException;
import java.sql.Statement;

public class StatementDelegation {
	private ConnectionDelegation conn;

	private Statement stmt;

	public StatementDelegation() {
	}

	public StatementDelegation(Statement stmt) {
		this.stmt = stmt;
	}

	//
	public void setConn(ConnectionDelegation conn) {
		this.conn = conn;
	}

	public ResultSetDelegation executeQuery(String sql) throws SQLException {
		return conn.executeQuery(sql);
	};

	public void close() throws SQLException {
		conn.closeStmt();
	};

	//
	public ResultSetDelegation executeQuery2(String sql) throws SQLException {
		return new ResultSetDelegation(stmt.executeQuery(sql));
	};

	public void close2() throws SQLException {
		stmt.close();
	};

}
