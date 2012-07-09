<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<meta http-equiv="CacheControl" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">

<title>文档标题</title>
<link rel="stylesheet" type="text/css" href="${base}/resource/common/css/style.css">
<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
</head>
<body>
<div style="width:100%;height:100%;">
   <div class="miniTitle">文档标题列表</div>
     <div  style="overflow:auto;">     
		<div class="sPane" style="border-top:none">
			<div style="border-left:1px solid #dedede;border-bottom:1px solid #dedede;margin-bottom:4px;">
		    <table id="roleList" width="100%"  cellspacing="0"  class="dcTb" >
				<tbody>		
<c:forEach items="${list}" var="list" varStatus="i">
	<tr >		
		<td style="padding: 8px" height="" width="70%" align="left" > <a href="${base}/setting/titleedit?id=${list.id}"   style="color: #56af8f;margin-left: 10px" title="修改标题属性"><c:out value="${list.titleName}" escapeXml="true"/></a></td>	
		<td width="10%" class="center"></td>		
	    <td width="10%" class="center"><a href="${base}/setting/titleedit?id=${list.id}" >修改</a>|<a href="${base}/setting/titledelete?id=${list.id}" >删除</a></td>
	</tr>
</c:forEach>
 <tr><td colspan="3"><input onclick="titleNew();" class=button style="height: 28px" type="button" value=" 新增标题 "/></td></tr>
				</tbody>
			  </table>
			</div>
		</div>
	</div>
</div>
</body>
<script>
function titleNew(){
	window.location.href="${base}/setting/titlenew?treeId=${treeId}";
}
</script>
</html>
