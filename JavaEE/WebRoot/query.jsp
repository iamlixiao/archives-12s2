<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="q"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		response.setCharacterEncoding("GBK");
		request.setCharacterEncoding("GBK");
		String qt = request.getParameter("txt");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'query.jsp' starting page</title>
    
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
		<q:setDataSource var="src" driver="org.gjt.mm.mysql.Driver"
			url="jdbc:mysql://10.12.8.28/je1024007" user="je1024007"
			password="278156" />
		<q:query var="customers" dataSource="${src}">
		select * from customer where name like ?
		<q:param><%=request.getParameter("txt")+'%'%></q:param>
		</q:query>
		<table style="border: 1px solid black">
			<tr>
				<td>
					ID
				</td>
				<td>
					����
				</td>
				<td>
					����
				</td>
				<td>
					Email
				</td>
			</tr>
			<c:forEach var="custrow" items="${customers.rowsByIndex}">
				<tr>
					<c:forEach var="custcol" items="${custrow }">
						<td>
							<c:out value="${custcol }" />
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
		</table>
  </body>
</html>
