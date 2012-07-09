<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
	<title>角色管理</title>
	<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
	<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
	<!--[if lt IE 7]>
	<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/fixie.css">
	<![endif]-->
</head>
<body>
<div id="docpane" class="rightPane" style=" width: 100%; height: 463px;" >

<div id="subTitleBar" style="margin-bottom: 10px">
	 <h1>修改角色</h1>
</div>
 
<form:form id="form" modelAttribute="role" action="save" method="post">
  <input type="hidden" name="roleId" value="${role.roleId}"/>
  <div id="subNavbar2">
    <div class="subNavTabs">
      <span tabContent="tab1" class="selected" onclick="showTab(this)">角色属性</span>
      <span tabContent="tab2" onclick="showTab(this)">角色权限</span>
    </div>
  </div>
  <div class="dcTbContainer" style="border-top:none;background:#fff;">
    <div id="tab1" >
      <table class="aloneTb" style="width: 97%" cellspacing="0">
        <tr>
          <th>角色名称</th>
          <td><input style="height:22px;" type="text" name="roleName" class="input_text mid" id="roleName" value="${role.roleName}"/></td>
        </tr>
        <tr class="last">
          <th>角色描述</th>
          <td><textarea name="roleDesc" style="width:360px;height:60px;" class="input_text">${role.roleDesc}</textarea></td>
        </tr>
      </table>
    </div>
    <div id="tab2"  class="modifyPrivTab" style="display:none;margin-bottom: 10px;">
      <form:checkboxes cssStyle="white-space: nowrap;"  path="permissionIds" items="${permissions}"/>
    </div>
 
	<div class="actionbar_b btnL">
		<input class="button" type="submit" value=" 提 交 "/>
		<input class="button" type="button" value=" 返 回 " onclick="history.back()"/>
	</div>
  </div>
</form:form>
</div>
<script type="text/javascript">
function showTab(tab){
	var id = $(tab).attr("tabContent");
	var other = "tab2"
	if (id == "tab1") other = "tab2"
	else other = "tab1"
	$("#"+other).hide();
	$("#"+id).show();
	
	$(".selected").removeClass("selected");
	$(tab).addClass("selected");
}
</script>
</body>
</html>