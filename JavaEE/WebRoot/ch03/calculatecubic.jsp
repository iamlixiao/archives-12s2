<?xml version="1.0" encoding="GBK" ?>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>计算立方</title>
</head>
<body>
	<%
		if (request.getParameter("num") != null) {
	%>
	<jsp:forward page="cubiccal.jsp">
		<jsp:param name="num" value="<%=request.getParameter(\"num\")%>" />
	</jsp:forward>
	<%
		}
	%>
	<h1>计算立方</h1>
	<form method="get" action="calculatecubic.jsp">
		<input name="num" type="text" />
		<div>
			<input type="submit" /><input type="reset" />
		</div>
	</form>
</body>
</html>