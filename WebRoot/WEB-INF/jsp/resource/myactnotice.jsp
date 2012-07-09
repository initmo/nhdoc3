<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
   <div class="miniTitle">待更新文档</div>
     <div  style="overflow:auto;">     
		<div class="sPane" style="border-top:none">
			<div style="border-left:1px solid #dedede;border-bottom:1px solid #dedede;margin-bottom:4px;">
		    <table id="roleList" width="100%"  cellspacing="0"  class="dcTb" >
				<tbody>
				
<tr style="height: 20px">
    <td style="padding-left: 16px;width: 60%"  align="left" > <strong>文档标题</strong></td>	
    <td style="padding-left: 8px"  align="left" > <strong>最近更新日期</strong></td>	
    <td style="padding-left: 8px"  align="left" > <strong>下次更新日期</strong></td>	
</tr>
<c:if test="${fn:length(list)==0}">
<tr height="10px">
    <td colspan="3" style="background-color: #ffc" align="center">当前没有需要更新的文档。</td>	
  </tr>
</c:if>
<c:forEach items="${list}" var="list" varStatus="i">
<tr height="10px">
    <td style="padding-left: 8px;width: 60%"  align="left" > <a href="${base}/resource/resourceinfolist?titleId=${list.titleid}&pid=0"   style="color: #56af8f;margin-left: 10px" title="点击查看资料"><c:out value="${list.titlename}" escapeXml="true"/></a></td>	
    <td style="padding-left: 8px"> <fmt:formatDate value="${list.recentlyact}" type="both"/></td>	
    <td style="padding-left: 8px"> <fmt:formatDate value="${list.nextact}" type="date"/></td>	
</tr>
</c:forEach>
				</tbody>
			  </table>
			</div>
		</div>
	</div>
</div>
</body>
</html>
