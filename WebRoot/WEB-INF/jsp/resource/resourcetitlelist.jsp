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
<style>
.visitedtitle {
	color: #b77c8a;
}
</style>
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
<tr><td style="padding: 8px"  align="left" > <a href="javascript:resourceinfolist('${list.id}');"   style="color: #56af8f;margin-left: 10px;" title="点击查看资料"><span id="title${list.id}"><c:out value="${list.titleName} " escapeXml="true"/></span></a><span style="color: fuchsia;margin-left: 5px">(${list.resourceCount})</span></td>	</tr>
</c:forEach>
				</tbody>
			  </table>
			</div>
		</div>
	</div>
</div>
<script>



function resourceinfolist(titleId){
    var currentpos = document.documentElement.scrollTop;
	window.location.href = "${base}/resource/resourceinfolist?titleId="+titleId+"&pid=0&pos="+currentpos;
}

var back_pos = '${param.pos}';
var back_titleId = '${param.titleId}'
$(function(){
	window.scrollTo(0,back_pos);
	$("#title"+back_titleId).addClass("visitedtitle");
})

</script>
</body>
</html>
