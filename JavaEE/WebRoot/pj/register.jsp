<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<jsp:useBean id="acc" class="pj.Account" scope="session"></jsp:useBean>
<%
	int q = 0;
	request.setCharacterEncoding("GBK");
	if (acc.validateNick(request.getParameter("usn"))) {
		if (request.getParameter("pwd").equals(
				request.getParameter("pwdc"))) {
			int c = acc.addAccount(request.getParameter("usn"), request
					.getParameter("pwd"));
			request.getSession().setAttribute("logged", c);
		} else {
			q = 1;
		}
	} else {
		q = 2;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>ע����</title>

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
	<div style="display:block;width:450px;height:130px;padding:150px;font-size:28px;text-align:center;margin:auto;background-image:-moz-linear-gradient(90deg, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.3) )">
		<%
			switch (q) {
			case 0:
		%>
		ע��ɹ���
		<a href="pj/user.jsp?act=settings">���ȥ�����˺�����</a>
		<%
			break;
			case 1:
		%>ע��ʧ�ܣ�
		<a href="pj/i.jsp">��˷���</a>
		<%
			break;
			case 2:
		%>���������ˣ�
		<a href="pj/i.jsp">��˷���</a>
		<%
			}
		%>
		</div>
	</body>
</html>
