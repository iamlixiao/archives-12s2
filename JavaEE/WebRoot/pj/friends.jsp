<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
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

		<title>���ѹ���</title>

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
		<div class="mid" style="padding:25px;border-radius:10px;display:table;width:70%;margin:15px auto 15px auto;background-image:-moz-linear-gradient(90deg, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.3) )">
		<div style="display:table-row">
			<div style="display:table-cell">
				<b style="font-size:36px">�ҹ�ע��</b>
			<%ResultSet r=acc.getFriends((Integer)request.getSession().getAttribute("logged"));
			int c=0;
			if (r != null)
							while (r.next()) { ++c;%>
			<ul style="">
			<li>
			<div><a style="font-size:25px;color:black" href="pj/user.jsp?act=view&aid=<%=r.getInt("a2id") %>"><%=acc.getNickById(r.getInt("a2id")) %></a>
			<a href="pj/user.jsp?act=delfriend&a2id=<%=r.getInt("a2id") %>">ȡ����ע</a>
			</div>
			</li>
			</ul>
			<%}else {%>
			��ȡʧ��
			<%} 
			if(c==0){%>
			<br/>û�й�ע�κ���
			<%} %>
			</div>
			<div style="display:table-cell">
				<b style="font-size:36px">��ע���ҵ�</b>
			<%r=acc.friendsGet((Integer)request.getSession().getAttribute("logged"));
			c=0;
			if (r != null)
							while (r.next()) { ++c;%>
			<ul style="">
			<li>
			<div><a style="font-size:25px;color:black" href="pj/user.jsp?act=view&aid=<%=r.getInt("a1id") %>"><%=acc.getNickById(r.getInt("a1id")) %></a>
			<a href="pj/user.jsp?act=addfriend&a2id=<%=r.getInt("a1id") %>">��ע</a>
			</div>
			</li>
			</ul>
			<%}else {%>
			��ȡʧ��
			<%} 
			if(c==0){%>
			<br/>û���κ��˹�ע��
			<%} %>
			</div>
			<div style="display:table-cell">
				<b style="font-size:36px">����Ƽ�</b>
			<%r=acc.randomFriends((Integer)request.getSession().getAttribute("logged"));
			c=0;
			if (r != null)
							while (r.next()) { ++c;%>
			<ul style="">
			<li>
			<div><a style="font-size:25px;color:black" href="pj/user.jsp?act=view&aid=<%=r.getInt("aid") %>"><%=acc.getNickById(r.getInt("aid")) %></a>
			<a href="pj/user.jsp?act=addfriend&a2id=<%=r.getInt("aid") %>">��ע</a>
			</div>
			</li>
			</ul>
			<%}else {%>
			��ȡʧ��
			<%} 
			if(c==0){%>
			<br/>û���Ƽ�
			<%} %>
			</div>
		</div>
</div>
	</body>
</html>
