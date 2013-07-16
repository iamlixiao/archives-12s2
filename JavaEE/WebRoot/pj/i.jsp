<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
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

		<title>»¶Ó­Ê¹ÓÃÄÉ²©</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<style type="text/css">

.usr {
	border-style:solid;
	border-color:grey;
	border-radius:3px;
	font-size:35px;
	width:70%;
	background:rgba(255,255,255,0.5);
	transition:background 1s;
}
.usr:hover{
	background:rgba(255,255,255,0.8);
	transition:background 1s;
}
.usk{
	padding:20px 0 20px 0;
	margin:75px 20px 0 20px;
	background:rgba(0,0,0,0.2);
	border-radius:5px;
	color:white;
	font-size:30px
}
.usd{
	font-size:40px;
	color:white;
	background:rgba(0,0,0,0.4);
	border-radius:14px;
	margin-top:85px;
	border:2px solid rgba(0,0,0,0);
	padding:5px;
	transition:background 1s,border 1s;
}
.usd:hover{
	background:rgba(0,0,0,0.7);
	border:2px solid black;
	transition:background 1s,border 1s;
}

.zsr {
	border-style:solid;
	border-color:grey;
	border-radius:3px;
	font-size:35px;
	width:70%;
	background:rgba(255,255,255,0.5);
	transition:background 1s;
}
.zsr:hover{
	background:rgba(255,255,255,0.8);
	transition:background 1s;
}
.zsk{
	padding:20px 0 20px 0;
	margin:35px 20px 0 20px;
	background:rgba(0,0,0,0.2);
	border-radius:5px;
	color:white;
	font-size:30px
}
.zsa{
	font-size:40px;
	color:rgba(255,255,255,0.4);
	background:rgba(0,0,0,0.2);
	border-radius:14px;
	margin-bottom:25px;
	border:2px solid rgba(0,0,0,0);
	padding:5px;
	transition:background 1s,border 1s,color 1s,transform 0.5s;
}
@keyframes blink{
0%{
	color:rgba(255,255,255,0.4);
	background:rgba(0,0,0,0.2);
	transform:scale(1,1);
}
50%{
	color:black;
	background:rgba(255,255,255,1);
	transform:scale(1.5,1.5);
}
100%{
	color:white;
	background:rgba(0,0,0,0.4);
	transform:scale(1.3,1.3);
}
}
.zsd{
	animation:blink 1s;
	font-size:40px;
	color:white;
	background:rgba(0,0,0,0.4);
	border-radius:14px;
	margin-top:65px;
	border:2px solid rgba(0,0,0,0);
	padding:5px;
	transform:scale(1.3,1.3);
	transition:border 1s;
}
.zsd:hover{
	background:rgba(0,0,0,0.7);
	border:2px solid black;
	transition:background 1s,border 1s;
}
#main{
	width:800px;
	margin:auto;
	position:relative;
	overflow:hidden;
	height:610px;
	background:rgba(0,0,0,0.3);
	top:15px;
	border-top-left-radius:17px;
	border-top-right-radius:17px
}
.ttl{
	border-left:1px solid white;
	display:table-cell;
	background:#78c;
	color:#ccc;
	font-size:25px;
	width:25%;
	transition:background 1s,color 1s;
}
.ttl:hover{
	border-top:4px solid rgba(255,255,255,0.5);
	border-bottom:3px solid rgba(0,0,0,0.5);
	background:#45c;
	color:#fff;
	transition:background 1s,color 1s;
}
@keyframes rvs{
	from{
		transform:rotateY(-90deg);
	}
	to{
		transform:rotateY(0);
	}
}
.drv{
	transform-origin:50% 0;
	transform:rotateY(90deg);
	transition:transform 1.2s;
}
.zrv{
	transform-origin:50% 0;
	animation:rvs 1.2s;
}
</style>
<script type="text/javascript">
function mainrvs(){
	document.getElementById('main').className='drv';
	var t=setTimeout("mainzvs()",1200)
}
function mainzvs(){
	var dl=document.getElementById("dl").style
	if(dl.display=="none"){
		dl.display="block";
		document.getElementById("zc").style.display="none";
	}
	else{
		dl.display="none";
		document.getElementById("zc").style.display="block";
	}
	document.getElementById("main").className="zrv";
}
function validate(){
	var q=document.getElementById("q"),p0;
	if(q.value==document.getElementById("p").value&&q.value.length>0){
		q.style.backgroundColor="green";
		p0=true;
	}
	else{
		q.style.backgroundColor="red";
		p0=false;
	}
	if(p0&&document.getElementById("n").value.length>0){
		document.getElementById("zci").disabled=false;
		document.getElementById("zci").className="zsd";
	}
	else{
		document.getElementById("zci").disabled=true;
		document.getElementById("zci").className="zsa";
	}
}
</script>
	<link rel="stylesheet" type="text/css" href="pj/x.css">

	</head>
	<%if(request.getSession().getAttribute("logged")!=null)response.sendRedirect("user.jsp"); %>
	<body style="background:url('pj/bkg.jpg') center;overflow:hidden"> 
		<jsp:useBean id="accData" class="pj.Account" scope="session"></jsp:useBean>
		<div class="top">ÄÉ²©</div>
		<div id="main" class="mid">
		<div id="dl">
		<div style="display:table;width:100%">
		<div style="display:table-row;background:#45c">
		<div style="display:table-cell;margin:15px;color:#fff;text-shadow:0 0 2px white;font-size:48px;border-top:4px solid rgba(255,255,255,0.5);border-bottom:3px solid rgba(0,0,0,0.5)">ÇëµÇÂ¼</div>
		<div class="ttl" onclick="mainrvs()">×¢²á &gt;&gt;</div>
		</div>
		</div>
		<form action="pj/user.jsp" method="post">
		<div class="usk">
		êÇ³Æ
		<input name="usn" type="text" class="usr"/>
		</div>
		<div class="usk">
		ÃÜÂë
		<input name="pwd" type="password" class="usr"/>
		</div>
		<input type="submit" value="µÇÂ¼" class="usd"/>
		</form>
		</div>
		
		<div id="zc" style="display:none">
		<div style="display:table;width:100%">
		<div style="display:table-row;background:#45c">
		<div style="display:table-cell;margin:15px;color:#fff;text-shadow:0 0 2px white;font-size:48px;border-top:4px solid rgba(255,255,255,0.5);border-bottom:3px solid rgba(0,0,0,0.5)">×¢²áÕËºÅ</div>
		<div class="ttl" onclick="mainrvs()">µÇÂ¼ &gt;&gt;</div>
		</div>
		</div>
		<form action="pj/register.jsp" method="post">
		<div class="zsk">
		êÇ³Æ
		<input name="usn" type="text" class="zsr" id="n" onkeyup="validate()"/>
		</div>
		<div class="usk">
		ÃÜÂë
		<input name="pwd" type="password" class="zsr" id="p" onkeyup="validate()"/>
		</div>
		<div class="usk">
		È·ÈÏ
		<input name="pwdc" type="password" class="zsr" id="q" onkeyup="validate()"/>
		</div>
		<input type="submit" id="zci" value="×¢²á" class="zsa"/>
		</form>
		</div>
		</div>
	</body>
</html>
