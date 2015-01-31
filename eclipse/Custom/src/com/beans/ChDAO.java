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




public class ChDAO {

	public List<UsersBean> getProId_Name() throws SQLException{//拿到众包用户的名称列表
		List<UsersBean> li = new ArrayList<UsersBean>();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			sql = "select id,loginname from users where userclass=3";
		
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				UsersBean ub = new UsersBean();
				ub.setLoginName(rs.getString("LoginName"));
				ub.setId(rs.getInt("ID"));
				li.add(ub);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return li;
	}
		
	public LinkedList<DocBean> cheGetDocByKCN(String keyword,int classId,int userId) throws SQLException{//通过传来的关键字keyword或classId或nameId(众包人员)，找到含有该关键字的文档并显示出来,此时文档的状态必须为3：校审
		LinkedList<DocBean> li = new LinkedList<DocBean>();
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		String sql = null;
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			
			if(keyword == null){
				if(classId != 0 && userId != 0){//搜某一人某一类型
					sql = "select * from basicinfo where classid = "+classId+" and userID ="+userId+" and state = 3";
				}else if(classId == 0 && userId != 0){//搜某一人所有类型
					sql = "select * from basicinfo where userID ="+userId+" and state = 3";
				}else if(classId != 0 && userId == 0){//搜某一类型所有人
					sql = "select * from basicinfo where classid = "+classId+" and state = 3";
				}else if(classId == 0 && userId == 0){//搜某所有类型所有人
					sql = "select * from basicinfo where state = 3";
			    }	
			}else{
				if(classId != 0 && userId != 0){//搜某一人某一类型
					sql = "select * from basicinfo where title like '%"+keyword+"%' and classid = "+classId+" and userID ="+userId+" and state = 3";
				}else if(classId == 0 && userId != 0){//搜某一人所有类型
					sql = "select * from basicinfo where title like '%"+keyword+"%' and userID ="+userId+" and state = 3";
				}else if(classId != 0 && userId == 0){//搜某一类型所有人
					sql = "select * from basicinfo where title like '%"+keyword+"%' and classid = "+classId+" and state = 3";
				}else if(classId == 0 && userId == 0){//搜某所有类型所有人
					sql = "select * from basicinfo where title like '%"+keyword+"%' and state = 3";
			
				}
			}
			
			/*if(classId != 0 && userId != 0){
				if(keyword!=null){
					sql = "select * from basicinfo where title like '%"+keyword+"%' and classid = "+classId+" and userID ="+userId+" and state = 3 ";
				}else{
					sql = "select * from basicinfo where classid = "+classId+" and userID ="+userId+" and state = 3     ";
				}
			}else if(classId == 0 && userId != 0){
				
			}else if(classId != 0 && userId == 0){
				
			}else if(classId == 0 && userId == 0){
				
			}*/
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


}
	
	
	
