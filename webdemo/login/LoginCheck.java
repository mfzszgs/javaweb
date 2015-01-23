import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginCheck {

	public static final String DBDRIVER = "org.gjt.mm.mysql.Driver";
	public static final String DBURL = "jdbc:mysql://localhost:3306/firstdb";
	public static final String DBUSER = "root";
	public static final String DBPASS = "s";

	public static void main(String[] args) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		String name = null;
		try {
			Class.forName(DBDRIVER);
			conn = DriverManager.getConnection(DBURL, DBUSER, DBPASS);
			String sql = "SELECT name FROM user WHERE userid=? AND password=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "admin");
			pstmt.setString(2, "admin");
			rs = pstmt.executeQuery(); // ²éÑ¯
			System.out.println(rs.next());
			System.out.println(rs.next());
			if (rs.next()) { // Èç¹ûÓÐÊýŸÝ£¬Ôò¿ÉÒÔÖŽÐÐ
				flag = true; // ±íÊŸµÇÂœ³É¹Š
				name = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e) {
			}
		}
		if(flag){
			System.out.println("Success");
		}else{
			System.out.println("Fail");
		}
	}
}

