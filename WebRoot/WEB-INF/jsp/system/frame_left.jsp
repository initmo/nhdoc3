<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>system-left</title>
<link href="${base}/resource/admin/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="${base}/resource/common/css/theme.css" rel="stylesheet" type="text/css"/>
<script src="${base}/resource/common/js/jquery.js" type="text/javascript"></script>
<script src="${base}/resource/admin/js/admin.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	Cms.lmenu('lmenu');
});
</script>
</head>
<body class="lbody">
<ul id="lmenu">
<li class="lmenu-focus"><a href="${base}/system/user"  target="rightFrame">用户管理</a></li>
<li><a href="${base}/system/role/list" target="rightFrame">角色管理</a></li>
<li><a href="${base}/system/permission/list" target="rightFrame">菜单设置</a></li>
<li><a href="${base}/system/department" target="rightFrame">部门设置</a></li>
</ul>
</body>
</html>