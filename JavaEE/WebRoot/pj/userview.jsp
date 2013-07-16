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

		<title>My JSP 'userview.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="pj/x.css">

	</head>

	<body>
		<jsp:include page="topbar.jsp"></jsp:include>
		<jsp:useBean id="acc" class="pj.Account" scope="session"></jsp:useBean>
		<div class="mid" style="margin: auto; width: 85%; height: 100%; display: table;">
			<div style="display: table-row">
				<div id="left">
					<div style="font-size: 32px; font-weight: bold">
						好友动态
					</div>
					<%
						ResultSet friendrs = acc.getFriendsRecords((Integer) request
								.getSession().getAttribute("logged"));
						if (friendrs != null)
							while (friendrs.next()) {
					%>
					<div
						style="text-align: left; background: white; box-shadow: 2px 2px 5px #057; margin: 1em 0 0 0">
						<div class="record-head"><%=acc.getNickById(friendrs.getInt("aid"))%></div>
						<div class="record-body"><%=friendrs.getString("content")%></div>
						<div class="record-foot"><%=friendrs.getTimestamp("datetime")%></div>
					</div>
					<%
						}
						else
							out.print("没有动态");
					%>
				</div>
				<div id="right">
					<div style="font-size: 28px; margin: 20px">
						发布状态
					</div>
					<form action="pj/user.jsp" method="post">
					<textarea style="width: 90%; height: 400px" name="rec"></textarea>
						<input type="submit" value="发布" style="height: 25px" />
					</form>
				</div>
			</div>
		</div>
		<br>
	</body>
</html>
