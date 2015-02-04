<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>注册界面</title>
    <link rel="stylesheet" type="text/css" href="MyStyle.css" />
    
    <script type="text/javascript">
		function myCheck(){
			if(document.form.loginName.value==""){alert("登录名不能为空！！");return false;}
			else if(document.form.password.value==""){alert("密码不能为空！！");return false;}
			else if(document.form.rePassword.value==""){alert("确认密码不能为空！！");return false;}
			else if(document.form.password.value!=document.form.rePassword.value){alert("您两次输入的密码不一样！！");return false;}
			else if(document.form.realName.value==""){alert("真实姓名不能为空！！");return false;}
			else if((document.form.Email.value)==""){alert("电子邮件不能为空！！");return false;}
			else if(((document.form.Email.value.indexOf("@"))<0)||((document.form.Email.value.indexOf("@"))-(document.form.Email.value.indexOf("."))>0)||((document.form.Email.value.indexOf("."))<0)){alert("您输入的电子邮件的格式不正确，请重新输入！！");return false;}
		}
	</script>
	
    <style type="text/css">
<!--
.STYLE1 {
	font-family: "新宋体";
	font-size: 18px;
	color: #999999;
}
.STYLE2 {
	font-family: "新宋体";
	font-size: 14px;
}
.STYLE3 {
	font-size: 16px;
	color: #999999;
}
.STYLE4 {
	font-size: 18px;
	color: #999999;
}
.STYLE5 {color: #FF0000}
-->
    </style>
</head>
  
  <body>
  <%request.setCharacterEncoding("GBK"); %>
	<form action="RegistrationServlet" name="form" method="post" onSubmit="return myCheck();">
   <%@ include file="Public/MyTitle.jsp"%>
	<div>	
		
 
	<div id="ctl00_M_left" class="M_left"> 
		
		 <div class="left_frame">	
			<div class="left_title">
			<img src="images/wel.png"  style="height: 150px; width: 200px;"/>
			</div>
		</div>
			
		
			
			
			 
		 </div>
	</div>
 
	<div class="M_right"><!-- 右边主体 -->
			<div>
				<h1 class="posts_title"><span class="STYLE4">尊敬的用户您好，感谢您使用粤海关档案管理系统</span></h1>
				<h2 class="posts_vtitle STYLE2 STYLE3">本系统为您提供了最原始的粤海关档案，您可通过本系统对原始档案进行翻译，注释，查阅，研究以及相关的管理工作。希望您使用愉快。</h2>
			</div>
			
			<div>
			<center>
				<table>
					<tr>
						<td>分类：</td>
						<td>
							<input type="radio" value=2 name="userClass">档案录入员 
							<input type="radio" value=3 name="userClass">众包人员 
							<input type="radio" value=4 name="userClass">校审员<br>
							<input type="radio" value=5 name="userClass">新闻发布员 
							<input type="radio" value=6 name="userClass">研究人员
							<input type="radio" value=1 name="userClass">管理员<br>
							<input type="radio" value=7 name="userClass">出版主编
						</td>
					</tr>
					<tr>
						<td>登录名：</td>
					  <td><input type="text" name="loginName">
						  <span class="STYLE5">*</span></td>
					</tr>
					<tr>
						<td>密码：</td>
					  <td><input type="password" name="password">
						  <span class="STYLE5">*</span></td>
					</tr>
					<tr>
						<td>确认密码：</td>
					  <td><input type="password" name="rePassword">
						  <span class="STYLE5">*</span></td>
					</tr>
	
					<tr>
						<td>性别：</td>
						<td><input type=radio value=0 name="sexId" checked>男 
							<input type=radio value=1 name="sexId" >女</td>
					</tr>
					<tr>
						<td>姓名：</td>
					  <td><input type="text" name="realName">
						  <span class="STYLE5">*</span></td>
					</tr>
					<tr>
						<td>单位：</td>
						<td><input type="text" name="organization"></td>
					</tr>
					<tr>
						<td>地址：</td>
						<td><input type="text" name="address"></td>
					</tr>
					<tr>
						<td>电子邮件：</td>
					  <td><input type="text" name="Email">
						  <span class="STYLE5">*</span></td>
					</tr>
					<tr>
						<td>邮政编码：</td>
						<td><input type="text" name="postCode"></td>
					</tr>
					<tr>
						<td>办公电话：</td>
						<td><input type="text" name="officeNumber"></td>
					</tr>
					<tr>
						<td>手机号码：</td>
						<td><input type="text" name="phoneNumber"></td>
					</tr>
					<tr>
						<td><input type="submit" name="submit" value="提交" style="width: 98px;"></td>
						<td><input type="reset" name="reset" value="重置" style="width: 98px;"></td>
					</tr>
				</table>
				</center>
			</div>

			
	</div>
</div>

	<%@ include file="Public/MyBottom.jsp"%>
	</form>
</body>
</html>
