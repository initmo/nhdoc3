<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
	<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
	<!--[if lt IE 7]>
	<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/fixie.css">
	<![endif]-->
	<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
</head>
<body>
<div class="dlgBody" style="display: block; ">
<div class="dia_main">
<form:form  modelAttribute="changePassword"  action="${base}/changepassword">
<table border="0" class="pwdtb" style="width: 350px; ">
<tbody>
<tr>
<th>新密码:</th>
<td>
<form:password path="password1" cssClass="input_text mid" cssStyle="width: 150;" />							
</td>
</tr >
<tr>
<th>确认密码:</th>
<td>
<form:password path="password2" cssClass="input_text mid" cssStyle="width: 150;" />
</td>
</tr>
<tr>
<th></th>
<td><form:errors cssStyle="color: red;" path="*" /></td>
</tr>
</tbody>
</table>
<div class="dia_action">
<div style="padding-top: 6px;" class="bobox btnL">
    <input type="submit" style="width: 80px;height: 28px" value=" 确 定 " />
    <input  type="button" style="width: 80px;height: 28px"  value=" 取 消 " onclick="top.closeChangepasswordWin();"/>
</div>
</div>
</form:form >
</div>
</div>
</body>
</html>