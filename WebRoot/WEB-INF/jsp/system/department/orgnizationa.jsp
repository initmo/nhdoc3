<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<HEAD>
		<title>部门管理</title>
		<meta content="text/html; charset=UTF-8" http-equiv=content-type></meta>
		<meta content=no-cache http-equiv=CacheControl></meta>
		<meta content=no-cache http-equiv=Pragma></meta>
		<meta content=-1 http-equiv=Expires></meta>

		<!-- for dhtmlxLayout -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.css"/>
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/skins/dhtmlxlayout_dhx_skyblue.css"/>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcommon.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcontainer.js"></script>
		
		<!-- for dhtmlxToolbar -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxToolbar/skins/dhtmlxtoolbar_dhx_skyblue.css"/>
		<script src="${base}/resource/dhx/dhtmlxToolbar/dhtmlxtoolbar.js"></script>
		
		<!-- for dhtmlxtree -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxTree/dhtmlxtree.css"/>
		<script src="${base}/resource/dhx/dhtmlxTree/dhtmlxtree.js"></script>

		
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxTabbar/dhtmlxtabbar.css"/>
		<script src="${base}/resource/dhx/dhtmlxTabbar/dhtmlxtabbar.js"></script>
		
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		
		<script type="text/javascript" src="${base}/resource/common/js/jquery.XYTipsWindow.min.2.8.js"></script>

	<style>
	html, body { width: 100%;height: 100%;margin: 0px;padding: 0px;overflow: hidden; }
	</style>
	
	</HEAD>
<BODY>		
<%@ include file="../../top.jsp"%>	
<script>

var main,tabbar,dhxLayout,dhxToolbar,dhxtabbar,areaTree,userGrid,statusBar,dhxWins,gridHelper;
var ctx = '${base}' ;

//加载框架
function doOnLoad() {
    main = new dhtmlXLayoutObject(document.body,"1C");

    tabbar = main.cells("a").attachTabbar();   
    tabbar.setSkin('dhx_skyblue');
    tabbar.setImagePath("${base}/resource/dhx/dhtmlxTabbar/imgs/");
    tabbar.addTab(1, "<img align=center  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/common/img/icons/chart_organisation.png'/>部门和用户", 100);
    tabbar.setTabActive(1);

    dhxLayout =  tabbar.cells(1).attachLayout("2U");
    dhxLayout.cells("a").setWidth(220);
    dhxLayout.cells("a").setText("<img align=center  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/common/img/icons/house.png'/>组织机构");
    dhxLayout.cells("b").hideHeader();
    attachAreaTree();
    dhxToolbar =this.dhxLayout.cells("a").attachToolbar();
    dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
    <shiro:hasPermission name="department:new">
    dhxToolbar.addButton   ("newdept",0,"新增机构", "org_add.png");
    </shiro:hasPermission>
    <shiro:hasPermission name="department:edit">
    dhxToolbar.addButton   ("editdept",2,"修改", "org_edit.png");
    </shiro:hasPermission>
    <shiro:hasPermission name="department:delete">
    dhxToolbar.addButton   ("deldept",3,"删除", "org_del.png");
    </shiro:hasPermission>
  
    dhxToolbar.attachEvent ("onClick",function(id){toolbarClick(id);	    	
    });
	    
    main.attachHeader("topmenu");
    main.attachFooter("footer"); 
    
    <shiro:hasPermission name="role:all">
    tabbar.addTab(2, "<img align=center  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/common/img/icons/group_key.png'/>用户组", 80);
    tabbar.setHrefMode("iframes");
	tabbar.setContentHref(2,"${base}/system/role/list");
    </shiro:hasPermission>
    
}

function attachAreaTree() {
    areaTree = dhxLayout.cells("a").attachTree();
	areaTree.setImagePath("${base}/resource/dhx/dhtmlxTree/imgs/csh_dhx_skyblue/");  
	areaTree.setXMLAutoLoading("${base}/system/department/treexml");
	areaTree.loadXML("${base}/system/department/treexml?id=0");
	areaTree.setOnClickHandler(edit);
}

function loadAllDeptList(){
	dhxLayout.cells("b").attachURL("${base}/system/department/list");
};	

function edit(deptId){
	dhxLayout.cells("b").attachURL("${base}/system/department/edit?deptId="+deptId);
}
function del(deptId) {
	if(confirm(" 确认删除该机构吗？     ")){
	dhxLayout.cells("b").attachURL("${base}/system/department/delete?deptId="+deptId);
	}
}
function add(pid){
	dhxLayout.cells("b").attachURL("${base}/system/department/add?pid="+pid);
}		
function toolbarClick(id){
	var selectedDeptId = areaTree.getSelectedItemId();
	if(id=="newdept") { add(selectedDeptId) };
   	if(id=="deldept") { del(selectedDeptId) };
   	if(id=="editdept"){ edit(selectedDeptId)};
}

$(function(){
    doOnLoad();
    loadAllDeptList();
});

</script>
</BODY>
</HTML>
