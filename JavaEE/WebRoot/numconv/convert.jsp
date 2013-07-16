<?xml version="1.0" encoding="GBK" ?>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="/WEB-INF/convertTag.tld" prefix="conv"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>大写金额</title>
</head>
<body>
	<h1>转换</h1>
	<div><%=request.getParameter("num")%></div>
	<div>
		<conv:num2shu><%=request.getParameter("num")%></conv:num2shu>
	</div>
</body>
</html>