<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<jsp:useBean id="acc" class="pj.Account" scope="session"></jsp:useBean>
<div class="top">
	<b id="title"><%=request.getSession().getAttribute("logged")==null?"JavaEE":acc.getS2((Integer)request.getSession().getAttribute("logged")) %></b>
	<a href="pj/user.jsp?act=front">首页</a>
	<a href="pj/user.jsp?act=friend">好友</a>
	<a href="pj/user.jsp?act=settings"> 账户 </a>
	<a href="pj/user.jsp?act=my">我的主页</a>
	<%
	if (acc
			.isAdmin(request.getSession().getAttribute("logged") == null ? -1
					: (Integer) request.getSession().getAttribute(
							"logged"))) { %>
	<a href="pj/admin.jsp">管理</a>
	<%} %>
	<a style="position:absolute;right:10px;top:10px;font-size:28px" href="pj/user.jsp?act=logout">登出</a>
</div>