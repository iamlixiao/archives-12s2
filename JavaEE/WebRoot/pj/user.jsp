<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setCharacterEncoding("GBK");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'user.jsp' starting page</title>

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
		<jsp:useBean id="acc" class="pj.Account" scope="session"></jsp:useBean>
		<%
			if (request.getSession().getAttribute("logged") == null) {
				if (!acc.validate(request.getParameter("usn"), request
						.getParameter("pwd")))
					response.sendRedirect("i.jsp");
				else {
					request.getSession().setAttribute("logged",
							acc.getIdByNick(request.getParameter("usn")));
					response.sendRedirect("user.jsp?act=front");
				}
			} else {
				if (request.getParameter("rec") != null) {
					if (request.getParameter("rec").length() > 0) {
						acc.addRecord((Integer) request.getSession()
								.getAttribute("logged"), request
								.getParameter("rec"));
						response.sendRedirect("user.jsp?act=view&aid="+String.valueOf(request.getSession().getAttribute("logged")));
					}
				} else if (request.getParameter("act") != null){
					if (request.getParameter("act").length() > 0) {
						String act = request.getParameter("act");
						if (act.equals("front")) {%><jsp:forward page="userview.jsp" /><%}
						else if (act.equals("friend")) {%><jsp:forward page="friends.jsp" /><%}
						else if(act.equals("settings")){%><jsp:forward page="settings.jsp" /><%}
						else if(act.equals("my")){response.sendRedirect("user.jsp?act=view&aid="+String.valueOf(request.getSession().getAttribute("logged")));}
						else if(act.equals("view")){%><jsp:forward page="accountview.jsp"><jsp:param name="aid" value="<%=request.getParameter(\"aid\") %>" /></jsp:forward><%}
						else if(act.equals("delrecord")){
							acc.delRecord(Integer.parseInt(request.getParameter("rid")));
							response.sendRedirect("user.jsp?act=view&aid="+String.valueOf(request.getSession().getAttribute("logged")));
						}
						else if(act.equals("delfriend")){
							acc.delFriend((Integer) request.getSession().getAttribute("logged"),Integer.parseInt(request.getParameter("a2id")));
							response.sendRedirect("user.jsp?act=view&aid="+request.getParameter("a2id"));
						}
						else if(act.equals("addfriend")){
							acc.addFriend((Integer) request.getSession().getAttribute("logged"),Integer.parseInt(request.getParameter("a2id")));
							response.sendRedirect("user.jsp?act=view&aid="+request.getParameter("a2id"));
						}
						else if(act.equals("logout")){
							request.getSession().setAttribute("logged",null);
							response.sendRedirect("i.jsp");
						}
					}} else {
		%>
		<jsp:forward page="userview.jsp" />
		<%
			}

			}
		%>
	</body>
</html>
