package test.server;

import java.sql.SQLException;

import javax.jws.WebMethod;
import javax.jws.WebService;
@WebService
public interface ConnectionDelegation {

	@WebMethod
	public void getConnect(String dbdriver, String dburl,
			String dbuser, String dbpassword) throws SQLException;
	@WebMethod
	public boolean isClosed() throws SQLException ;
	@WebMethod
	public StatementDelegation createStatement() throws SQLException;
	@WebMethod
    public void close() throws SQLException;
	@WebMethod
    public ResultSetDelegation executeQuery(String sql) throws SQLException;
	@WebMethod
	public void closeStmt() throws SQLException;
	@WebMethod	
	public boolean next() throws SQLException;
	@WebMethod
	public void closeRs() throws SQLException;
	@WebMethod
	public String getString(String string) throws SQLException;
}
