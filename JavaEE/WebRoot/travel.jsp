<?xml version="1.0" encoding="GBK" ?>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>���η���</title>
</head>
<body>
	<h2>���η��ò�ѯ</h2>
	<form action="travel.jsp" method="post">
		<select name="dest">
			<option value=0>�ص�</option>
			<option value=1>����</option>
			<option value=2>����</option>
			<option value=3>�Ͼ�</option>
			<option value=4>����</option>
			<option value=5>�ɶ�</option>
			<option value=6>���</option>
		</select> <input type="submit" value="��ѯ" />
	</form>
	<div>
		<c:set var="dest" value="<%=request.getParameter(\"dest\")%>" />
		<c:choose>
			<c:when test="${dest==1 }">�����ķ���Ϊ100</c:when>
			<c:when test="${dest==2 }">���ݵķ���Ϊ200</c:when>
			<c:when test="${dest==3 }">�Ͼ��ķ���Ϊ300</c:when>
			<c:when test="${dest==4 }">���ݵķ���Ϊ400</c:when>
			<c:when test="${dest==5 }">�ɶ��ķ���Ϊ500</c:when>
			<c:when test="${dest==6 }">��۵ķ���Ϊ600</c:when>
		</c:choose>Ԫ
	</div>
</body>
</html>