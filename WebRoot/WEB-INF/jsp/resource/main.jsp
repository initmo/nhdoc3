<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
	    <meta content="text/html; charset=UTF-8" http-equiv=content-type/>
		<title>资料管理平台</title>	
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		
		<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
		
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

		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		<!-- css for dhtmlxAccordion -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxAccordion/skins/dhtmlxaccordion_dhx_skyblue.css"></link>
		<script src="${base}/resource/dhx/dhtmlxAccordion/dhtmlxaccordion.js"></script>
		
		<script type="text/javascript" src="${base}/resource/common/js/jquery.XYTipsWindow.min.2.8.js"></script>
	<style>
	html, body { width: 100%;height: 100%;margin: 0px;padding: 0px;overflow: hidden; }
	</style>
	</head>
	<body>
<%@ include file="../top.jsp"%>	
<div id="bg" style="width: 100%; height: 100%;display: none;">
	<img src="${base}/resource/common/img/sgcc_bg.jpg"/>
</div>

<div id=mytaskmenu style="display: none">	
	<div id=optionGrp1 class="optionCate" >
	<div  class="optionTitle" onclick="document.openRight('${base}/resource/myactnotice')">更新提醒</div>
	</div>
	<div id=optionGrp2 class="optionCate" >
	<div  class="optionTitle" onclick="document.openRight('${base}/resource/myact?view=draft')">我的文档</div>
	</div>
	<%--
	<div id=optionGrp3 class="optionCate">
	<div onclick="document.showCategoryDetail('_settings', this)" class="optionTitle">当前文档</div>
	<div id="_settings" style="display: none">
	<ul class="opCate">
	<li style="background-color: #ffe3a8"><a href="javascript:document.openRight('${base}/resource/myact');"><img class="subContent"align=center  src ='${base}/resource/dhx/dhtmlxToolbar/icons/paste.gif' />草稿</a></li>
	<li><a href="javascript:document.openRight('${base}/resource/myact?view=sent');"><img class="subContent"align=center  src ='${base}/resource/dhx/dhtmlxToolbar/icons/page.gif' />待审核</a></li>
	<li><a href="javascript:document.openRight('${base}/resource/myact?view=pass');"><img class="subContent"align=center  src ='${base}/resource/dhx/dhtmlxToolbar/icons/search.gif' />审核通过</a></li>
	<li><a href="javascript:document.openRight('${base}/resource/myact?view=returned');"><img class="subContent"align=center  src ='${base}/resource/dhx/dhtmlxToolbar/icons/paste.gif' />退回</a></li>
	</ul>
	</div>
	</div>
	--%>
</div>

<div id=myapprovalmenu style="display: none">
<div id=optionGrp3 class="optionCate" >
	<div  class="optionTitle" onclick="document.openRight('${base}/resource/myapproval?view=sent')">需要审核的请求</div>
</div>
</div>


<script>
var dhxLayout,dhxToolbar,dhxAccord,dhxTree,dbxGrid,_nodeid,dhxToolbar2,grpToolbar ;
var curDept = "[${sessionScope.sessionUser.deptName}]";
var curDeptId = "${sessionScope.sessionUser.deptId}";

//切换区域
function selectDept(){
	var selectdept = OpenMoldalWin('${base}/system/department/selectdept',300,400);
	if(selectdept.length > 1){
		grpToolbar.setItemText("viewdepartment",selectdept[1]);
		changeViewDepartment(selectdept[0]);
		dhxLayout.cells("b").attachObject("bg");
	}
}

//加载框架
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"2U");

    dhxLayout.cells("a").setWidth(250);
    dhxLayout.cells("a").hideHeader();
    dhxLayout.cells("b").hideHeader();
    dhxLayout.cells("b").attachObject("bg");
      
    var icon_wait= "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='${base}/resource/dhx/dhtmlxToolbar/icons/paste.gif' />"
    var icon_now = "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='${base}/resource/dhx/dhtmlxToolbar/icons/page.gif' />"
    var icon_shr = "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='${base}/resource/dhx/dhtmlxToolbar/icons/share.gif' />"
    dhxAccord = dhxLayout.cells("a").attachAccordion();
    dhxAccord.addItem("a1", icon_wait+"文档资源");
   
   
    grpToolbar = dhxAccord.cells("a1").attachToolbar();
    grpToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
    grpToolbar.addText   ("txt_Cur",0,"当前:", "save.gif");
    grpToolbar.addText   ("viewdepartment",1,curDept, "save.gif");
    grpToolbar.addButton   ("selectDept",2,"切换", "share.gif");
    grpToolbar.addSeparator(3,null); 
    grpToolbar.addButton   ("search",4,"搜索", "search.gif");
    grpToolbar.attachEvent ("onClick",function(id){
      if(id=="selectDept"){selectDept();}
      if(id=="search"){search();}
    });

//装载目录树

	dhxTree = dhxAccord.cells("a1").attachTree();
    dhxTree.setImagePath("${base}/resource/dhx/dhtmlxTree/imgs/csh_bluebooks/");
    
	dhxTree.setXMLAutoLoading("${base}/resourcetree");
	dhxTree.loadXML("${base}/resourcegroup");
    dhxTree.setOnClickHandler(getTitlesByTreeId);
    dhxTree.attachEvent("onXLS", function(tree,id){dhxLayout.cells("a").progressOn();});
    dhxTree.attachEvent("onXLE", function(tree,id){dhxLayout.cells("a").progressOff();});
    
    window.dhx_globalImgPath = "${base}/resource/dhx/dhtmlxCombo/imgs/";
    dhtmlx.skin = "dhx_skyblue";
    
    
    
      /**开始装载 我的任务**/
    <shiro:hasPermission name="resource:act">
    dhxAccord.addItem("a2", icon_shr+"我的任务");
    dhxAccord.cells("a2").attachObject("mytaskmenu"); 
    </shiro:hasPermission>
    
    <shiro:hasPermission name="resource:approval">
    dhxAccord.addItem("a3", icon_shr+"审核请求");
    dhxAccord.cells("a3").attachObject("myapprovalmenu"); 
    </shiro:hasPermission>
    
    dhxAccord.attachEvent("onActive", function(itemId, state){
    	if(itemId=="a2"){
    		document.openRight('${base}/resource/myactnotice'); 
    	}
        if(itemId=="a3"){
        	document.openRight('${base}/resource/myapproval?view=sent');
        }
    });
    
    dhxAccord.openItem("a1");
    dhxLayout.attachHeader("topmenu");
    dhxLayout.attachFooter("footer"); 
}

//切换区域
function changeViewDepartment(deptId){
	if(deptId!=""){
	    dhxTree.deleteChildItems(0);
		dhxTree.loadXML("${base}/resourcegroup?deptId="+deptId);
	}	
}

function search(){
	dhxLayout.cells("b").attachURL("${base}/resource/search");
}

function getTitlesByTreeId(treeId) { 
  if(dhxTree.hasChildren(treeId) > 0 ) {
  	dhxTree.openItem(treeId);return;
  }
  dhxLayout.cells("b").attachURL("${base}/resource/resourcetitlelist?treeId="+treeId);
  var headimg = "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='${base}/resource/dhx/dhtmlxToolbar/icons/other.gif' />"
 };

function mOvr(src,clrOver){ 
  if (!src.contains(event.fromElement)){ 
  src.bgColor = clrOver; 
  }
}
function mOut(src,clrIn){ 
	if (!src.contains(event.toElement)) { 
		src.style.cursor = 'default'; 
		src.bgColor = clrIn; 
	}
}

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
document.openRight=function(url){
 dhxLayout.cells("b").attachURL(url);
}

$(function(){
	doOnLoad();
});

</script>
	</body>
</html>
