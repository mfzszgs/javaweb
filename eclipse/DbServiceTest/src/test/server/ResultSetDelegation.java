package test.server;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ResultSetDelegation {
	private ConnectionDelegation conn;

	private ResultSet rs;

	ResultSetDelegation() {
	}

	ResultSetDelegation(ResultSet rs) {
		this.rs = rs;
	}

	// 初始化conn
	public void setConn(ConnectionDelegation conn) {
		this.conn = conn;
	}

	// public ConnectionDelegation getConn(){
	// return conn;
	// }
	// before deploy
	public boolean next() throws SQLException {
		return conn.next();
	};

	public void close() throws SQLException {
		conn.closeRs();
	}

	public String getString(String string) throws SQLException {
		return conn.getString(string);
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
