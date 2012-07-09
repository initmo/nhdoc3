<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
	<title>文档库</title>
	<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
	<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
	<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
</head>
<body>
<div id="docpane" class="rightPane" style=" width: 100%; height: 463px;" >
<!-- Sub Title -->
<div id="subTitleBar">
	<div class="subTitle" style="float: left;">
	<h1>
	 <img align="middle" style=" margin-right: 15px" src="${base}/resource/dhx/dhtmlxTree/imgs/csh_bluebooks/iconSafe.gif"/>
	 	<c:if test="${empty group.id}"> 新增文档库 </c:if>
	 	<c:if test="${not empty group.id}"> 修改文档库 </c:if> 
	 </h1>
	</div>
	<div class="clear"></div>
</div>

<div class="borderlineTop">
  <div class="dcTbContainer">
    <form:form id="form" modelAttribute="group" action="${base}/setting/groupsave" method="post">
      <input name="id" value="${group.id}" type="hidden">
      <input name="createDeptid" value="${group.createDeptid}" type="hidden">
      <table class="aloneTb" style="width: 97%"  cellspacing="0" >
        <tbody>
        <tr>
          <th>文档库名称</th>
          <td><input style="height: 23px" name="grpName" maxlength="50" value="${group.grpName}" class="input_text mid" type="text">
              <form:errors path="*" element="div" cssClass="errors"/>
          </td>
        </tr>
        <tr>
          <th>描述</th>
           <td><textarea name="grpDesc" style="width:360px;height:60px;" class="input_text">${group.grpDesc}</textarea></td>
        </tr>
         
         <tr>
          <th>授权机构</th>
           <td><form:checkboxes cssStyle="white-space: nowrap;"  path="departmentIds" items="${departments}"/></td>
        </tr>
        <tr>
        <tr class="last">
          <th>&nbsp;</th>
          <td>
            <div style="padding-top: 6px;" class="bobox btnL">
	            <input class="button" type="submit" value=" 提 交 "/>
		        <input class="button" type="button" value=" 返 回 " onclick="history.back()"/>
                <c:if  test="${not empty group.id}">
                <input class="button" type="button" value=" 增加子目录 " onclick="newTreeNode(${group.id})"/>
			    </c:if> 
            </div>
          </td>
        </tr>
      </tbody></table>
 </form:form>
  </div>
</div>
</div>

<script>
function newTreeNode(groupId){
	window.location.href="${base}/setting/treenew?groupId="+groupId+"&pid=0";
}

var reloadtree = '${reloadtree}';
var tree = window.parent.settingObj;
if(reloadtree=='true'){
	tree.refreshTree();
	setTimeout(function(){tree.selectItem(${group.id})},600);
}
</script>
</body>
</html>