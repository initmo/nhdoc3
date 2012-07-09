<%@ page language="java" contentType="text/html;charset=GBK" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>文档设置</title>	
		<meta content="text/html; charset=GBK" http-equiv=content-type/>
		<meta content=no-cache http-equiv=CacheControl/>
		<meta content=no-cache http-equiv=Pragma/>
		<meta content=-1 http-equiv=Expires/>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
		<link rel=stylesheet type=text/css href="${base}/resource/dhx/dhtmlx.css"></link>
		<script type="text/javascript" src="${base}/resource/dhx/dhtmlx.js"></script>
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		<script src="${base}/resource/bizjs/resourceinfo.js"></script>
	</head>
	<body>
<%@ include file="../top.jsp"%>	
<div id="bg" style="width: 100%; height: 100%;display: none;"><img src="${base}/resource/common/img/sgcc_bg.jpg"/></div>
<script>
var curDept = "[${sessionScope.sessionUser.deptName}]";
var curDeptId = "${sessionScope.sessionUser.deptId}";
$(function(){
	var resourceInfo = new ResourceInfo('${base}');
	resourceInfo.afterTreeLoaded=function(){resourceInfo.selectTreeNode(1)};
	resourceInfo.init();
});
</script>
	</body>
</html>