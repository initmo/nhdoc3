<%@ page language="java" contentType="text/html;charset=GBK" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"> 
	<HEAD>
		<TITLE>资料管理平台</TITLE>	
		<META content="text/html; charset=GBK" http-equiv=content-type/>
		<META content=no-cache http-equiv=CacheControl/>
		<META content=no-cache http-equiv=Pragma/>
		<META content=-1 http-equiv=Expires/>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		<!-- for dhtmlxLayout -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.css"></link>
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/skins/dhtmlxlayout_dhx_skyblue.css"></link>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcommon.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.js"></script>

		<!-- for dhtmlxtree -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxTree/dhtmlxtree.css"></link>
		<script src="${base}/resource/dhx/dhtmlxTree/dhtmlxtree.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcontainer.js"></script>
		
		<!-- for dhtmlxToolbar -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxToolbar/skins/dhtmlxtoolbar_dhx_skyblue.css"></link>
		<script src="${base}/resource/dhx/dhtmlxToolbar/dhtmlxtoolbar.js"></script>
		<script src="${base}/resource/dhx/dhtmlxTree/ext/dhtmlxtree_json.js"></script>

		
		<!-- for dhtmlxWindows -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxwindows/dhtmlxwindows.css"></link>
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxwindows/skins/dhtmlxwindows_dhx_skyblue.css"></link>
		<script src="${base}/resource/dhx/dhtmlxwindows/dhtmlxwindows.js"></script>
		 
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		
		<!-- css for dhtmlxCombo -->
		<link rel="STYLESHEET" type="text/css" href="${base}/resource/dhx/dhtmlxCombo/dhtmlxcombo.css"></link>
		<script  src="${base}/resource/dhx/dhtmlxCombo/dhtmlxcommon.js"></script>
		<script  src="${base}/resource/dhx/dhtmlxCombo/dhtmlxcombo.js"></script>
		<script  src="${base}/resource/dhx/dhtmlxCombo/ext/dhtmlxcombo_extra.js"></script>
		<script  src="${base}/resource/dhx/dhtmlxCombo/ext/dhtmlxcombo_whp.js"></script>
		
		<!-- css for dhtmlxAccordion -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxAccordion/skins/dhtmlxaccordion_dhx_skyblue.css"></link>
		<script src="${base}/resource/dhx/dhtmlxAccordion/dhtmlxaccordion.js"></script>
		
		
	</HEAD>
<BODY>
<%@ include file="../top.jsp"%>
			
<div id=optionGrp1 class="optionCate">
<div onclick="document.showCategoryDetail('_settings', this)" class="optionTitle2">系统设置</div>
<div id="_settings">
<ul class="opCate">
<li>
<a href="javascript:document.openUrl('${base}/system/user');">帐号管理</a>
</li>
<li>
<a href="javascript:document.openUrl('${base}/system/role/list');">角色管理</a>
</li>
<li>
<a href="javascript:document.openUrl('${base}/system/department');">机构管理</a>
</li>
</ul>
</div>
</div>
<script>
document.showCategoryDetail=function(id, title)
{
  var obj = document.getElementById(id);
  if(obj.style.display=="none")
  {
  	obj.style.display="";
	title.className = "optionTitle2";
	}
  else
  {
  	obj.style.display="none";
	title.className = "optionTitle";
	}
}


document.openUrl=function(url)
{
    dhxLayout.cells("b").attachURL(url);
  //  dhxLayout.cells("b").setText(dhxTree.getSelectedItemText());
}

var dhxLayout,dhxToolbar,dhxTree,dbxGrid,_nodeid;

//加载框架
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"2U");

    dhxLayout.cells("a").setWidth(250);
    var headimg = "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='${base}/resource/dhx/dhtmlxToolbar/icons/open.gif' />"
    dhxLayout.cells("a").setText(headimg+" 系统设置");

    dhxLayout.cells("a").attachObject("optionGrp1"); 
     dhxLayout.attachHeader("topmenu");
     dhxLayout.attachFooter("footer"); 
}

$(function(){doOnLoad();});
</script>
	</BODY>
</HTML>
