<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<jsp:useBean id="acc" class="pj.Account" scope="session"></jsp:useBean>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("GBK");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改结果</title>
		<meta http-equiv="refresh" content="2;url=user.jsp?act=settings">
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
  <%if(acc.validate((Integer)request.getSession().getAttribute("logged"),request.getParameter("opw"))) {
  	if(acc.modifyPwd((Integer)request.getSession().getAttribute("logged"),request.getParameter("pwd"))){%>
    修改成功
    <%}else{ %>
    修改失败
    <%}}else{ %>
    验证错误
    <%} %>
  </body>
</html>
