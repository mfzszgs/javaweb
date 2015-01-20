<%@page import="com.beans.*"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java"
	import="java.util.*,com.beans.Conn,java.sql.*,com.filter.*,com.tools.*"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script type="text/javascript">
<!--
function HS_DateAdd(interval,number,date){
 number = parseInt(number);
 if (typeof(date)=="string"){var date = new Date(date.split("-")[0],date.split("-")[1],date.split("-")[2])}
 if (typeof(date)=="object"){var date = date}
 switch(interval){
 case "y":return new Date(date.getFullYear()+number,date.getMonth(),date.getDate()); break;
 case "m":return new Date(date.getFullYear(),date.getMonth()+number,checkDate(date.getFullYear(),date.getMonth()+number,date.getDate())); break;
 case "d":return new Date(date.getFullYear(),date.getMonth(),date.getDate()+number); break;
 case "w":return new Date(date.getFullYear(),date.getMonth(),7*number+date.getDate()); break;
 }
}
function checkDate(year,month,date){
 var enddate = ["31","28","31","30","31","30","31","31","30","31","30","31"];
 var returnDate = "";
 if (year%4==0){enddate[1]="29"}
 if (date>enddate[month]){returnDate = enddate[month]}else{returnDate = date}
 return returnDate;
}

function WeekDay(date){
 var theDate;
 if (typeof(date)=="string"){theDate = new Date(date.split("-")[0],date.split("-")[1],date.split("-")[2]);}
 if (typeof(date)=="object"){theDate = date}
 return theDate.getDay();
}
function HS_calender(){
 var lis = "";
 var style = "";
 style +="<style type='text/css'>";
 style +=".calender { width:170px; height:auto; font-size:12px; margin-right:14px; background:url(calenderbg.gif) no-repeat right center #fff; border:1px solid #397EAE; padding:1px}";
 style +=".calender ul {list-style-type:none; margin:0; padding:0;}";
 style +=".calender .day { background-color:#EDF5FF; height:20px;}";
 style +=".calender .day li,.calender .date li{ float:left; width:14%; height:20px; line-height:20px; text-align:center}";
 style +=".calender li a { text-decoration:none; font-family:Tahoma; font-size:11px; color:#333}";
 style +=".calender li a:hover { color:#f30; text-decoration:underline}";
 style +=".calender li a.hasArticle {font-weight:bold; color:#f60 !important}";
 style +=".lastMonthDate, .nextMonthDate {color:#bbb;font-size:11px}";
 style +=".selectThisYear a, .selectThisMonth a{text-decoration:none; margin:0 2px; color:#000; font-weight:bold}";
 style +=".calender .LastMonth, .calender .NextMonth{ text-decoration:none; color:#000; font-size:18px; font-weight:bold; line-height:16px;}";
 style +=".calender .LastMonth { float:left;}";
 style +=".calender .NextMonth { float:right;}";
 style +=".calenderBody {clear:both}";
 style +=".calenderTitle {text-align:center;height:20px; line-height:20px; clear:both}";
 style +=".today { background-color:#ffffaa;border:1px solid #f60; padding:2px}";
 style +=".today a { color:#f30; }";
 style +=".calenderBottom {clear:both; border-top:1px solid #ddd; padding: 3px 0; text-align:left}";
 style +=".calenderBottom a {text-decoration:none; margin:2px !important; font-weight:bold; color:#000}";
 style +=".calenderBottom a.closeCalender{float:right}";
 style +=".closeCalenderBox {float:right; border:1px solid #000; background:#fff; font-size:9px; width:11px; height:11px; line-height:11px; text-align:center;overflow:hidden; font-weight:normal !important}";
 style +="</style>";

 var now;
 if (typeof(arguments[0])=="string"){
  selectDate = arguments[0].split("-");
  var year = selectDate[0];
  var month = parseInt(selectDate[1])-1+"";
  var date = selectDate[2];
  now = new Date(year,month,date);
 }else if (typeof(arguments[0])=="object"){
  now = arguments[0];
 }
 var lastMonthEndDate = HS_DateAdd("d","-1",now.getFullYear()+"-"+now.getMonth()+"-01").getDate();
 var lastMonthDate = WeekDay(now.getFullYear()+"-"+now.getMonth()+"-01");
 var thisMonthLastDate = HS_DateAdd("d","-1",now.getFullYear()+"-"+(parseInt(now.getMonth())+1).toString()+"-01");
 var thisMonthEndDate = thisMonthLastDate.getDate();
 var thisMonthEndDay = thisMonthLastDate.getDay();
 var todayObj = new Date();
 today = todayObj.getFullYear()+"-"+todayObj.getMonth()+"-"+todayObj.getDate();
 
 for (i=0; i<lastMonthDate; i++){  // Last Month's Date
  lis = "<li class='lastMonthDate'>"+lastMonthEndDate+"</li>" + lis;
  lastMonthEndDate--;
 }
 for (i=1; i<=thisMonthEndDate; i++){ // Current Month's Date

  if(today == now.getFullYear()+"-"+now.getMonth()+"-"+i){
   var todayString = now.getFullYear()+"-"+(parseInt(now.getMonth())+1).toString()+"-"+i;
   lis += "<li><a href=javascript:void(0) class='today' onclick='_selectThisDay(this)' title='"+now.getFullYear()+"-"+(parseInt(now.getMonth())+1)+"-"+i+"'>"+i+"</a></li>";
  }else{
   lis += "<li><a href=javascript:void(0) onclick='_selectThisDay(this)' title='"+now.getFullYear()+"-"+(parseInt(now.getMonth())+1)+"-"+i+"'>"+i+"</a></li>";
  }
  
 }
 var j=1;
 for (i=thisMonthEndDay; i<6; i++){  // Next Month's Date
  lis += "<li class='nextMonthDate'>"+j+"</li>";
  j++;
 }
 lis += style;

 var CalenderTitle = "<a href='javascript:void(0)' class='NextMonth' onclick=HS_calender(HS_DateAdd('m',1,'"+now.getFullYear()+"-"+now.getMonth()+"-"+now.getDate()+"'),this) title='Next Month'>&raquo;</a>";
 CalenderTitle += "<a href='javascript:void(0)' class='LastMonth' onclick=HS_calender(HS_DateAdd('m',-1,'"+now.getFullYear()+"-"+now.getMonth()+"-"+now.getDate()+"'),this) title='Previous Month'>&laquo;</a>";
 CalenderTitle += "<span class='selectThisYear'><a href='javascript:void(0)' onclick='CalenderselectYear(this)' title='Click here to select other year' >"+now.getFullYear()+"</a></span>年<span class='selectThisMonth'><a href='javascript:void(0)' onclick='CalenderselectMonth(this)' title='Click here to select other month'>"+(parseInt(now.getMonth())+1).toString()+"</a></span>月";

 if (arguments.length>1){
  arguments[1].parentNode.parentNode.getElementsByTagName("ul")[1].innerHTML = lis;
  arguments[1].parentNode.innerHTML = CalenderTitle;

 }else{
  var CalenderBox = style+"<div class='calender'><div class='calenderTitle'>"+CalenderTitle+"</div><div class='calenderBody'><ul class='day'><li>日</li><li>一</li><li>二</li><li>三</li><li>四</li><li>五</li><li>六</li></ul><ul class='date' id='thisMonthDate'>"+lis+"</ul></div><div class='calenderBottom'><a href='javascript:void(0)' class='closeCalender' onclick='closeCalender(this)'>×</a><span><span><a href=javascript:void(0) onclick='_selectThisDay(this)' title='"+todayString+"'>Today</a></span></span></div></div>";
  return CalenderBox;
 }
}
function _selectThisDay(d){
 var boxObj = d.parentNode.parentNode.parentNode.parentNode.parentNode;
  boxObj.targetObj.value = d.title;
  boxObj.parentNode.removeChild(boxObj);
}
function closeCalender(d){
 var boxObj = d.parentNode.parentNode.parentNode;
  boxObj.parentNode.removeChild(boxObj);
}

function CalenderselectYear(obj){
  var opt = "";
  var thisYear = obj.innerHTML;
  for (i=1970; i<=2020; i++){
   if (i==thisYear){
    opt += "<option value="+i+" selected>"+i+"</option>";
   }else{
    opt += "<option value="+i+">"+i+"</option>";
   }
  }
  opt = "<select onblur='selectThisYear(this)' onchange='selectThisYear(this)' style='font-size:11px'>"+opt+"</select>";
  obj.parentNode.innerHTML = opt;
}

function selectThisYear(obj){
 HS_calender(obj.value+"-"+obj.parentNode.parentNode.getElementsByTagName("span")[1].getElementsByTagName("a")[0].innerHTML+"-1",obj.parentNode);
}

function CalenderselectMonth(obj){
  var opt = "";
  var thisMonth = obj.innerHTML;
  for (i=1; i<=12; i++){
   if (i==thisMonth){
    opt += "<option value="+i+" selected>"+i+"</option>";
   }else{
    opt += "<option value="+i+">"+i+"</option>";
   }
  }
  opt = "<select onblur='selectThisMonth(this)' onchange='selectThisMonth(this)' style='font-size:11px'>"+opt+"</select>";
  obj.parentNode.innerHTML = opt;
}
function selectThisMonth(obj){
 HS_calender(obj.parentNode.parentNode.getElementsByTagName("span")[0].getElementsByTagName("a")[0].innerHTML+"-"+obj.value+"-1",obj.parentNode);
}
function HS_setDate(inputObj){
 var calenderObj = document.createElement("span");
 calenderObj.innerHTML = HS_calender(new Date());
 calenderObj.style.position = "absolute";
 calenderObj.targetObj = inputObj;
 inputObj.parentNode.insertBefore(calenderObj,inputObj.nextSibling);
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

function MM_passId(id){
	send("Editor.jsp?param="+id);
}
//-->
</script>
    
    <title>出版主编</title>
    <link rel="stylesheet" type="text/css" href="MainStyle.css"/>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <style type="text/css">
<!--
/* #Layer1 {
	position:absolute;
	width:618px;
	height:291px;
	z-index:1;
	left: 229px;
	top: 158px;
	visibility: visible;
} */
-->
    </style>
</head>
  
  <body>
  <p>
		<%@ include file="Public/MyTitle.jsp"%>
  </p>
  	<p>
		<jsp:useBean id="m_pages" scope="page" class="com.beans.Pagination">
		</jsp:useBean>
	</p>
	
	
   <form method="post" action="" name="form" style="height: 0; color: #F00;">
		
			<span class="STYLE21">当前用户：<%=session.getAttribute("loginName")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<%
				String loginName = session.getAttribute("loginName").toString();
				DAO dao = new DAO();
				int uid = dao.checkUserId(loginName);/* 获取userId */

				List<String> li = dao.getDocClass(0);/* 获取文档类别列表 */

				int curPages = m_pages.current_Pages(m_pages.strPage(request, "page"));
				m_pages.setPage_record(10);//设置每页显示10条
				int resultconts = 0;
				int totalPages = 0;
				Statement stmt = null;
				ResultSet rs = null;
				ResultSet rset = null;
				Connection con = Conn.getConnection();
				String sql = "select * from basicinfo where state = 4 order by BuildTime DESC";
				if (!con.isClosed())
					System.out.println("Succeeded connecting to the Database!");
				try {
					stmt = con.createStatement();
					rs = stmt.executeQuery(sql);//要执行的SQL语句
					rs.last();
					resultconts = rs.getRow();//取得总的数据数
					rs.beforeFirst();
					totalPages = m_pages.getTotal_Pages(resultconts);//取出总页数
					rset = m_pages.getPageSet(rs, curPages);//获取指针的结果集参数是(结果集，页数)
				} catch (SQLException e) {
					e.printStackTrace();
				}
			%>
			<a href="LogoutServlet?loginName=<%=session.getAttribute("loginName")%>" class="STYLE21"> <u>注销</u>
			</a>
		
  </form>
  
  			<%-- 	<div id="Layer1" >
					 <fieldset>
					<% 
						int id = 0;
					 	if(request.getParameter("param")!=null){
							id = Integer.parseInt(request.getParameter("param"));
					}%>
				<p><strong><%=dao.getDoc(id).get(0).getTitle()%></strong></p>
				<p>起草时间：<%=dao.getDoc(id).get(0).getBuildTime()%></p>
				<p>起草人：<%=dao.getDoc(id).get(0).getBuilder()%></p>
				<p>译文：<%=dao.getDoc(id).get(0).getFullText()%></p>
					</fieldset>
				</div>  --%>

	<form method="post" name="form2">
		<div class="search1">
			<div align="right">
				<span> 
				关键字：<input name="keyword" type="text" maxlength="20" style="width: 200px; ">
				文档起草人<input name="builder" type="text" maxlength="20" style="width: 200px; "><br/>
				<label>档案类别： <select name="selectDocClass">
							<%
								for (int i = 0; i <= li.size(); i++) {
								if(i==0){%>
									<option value="<%=i%>"></option>
							<%		
								continue;
								}
							%>
								<option value="<%=i%>"><%=li.get(i-1)%></option>
							<%
								}
							%>
					</select>
				</label>
					起草日期： <input type="text" name ="startBt" style="width:100px" onFocus="HS_setDate(this)" >
				            至	   <input type="text" name ="endBt" style="width:100px" onFocus="HS_setDate(this)" >

				</span> 
				<span> 
					<input name="search" type="button" value="搜索" onClick="form2.action='SearchServlet?jsp=Editor';form2.submit();" />
				</span>

			</div>
		</div>
	</form>

	
	<form action="ProChStaServlet" method="post" name="form3"><br><br><br><br>
		<div class="M_table">
			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr bgcolor="#EBF4FB">
					<td width="309"><div align="center"><strong>
						  档案标题
						</strong>
					   
					</div></td>
					<td width="225" height="30" class="STYLE9"><div align="center"
							class="STYLE19"><strong>
						  建档时间
						</strong></div></td>
					<td width="163" class="STYLE9"><div align="center"
							class="STYLE19"><strong>
						  档案类别
						</strong></div></td>
					<td width="49"><div align="center"><strong>起草人</strong></div></td>
				</tr>
				<tr bgcolor="#EBF4FB">

					<%
						int i = 1;
					%>
					<%
						while (rset.next()) {
					%>
					<td><%=rset.getString("Title")%></td>
					<td height="33"><%=rset.getString("BuildTime")%></td>
					<td><%=dao.getDocClass(rset.getInt("ClassID")).get(0)%></td>
					<td><%=rset.getString("Builder")%></td>
				
				</tr>

				<%
					i = i + 1;
						if (i > 10)
							break;
					}
					Conn.closeRs(rs);
					Conn.closeStmt(stmt);
					Conn.closeCon(con);
					Conn.closeRs(rset);
				%>
			</table>
			
			 <span>共有<%=resultconts %>条数据,共<%=totalPages %>页</span>
		  <p align="center">
		 
		  第<%=curPages%>页
				<%
					if (curPages > 1) {
				%>
				<a href="Processer.jsp?page=<%=curPages - 1%>">上一页</a>
				<%
					}
				%>
				<%
					if (curPages < totalPages) {
				%>
				<a href="Processer.jsp?page=<%=curPages + 1%>">下一页</a>
				<%
					}
				%>
		  </p>
			<br>
		</div>
		<p align="center">
			<%@ include file="Public/MyBottom.jsp"%>
		</p>
		<p>&nbsp;</p>
	</form>
	
  </body>
</html>
