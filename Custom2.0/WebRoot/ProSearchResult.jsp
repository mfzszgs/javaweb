<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.beans.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'SearchReasult.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="MainStyle.css" />
    
    <script language="JavaScript" type="text/JavaScript">
	/* 是否全选标记 */
	var checkedAll = false;

	/* 全选/取消全选
	 * formName 所在form的name值
	 * checkboxName checkbox的name值
	 * 注意：所有checkbox的name值都必须一样，这样才能达到全选的效果
	 */
	function selectAll(formName, checkboxName) {
		var form = document.all.item(formName);
		var elements = form.elements[checkboxName];
		for ( var i = 0; i < elements.length; i++) {
			var e = elements[i];
			if (checkedAll) {
				e.checked = false;
				form.alls.checked = false;
			} else {
				e.checked = true;
				form.alls.checked = true;
			}
		}
		if (checkedAll) {
			checkedAll = false;
		} else {
			checkedAll = true;
		}
	}
	/* 检查是否有checkbox被选中
	 * formName 所在form的name值
	 * checkboxName checkbox的name值
	 * 注意：所有checkbox的name值都必须一样，这样才能达到全选的效果
	 */
	function checkAll(formName, checkboxName) {
		var hasCheck = false;
		var form = document.all.item(formName);
		var elements = form.elements[checkboxName];
		for ( var i = 0; i < elements.length; i++) {
			var e = elements[i];
			if (e.checked) {
				hasCheck = true;
			}
		}
		return hasCheck;
	}
	/* 执行操作 */
	function do_action() {
		if (!checkAll("form", "choose")) {
			alert("没有checkbox被选中，提示用户至少选择一个！");
		} else if (checkAll("form", "choose")) {
			document.form.submit();
		}
	}
</script>
 
  </head>
  
  <body>
  	<form action="ProChStaServlet" method = "post" name = "form" >
    <%@ include file="Public/MyTitle.jsp"%>
    <div class="M_table">
     <%  
    	DocBean docb = (DocBean)request.getAttribute("docb"); 
   		LinkedList<DocBean> a=(LinkedList<DocBean>)request.getAttribute("SearchList");
    	ListIterator<DocBean> aIter=(ListIterator<DocBean>)request.getAttribute("aIter");
    %>
    <span style="height: 30px">共搜索到<%=a.size() %>条数据</span><br><br>
    
			<table width="960" border="1" align="center" cellpadding="1"
				cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EBF4FB">
				<tr >
					<td width="309"><div align="center">
							<img src="images/ArchiveTitle.png" width="120" height="24" />
						</div></td>
					<td width="225" height="30" class="STYLE9"><div align="center"
							class="STYLE19">
							<img src="images/buildtime.png" width="120" height="24" />
						</div></td>
					<td width="163" class="STYLE9"><div align="center"
							class="STYLE19">
							<img src="images/danganleibie.png" width="120" height="24" />
						</div></td>
					<td width="49">
						<div>
							<span class="STYLE19"> <input type="checkbox" name="alls" onClick="selectAll('form','choose')" value="全选">
							</span>
						</div>
					</td>
				</tr>
    	<%
    		DAO dao = new DAO();
  
    	 while(aIter.hasNext()){
    		docb = (DocBean) aIter.next();
    	  	docb.getTitle();
    	  	%>
    	  	<tr>
				<td ><%=docb.getTitle()%></td>    	  	
    	  		<td ><%=docb.getBuildTime()%></td> 
    	  		<td ><%=dao.getDocClass(docb.getClassId()).get(0)%></td> 
    	  		<td style="width:38px;"><input type="checkbox" name="choose" value="<%=docb.getID()%>">
				</td> 
   	  	    </tr>
    	<%  	
    	 }
    %>
    </table>
    
   	   <p align="center">
		<input type="button" name="confirm" value="确定" onclick="do_action();">
		</p>
 
    	<center>
     	<font color="blue" ><a href="Processer.jsp" >返回众包首页</a></font>
     	</center>
    </div>

    <%@ include file="Public/MyBottom.jsp"%>
    </form>
  </body>
</html>
