<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
	<title>部门管理</title>
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

</script>
<div id="docpane" class="rightPane" style=" width: 100%; height: 463px;" >
<!-- Sub Title -->
<div id="subTitleBar">
	<div class="subTitle" style="float: left;">
	 <h1>
	 	<c:if test="${empty dept.deptId}"> 新增部门 </c:if>
	 	<c:if test="${not empty dept.deptId}"> 修改部门  [${dept.deptName}] </c:if> 
	 </h1>
	</div>
	<div class="clear"> </div>
</div>

<div class="borderlineTop">
  <div class="dcTbContainer">
    <form:form id="form" modelAttribute="dept" action="save" method="post">
      <input name="deptId" value="${dept.deptId}" type="hidden">
      <input name="hasChild" value="${dept.hasChild}" type="hidden">
      <table class="aloneTb" style="width: 97%"  cellspacing="0" >
        <tbody><tr>
          <th>部门名称</th>
          <td>
			 <input name="deptName" maxlength="50" value="${dept.deptName}" class="input_text mid" type="text"> 
          </td>
        </tr>
        <tr>
          <th>上级部门</th>
          <td>
            <select id="pid" name="pid"  style="height:22px; padding: 0pt;" class="input_text mid">
            	<option value="${empty pdept.deptId ? 0 :pdept.deptId}" selected>${empty pdept.deptId ? "根目录" : pdept.deptName}</option>
            </select>
            <a href="#" onclick="selectDept();return false;">更改</a>
          </td>
        </tr>
        
        <tr class="last">
          <th>&nbsp;</th>
          <td>
            <div style="padding-top: 6px;" class="bobox btnL">
	            <input class="button" type="submit" value=" 提 交 "/>
		        <input class="button" type="button" value=" 返 回 列 表 " onclick="location.href='list'"/>
		        
		        <c:if test="${not empty dept.deptId}"> 
		        <input class="button" type="button" value=" 新建部门 " onclick="location.href='${base}/system/department/add?pid=${dept.deptId}'"/>
		        <shiro:hasPermission name="user:all">
		        <input class="button" type="button" value=" 查看部门成员 " onclick="location.href='${base}/system/user/list?deptId=${dept.deptId}'"/>
		        </shiro:hasPermission>
		        </c:if> 
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
		var pdept = document.getElementById("pid")[0];
		pdept.value=selectdept[0];
		pdept.text=selectdept[1];
	}
}
</script>
</body>
</html>