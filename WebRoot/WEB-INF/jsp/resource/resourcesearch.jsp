<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>搜索</title>

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
 
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		<script src="${base}/resource/common/js/common.js"></script>
	    <script type="text/javascript" src="${base}/resource/common/js/jquery.XYTipsWindow.min.2.8.js"></script>
		
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
	<style>
	html, body { width: 100%;height: 100%;margin: 0px;padding: 0px;overflow: hidden; }
	.link {COLOR: #333333; TEXT-DECORATION: none}
	.link:hover {COLOR: #FF9900; TEXT-DECORATION: underline}
	.gridhover {background-color: #f9f5d0;}
	.page{COLOR: #333333; TEXT-DECORATION: none;float: right; margin: auto 10px;}
	.page:hover {COLOR: #FF9900; TEXT-DECORATION: underline}
	</style>
	</head>
<body>		
<script>
var dhxLayout,dhxToolbar,dhxtabbar,listGrid,statusBar,dhxWins,gridHelper;
var ctx = '${base}' ;
var resourcetitleid = '${resourcetitle.id}' ;
var resourcetitlename = '${resourcetitle.titleName}' ;
var resourcepid = "${resourcepid}";
var historyAr=new Array();
var keyval="";
var pageSize= 19;
//加载框架 
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"1C");
    dhxLayout.cells("a").setText("<img align=center  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/dhx/dhtmlxToolbar/icons/search.gif'/>搜索");
  
    statusBar = dhxLayout.cells("a").attachStatusBar();
    attachList();
    
    dhxToolbar = dhxLayout.cells("a").attachToolbar();
    dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
    dhxToolbar.addText("tb_text", 45, "搜索关键字:");
	dhxToolbar.addInput("tb_key",46,"",100); 
	dhxToolbar.addText("txt47", 47, "(回车确认)");

	dhxToolbar.addSeparator("s2",49);
    dhxToolbar.attachEvent ("onClick",function(id){
   		 if (id=="back")  {loadList(resourcetitleid,listGrid.getUserData("","parent_pid"));}
   		 if (id=="upload"){showUploadWindow();}
   		 if (id=="packagedownload"){packagedownload();}
   		 if (id=="move"){domove();}
    });   
    dhxToolbar.attachEvent("onEnter",
    function(id,value){
  			if (id=="tb_key") {search(value);}
    }); 
}
 
function attachList() {
    listGrid = dhxLayout.cells("a").attachGrid();
	listGrid.setIconsPath("${base}/resource/common/images/filetypes/");
	listGrid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";
	listGrid.setHeader("<a class=link href='javascript:listGrid.checkAll(true);'>全选</a>,ID,状态,类型,名称,大小KB,修改人,修改时间,&nbsp");
	listGrid.setInitWidths("40,50,40,40,*,60,80,150,100");
	listGrid.setColAlign("center,center,center,center,left,right,center,center,center");
	listGrid.setColTypes("ch,ro,img,img,ro,ro,ro,ro,ro");
	listGrid.setColSorting(",int,str,str,str,int,str,str,");
	listGrid.setColumnHidden(1,true);

	listGrid.init();
	listGrid.enableRowsHover(true,"gridhover");
	listGrid.attachEvent("onXLS", function(grid_obj){}); 
	listGrid.attachEvent("onXLE", function(grid_obj){  
	   rendPageInfo();
	}); 
	listGrid.attachEvent("onRowDblClicked", function(rId,cInd){
			showResourceInfo(rId);
	}); 
}

function search(value) {
	if(value==""){
		alert("请输入搜索关键字！");
		return;
	}
    keyval = encodeURI(encodeURI(value));
	listGrid.clearAll();
	listGrid.load("${base}/resource/resourcesearchxml?pageNo=1&pageSize="+pageSize+"&keyval="+keyval,afterGridLoad);  
}

function toDir(titleid,pid){
	window.location.href="${base}/resource/resourceinfolist?titleId="+titleid+"&pid="+pid;
}

/**表格加载后**/

function afterGridLoad(){
    dhxLayout.cells("a").progressOff();
}


function rendPageInfo(){
	var pageSize = parseInt(listGrid.getUserData("","pageSize"));
	var totalCount = parseInt(listGrid.getUserData("","totalCount"));
	var totalPage = parseInt(listGrid.getUserData("","totalPage"));
	var pageNo = parseInt(listGrid.getUserData("","pageNo"));
	var prePage = pageNo - 1;
	var nextPage = pageNo + 1;	
	var html="";
	html += "<a href=# class=page onclick='gopage("+totalPage+")'>尾页</a> ";
	html += "<a href=# class=page onclick='gopage("+nextPage+")'>下一页</a> ";
	html += "<a href=# class=page onclick='gopage("+prePage+")'>上一页</a> ";
	html += "<a href=# class=page onclick='gopage(1)'>首页</a> ";
	html += "<span class=page>第"+pageNo+"/"+totalPage+"页 </span>";
	html += "<span class=page>共 "+totalCount+" 条记录</span> ";
	statusBar.setText(html);
}

function gopage(pageNo){
    var totalPage = parseInt(listGrid.getUserData("","totalPage")); 
    if(pageNo < 1){alert("已经是首页");return;}
    if(pageNo > totalPage){alert("已经是尾页");return;}
	listGrid.clearAll();
	listGrid.load("${base}/resource/resourcesearchxml?pageNo="+pageNo+"&pageSize="+pageSize+"&keyval="+keyval,afterGridLoad);  
	
}

/**查看 文件\文档**/
function showResourceInfo(resourceId){
	if(listGrid.getUserData(resourceId,"isdir")=="true"){
		var titleid = listGrid.getUserData(resourceId,"titleid");
		toDir(titleid,resourceId);
	}
	else{
		download(resourceId);
	}
}

/**下载文档**/
function download(resourceId){
	window.location.href="${base}/resource/download?id="+resourceId;
}

/**打包下载**/
function packagedownload(){
  var ids = listGrid.getCheckedRows(0); 
  if(ids==""){return;}
  var idArray = ids.split(",");
  var url = "${base}/resource/packagedownload";
  var downloadform = createForm("post",url);
  for(var i in idArray){
  	if (idArray[i]!="")
  		addparam("ids",idArray[i],downloadform);
  }
  downloadform.submit();
}

/**批量删除**/
function batchDeleteResource() {
var ids = listGrid.getCheckedRows(0);
if(ids==""){return;}
if(confirm(" 确认要删除选择的项目？     ")){
	$.ajax({
	   url: ctx+"/resource/batchdeleteresource",
	   type: "POST",
	   data: {"ids":ids},
	   error: function(data){alert("删除失败");},
	   success: function(data){if(data=='success') refresh();}
	 }); 
 }
}


/**单个删除**/
function delResourceInfo(id){
if(confirm(" 确认要删除选择的项目？     ")){
	$.ajax({
	   url: ctx+"/resource/batchdeleteresource",
	   type: "POST",
	   data: {"ids":id},
	   error: function(){alert("删除失败");},
	   success: function(data){if(data=='success') refresh();}
	 }); 
 }
}

/**批量发送审核**/
function batchSentResource() {
var ids = listGrid.getCheckedRows(0);
if(ids==""){return;}
if(confirm(" 确认要发送审核选择的项目？     ")){
	$.ajax({
	   url: ctx+"/resource/batchsentapproval",
	   type: "POST",
	   data: {"ids":ids},
	   error: function(data){alert("删除失败");},
	   success: function(data){if(data=='success') refresh();}
	 }); 
 }
}

$(function(){
    doOnLoad();
});

</script>

</body>
</html>
