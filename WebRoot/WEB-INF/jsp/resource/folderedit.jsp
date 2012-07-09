<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="CacheControl" content="no-cache">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<title>文档审核</title>
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		<!--[if lt IE 7]>
		<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/fixie.css">
		<![endif]-->
	</head>
	<body scroll="no">
	<div class="miniTitle">
 	  <c:if test="${empty folder.id}"> 新增文件夹 </c:if>
	  <c:if test="${not empty folder.id}"> 修改文件夹[<c:out value="${folder.filealiasname}"/>] </c:if> 
	</div>
		<div class="sPane">
			<div style="height: 4px"></div>
			<div class="dcTbContainer bgSpecial upWrap"
				style="margin: 0px 4px 4px 4px">
	    <form:form id="form" modelAttribute="folder" action="${base}/resource/foldersave" method="post">
      <input name="id" value="${folder.id}" type="hidden">
      <input name=titleid value="${folder.titleid}" type="hidden">
      <input name=pid value="${folder.pid}" type="hidden">
      <table class="aloneTb" cellspacing="0" width="100%">
        <tbody>
        <tr>
          <th>名称</th>
          <td><input style="height: 23px" name="filealiasname" maxlength="50" value="<c:out value="${folder.filealiasname}"/>" class="input_text mid" type="text">
              <form:errors path="*" element="div" cssClass="errors"/>
          </td>
        </tr>
        <tr>
          <th>描述</th>
           <td><textarea name="remark" style="width:360px;height:60px;" class="input_text">${folder.remark}</textarea></td>
        </tr>
      </tbody>
      </table>
      <div class="actionbar_b " style="margin-top: 10px;">
						<input class=button style="height: 25px;float: left;width: 80px"
							type="submit" value="完 成 " />
						<input class=button style="height: 25px;float: left;width: 80px"
							type="button" onclick="history.back()" value="返 回 " />
	 </div>
 </form:form>
 </div>
		</div>
	</body>
</html>
