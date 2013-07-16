<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="java.sql.*"%>
<jsp:useBean id="acc" class="pj.Account" scope="session"></jsp:useBean>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setCharacterEncoding("GBK");
	if (acc
			.isAdmin(request.getSession().getAttribute("logged") == null ? -1
					: (Integer) request.getSession().getAttribute(
							"logged"))) {
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>管理页</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="pj/x.css">

	</head>

	<body>
		<jsp:include page="topbar.jsp"></jsp:include>
		<%if(request.getParameter("aid")==null){ %>
		<div style="width: 70%; margin: auto">
			<%
				int pages=10;
				int rows=0;
				int p = request.getParameter("n") == null ? 0 : Integer
							.parseInt(request.getParameter("n"));
					ResultSet r = acc.getAccounts(p, pages);
					request.getSession().setAttribute("n",String.valueOf(p));
					while (r.next()) {
					++rows;
			%>
			<form action="pj/admin.jsp" method="post"
				style="margin: 10px; border: 1px solid black; background-image: -moz-linear-gradient(90deg, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 0.1) ); border-radius: 10px">
				<div>
					<input style="display:none" name="aid" type="text" value="<%=r.getInt("aid")%>"/><%=r.getInt("aid")%>::
					<input name="anick" type="text" value="<%=r.getString("anick")%>" />
					<input name="pwd" type="text" value="<%=r.getString("pwd")%>" />
				</div>
				<div>
					邮箱：
					<input name="email" type="text" value="<%=r.getString("email")%>" />
					生日：
					<input name="birthday" type="text" value="<%=r.getDate("birthday")%>" />
					简介：
					<input name="comment" type="text" value="<%=r.getString("comment")%>" />
				</div>
				<div>
					权限：
					<input name="s1" type="text" value="<%=r.getInt("s1")%>" />
					标题：
					<input name="s2" type="text" value="<%=r.getString("s2")%>" />
				</div>
				<input type="submit" value="保存" />
			</form>
			<%
				}
			%>
		</div>
		<form action="pj/admin.jsp" method="get">
			<a <%if(p>0){ %> href="pj/admin.jsp?n=<%=p - 1%>" <%} %>>&lt;</a> 第
			<input type="text" name="n" value="<%=p%>" />
			页
			<input type="submit" value="前往" />
			<a <%if(rows==pages){ %> href="pj/admin.jsp?n=<%=p + 1%>" <%} %>>&gt;</a>
		</form>
		<%if(r!=null)r.close();
			}else{
				acc.modifyAccount(request.getParameter("aid"),request.getParameter("pwd"),request.getParameter("anick"),request.getParameter("email"),request.getParameter("birthday"),request.getParameter("comment"),request.getParameter("s1"),request.getParameter("s2"));
				response.sendRedirect("admin.jsp?n="+(String)request.getSession().getAttribute("n"));
			} %>
	</body>
</html>
<%
	} else
		response.sendRedirect("user.jsp");
%>
