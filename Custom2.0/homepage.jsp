<%@ page language="java" import="java.util.*,com.beans.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	    <base href="<%=basePath%>">
	    <title>欢迎光临海关档案管理系统</title>
	    <link rel="stylesheet" type="text/css" href="MyStyle.css" />
	    <script type="text/javascript" src="jquery-1.11.1.js"></script>
	 
	    <script type="text/javascript">
			function login(){
				if(document.form.loginName.value==""){
					alert("用户名不能为空！");
					return false;//两个作用：1，防止事件传播；2，阻止事件默认的行为
				}
				else if(document.form.password.value==""){alert("密码不能为空！");return false;}
				else{return true;}
			}

		 	$(function(){
				var $content = $(".content");
				$("#contract ul li:first").hover(//相当于包含mouseover和mouseout两个函数
					function(){$content.show("fast");},
					function(){$content.hide("fast");}
				);
			}); 
			
			
			$(function(){
				var $comment = $(".comment");
				$("#c2").hover(
					function(){$comment.show("fast");},
					function(){$comment.hide("fast");}
				);
			});			
			
		/* 	$(function(){
				//alert($("#contract ul li").length);
				
			 	$("#contract ul li:first").bind("click",function(){
					var $content = $(".content");
					if($content.is(":visible")){
						$content.hide("fast");
					}else{
						$content.show("fast");
					}
				});
			});	 
		
		
			$(function(){
					var $comment = $(".comment");
					
					$("#contract ul li:last").mouseover(function(){//构造mouseover和mouseout两个函数
						$comment.show("fast");
					});
					$("#contract ul li:last").mouseout(function(){
						$comment.hide("fast");
					});
					
					
	
				 	$("#contract ul li:last").bind("click",function(){//绑定click事件
						var $comment = $(".comment");
						if($comment.is(":visible")){
							$comment.hide("fast");
						}else{
							$comment.show("fast");
						}
					}); 
					
				}) 
		
		
		*/
			
			
			
			
			
		 	

		</script>
		
	    <style type="text/css">
<!--
.STYLE4 {
	font-size: 18px;
	color: #999999;
}
.STYLE5 {
	font-size: 14px;
	color: #999999;
}
-->
        </style>
    </head>
  
	<body>
		<%
			PubDAO pubdao = new PubDAO();
			//DAO dao = new DAO(); 
			List<NewsBean> nli = pubdao.getNews(0);

		 %>
	
		<form action="LoginServlet" method="post" name="form" onSubmit="return login();">
			<%@ include file="Public/MyTitle.jsp"%>
			<div><!-- 主体 -->
			<div id="ctl00_M_left" class="M_left"><!-- 左边主体 -->
				<div class="left_frame">
					<!-- <div id="ctl00_left_help" class="left_frame"></div>加黑框 -->
						<div class="left_title">
							<img src="images/two_users.png" alt="" style="height: 20px; width: 20px; " /> <span>用户登录</span>
						</div>
		
						<div>
							<div>
								<span class="log_span">账号：<input class="log_input" name="loginName" type="text" style="width: 150px; "/></span>
							</div>
							<div>
								<span class="log_span">密码：</span><input class="log_input" name="password" type="password" style="width: 150px; "/>
							</div>
							<center>
							<div>
								<input type="submit" name="submit" value="登  录" style="width: 77px; "/> <input type="reset" name="reset" value="重   置" style="width: 74px; "/>
							</div>
							<div> 
								<center><span class="msgstr">欢迎使用本系统，请登录</span></center>
							</div></center>
						</div>
				</div>
				
					
				<div class="left_frame">
					<div class="left_title">
						<img src="images/wel.png"  style="height: 150px; width: 200px;"/>
					</div>
					
					<div id="contract">
						<ul class="left_body">
							
							
							
							
						<!-- 	<li id = "c3">change
								<div class="change">
									变颜色
								</div>
							</li> -->
						</ul>
					</div>
					
				</div>
			</div>
		
			<div class="M_right"><!-- 右边主体 -->
				<div>
					<div>
						<h1 class="posts_title"><span class="STYLE4">尊敬的用户，您好！感谢您使用粤海关档案管理系统</span></h1>
						<h2 class="posts_vtitle STYLE5">本系统为您提供了最原始的粤海关档案，您可通过本系统对原始档案进行翻译，注释，查阅，研究以及相关的管理工作。希望您使用愉快。</h2>
					</div>
				</div>
				
				<%for(int i=0;i<5;i++) {%>
					<dl>
						<dt><a href="NewsView.jsp?id=<%=nli.get(i).getID()%>"><%=nli.get(i).getTitle()%></a>&nbsp;&nbsp;&nbsp;&nbsp;<%=nli.get(i).getInputDate()%></dt>
					</dl>
					<%} %>
					
			</div>
		</div>
			<%@ include file="Public/MyBottom.jsp"%>
		</form>
	</body>
</html>
