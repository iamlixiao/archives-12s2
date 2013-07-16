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

		<title>账户资料</title>

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
		<div class="mid"
			style="display: table; width: 65%; margin: 100px auto 0 auto; background-image: -moz-linear-gradient(90deg, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.3) ); border-radius: 7px; padding: 10px; border: 1px solid white">
			<div style="display: table-row">
				<div style="display: table-cell">
					<%
						ResultSet r = acc.getSettings((Integer) request.getSession()
								.getAttribute("logged"));
						r.next();
					%>
					<div>
						修改资料
					</div>
					<form action="pj/modData.jsp" method="post">
						<div>
							昵称
						</div>
						<input name="nick" value="<%=r.getString("anick")%>" />
						<div>
							邮箱
						</div>
						<input name="email" value="<%=r.getString("email")%>" />
						<div>
							生日
						</div>
						<input name="birthday" value="<%=r.getDate("birthday")%>" />
						<div>
							简介
						</div>
						<input name="comment" value="<%=r.getString("comment")%>" />
						<div>
							自定义标题
						</div>
						<input name="s2" value="<%=r.getString("s2")%>" />
						<div>
							<input type="submit" value="提交" />
						</div>
					</form>
				</div>
				<script type="text/javascript">
function pwdvalidate(){
	var q=document.getElementById("q"),p0;
	if(q.value==document.getElementById("p").value&&q.value.length>0){
		q.style.backgroundColor="green";
		document.getElementById("zci").disabled=false;
	}
	else{
		q.style.backgroundColor="red";
		document.getElementById("zci").disabled=true;
	}
}
		</script>
				<div style="display: table-cell">
					<div>
						修改密码
					</div>
					<form action="pj/modPwd.jsp" method="post">
						<div>
							旧密码
						</div>
						<input name="opw" type="password" id="n"/>
						<div>
							新密码
						</div>
						<input name="pwd" type="password" id="p" onkeyup="pwdvalidate()"/>
						<div>
							确认密码
						</div>
						<input name="pwdc" type="password" id="q" onkeyup="pwdvalidate()"/>
						<div>
							<input type="submit" value="修改" id="zci"/>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>
