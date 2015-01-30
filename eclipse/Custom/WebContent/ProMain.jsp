<%@page import="com.beans.*"%>
<%@page import="java.io.File"%>
<%@page import="java.lang.*"%>

<%@page import="java.sql.ResultSet"%>
<%@ page language="java"
	import="java.util.*,com.beans.Conn,java.sql.*,com.filter.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<script type="text/javascript" src="jquery-1.11.1.js"></script>

<script type="text/javascript">

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





	
<!--
$(function(){
    $(".clsTitle").hover(function(){
 $(".clsContent").show();
 },
 function(){
 $(".clsContent").hide();
})
  })

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
//-->
</script>

<title>编辑文档</title>
<link rel="stylesheet" type="text/css" href="MainStyle.css" />

<style type="text/css">
<!--
.STYLE7 {
	color: #FF0000;
	font-weight: bold;
}
.STYLE9 {color: #FF0000}
#Layer1 {
    background: none repeat scroll 0 0 #EBF4FB;
	position:absolute;
	width:760px;
	z-index:1;
	left: 365px;
	top: 180px;
	visibility: hidden;
}
.STYLE11 {
	font-size: 14px;
	font-weight: bold;
	color: #3366CC;
}
.STYLE12 {font-weight: bold}

-->
</style>
</head>

<body >
<%
		int id =Integer.parseInt(request.getParameter("id"));
		DAO dao = new DAO();
		List<DocBean> bli = dao.getDoc(id);
		session.setAttribute("id", id);
	 %>
<div id="Layer1">
  <fieldset><legend></legend>
  <p  align="center"><strong><%= bli.get(0).getTitle() %></strong></p><br>
  <p><%= bli.get(0).getFullText() %>&nbsp;</p><br>
  <p><%=bli.get(0).getTranslateText()%>&nbsp;</p>
  </fieldset>
</div>
<form name="form1" method="post" action="">
  <label></label>
</form>
<form name="form" method = "post">
	<p>
		<%@ include file="Public/MyTitle.jsp"%>
	</p>
	
	
	<div >
	<%
	
		String virtPath = request.getServletPath();//虚拟路径
		System.out.println("虚拟路径："+virtPath);
		System.out.println("当前WEB应用的物理路径："+application.getRealPath("/"));
		String rawUrl = bli.get(0).getRawUrl();//得到当前档案的rawUrl
		String savepath = getServletConfig().getInitParameter("savePath");
		System.out.println("savepath是----"+savepath);
		String url = savepath+"/"+rawUrl;
		System.out.println("url是----"+url);
		
		
		
	%>
         <iframe src="<%=url%>" width="570" height="570"></iframe>
    	 
    	 <div class="biaoge" style="width:410px;height:470px;">
    
    
    
    
    <table width="100%" border="1" cellpadding="1" cellspacing="0">
      <tr>
        <td colspan="2"><span class="STYLE7">标题：
          <input type="text" name="retitle" value="<%=bli.get(0).getTitle()%>" style="width: 303px; ">
        </span></td>
      </tr>
      <tr>
        <td><span class="STYLE7">关键词：
            <input type="text" name ="keywords" value ="<%=bli.get(0).getKeyWords()%>" style="width: 94px; "></span></td>
        <td><span class="STYLE7">关键人：
            <input type="text" name ="keypersons" value ="<%=bli.get(0).getKeyPersons()%>" style="width: 94px; ">
          </span></td>
      </tr>
      <tr>
        <%-- <td><span class="STYLE7">起草日期：<input type="text" name ="btime" value ="<%=bli.get(0).getBuildTime()%>" style="width: 80px; "></span></td> --%>
       	<td><span class="STYLE7">起草日期：<input type="text" style="width:70px" onfocus="HS_setDate(this)" name ="btime" value ="<%=bli.get(0).getBuildTime()%>"  ></span></td>
        <td><span class="STYLE7">起草人：<input type="text" name = "builder"  value ="<%=bli.get(0).getBuilder()%>"style="width: 101px; "></span></td>
      </tr>
      <tr>
        <td colspan="2"><span class="STYLE7"  >摘要：<textarea name="abstract" cols="50" rows="1" style="width: 345px; height: 22px"><%=bli.get(0).getDocAbstract()%>" </textarea></span></td>
      </tr>
      <tr>
        <td colspan="2" style="height: 200px; ">
        <div class="STYLE7" style="height:200px; overflow-y:scroll; border:0 solid;"> 原文：<br>
          
          <textarea name="fulltext" cols="50" rows="9" ><%=bli.get(0).getFullText()%>
          </textarea>
        </div></td>
        </tr>
        <tr>
        <td colspan="2" style="height: 200px; ">
        <div class="STYLE7" style="height:200px; overflow-y:scroll; border:0 solid;"> 译文：<br>
          
          <textarea name="translatetext" cols="50" rows="9" ><%=bli.get(0).getTranslateText()%>
          </textarea>
        </div></td>
        </tr>
        
        <tr> <td><div align="center"><span class="STYLE12" align="center" onMouseOver="MM_showHideLayers('Layer1','','show')" onMouseOut="MM_showHideLayers('Layer1','','hide')">
          <img src="images/view.png" width="20" height="20"/><span class="STYLE11">预览档案</span></span></div></td>
        <td style="height:25px;"><span class="STYLE9">
        	<a href="ProFile.jsp">返回</a> &nbsp;     
         
            <a href="ProResult.jsp?id=<%=request.getParameter("id")%>">提交档案</a></span>&nbsp;
         
          <input onClick="form.action='ProUpdateServlet';form.submit();" type="submit" name="Submit" value="保存">
                 </td>
      
        </tr>
    </table>
    </div>
   </div>
    <p align="center">&nbsp;</p>
	<p>&nbsp;</p>
	<p align="center">
	  <%@ include file="Public/MyBottom.jsp"%>
</p>
  
</form>
</body>
</html>
    