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

public class PubDAO {
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public List<String> getNewCol(int i) throws SQLException{//拿到数据库里新闻的栏目返回String型的列表，i=0时返回所有栏目
		List<String> li = new ArrayList<String>();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			if(i == 0){
				sql = "select ColumnName from newscolumn";
			}
			else{
				sql = "select ColumnName from newscolumn where id = '"+i+"'";
			}
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				li.add(rs.getString("ColumnName"));
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

	public LinkedList<NewsBean> pubGetNewsByKC(String keyword,int columnId) throws SQLException{//通过传来的关键字keyword或columnId，找到含有该关键字的文档并显示出来
		LinkedList<NewsBean> li = new LinkedList<NewsBean>();
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		String sql = null;
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			if(keyword!=null){//如果填了keywords
				sql = "select * from news where title like '%"+keyword+"%' and columnid = "+columnId+" ";
			}
			else{
				sql = "select * from news where columnid = "+columnId+"";
			}
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				NewsBean newb = new NewsBean();
				newb.setTitle(rs.getString("title"));
				newb.setColumnId(rs.getInt("columnId"));
				newb.setInputDate(rs.getString("inputDate"));
				li.add(newb);
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
	
	public boolean addNews(String title, int authorId, String keywords, String inputDate, int columnId, String fullText) throws SQLException{//针对新闻人员：添加一则新闻
				
		boolean flag = false;
		String date = df.format(new Date());
		String sql = "INSERT INTO news (`Title`, `AuthorID`, `Keywords`, `InputDate`, `ColumnID`, `FullText`) VALUES ('"+title+"', "+authorId+", '"+keywords+"', '"+date+"', "+columnId+", '"+fullText+"');";
		Statement stmt = null;
		Connection con = Conn.getConnection();
		try {
			if (!con.isClosed())
				System.out.println("Succeeded connecting to the Database!");
			stmt = con.createStatement();
			int i = stmt.executeUpdate(sql);
			if(i!=0){
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return flag;
	}
	
	public void editNews(int id, String title, String keywords, int columnId, String fullText) throws SQLException{//修改一则新闻
		
		
		//String date = df.format(new Date());
		String sql = "UPDATE news SET `Title`='"+title+"', `Keywords`='"+keywords+"', `ColumnID`="+columnId+", `FullText`='"+fullText+"' WHERE  `ID`="+id+" ";
		Statement stmt = null;
		Connection con = Conn.getConnection();
		try {
			if (!con.isClosed())
				System.out.println("Succeeded connecting to the Database!");
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
	}
	
public List<NewsBean> getNews(int i) throws SQLException{//通过新闻id拿到数据库里新闻信息返回NewsBean型的列表,i=0时取所有信息
		List<NewsBean> li = new ArrayList<NewsBean>();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			if(i==0){
				sql = "select * from news order by InputDate desc";
			}
			else{
				sql = "select * from news where ID = '"+i+"'";
			}
	
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				NewsBean newb = new NewsBean();
				newb.setID(rs.getInt("ID"));
				newb.setTitle(rs.getString("title"));
				newb.setAuthorId(rs.getInt("AuthorId"));
				newb.setColumnId(rs.getInt("ColumnId"));
				newb.setInputDate(rs.getString("inputDate"));
				newb.setKeyWords(rs.getString("Keywords"));
				newb.setFullText(rs.getString("FullText"));
				li.add(newb);
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



public List<String> getNewsClass(int i) throws SQLException{//拿到数据库里新闻的种类返回String型的列表
	List<String> li = new ArrayList<String>();
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	Connection con = Conn.getConnection();
	if (!con.isClosed())
		System.out.println("Succeeded connecting to the Database!");
	try {
		if(i == 0){
			sql = "select ColumnName from newscolumn";
		}
		else{
			sql = "select ColumnName from newscolumn where id = '"+i+"'";
		}
		stmt = con.createStatement();
		rs = stmt.executeQuery(sql);//要执行的SQL语句
		while(rs.next()){
			li.add(rs.getString("ColumnName"));
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

public void updateNewsClass(int id ,String className) throws SQLException{//改变对应档案类别的名字

	Statement stmt = null;
	ResultSet rs = null;
	String sql = "UPDATE newscolumn SET ColumnName='"+className+"' WHERE  ID="+id+"  ";
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

	public void delFromNews(int id) throws SQLException{//删除news表里的一行数据
		Statement stmt = null;
		Connection con = Conn.getConnection();
		String sql = "delete from news where ID = '"+id+"'";
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
	}
	
}
