<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<jsp:useBean id="acc" class="pj.Account" scope="session"></jsp:useBean>
<div class="top">
	<b id="title"><%=request.getSession().getAttribute("logged")==null?"JavaEE":acc.getS2((Integer)request.getSession().getAttribute("logged")) %></b>
	<a href="pj/user.jsp?act=front">��ҳ</a>
	<a href="pj/user.jsp?act=friend">����</a>
	<a href="pj/user.jsp?act=settings"> �˻� </a>
	<a href="pj/user.jsp?act=my">�ҵ���ҳ</a>
	<%
	if (acc
			.isAdmin(request.getSession().getAttribute("logged") == null ? -1
					: (Integer) request.getSession().getAttribute(
							"logged"))) { %>
	<a href="pj/admin.jsp">����</a>
	<%} %>
	<a style="position:absolute;right:10px;top:10px;font-size:28px" href="pj/user.jsp?act=logout">�ǳ�</a>
</div>