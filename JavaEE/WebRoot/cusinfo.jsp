<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.sql.*"%>
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

		<title>My JSP 'cusinfo.jsp' starting page</title>

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
		<jsp:useBean id="cusData" class="cusinfo.CusinfoAccess"
			scope="session"></jsp:useBean>
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
			<%
				ResultSet allData = cusData.getAllData();
				while (allData.next()) {
				String cid=allData.getString("cid");
			%>
			<tr>
				<td><%=cid%></td>
				<td><%=allData.getString("cname")%></td>
				<td><%=allData.getString("phone")%></td>
				<td><%=allData.getString("mobile")%></td>
				<td><%=allData.getString("address")%></td>
				<td>
					<a href="cusinfo/cusctl?act=mod&cid=<%=cid%>">修改</a>|
					<a href="cusinfo/cusctl?act=del&cid=<%=cid%>">删除</a>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<a href="cusinfo/cusctl?act=new">添加</a>
		<br>
	</body>
</html>
