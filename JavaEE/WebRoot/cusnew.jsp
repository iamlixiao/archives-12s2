<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'cusnew.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
		<form action="cusinfo/cusctl" method="post">
			<table style="border: 1px solid black">
				<tr>
					<td>
						序号
					</td>
					<td>
						姓名
					</td>
					<td>
						电话
					</td>
					<td>
						手机号码
					</td>
					<td>
						地址
					</td>
					<td>
						操作
					</td>
				</tr>
				<tr>
					<td><%=request.getSession().getAttribute("cid")%></td>
					<td><input name="cname"/></td>
					<td><input name="phone"/></td>
					<td><input name="mobile"/></td>
					<td><input name="address"/></td>
					<td>
						<input type="submit" value="提交"/>
					</td>
				</tr>
			</table>
		</form>
  </body>
</html>
