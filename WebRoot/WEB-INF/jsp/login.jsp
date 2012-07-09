<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 

<head>
<title> 标准化供电（营业）所资料管理平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href='${base}/resource/common/css/login.css' type="text/css" />
<style type="text/css">
.login-label {
	font-size: 12px;
	background-image: none;
	text-align: right;
	font-weight: bold;
	padding-right: 8px;
	color: #06547a;
}
.code-input {
	width: 46px;
	background-color: #FFFFFF;
	border: 1px solid #999999;
	margin: 1px;
	padding: 1px;
}
ul{margin:35px;padding:0px;}

#container {margin: auto;}
#header {border:0 solid white;width:100%;background-image:url(${base}/resource/common/images/login/banner.gif);background-repeat:repeat-x;}
#content {width: 602px;height: 246px; margin-top:100px; text-align:center;}
#content_login td {vertical-align: middle;}
#content_text {width:329px;background-image: url(${base}/resource/common/images/login/content_text.gif);}
#content_login {width:274px;background-image: url(${base}/resource/common/images/login/content_login.gif)}
#content_text ul {padding-left:30px; color: #249ed1;}
#content_text li {padding-bottom:5px;}
#copyright {color: 999999; text-align: center;}

#footer {margin-top: 100px;}
.btn_login {
	width: 77px; 
	height: 26px; 
	background-image: url('${base}/resource/common/images/login/btn_back.gif');
	border: 0px solid #fff;
	cursor: pointer;
	font-size: 14px;
	color: white;
	font-family: Arial, "黑体" ;
}

.login-tr {
	height:25px;
}

</style>
<script type="text/javascript">
	if(top!=this) {
		top.location=this.location;
	}
</script>
<script>

function MyShowTips(tips) {
	var tipsArea = document.getElementById("tipsArea");
	var style = "font-size:12px; color:red;";
	tipsArea.innerHTML = "<font style='" + style + "'>" + tips + "</font>"; 
}

function showTips(obj) {
	var tipsArea = document.getElementById("tipsArea");
	obj.style.border = "1px; solid #016BC9";
	var style = "font-size:12px; color:blue;";
	var tips = "";
	switch(obj.name) {
		case "username" : tips = "请输入您的帐号";break;
		case "password" : tips = "请输入您的密码";break;
		case "siteId" : tips = "请选择帐套";break;
		case "checkcode" : tips = "请输入图片显示的4个字符，不分大小写";break;
		default : tipsArea.innerHTML = "&nbsp;";
	}
	tipsArea.innerHTML = "<font style='" + style + "'>" + tips + "</font>"; 
}

function disableTips(obj) {
	obj.style.border = "1px solid #999999";
	var tipsArea = document.getElementById("tipsArea");
	tipsArea.innerHTML = "&nbsp;";
}

function focusOn(obj) {
	obj.select();
	obj.focus();
}

</script>
</head>
<body bgcolor="#ffffff" style="margin:0px; text-align: center; overflow: hidden;">
			
<form:form modelAttribute="loginCommand">

<div align="center" id="container">
<table cellpadding="0" cellspacing="0" border="0" id="header">
	<tr>
		<td style="width:304px;"><img src="${base}/resource/common/images/login/logo.gif" />
		</td>
		
		<td style="text-align:right; color:white; padding-right:20px;width:15%">
			　</td>
	</tr>
</table>

<table id="content" cellpadding="0" cellspacing="0">
	<tr>
		<td id="content_text">
			<table cellpadding="0" cellspacing="0" style="width:100%; height:100%">
				<tr style="height: 80px;">
					<td colspan="2">　</td>
				</tr>

				<tr>
					<td colspan="2">
						<ul>
							<li>操作人性化，简单易用</li>
							<li>专门针对供电所，专业实用</li>
							<li>日常整理资料，以不变应万变</li>
							<li>软件就是服务，让我们做得更好！</li>
						</ul>
					</td>
				</tr>
			</table>
		</td>
		<td id="content_login">
			<table cellpadding="0" cellspacing="0" style="height:100%;width:100%;">
				<tr style="height: 56px;">
					<td style="font-size: 14px; color:#1268a5;padding-left:80px;"><b>
					用户登录</b></td>
				</tr>
				<tr>
					<td>
						<table id="login_table"  style="width: 100%;" cellpadding="0" cellspacing="0">
							
							<tr class="login-tr">
								<td  class="login-label">帐号:</td><td>
								<form:input path="username" cssClass="login-input" cssStyle="width:136px;" onfocus="showTips(this)" onblur="disableTips(this)"/>
								 </td>
							</tr>
							<tr class="login-tr">
								<td  class="login-label">密码:</td><td>
								<form:password path="password"  cssClass="login-input" cssStyle="width:136px;" onfocus="showTips(this)" onblur="disableTips(this)" />
</td>
							</tr>
							
							<tr class="login-tr">
								<td>　</td><td style="color:#729db3;"><form:checkbox path="rememberMe"/> 记住我</td>
							</tr>
							<tr class="login-tr">
								<td colspan="2"><div style="padding-left:40px;" id="tipsArea">
									　</div>
									
					
									
									</td>
							</tr>
							<tr style="vertical-align: top;">
								<td colspan="2" style="text-align: center;">
									<input type="submit" alt="登录" value="登录" class="btn_login" />
									<input type="button" alt="重置" onclick="reset();" value="重置" class="btn_login" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<div>
	
</div>
<table id="footer">
	<tr>
		<td>
			<p id="copyright"> &copy; 2009-2010. 杭州新正软件技术有限公司 版权所有.</p>
		</td>
	</tr>
</table>
</div>
</form:form>
</body>
</html>

