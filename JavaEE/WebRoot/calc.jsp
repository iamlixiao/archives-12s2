<?xml version="1.0" encoding="GBK" ?>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>计算器</title>
</head>
<body>
	<jsp:useBean id="cb" class="lab02.CalcBean" />
	<jsp:setProperty property="arg1" name="cb" param="arg1" />
	<jsp:setProperty property="arg2" name="cb" param="arg2" />
	<jsp:setProperty property="method" name="cb" param="method" />
	<%
		if (request.getParameter("arg1") != null) {
	%>
	计算的结果是：<jsp:getProperty property="arg1" name="cb" /><jsp:getProperty
		property="method" name="cb" /><jsp:getProperty property="arg2"
		name="cb" />=<%=cb.calc()%>
	<%
		} else {
	%>
	<div>简单计算器</div>
	<form action="calc.jsp" method="get">
		<input type="text" name="arg1" /> <select name="method">
			<option value="+">+</option>
			<option value="-">-</option>
			<option value="*">*</option>
			<option value="/">/</option>
		</select> <input type="text" name="arg2" /> <input type="submit" />
	</form>
	<%
		}
	%>
</body>
</html>