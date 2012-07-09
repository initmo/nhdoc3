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
	<style>
	.link {COLOR: #333333; TEXT-DECORATION: none}
	.link:hover {COLOR: #FF9900; TEXT-DECORATION: underline}
	.gridhover {background-color: #f9f5d0;}
	</style>
	</head>
<BODY>		

<script><!--


var dhxLayout,dhxToolbar,dhxtabbar,listGrid,statusBar,dhxWins,gridHelper;
var draft={};
var sent={};
var pass={};
var returned={};

var view = '${view}';
//加载框架 
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"1C");
    dhxtabbar = dhxLayout.cells("a").attachTabbar();    
    dhxtabbar.setImagePath("${base}/resource/dhx/dhtmlxTabbar/imgs/");
    dhxtabbar.addTab("draft", "草稿", 100);
    dhxtabbar.addTab("sent","待审核", 100);
    dhxtabbar.addTab("pass", "通过审核", 100);
    dhxtabbar.addTab("returned", "审核退回", 100);
    
	dhxtabbar.attachEvent('onSelect', function(id, last_id){
		if(id=="draft"){document.loadDraft();};
		if(id=="sent"){document.loadSent();};
		if(id=="pass"){document.loadPass();};
		if(id=="returned"){document.loadReturned();};
		view=id;
		return true;
	});
	
	if(view!="") 
		dhxtabbar.setTabActive(view);
	else
		dhxtabbar.setTabActive("draft");
}


document.loadDraft = function(){
	if(draft.loaded)return;
	draft.dhxToolbar = dhxtabbar.cells("draft").attachToolbar();
    draft.dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
    draft.dhxToolbar.addButton   ("sent",1,"发送审核", "forward.gif");
	draft.dhxToolbar.addButton   ("del",8,"删除", "recycle.gif");
	draft.dhxToolbar.addButton   ("refresh",10,"刷新", "reload.gif");
	draft.dhxToolbar.attachEvent ("onClick",function(id){
		 if (id=="sent"){batchSentResource(draft);}
   		 if (id=="del"){batchDeleteResource(draft);}
   		 if (id=="refresh"){draft.refresh();}
    });   
    
    draft.grid = dhxtabbar.cells("draft").attachGrid();
	draft.grid.setIconsPath("${base}/resource/common/images/filetypes/");
	draft.grid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";
	draft.grid.setHeader("<a class=link href='javascript:draft.grid.checkAll(true);'>全选</a>,,状态,类型,名称,大小KB,,修改时间,");
	draft.grid.setInitWidths("40,0,40,40,*,60,0,150,100");
	draft.grid.setColAlign("center,center,center,center,left,right,center,center,center");
	draft.grid.setColTypes("ch,ro,img,img,ro,ro,ro,ro,ro");
	draft.grid.setColSorting(",int,str,str,str,int,str,str,");
	//draft.grid.setColumnHidden(1,true);
	draft.grid.init();
	draft.grid.attachEvent("onXLE", function(grid_obj){  
	    dhxtabbar.setLabel("draft","草稿 ("+grid_obj.getRowsNum()+")"); 
	}); 
	draft.grid.enableRowsHover(true,"gridhover");
	draft.loadgrid = function(){	
		draft.grid.load("${base}/resource/myactresourceinfolistxml?status=0"); 
	};
	draft.refresh=function(){
	    draft.grid.clearAll();
		draft.loadgrid();
	};
	draft.loadgrid();
	draft.loaded = true;
}
document.loadSent = function(){
	if(sent.loaded)return;
	sent.dhxToolbar = dhxtabbar.cells("sent").attachToolbar();
    sent.dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
   	sent.dhxToolbar.addButton   ("refresh",10,"刷新", "reload.gif");
	sent.dhxToolbar.attachEvent ("onClick",function(id){
   		 if (id=="refresh"){sent.refresh();}
    });   
    sent.grid = dhxtabbar.cells("sent").attachGrid();
	sent.grid.setIconsPath("${base}/resource/common/images/filetypes/");
	sent.grid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";
	sent.grid.setHeader("<a class=link href='javascript:sent.grid.checkAll(true);'>全选</a>,,状态,类型,名称,大小KB,,修改时间");
	sent.grid.setInitWidths("40,0,40,40,*,60,0,150");
	sent.grid.setColAlign("center,center,center,center,left,right,center,center");
	sent.grid.setColTypes("ch,ro,img,img,ro,ro,ro,ro");
	sent.grid.setColSorting(",int,str,str,str,int,str,str");
	sent.grid.init();
	sent.grid.enableRowsHover(true,"gridhover");
	sent.grid.attachEvent("onXLE", function(grid_obj){  
	    dhxtabbar.setLabel("sent","待审核 ("+grid_obj.getRowsNum()+")"); 
	}); 
	sent.loadgrid = function(){	
		sent.grid.load("${base}/resource/myactresourceinfolistxml?status=1"); 
	};
	sent.refresh=function(){
	    sent.grid.clearAll();
		sent.loadgrid();
	};
	
	sent.loadgrid();
	sent.loaded = true;
}
document.loadPass = function(){
	if(pass.loaded)return;
	pass.dhxToolbar = dhxtabbar.cells("pass").attachToolbar();
    pass.dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
   	pass.dhxToolbar.addButton   ("refresh",10,"刷新", "reload.gif");
	pass.dhxToolbar.attachEvent ("onClick",function(id){
   		 if (id=="refresh"){sent.refresh();}
    });   
    pass.grid = dhxtabbar.cells("pass").attachGrid();
	pass.grid.setIconsPath("${base}/resource/common/images/filetypes/");
	pass.grid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";
	pass.grid.setHeader("<a class=link href='javascript:pass.grid.checkAll(true);'>全选</a>,,状态,类型,名称,大小KB,,修改时间");
	pass.grid.setInitWidths("40,0,40,40,*,60,0,150");
	pass.grid.setColAlign("center,center,center,center,left,right,center,center");
	pass.grid.setColTypes("ch,ro,img,img,ro,ro,ro,ro");
	pass.grid.setColSorting(",int,str,str,str,int,str,str");
	pass.grid.init();
	pass.grid.enableRowsHover(true,"gridhover");
	pass.loadgrid = function(){	
		pass.grid.load("${base}/resource/myactresourceinfolistxml?status=3"); 
	};
	pass.refresh=function(){
	    pass.grid.clearAll();
		pass.loadgrid();
	};
	
	pass.loadgrid();
	pass.loaded = true;
}
document.loadReturned = function(){
	if(returned.loaded)return;
	returned.dhxToolbar = dhxtabbar.cells("returned").attachToolbar();
    returned.dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
    returned.dhxToolbar.addButton   ("sent",1,"发送审核", "forward.gif");
	returned.dhxToolbar.addButton   ("del",8,"删除", "recycle.gif");
	returned.dhxToolbar.addButton   ("refresh",10,"刷新", "reload.gif");
	returned.dhxToolbar.attachEvent ("onClick",function(id){
		 if (id=="sent"){};
   		 if (id=="sent"){batchSentResource(returned);}
   		 if (id=="del"){batchDeleteResource(returned);}
   		 if (id=="refresh"){draft.refresh();}
   		 
    });   
    
    returned.grid = dhxtabbar.cells("returned").attachGrid();
	returned.grid.setIconsPath("${base}/resource/common/images/filetypes/");
	returned.grid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";
	returned.grid.setHeader("<a class=link href='javascript:returned.grid.checkAll(true);'>全选</a>,,状态,类型,名称,大小KB,,修改时间,");
	returned.grid.setInitWidths("40,0,40,40,*,60,0,150,100");
	returned.grid.setColAlign("center,center,center,center,left,right,center,center,center");
	returned.grid.setColTypes("ch,ro,img,img,ro,ro,ro,ro,ro");
	returned.grid.setColSorting(",int,str,str,str,int,str,str,");
	//draft.grid.setColumnHidden(1,true);
	returned.grid.init();
	returned.grid.enableRowsHover(true,"gridhover");
	returned.grid.attachEvent("onXLE", function(grid_obj){  
	    dhxtabbar.setLabel("returned","审核退回 ("+grid_obj.getRowsNum()+")"); 
	}); 
	returned.loadgrid = function(){	
		returned.grid.load("${base}/resource/myactresourceinfolistxml?status=2"); 
	};
	returned.refresh=function(){
	    returned.grid.clearAll();
		returned.loadgrid();
	};
	returned.loadgrid();
	returned.loaded= true;
}

/**批量删除**/
function batchDeleteResource(view) {
var ids = view.grid.getCheckedRows(0);
if(ids=="")return;
if(confirm(" 确认要删除选择的项目？     ")){
	$.ajax({
	   url: "${base}/resource/batchdeleteresource",
	   type: "POST",
	   data: {"ids":ids},
	   error: function(data){alert("删除失败");},
	   success: function(data){if(data=='success') view.refresh();}
	 }); 
 }
}

/**单个删除**/
function delResourceInfo(id){
if(confirm(" 确认要删除选择的项目？     ")){
	$.ajax({
	   url: "${base}/resource/batchdeleteresource",
	   type: "POST",
	   data: {"ids":id},
	   error: function(){alert("删除失败");},
	   success: function(data){
	   	if(data=='success') {
	   		if(view=="draft")draft.refresh();
	   		if(view=="returned")returned.refresh();
	   		}
	   	}
	 }); 
 }
}

/**批量发送审核**/
function batchSentResource(view) {
var ids = view.grid.getCheckedRows(0);
if(ids=="")return;
if(confirm(" 确认要发送审核选择的项目？     ")){
	$.ajax({
	   url: "${base}/resource/batchsentapproval",
	   type: "POST",
	   data: {"ids":ids},
	   error: function(data){alert("发送审核失败");},
	   success: function(data){if(data=='success') view.refresh();}
	 }); 
 }
}
 /**查看 文件\文档**/
function showResourceInfo(resourceId){
		download(resourceId);
}
/**下载文档**/
function download(resourceId){
	window.location.href="${base}/resource/download?id="+resourceId;
}
/**修改**/
function editResourceInfo(id){
 	window.location.href="${base}/resource/resourceinfoedit?id="+id;
}


$(function(){
    doOnLoad();
    
});

--></script>

</BODY>
</HTML>
