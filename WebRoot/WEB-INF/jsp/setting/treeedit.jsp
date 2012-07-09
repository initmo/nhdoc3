<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
	<title>目录</title>
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
	 	<c:if test="${empty tree.id}"> 新增子目录 </c:if>
	 	<c:if test="${not empty tree.id}"> 修改子目录 </c:if> 
	 </h1>
	</div>
	<div class="clear"> </div>
</div>

<div class="borderlineTop">
  <div class="dcTbContainer">
    <form:form id="form" modelAttribute="group" action="${base}/setting/treesave" method="post">
      <input name="child" value="${tree.child}" type="hidden">
      <input name="pid" value="${tree.pid}" type="hidden">
      <input name="groupId" value="${tree.groupId}" type="hidden">
      <input name="id" value="${tree.id}" type="hidden">
      <table class="aloneTb" style="width: 97%"  cellspacing="0" >
        <tbody>
        <tr>
          <th>子目录名称</th>
          <td><input style="height: 23px" name="treeName" maxlength="50" value="${tree.treeName}" class="input_text mid" type="text">
              <form:errors path="*" element="div" cssClass="errors"/>
          </td>
        </tr>
     
        <tr class="last">
          <th>&nbsp;</th>
          <td>
            <div style="padding-top: 6px;" class="bobox btnL">
	            <input class="button" type="submit" value=" 保 存 "/>
		        <input class="button" type="button" value=" 返 回 " onclick="history.back()"/>
                <c:if test="${not empty tree.id}"> 
                 <input class="button" type="button" value=" 增加同级目录 " onclick="newTreeNode(${tree.groupId},${tree.pid})"/>
                 <input class="button" type="button" value=" 增加下级目录 " onclick="newTreeNode(${tree.groupId},${tree.id})"/>
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

function newTreeNode(groupId,pid){
	window.location.href="${base}/setting/treenew?groupId="+groupId+"&pid="+pid;
}

var tree = window.parent.settingObj;

<c:if test="${not empty tree.id}"> 
  tree.refreshItem(${tree.pid});
  setTimeout(function(){tree.selectItem(${tree.id})},300);
</c:if> 
</script>
</body>
</html>