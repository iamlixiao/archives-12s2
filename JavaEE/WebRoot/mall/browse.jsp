<?xml version="1.0" encoding="GBK" ?>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.HashMap"%>
<jsp:useBean id="data" class="mall.GoodsData" />
<%
	String[] bought = request.getParameterValues("goods");
	if (bought != null) {
		Integer[] troll = (Integer[]) session.getAttribute("goods");
		if (troll == null) {
			troll = new Integer[data.getItems().length];
			for (int i = 0; i < data.getItems().length; ++i)
				troll[i] = 0;
		}
		for (int i = 0; i < bought.length; ++i) {
			troll[Integer.parseInt(bought[i])]++;
		}
		session.setAttribute("goods", troll);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>李霄商城</title>
</head>
<body>
	<form method="post" action="browse.jsp">
		<div>请选购</div>
		<br /> <input type="checkbox" value=0 name="goods"><%=data.getItems()[0]%></input>
		<input type="checkbox" value="1" name="goods" /><%=data.getItems()[1]%>
		<input type="checkbox" value="2" name="goods" /><%=data.getItems()[2]%>
		<input type="checkbox" value="3" name="goods" /><%=data.getItems()[3]%>
		<input type="checkbox" value="4" name="goods" /><%=data.getItems()[4]%>
		<input type="checkbox" value="5" name="goods" /><%=data.getItems()[5]%>
		<input type="checkbox" value="6" name="goods" /><%=data.getItems()[6]%><br />
		<br /> <input type="submit" value="买了" />
	</form>
	<a href="goods.jsp">购物车</a>
</body>
</html>