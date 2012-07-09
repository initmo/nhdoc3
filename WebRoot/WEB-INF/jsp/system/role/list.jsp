<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<HEAD>
		<TITLE>角色管理</TITLE>
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
	.link {COLOR: #333333; TEXT-DECORATION: none}
	.link:hover {COLOR: #FF9900; TEXT-DECORATION: underline}
	.gridhover {background-color: #f9f5d0;}
	</style>
	
	</HEAD>
<BODY>		

<script><!--


var dhxLayout,dhxToolbar,dhxtabbar,listGrid,statusBar,dhxWins,gridHelper;

var STATE_NORMAL = 1;
var STATE_SEARCH = 2;
var state =  STATE_NORMAL;
var ctx = '${base}' ;


//加载框架 
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"1C");
    dhxLayout.cells("a").hideHeader();
    
    statusBar = dhxLayout.cells("a").attachStatusBar();
    attachList();
    
    dhxToolbar = dhxLayout.cells("a").attachToolbar();
    dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
    dhxToolbar.addButton   ("new",1,"新增角色", "new.gif");
    dhxToolbar.addSeparator("s1",2);
    dhxToolbar.addText("tb_text", 45, "搜索:");
	dhxToolbar.addInput("tb_name",46,"",100); 
	dhxToolbar.addText("txt47", 47, "(回车确认)");
	dhxToolbar.addSeparator("s2",49);
    dhxToolbar.attachEvent ("onClick",function(id){
   		 if (id=="new") {add();}
    });
    dhxToolbar.attachEvent("onEnter",
    function(id,value){
  			if (id=="tb_name") {searchUser(value);state = STATE_SEARCH;}
     });	
   
}
function setState(s){
   state = s ; 
}

function attachList() {
	listGrid = dhxLayout.cells("a").attachGrid();
	listGrid.setIconsPath("../images/files/");
	listGrid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";
	listGrid.setHeader("<a class=link href='javascript:listGrid.checkAll(true);'>选择</a>,ID,角色名称,操作");
	listGrid.setInitWidths("40,50,*,100");
	listGrid.setColAlign("center,center,left,center");
	listGrid.setColTypes("ch,ro,ro,link");
	listGrid.setColSorting(",int,str,str");
	listGrid.init();
	listGrid.enableRowsHover(true,"gridhover");
	listGrid.attachEvent("onXLS", function(grid_obj){}); 
	listGrid.attachEvent("onXLE", function(grid_obj){  
		if (state == STATE_SEARCH)	
			statusBar.setText("搜索: ["+dhxToolbar.getValue('tb_name') +"]  结果共  "+listGrid.getRowsNum()+"  个")
		else
			statusBar.setText(" 共  "+listGrid.getRowsNum()+"  个"); 
		}); 
	listGrid.attachEvent("onRowDblClicked", function(rId,cInd){edit(listGrid.cells(rId, 1).getValue())});  

}

/**列表**/
function loadList(areaId) {
	listGrid.clearAll();
	listGrid.load("listxml");
}

/**修改**/
function edit(id){
 	window.location.href="edit?roleId="+id;
}

/**新增**/
function add() {
	window.location.href="add";
}

/**删除**/
function del(id) {
if(confirm(" 确认删除该角色吗？     ")){
	window.location.href="delete?roleId="+id;
/*
	$.ajax({
	   url: ctx+"/manage/ManageAction.17?method=delUser",
	   type: "POST",
	   data: {"roleId":id},
	   success: function(data){if(data=='SUCC') refrash();}
	 }); 
*/
 }
}

/**搜索**/
function search(value) {
    var v = encodeURI(encodeURI(value));
	listGrid.clearAll();
	listGrid.load("${base}/system/role/search/getManageListBySearchValue&value="+v);	
}

function refrash(){
 if (state==STATE_SEARCH)
 	search(dhxToolbar.getValue("tb_name"))
 else
	loadList();							 
 return true;
}

$(function(){
    doOnLoad();
    loadList();
});

--></script>
</BODY>
</HTML>
