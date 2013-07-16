<?xml version="1.0" encoding="GBK" ?>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="java.util.*"%>
<%@page import="mall.GoodsData"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>Insert title here</title>
</head>
<body>
	<%
		Integer[] troll = (Integer[]) session.getAttribute("goods");
		String[] todel = request.getParameterValues("goods");
		if (todel != null) {
			for (int i = 0; i < todel.length; ++i) {
				troll[Integer.parseInt(todel[i])] = 0;
			}
		}
	%>
	<form action="goods.jsp" method="post">
		<table>
			<tr>
				<td style="width: 100px">名称</td>
				<td>数量</td>
			</tr>
			<%
				GoodsData data = new GoodsData();
				for (int i = 0; i < data.getItems().length; ++i) {
					if (troll[i] != 0) {
			%>
			<tr>
				<td><input type="checkbox" value="<%=i%>" name="goods" /><%=data.getItems()[i]%></td>
				<td><%=troll[i]%></td>
			</tr>
			<%
				}
				}
			%>
		</table>
		<input type="submit" value="删除" />
	</form>
	<a href="goods.jsp?ac=check">结账</a>
	<a href="browse.jsp">返回购物</a>
	<%
		int sum = 0;
		String ac = request.getParameter("ac");
		if (ac != null) {
			if (ac.equals("check")) {
				for (int i = 0; i < data.getPrizes().length; ++i) {
					sum += troll[i] * data.getPrizes()[i];
				}
				out.println("<div>你的总金额为：");
				out.print(sum);
				out.print("元</div>");
				troll = new Integer[data.getItems().length];
				for (int i = 0; i < data.getItems().length; ++i)
					troll[i] = 0;
				session.setAttribute("goods", troll);
			}
		}
	%>
</body>
</html>