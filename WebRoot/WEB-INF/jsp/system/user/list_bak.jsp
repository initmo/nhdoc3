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
	.button {
		height: 20px;
		background: #F7FCFD;
		border-top: 1px #4EA4B7 solid;
		border-right: 1px #016F87 solid;
		border-bottom: 1px #016F87 solid;
		border-left: 1px #4EA4B7 solid;
		padding: 2px 5px;
		filter:progid:DXImageTransform.Microsoft.gradient(enabled='enabled',startColorstr=#ffffff, endColorstr=#cde0ef);
		margin: 3px 0;
		font-size:9pt;
	}
	.link {COLOR: #333333; TEXT-DECORATION: none}
	.link:hover {COLOR: #FF9900; TEXT-DECORATION: underline}
	.gridhover {background-color: #f9f5d0;}
	</style>
	
	</HEAD>
<BODY>		

<script>


var dhxLayout,dhxToolbar,dhxtabbar,areaTree,userGrid,statusBar,dhxWins,gridHelper;

var STATE_NORMAL = 1;
var STATE_SEARCH = 2;
var state =  STATE_NORMAL;
var ctx = '${base}' ;


//加载框架
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"2U");
    dhxLayout.cells("a").setWidth(180);
    dhxLayout.cells("a").setText("<img align=center  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/common/img/icons/chart_organisation.png'/>组织机构");
  
    attachAreaTree();
    
    dhxtabbar = dhxLayout.cells("b").attachTabbar();    
    dhxtabbar.setImagePath("${base}/resource/dhx/dhtmlxTabbar/imgs/");
    dhxtabbar.addTab(1, "<img align=center  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/common/img/icons/user.png'/>用户列表", 100);
    dhxtabbar.setTabActive(1);
    
    statusBar = dhxLayout.cells("b").attachStatusBar();
    attachUserList();
    
    dhxToolbar = dhxtabbar.cells(1).attachToolbar();
    dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
    dhxToolbar.addButton   ("new",1,"新增用户", "new.gif");
    dhxToolbar.addSeparator("s1",2);
    dhxToolbar.addText("tb_text", 45, "搜索账号或姓名:");
	dhxToolbar.addInput("tb_name",46,"",100); 
	dhxToolbar.addText("txt47", 47, "(回车确认)");
	dhxToolbar.addSeparator("s2",49);
    dhxToolbar.attachEvent ("onClick",function(id){
   		 if (id=="new") {newUser(areaTree.getSelectedItemId());}
    });
    dhxToolbar.attachEvent("onEnter",
    function(id,value){
  			if (id=="tb_name") {searchUser(value);state = STATE_SEARCH;}
     });	
   
}
function attachAreaTree() {
    areaTree = dhxLayout.cells("a").attachTree();
	areaTree.setImagePath("${base}/resource/dhx/dhtmlxTree/imgs/csh_dhx_skyblue/");  
	areaTree.setXMLAutoLoading("${base}/system/department/deptxml");
	areaTree.loadXML("${base}/system/department/deptxml?id=0");
	areaTree.setOnClickHandler(toncheck);
}

function toncheck(id,state){  
    state =  setState(STATE_NORMAL);
    dhxToolbar.setValue('tb_name', '');
    loadUserList(id); 
};	

function setState(s){
   state = s ; 
}

function attachUserList() {
	userGrid = dhxtabbar.cells(1).attachGrid();
	userGrid.setIconsPath("../images/files/");
	userGrid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";

	userGrid.setHeader("<a href='javascript:userGrid.checkAll(true);'>选择</a>,ID,登陆账号,用户名称,角色,机构名称,操作");
	userGrid.setInitWidths("40,50,100,100,*,100,100");
	userGrid.setColAlign("center,center,center,center,left,center,center");
	userGrid.setColTypes("ch,ro,ro,ro,ro,ro,link");
	userGrid.setColSorting(",str,str,str,str,str,str");
	userGrid.init();
	userGrid.enableRowsHover(true,"gridhover");
	userGrid.attachEvent("onXLS", function(grid_obj){}); 
	userGrid.attachEvent("onXLE", function(grid_obj){  
		if (state == STATE_SEARCH)	
			statusBar.setText("搜索: ["+dhxToolbar.getValue('tb_name') +"]  结果共  "+userGrid.getRowsNum()+"  个")
		else
			statusBar.setText(areaTree.getSelectedItemText() +"  :  共  "+userGrid.getRowsNum()+"  个"); 
		}); 
	userGrid.attachEvent("onRowDblClicked", function(rId,cInd){editUser( userGrid.cells(rId, 0).getValue())});  

}

function loadUserList(areaId) {
	userGrid.clearAll();
	userGrid.load("${base}/system/user/userxml?deptId="+areaId);
}

function editUser(manageId){
	var url = "/manage/AdminUserQuery.jsp?manageId="+manageId;
	OpenWin(url,450,400);
}

function OpenWin(url,width,height){
  if (width) _width = width ;else _width = 990 ;
  if (height) _height = height ; else _height = 560 ;
  var left = (screen.width  - _width)  / 2; 
  var top  = (screen.height - _height) / 2; 
  window.open(ctx+url,'','left='+left+',top='+top+',width='+_width+',height='+_height+',resizable=1,scrollbars=no,status=no,toolbar=no,menubar=no,location=no');
 }

function  editUserCzbm(){
	OpenWin('/dhtmlxTree/samples/checkboxes/AreaCbTree.jsp',210,600);
}

function newUser(areaId) {
alert(userGrid.getCheckedRows(0));
}
function delUser(manageId) {
if(confirm(" 确认删除该用户吗？     ")){
	$.ajax({
	   url: ctx+"/manage/ManageAction.17?method=delUser",
	   type: "POST",
	   data: {"manageId":manageId},
	   success: function(data){if(data=='SUCC') refrash();}
	 }); 
 }
}

function searchUser(value) {
    var v = encodeURI(encodeURI(value));
	userGrid.clearAll();
	userGrid.load(ctx+"/manage/ManageAction.17?method=getManageListBySearchValue&value="+v);	
}

function refrash(){
 if (state==STATE_SEARCH)
 	searchUser(dhxToolbar.getValue("tb_name"))
 else
	loadUserList(areaTree.getSelectedItemId());							 
 return true;
}


$(function(){
    doOnLoad();
});

</script>
</BODY>
</HTML>
