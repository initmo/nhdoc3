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
<tr style="height: 20px">
    <td style="padding-left: 16px;  align="left" > <strong>文档标题</strong></td>	
    <td style="padding-left: 8px"  align="left" > <strong>更新授权</strong></td>	
    <td style="padding-left: 8px"  align="left" > <strong>审核授权</strong></td>	
</tr>
<c:forEach items="${list}" var="list" varStatus="i">

<c:if test="${list.arrowedAct}">
<c:set var="actclassname" value="ico icoAllowed"></c:set>
<c:set var="acttitle" value="授权更新,点击取消授权"></c:set>
</c:if>
<c:if test="${not list.arrowedAct}">
<c:set var="actclassname" value="ico icoForbiden"></c:set>
<c:set var="acttitle" value="未授权,点击授权更新"></c:set>
</c:if>
<c:if test="${list.arrowedApproval}">
<c:set var="approvalclassname" value="ico icoAllowed"></c:set>
<c:set var="approvaltitle" value="授权审核,点击取消授权"></c:set>
</c:if>
<c:if test="${not list.arrowedApproval}">
<c:set var="approvalclassname" value="ico icoForbiden"></c:set>
<c:set var="approvaltitle" value="未授权,点击授权审核"></c:set>
</c:if>
	<tr >		
		<td style="padding: 8px" height="" width="*" align="left" > <a href="javascript:void(0);"   style="color: #56af8f;margin-left: 10px" title="修改标题属性"><c:out value="${list.resourceTitle.titleName}" escapeXml="true"/></a></td>	
		<td width="60px" class="center">
			<a id="act_"+${list.resourceTitle.id} href="javascript:void(0);"  onclick="setAct(this,${list.resourceTitle.id});" class="${actclassname}" title="${acttitle}"/>
		</td>		
	    <td width="60px" class="center">
	   		<a id="apr_"+${list.resourceTitle.id} href="javascript:void(0);" onclick="setApproval(this,${list.resourceTitle.id});" class="${approvalclassname}" title="${approvaltitle}"/>
	    </td>
	</tr>
</c:forEach>
				</tbody>
			  </table>
			</div>
		</div>
	</div>
</div>
</body>
<script>

var  userId = parent.userId ;
function setAct(o,titleId){
	var oldClassName = o.className;
	var allowed = (oldClassName == "ico icoAllowed");
	var actionUrl,nextClassName;
	o.className = "ico icoRefresh";
	if(allowed){
		actionUrl = "${base}/setting/usertitles/setact?set=off&titleid="+titleId+"&userid="+userId;
		nextClassName ="ico icoForbiden";
	}else{
		actionUrl = "${base}/setting/usertitles/setact?set=on&titleid="+titleId+"&userid="+userId;
		nextClassName="ico icoAllowed";
	}
	if (ajaxRequest(actionUrl,{})){	
		o.className = nextClassName;
	}else{
		o.className = oldClassName;
	}
}
function setApproval(o,titleId){
	var oldClassName = o.className;
	var allowed = (oldClassName == "ico icoAllowed");
	var actionUrl,nextClassName;
	o.className = "ico icoRefresh";
	if(allowed){
		actionUrl = "${base}/setting/usertitles/setapproval?set=off&titleid="+titleId+"&userid="+userId;
		nextClassName ="ico icoForbiden";
	}else{
		actionUrl = "${base}/setting/usertitles/setapproval?set=on&titleid="+titleId+"&userid="+userId;
		nextClassName="ico icoAllowed";
	}
	if (ajaxRequest(actionUrl,{})){	
		o.className = nextClassName;
	}else{
		o.className = oldClassName;
	}
}

function ajaxRequest(url,jsonParam){
	var result = true;
	$.ajax({
	   url: url,
	   async :false,
	   type: "POST",
	   data: jsonParam || {},
	   error: function(data){alert("删除失败");result = false;},
	   success: function(data){result = true;}
	 }); 
	 return result;
}

</script>
</html>
