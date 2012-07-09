<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
	<title>账号管理</title>
	<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
	<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
	<!--[if lt IE 7]>
	<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/fixie.css">
	<![endif]-->
	<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
</head>
<body>
<script type="text/javascript">
window.updateDepartmentSelection=function(deptId,deptName)
{
	var fm = document.getElementById("userAccountForm");
	fm.department[0].value=deptId;
	fm.department[0].text=deptName;
}
window.updateRoleSelections=function(selectedIds,selectedNames)
{
	var roles = document.getElementById("accountRoles");
	for(var i=0;i<selectedIds.length;i++)
	{
		if(!isRoleExist(selectedIds[i]))
		{
			var anOption = document.createElement("OPTION");
			roles.options.add(anOption);
			anOption.text = selectedNames[i];
			anOption.value = selectedIds[i];
		}
	}
}
function isRoleExist(roleId)
{
	var roles = document.getElementById("accountRoles").options;
	for(var i=0;i<roles.length;i++)
	{
		if(roles[i].value==roleId)
			return true;
	}
	return false;
}
document.removeRole=function()
{
	var roles = document.getElementById("accountRoles");
	var selectedIndex=roles.selectedIndex;
	if(selectedIndex>=0)
	{
		roles.remove(selectedIndex);
	}
	else
		alert( "<bean:message key='action.rm.noselect.alert'/>" );
}
document.doSubmit=function()
{
	var roles = document.getElementById("accountRoles");
	if(roles.options.length==0)
	{
    alert( "<bean:message key='action.rm.lastone.alert'/>" );
    return;
	}
	showProcessingDialog();
	var fm = document.getElementById("userAccountForm");
	var ops = roles.options;
	fm.selectedRoles.value=ops[0].value;
	for(var i=1;i<ops.length;i++)
	{
		fm.selectedRoles.value=fm.selectedRoles.value+","+ops[i].value;
	}
}
</script>
<div id="docpane" class="rightPane" style=" width: 100%; height: 463px;" >
<!-- Sub Title -->
<div id="subTitleBar">
	<div class="subTitle" style="float: left;">
	 <h1>
	 	<c:if test="${empty user.userId}"> 新增账号 </c:if>
	 	<c:if test="${not empty user.userId}"> 修改账号<c:out value="[ ${user.loginName} ] "/></c:if> 
	 </h1>
	</div>
	<div class="clear"> </div>
</div>

<div class="borderlineTop">
  <div class="dcTbContainer">
    <form:form id="form" modelAttribute="user" action="save" method="post">
      <input name="userId" value="${user.userId}" type="hidden">
      <input name="selectedRoles" value="" type="hidden">
      <table class="aloneTb" style="width: 97%"  cellspacing="0" >
        <tbody><tr>
          <th>账号</th>
          <td>
          <c:if test="${empty user.userId}"> <input name="loginName" maxlength="50" value="${user.loginName}" class="input_text mid" type="text"> </c:if>
	 	  <c:if test="${not empty user.userId}"> ${user.loginName} <input name="loginName" value="${user.loginName}" type="hidden"> </c:if> 
          </td>
        </tr>
        <tr>
          <th>姓名</th>
          <td><input name="userName" maxlength="50" value="${user.userName}" class="input_text mid" type="text"></td>
        </tr>
        <tr>
          <th>部门</th>
          <td>
            <select id="deptId" name="deptId"  style="height:22px; padding: 0pt;" class="input_text mid">
            	<option value="${user.deptId}" selected>${user.deptName}</option>
            </select>
            <a href="#" onclick="selectDept();return false;">更改</a>
          </td>
        </tr>
        <tr>
          <th valign="top">用户组</th>
          <td>
          <%--    
              <form:select  size="4" cssStyle="width: 244px; margin-top: 4px;"  path="roleList">
  				<form:options items="${userRoles}"/>            	
              </form:select>
          --%>
           <div style="width: 300px">
             <form:checkboxes cssStyle="white-space: nowrap;" onchange="checkrole(this);"  path="roleIds" items="${allRoles}"/>
           </div>
          <%--
            <div style="padding: 0pt 0pt 4px;">
              <a href="#" onclick="openInNew('/doccare/selectroles.do','SelectRole');return false;">添加用户组</a>
              <a href="#" onclick="document.removeRole();return false;" style="margin-left: 8px;">删除用户组</a>
            </div>
          --%></td>
        </tr>
        <%--<tr>
          <th>允许上传文件大小</th>
          <td style="font-weight: normal;"><input name="maxUploadSize" size="10" value="5000" style="width: 100px;" class="input_text" type="text"> KB</td>
        </tr>
        <tr>
          <th>个人文档空间大小</th>
          <td style="font-weight: normal;"><input name="personalSpaceSize" size="10" value="100000" style="width: 100px;" class="input_text" type="text"> KB</td>
        </tr>
        --%>
        <tr class="last">
          <th>&nbsp;</th>
          <td>
            <div style="padding-top: 6px;" class="bobox btnL">
	            <input class="button" type="submit" value=" 提 交 "/>
		        <input class="button" type="button" value=" 返 回 " onclick="history.back()"/>
            </div>
          </td>
        </tr>
      </tbody></table>
 </form:form>
  </div>
</div>
</div>
<script type="text/javascript">
function selectDept(){
	var selectdept = OpenMoldalWin('${base}/system/department/selectdept',300,400);
	if(selectdept.length > 1){
		var pdept = document.getElementById("deptId")[0];
		pdept.value=selectdept[0];
		pdept.text=selectdept[1];
	}
}

function checkrole(ck){
	
}
</script>
</body>
</html>