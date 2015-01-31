package www.wing.com;
import javax.xml.namespace.QName;  
import javax.xml.ws.Service;  
import java.net.URL;  
import www.wing.com.Connect;
//import myweb.service.*; 

import java.sql.*;
public class JavaToMuleToDb {

	    public static void main(String[] args) throws Exception{  
	        URL url = new URL("http://localhost:10100/myweb?wsdl");  
	        // 第一个参数是服务的URI  
	        // 第二个参数是在WSDL发布的服务名  
	        QName qname = new QName("http://service.myweb/","ConnectImplService");  
	        // 创建服务  
	        Service service = Service.create(url, qname);  
	        // 提取端点接口，服务“端口”。  
	        Connect eif = service.getPort(Connect.class);  
	        System.out.println(eif.getTimeAsString("Hello World!"));  
	        System.out.println(eif.getTimeAsElapsed());  
	    }  
	
	
	private static Connection con;
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost:3306/customsdb";
    /*private static final String URL = "jdbc:mysql://192.168.1.79:3306/customsdb";*/
    private static final String USER = "root";
	private static final String PASSWORD = "s";
	
	static{
		try {
			Class.forName(DRIVER);
			System.out.println("驱动加载！");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection() {
			try {
				con = DriverManager.getConnection(URL, USER, PASSWORD);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return con;
	}
	
	public static void closeCon(Connection con){
		try {
			if(con!=null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void closeStmt(Statement stmt){
		try {
			if(stmt!=null)
				stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void closeRs(ResultSet rs){
		try {
			if(rs!=null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
