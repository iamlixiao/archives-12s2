<?xml version="1.0" encoding="GBK" ?>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>旅游费用</title>
</head>
<body>
	<h2>旅游费用查询</h2>
	<form action="travel.jsp" method="post">
		<select name="dest">
			<option value=0>地点</option>
			<option value=1>北京</option>
			<option value=2>杭州</option>
			<option value=3>南京</option>
			<option value=4>广州</option>
			<option value=5>成都</option>
			<option value=6>香港</option>
		</select> <input type="submit" value="查询" />
	</form>
	<div>
		<c:set var="dest" value="<%=request.getParameter(\"dest\")%>" />
		<c:choose>
			<c:when test="${dest==1 }">北京的费用为100</c:when>
			<c:when test="${dest==2 }">杭州的费用为200</c:when>
			<c:when test="${dest==3 }">南京的费用为300</c:when>
			<c:when test="${dest==4 }">广州的费用为400</c:when>
			<c:when test="${dest==5 }">成都的费用为500</c:when>
			<c:when test="${dest==6 }">香港的费用为600</c:when>
		</c:choose>元
	</div>
</body>
</html>