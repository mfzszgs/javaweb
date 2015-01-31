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


public class DAO {//各种对数据库的操作函数
	
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public int userIsExist(String getLoginName){//判断注册名是否被使用
		int i = 0;
		String sql = "select * from users where LoginName = '"+getLoginName+"'";
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		try {
			if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
			stmt = con.createStatement(); 
			rs = stmt.executeQuery(sql);
			rs.last();//判断结果集是否为空
			int rows = rs.getRow();
			if(rows!=0){
				i=1;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return i;	
	}
	
	public boolean addUser(UsersBean ub) {//添加用户
		boolean flag = false;
		String sql = "insert into `users` (`UserClass`, `LoginName`, `Password`, `Name`, `SexID`, `Organization`, `email`, `Address`, `Postcode`, `OfficePhone`, `MobilePhone`) values ("+ub.getUserClass()+", '"+ub.getLoginName() +"', '"+ub.getPassword()+"', '"+ub.getName()+"', '"+ub.getSexId()+"', '"+ub.getOrganization()+"', '"+ub.getEmail()+"', '"+ub.getAddress()+"', '"+ub.getPostCode()+"', '"+ub.getOfficeNumber()+"', '"+ub.getPhoneNumber()+"')";
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
	
	public void addUserDocUrl(int id,String newName) {//添加众包人员的校审材料名
		String sql = "UPDATE `users` SET `DocUrl`='"+ newName +"' WHERE  `ID`="+id+" ";
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
	
	public int checkUserClass(String loginName) throws SQLException{//通过loginName在数据库中找到对应用户，返回相应用户类别型号
		int i = 0;
		String sql = "select * from users where loginName='"+loginName+"'";
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				i = rs.getInt(2);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return i;
	}
	
	public int checkUserId(String loginName) throws SQLException{//通过loginName在数据库中找到对应用户，返回相应用户id号
		int i = 0;
		String sql = "select * from users where loginName='"+loginName+"'";
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				i = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return i;
	}
	
	
	public String checkUserName(int id) throws SQLException{//通过用户id在数据库中找到对应用户，返回相应用户名
		String loginName = null;
		String sql = "select * from users where ID='"+id+"'";
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				loginName = rs.getString("LoginName");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return loginName;
	}
	
	public boolean checkUser(String loginName,String password) throws SQLException{//检查是否能登录成功
		boolean flag = false;
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		String sql = "select * from users where LoginName = '"+loginName+"' and password= '"+password+"'"; 
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			rs.last();//判断结果集是否为空
			int rows = rs.getRow();
			System.out.println(rows);
			if(rows==1){
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return flag;	
	}
	
	public List<String> getDocClass(int i) throws SQLException{//拿到数据库里档案的种类返回String型的列表
		List<String> li = new ArrayList<String>();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			if(i == 0){
				sql = "select className from classify";
			}
			else{
				sql = "select className from classify where id = '"+i+"'";
			}
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				li.add(rs.getString("className"));
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

	public List<String> getUserClass(int i) throws SQLException{//拿到数据库里用户的种类,返回String型的列表,若i=0，则返回所有种类
		List<String> li = new ArrayList<String>();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			if(i == 0){
				sql = "select userclassName from userclass";
			}
			else{
				sql = "select userclassName from userclass where id = '"+i+"'";
			}
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				li.add(rs.getString("userclassName"));
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
	
	
	
	public void updateDoc(int id,String title,int classId) throws SQLException{

		Statement stmt = null;
		ResultSet rs = null;
		String sql = "UPDATE basicinfo SET Title='"+title+"', ClassID="+classId+" WHERE  ID="+id+"  ";
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
	
	public void updateUserClass(int id ,String className) throws SQLException{//改变对应用户类别的名字

		Statement stmt = null;
		ResultSet rs = null;
		String sql = "UPDATE userclass SET userclassName='"+className+"' WHERE  ID="+id+"  ";
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
	
	public void updateUserAuth(int id) throws SQLException{//改变对应众包人员的授权状态,默认是0，若通过审核，将状态改为1
		Statement stmt = null;
		String sql = "UPDATE `users` SET `Authority`=1 WHERE  `ID`="+ id +" ";
		Connection con = Conn.getConnection();
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
	
	public void updateUserDocUrl(int id) throws SQLException{//改变对应众包人员的上传的文档名
		Statement stmt = null;
		String sql ="   UPDATE `users` SET `DocUrl`='' WHERE  `ID`="+  id +"";
		Connection con = Conn.getConnection();
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
	
	public void updateDocClass(int id ,String className) throws SQLException{//改变对应档案类别的名字

		Statement stmt = null;
		ResultSet rs = null;
		String sql = "UPDATE classify SET ClassName='"+className+"' WHERE  ID="+id+"  ";
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
	
	public boolean addDocOne(String title,int classId, String loginName, String newName) throws SQLException{//针对录入人员：将文档的标题、类型 、userID写入数据库中，同时将文档的State属性设为0
		/*1.通过loginName找到userId
		  2.将title、classId、userId写入数据库,将当前日期写入数据库
		  3.将State属性设为0
		*/
		System.out.println("------title---"+title);
		System.out.println("------classId---"+classId);
		System.out.println("------loginName---"+loginName);
		System.out.println("------newName---"+newName);
		boolean flag = false;
		int userId = checkUserId(loginName);
		String date = df.format(new Date());
		//System.out.println("title   classId  loginName是"+title+" "+classId+" "+loginName);
		String sql = "INSERT INTO `basicinfo` (`Title`, `CustomsID`, `ClassID`, `InputDate`,`RawID`, `RawUrl`,`UserID`, `State`) VALUES ('"+title+"', 1, "+classId+",'"+ date +"', 1, '"+newName+"', "+userId+",1)";
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
	
	
public List<DocBean> getDocByUser(int userid) throws SQLException{//通过用户id拿到数据库里档案信息返回DocBean型的列表
		
		
		List<DocBean> li = new ArrayList<DocBean>();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			sql = "select * from basicinfo where UserID = '"+userid+"'";
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				DocBean docb = new DocBean();
				docb.setTitle(rs.getString("title"));
				docb.setKeyWords(rs.getString("keywords"));
				docb.setKeyPersons(rs.getString("KeyPersons"));
				docb.setBuildTime(rs.getString("buildtime"));
				docb.setBuilder(rs.getString("builder"));
				docb.setDocAbstract(rs.getString("Abstract"));
				docb.setFullText(rs.getString("fullText"));
				docb.setClassId(rs.getInt("classId"));
				docb.setCustomsId(rs.getInt("customsId"));
				docb.setRawId(rs.getInt("rawId"));
				docb.setRawUrl(rs.getString("RawUrl"));
				docb.setUserId(rs.getInt("userId"));
				docb.setInputDate(rs.getString("inputdate"));
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
	
	public List<DocBean> getDoc(int i) throws SQLException{//拿到数据库里档案信息返回DocBean型的列表,i=0时取所有信息
		List<DocBean> li = new ArrayList<DocBean>();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			if(i==0){
				sql = "select * from basicinfo order by InputDate desc";
			}
			else{
				sql = "select * from basicinfo where id = '"+i+"'";
			}
	
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				DocBean docb = new DocBean();
				docb.setTitle(rs.getString("title"));
				docb.setKeyWords(rs.getString("keywords"));
				docb.setKeyPersons(rs.getString("KeyPersons"));
				docb.setBuildTime(rs.getString("buildtime"));
				docb.setBuilder(rs.getString("builder"));
				docb.setDocAbstract(rs.getString("Abstract"));
				docb.setFullText(rs.getString("fullText"));
				docb.setClassId(rs.getInt("classId"));
				docb.setCustomsId(rs.getInt("customsId"));
				docb.setRawId(rs.getInt("rawId"));
				docb.setRawUrl(rs.getString("RawUrl"));
				docb.setUserId(rs.getInt("userId"));
				docb.setInputDate(rs.getString("inputdate"));
				docb.setState(rs.getInt("state"));
				docb.setTranslateText(rs.getString("translateText"));
				docb.setSuggestion(rs.getString("Suggestion"));
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
	
	
public List<UsersBean> getUser(int i) throws SQLException{//拿到数据库里用户信息返回UsersBean型的列表,i=0时取所有信息
		List<UsersBean> li = new ArrayList<UsersBean>();
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			if(i==0){
				sql = "select * from users";
			}
			else{
				sql = "select * from users where id = '"+i+"'";
			}
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				UsersBean useb = new UsersBean();
				useb.setAddress(rs.getString("Address"));
				useb.setEmail(rs.getString("email"));
				useb.setLoginName(rs.getString("LoginName"));
				useb.setName(rs.getString("Name"));
				useb.setOfficeNumber(rs.getString("OfficePhone"));
				useb.setOrganization(rs.getString("Organization"));
				useb.setPassword(rs.getString("Password"));
				useb.setPhoneNumber(rs.getString("MobilePhone"));
				useb.setPostCode(rs.getString("Postcode"));
				useb.setSexId(rs.getInt("SexID"));
				useb.setUserClass(rs.getInt("UserClass"));
				useb.setAuthority(rs.getInt("Authority"));
				useb.setdocUrl(rs.getString("DocUrl"));
				li.add(useb);
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
	
	
	
	public String getDocName(int classId) throws SQLException{//通过文档类型找类型名
		String className = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select ClassName from classify where ID = '"+classId+"'";
		Connection con = Conn.getConnection();
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while (rs.next()) {
				className =rs.getString("ClassName");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Conn.closeRs(rs);
			Conn.closeStmt(stmt);
			Conn.closeCon(con);
		}
		return className;
	}
	
	
	
	public LinkedList<DocBean> uploadgetDocByKey(String keyword) throws SQLException{//通过传来的关键字keyword，找到含有该关键字的文档并显示出来
		LinkedList<DocBean> li = new LinkedList<DocBean>();
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		String sql = null;
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			sql = "select * from basicinfo where title like '%"+keyword+"%'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				DocBean docb = new DocBean();
				docb.setID(rs.getInt("id"));
				docb.setTitle(rs.getString("title"));
				docb.setClassId(rs.getInt("classId"));
				docb.setInputDate(rs.getString("InputDate"));
				docb.setCustomsId(rs.getInt("customsId"));
				docb.setRawId(rs.getInt("rawId"));
				docb.setUserId(rs.getInt("userId"));
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
	
	public LinkedList<DocBean> proGetDocByKC(String keyword,int classId) throws SQLException{//通过传来的关键字keyword或classId，找到含有该关键字的文档并显示出来,此时文档的状态必须为1：可包
		LinkedList<DocBean> li = new LinkedList<DocBean>();
		Statement stmt = null;
		ResultSet rs = null;
		Connection con = Conn.getConnection();
		String sql = null;
		if (!con.isClosed())
			System.out.println("Succeeded connecting to the Database!");
		try {
			if(keyword!=null){
				sql = "select * from basicinfo where title like '%"+keyword+"%' and classid = "+classId+" and state = 1";
			}
			else{
				sql = "select * from basicinfo where classid = "+classId+" and state = 1";
			}
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);//要执行的SQL语句
			while(rs.next()){
				DocBean docb = new DocBean();
				docb.setTitle(rs.getString("title"));
				docb.setClassId(rs.getInt("classId"));
				docb.setBuildTime(rs.getString("BuildTime"));
				docb.setCustomsId(rs.getInt("customsId"));
				docb.setRawId(rs.getInt("rawId"));
				docb.setUserId(rs.getInt("userId"));
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
	
	
	public void delFromBasicinfo(int id) throws SQLException{//删除basicinfo表里的一行数据
		Statement stmt = null;
		Connection con = Conn.getConnection();
		String sql = "delete from basicinfo where ID = '"+id+"'";
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
	
	public void delFromUser(int id) throws SQLException{//删除user表里的一行数据
		Statement stmt = null;
		Connection con = Conn.getConnection();
		String sql = "delete from users where ID = '"+id+"'";
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
