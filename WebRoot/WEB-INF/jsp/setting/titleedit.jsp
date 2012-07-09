<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>文档设置</title>	
		<meta content="text/html; charset=UTF-8" http-equiv=content-type/>
		<meta content=no-cache http-equiv=CacheControl/>
		<meta content=no-cache http-equiv=Pragma/>
		<meta content=-1 http-equiv=Expires/>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
		<link rel=stylesheet type=text/css href="${base}/resource/dhx/dhtmlx.css"></link>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		<script type="text/javascript" src="${base}/resource/dhx/dhtmlx.js"></script>
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
	</head>
<BODY>		
<div id="docpane" class="rightPane" style="margin:auto; width: 98%; height: 463px;" >


<div class="borderlineTop">
  <div class="dcTbContainer">
    <form:form id="form" modelAttribute="title" action="${base}/setting/titleinfosave" method="post">
      <input name="treeId" value="${title.treeId}" type="hidden"/>
      <input name="id" value="${title.id}" type="hidden"/>
      <table class="aloneTb" style="width: 97%"  cellspacing="0" >
        <tbody>
        <tr>
          <th>标题名称</th>
          <td><form:input cssStyle="height: 23px" path="titleName" maxlength="50"  cssClass="input_text mid" />
          </td>
        </tr>
        <tr>  
          <th>更新周期</th>
          <td> <form:select cssClass="input_text mid" cssStyle="width: 100px;height: 25px;" path="noticeCycle" items="${cycletypes}"/>
          <form:input cssStyle="width: 30px;" path="actDay"  cssClass="input_text mid" />&nbsp;&nbsp;日前提醒
           </td>
        </tr>
        
        <tr>
			<th></th>
			<td>
	              <form:radiobutton   path="isEnable" label="启用" value="1" />
	              <form:radiobutton   path="isEnable" label="隐藏" value="0"/>
		 	</td>
		</tr>
     
        <tr class="last">
          <th>&nbsp;</th>
          <td>
            <div style="padding-top: 6px;" class="bobox btnL">
	            <input class="button" type="submit" value=" 保 存 "/>
		        <input class="button" type="button" value=" << 返 回 列 表" onclick="javascript:window.location.href='${base}/setting/titlelist?treeId=${title.treeId}';"/>
		        <input class="button" type="button" value=" 新增" onclick="javascript:window.location.href='${base}/setting/titlenew?treeId=${title.treeId}';"/>
            </div>
          </td>
        </tr>
      </tbody></table>
 </form:form>
  </div>
</div>
</div>


<script><!--


var dhxLayout,dhxToolbar,dhxtabbar,listGrid,statusBar,dhxWins,gridHelper;

//加载框架 
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"1C");
    dhxtabbar = dhxLayout.cells("a").attachTabbar();    
    dhxtabbar.setImagePath("${base}/resource/dhx/dhtmlxTabbar/imgs/");
    dhxtabbar.addTab("info", "<img align=center  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/common/img/icons/application_edit.png'/>标题信息", 100);
    dhxtabbar.addTab("actors", "授权设置", 100);
    dhxtabbar.addTab("checkers", "审核设置", 100);
    dhxtabbar.addTab("template", "模板设置", 100);
    dhxtabbar.setTabActive("info");
    dhxtabbar.setHrefMode("iframes");
	dhxtabbar.setContent("info","docpane");
	
	<c:if test="${not empty title.id}">
	dhxtabbar.setContentHref("actors","${base}/setting/titleactors?titleId=${title.id}");
	dhxtabbar.setContentHref("checkers","${base}/setting/titlecheckers?titleId=${title.id}");
	dhxtabbar.setContentHref("template","${base}/setting/template?titleId=${title.id}");
	</c:if>
}


$(function(){
    doOnLoad();
});

--></script>

</BODY>
</HTML>
