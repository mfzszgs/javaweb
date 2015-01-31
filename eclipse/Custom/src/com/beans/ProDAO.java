package com.beans;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class ProDAO {
	
	//SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	
	public void updateAllDoc(
			int id,
			String retitle,
			String keywords,
			String keypersons,
			String buildtime,
			String builder,
			String abstracts,
			String fulltext,
			String translatetext) throws SQLException{//众包人员补全文档信息
		Statement stmt = null;
		String sql = "UPDATE `basicinfo` SET " +
				"`Title`='"+retitle+"'," +
				"`Abstract`='"+abstracts+"'," +
				" `Keywords`='"+keywords+"'," +
				" `KeyPersons`='"+keypersons+"'," +
				" `BuildTime`='"+buildtime+"', " +
				"`FullText`='"+fulltext+"', " +
				"`TranslateText`='"+translatetext+"'," +
				"`Builder`='"+builder+"' WHERE  `ID`="+id+"";

		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);//要执行的SQL语句
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}

	}
	

	public void updateDocSuggestion(int id,String suggestion) throws SQLException{/*通过文档id 设置用户id和文档状态*/

		Statement stmt = null;
		ResultSet rs = null;
		
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			String sql = "UPDATE `basicinfo` SET `Suggestion`='"+suggestion+"' WHERE `ID`="+id+"";
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
	}
	public boolean statexToy(int id,int x,int y) throws SQLException{/*通过文档id将文档状态改为校审*/
		boolean flag = false;
		Statement stmt = null;
		Connection con = Conn.getConnection();
		String sql = null;
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		
		
		if(x==2 && y==3){
			sql =" UPDATE `basicinfo` SET `State`=3 WHERE  `ID`="+id+" ";
		}else if(x==3 && y==4){
			sql =" UPDATE `basicinfo` SET `State`=4 WHERE  `ID`="+id+" ";
		}else if(x==3 && y==5){
			sql =" UPDATE `basicinfo` SET `State`=5 WHERE  `ID`="+id+" ";
		}
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);//要执行的SQL语句
			flag = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return flag;
	}
	
	
	public void updateDoc(int id,int uid) throws SQLException{/*通过文档id 设置用户id和文档状态*/

		Statement stmt = null;
		ResultSet rs = null;
		String sql = "UPDATE basicinfo SET UserID="+uid+",state = '2'  WHERE  ID="+id+"";
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
	}
	
	
	public List<String> getDocState(int i) throws SQLException{//拿到数据库里档案的状态id，返回String型的列表
		List<String> li = new ArrayList<String>();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			if(i == 0){
				sql = "select ClassName from stateclass";
			}
			else{
				sql = "select ClassName from stateclass where id = '"+i+"'";
			}
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				li.add(rs.getString("ClassName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return li;
	}
	

	public LinkedList<DocBean> proGetDocByKS(String keyword, int stateId, int uid) throws SQLException {//通过keyword和文档状态，查找指定用户的文档
		LinkedList<DocBean> li = new LinkedList<DocBean>();
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		String sql = null;
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			if(keyword!=null){
				sql = "select * from basicinfo where title like '%"+keyword+"%' and state = "+stateId+" and UserID = "+uid+"";
			}
			else{
				sql = "select * from basicinfo where state = "+stateId+" and UserID = "+uid+" ";
			}
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				DocBean docb = new DocBean();
				docb.setID(rs.getInt("ID"));
				docb.setTitle(rs.getString("title"));
				docb.setClassId(rs.getInt("classId"));
				docb.setCustomsId(rs.getInt("customsId"));
				docb.setRawId(rs.getInt("rawId"));
				docb.setUserId(rs.getInt("userId"));
				docb.setState(rs.getInt("state"));
				li.add(docb);
				//剩下的还没写
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return li;	
	}

	
	
	public void delFromProFile(int id) throws SQLException {/*通过文档id修改文档状态：从被包改成可包*/
		Statement stmt = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		DAO dao = new DAO();
		int stateId = dao.getDoc(id).get(0).getState();
		if(stateId == 2){//如果等于2，确定该文档的状态为被包
			sql = "  UPDATE `basicinfo` SET `State`=1 WHERE  `ID`= '"+id+"'";
		}
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);//要执行的SQL语句
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		
	}
	
	
	/*	Statement stmt = null;
	ResultSet rs = null;
	Connection con = Conn.getConnection();
	if (!con.isClosed())
		System.out.println("Succeeded connecting to the Database!");
	try {
		stmt = con.createStatement();
		rs = stmt.executeQuery("select * from student");//要执行的SQL语句
		while (rs.next()) {
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		Conn.closeRs(rs);
		Conn.closeStmt(stmt);
		Conn.closeCon(con);
	}*/
}
