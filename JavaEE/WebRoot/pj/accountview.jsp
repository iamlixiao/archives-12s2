<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="java.sql.*"%>
<jsp:useBean id="acc" class="pj.Account" scope="session"></jsp:useBean>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	try {
		ResultSet r = acc.getData(Integer.parseInt(request
				.getParameter("aid")));
		if (!r.next())
			throw new Exception();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title><%=r.getString("s2")%></title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="pj/x.css">
		<script type="text/javascript">
			function first(){
				document.getElementById("title").innerHTML="<%=r.getString("s2")%>";
			}
		</script>
	</head>

	<body onload="first()">
		<jsp:include page="topbar.jsp"></jsp:include>
		<div class="mid"
			style="margin: auto; width: 85%; height: 100%; display: table;">
			<div style="display: table-row">
				<div id="left">
					<div style="font-size: 32px; font-weight: bold">
						<%=r.getString("anick")%>的动态
					</div>
					<%
						ResultSet myrs = acc.getRecords(Integer.parseInt(request
									.getParameter("aid")));
							Boolean me = Integer.parseInt(request.getParameter("aid")) == (Integer) request
									.getSession().getAttribute("logged");
							String aid = request.getParameter("aid");
							if (myrs != null)
								while (myrs.next()) {
					%>
					<div
						style="text-align: left; background: white; border-radius: 4px; box-shadow: 0 0 7px #0bd; margin: 1em 0 0 0">
						<div class="record-head"><%=acc.getNickById(Integer.parseInt(aid))%></div>
						<div class="record-body"><%=myrs.getString("content")%></div>
						<div class="record-foot">
							<%
								if (me) {
							%><a href="pj/user.jsp?act=delrecord&rid=<%=myrs.getInt("rid")%>">删除</a>
							<%
								}
							%>
							<%=myrs.getTimestamp("datetime")%></div>
					</div>
					<%
						}
							else
								out.print("没有动态");
					%>
				</div>
				<div id="right">
					<form action="pj/accountview.jsp">
						查找用户
						<div>
							ID:
							<input type="text" name="aid" />
						</div>
					</form>
					<div style="font-size: 28px; margin: 20px">
						<%=r.getString("anick")%>的资料
					</div>
					<%
						if (!me) {
					%>
					<div>
						<%
							if (acc.isFriend((Integer) request.getSession()
											.getAttribute("logged"), Integer.parseInt(request
											.getParameter("aid")))) {
						%>
						<a
							href="pj/user.jsp?act=delfriend&a2id=<%=request.getParameter("aid")%>">取消关注</a>
						<%
							} else {
						%>
						<a
							href="pj/user.jsp?act=addfriend&a2id=<%=request.getParameter("aid")%>">加关注</a>
						<%
							}
						%>
					</div>
					<%
						}
					%>
					<div style="text-align: left; padding-left: 10px; line-height: 2em">
						<div>
							ID：<%=r.getInt("aid")%></div>
						<div>
							昵称：<%=r.getString("anick")%></div>
						<div>
							邮箱：<%=r.getString("email")%></div>
						<div>
							生日：<%=r.getDate("birthday")%></div>
						<div>
							简介：<%=r.getString("comment")%></div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
<%
	if (r != null)
			r.close();
		if (myrs != null)
			myrs.close();
	} catch (Exception e) {
		e.printStackTrace();
		out
				.print("<html><body><div style=\"margin:35px;font-size:28px;background:red\">无此用户！</div></body></html>");
	}
%>