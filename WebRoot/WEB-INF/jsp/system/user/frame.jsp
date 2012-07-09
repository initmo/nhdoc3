<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<HEAD>
		<TITLE>用户管理</TITLE>
		<META content="text/html; charset=GBK" http-equiv=content-type>
		<META content=no-cache http-equiv=CacheControl>
		<META content=no-cache http-equiv=Pragma>
		<META content=-1 http-equiv=Expires>

		<!-- for dhtmlxLayout -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.css">
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/skins/dhtmlxlayout_dhx_skyblue.css">
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcommon.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcontainer.js"></script>
		
		<!-- for dhtmlxToolbar -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxToolbar/skins/dhtmlxtoolbar_dhx_skyblue.css">
		<script src="${base}/resource/dhx/dhtmlxToolbar/dhtmlxtoolbar.js"></script>
		
		<!-- for dhtmlxGrid -->
	    <link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxGrid/dhtmlxgrid.css">
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxGrid/skins/dhtmlxgrid_dhx_skyblue.css">
		<script src="${base}/resource/dhx/dhtmlxGrid/dhtmlxgrid.js"></script>
		<script src="${base}/resource/dhx/dhtmlxGrid/dhtmlxgridcell.js"></script>
		<script src="${base}/resource/dhx/dhtmlxGrid/ext/dhtmlxgrid_srnd.js"></script>
		<script src="${base}/resource/dhx/dhtmlxGrid/excells/dhtmlxgrid_excell_link.js"></script>
		<!-- for dhtmlxtree -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxTree/dhtmlxtree.css">
		<script src="${base}/resource/dhx/dhtmlxTree/dhtmlxtree.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcontainer.js"></script>   
		<!-- for dhtmlxtabbar -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxTabbar/dhtmlxtabbar.css">
		<script src="${base}/resource/dhx/dhtmlxTabbar/dhtmlxtabbar.js"></script>
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		
	<style>
	html, body { width: 100%;height: 100%;margin: 0px;padding: 0px;overflow: hidden; }
	</style>
	
	</HEAD>
<BODY>		

<script>


var dhxLayout,dhxToolbar,dhxtabbar,areaTree,userGrid,statusBar,dhxWins,gridHelper;


var ctx = '${base}' ;


//加载框架
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"2U");
    dhxLayout.cells("a").setWidth(180);
    dhxLayout.cells("a").setText("<img align=center  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/common/img/icons/chart_organisation.png'/>组织机构");
    dhxLayout.cells("b").hideHeader();
    attachAreaTree();
    
}
function attachAreaTree() {
    areaTree = dhxLayout.cells("a").attachTree();
	areaTree.setImagePath("${base}/resource/dhx/dhtmlxTree/imgs/csh_dhx_skyblue/");  
	areaTree.setXMLAutoLoading("${base}/system/department/treexml");
	areaTree.loadXML("${base}/system/department/treexml?id=0");
	areaTree.setOnClickHandler(loadUserList);
}

function loadUserList(id){
	dhxLayout.cells("b").attachURL("${base}/system/user/list?deptId="+id);
};	



$(function(){
    doOnLoad();
    loadUserList("${sessionScope.sessionUser.deptId}");
});

</script>
</BODY>
</HTML>
