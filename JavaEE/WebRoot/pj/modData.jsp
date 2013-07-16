<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>修改结果</title>
		<meta http-equiv="refresh" content="2;url=user.jsp?act=my">
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
		<%request.setCharacterEncoding("GBK");
		if(request.getSession().getAttribute("logged")==null){ %>
		登录出错
		<%}else if(request.getParameter("nick")==null){ %>
		昵称为空
		<%}else if(acc.getIdByNick(request.getParameter("nick"))!=((Integer)request.getSession().getAttribute("logged")).intValue()){ if(acc.getIdByNick(request.getParameter("nick"))!=null){%>
		昵称有误
		<%}}else if(request.getParameter("email")==null){ %>
		邮箱为空
		<%}else if(request.getParameter("birthday")==null){ %>
		生日为空
		<%}else if(request.getParameter("comment")==null){ %>
		简介为空
		<%}else{
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
  		java.util.Date birthday=f.parse(request.getParameter("birthday"));
  		if(birthday==null){
  	%>
		生日有误
		<%}else if(!acc.modifyData((Integer)request.getSession().getAttribute("logged"),request.getParameter("nick"),request.getParameter("email"),birthday,request.getParameter("comment"),request.getParameter("s2"))){ %>
		修改失败
		<%}else{ %>修改成功<%}} %>
		<br>
	</body>
</html>
