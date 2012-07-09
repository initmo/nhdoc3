<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>用户管理</title>

		<!-- for dhtmlxLayout -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.css"/>
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/skins/dhtmlxlayout_dhx_skyblue.css"/>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcommon.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcontainer.js"></script>
		
		<!-- for dhtmlxToolbar -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxToolbar/skins/dhtmlxtoolbar_dhx_skyblue.css"/>
		<script src="${base}/resource/dhx/dhtmlxToolbar/dhtmlxtoolbar.js"></script>
		
		<!-- for dhtmlxGrid -->
	    <link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxGrid/dhtmlxgrid.css"/>
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxGrid/skins/dhtmlxgrid_dhx_skyblue.css"/>
		<script src="${base}/resource/dhx/dhtmlxGrid/dhtmlxgrid.js"></script>
		<script src="${base}/resource/dhx/dhtmlxGrid/dhtmlxgridcell.js"></script>
		<script src="${base}/resource/dhx/dhtmlxGrid/ext/dhtmlxgrid_srnd.js"></script>
		<script src="${base}/resource/dhx/dhtmlxGrid/excells/dhtmlxgrid_excell_link.js"></script>
		 
		<!-- for dhtmlxtabbar -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxTabbar/dhtmlxtabbar.css"/>
		<script src="${base}/resource/dhx/dhtmlxTabbar/dhtmlxtabbar.js"></script>
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="${base}/resource/common/js/jquery.XYTipsWindow.min.2.8.js"></script>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
	<style>
	html, body { width: 100%;height: 100%;margin: 0px;padding: 0px;overflow: hidden; }
	.link {COLOR: #333333; TEXT-DECORATION: none}
	.link:hover {COLOR: #FF9900; TEXT-DECORATION: underline}
	.gridhover {background-color: #f9f5d0;}
	</style>
	
	</head>
<body>		

<script>


var dhxLayout,dhxToolbar,dhxtabbar,areaTree,userGrid,statusBar,dhxWins,gridHelper;

var STATE_NORMAL = 1;
var STATE_SEARCH = 2;
var state =  STATE_NORMAL;
var ctx = '${base}' ;


//加载框架
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"1C");
     dhxtabbar = dhxLayout.cells("a").attachTabbar();    
    dhxtabbar.setImagePath("${base}/resource/dhx/dhtmlxTabbar/imgs/");
    dhxtabbar.addTab(1, "<img align=left  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/common/img/icons/user.png'/>用户列表 (${dept.deptName})", 180);
    dhxtabbar.setTabActive(1);

    statusBar = dhxLayout.cells("a").attachStatusBar();

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
   		 if (id=="new") {newUser("${dept.deptId}");}
    });
    dhxToolbar.attachEvent("onEnter",
    function(id,value){
  			if (id=="tb_name") {searchUser(value);state = STATE_SEARCH;}
     });	
}

function setState(s){
   state = s ; 
}

function attachUserList() {
	userGrid = dhxtabbar.cells(1).attachGrid();
	userGrid.setIconsPath("../images/files/");
	userGrid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";

	userGrid.setHeader("<a href='javascript:userGrid.checkAll(true);'>选择</a>,ID,登陆账号,用户名称,角色,机构名称,操作");
	userGrid.setInitWidths("40,50,100,100,*,100,200");
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
			statusBar.setText("${dept.deptName}   :  共  "+userGrid.getRowsNum()+"  个"); 
		}); 
	userGrid.attachEvent("onRowDblClicked", function(rId,cInd){editUser( userGrid.cells(rId, 1).getValue())});  

}

function loadUserList(deptId) {
	userGrid.clearAll();
	userGrid.load("${base}/system/user/userxml?deptId="+deptId);
}

function editUser(userId){
	window.location.href="edit?userId="+userId;
}

function setUserTitle(userId){
	//OpenWin("/setting/usertitles?userId="+userId);
	popWin("${base}/setting/usertitles?userId="+userId,720,420,'文档授权');
}

function OpenWin(url,width,height){
  if (width) _width = width ;else _width = 990 ;
  if (height) _height = height ; else _height = 560 ;
  var left = (screen.width  - _width)  / 2; 
  var top  = (screen.height - _height) / 2; 
  window.open(ctx+url,'','left='+left+',top='+top+',width='+_width+',height='+_height+',resizable=1,scrollbars=no,status=no,toolbar=no,menubar=no,location=no');
 }

function newUser(deptId) {
    window.location.href="add?deptId="+deptId;
}

function delUser(userId) {
    if(confirm("  确定删除该用户记录吗？"))
       window.location.href="delete?userId="+userId+"&deptId=${dept.deptId}";
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
    loadUserList("${dept.deptId}");
});

</script>
</BODY>
</HTML>
