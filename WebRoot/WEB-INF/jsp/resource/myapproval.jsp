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
	.page{COLOR: #333333; margin: auto 5px;}
	.page:hover {COLOR: #FF9900;}
	.pageinfo{COLOR: #333333; TEXT-DECORATION: none; margin: auto 5px;}
	</style>
	</head>
<BODY>		

<script><!--

var dhxLayout,dhxToolbar,dhxtabbar,listGrid,statusBar,dhxWins,gridHelper;

var sent={};
var finish={};

var view = '${view}';
//加载框架 
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"1C");
    dhxtabbar = dhxLayout.cells("a").attachTabbar();    
    dhxtabbar.setImagePath("${base}/resource/dhx/dhtmlxTabbar/imgs/");
    dhxtabbar.addTab("sent", "待审核", 100);
    dhxtabbar.addTab("finish","审核记录", 100);
    
	dhxtabbar.attachEvent('onSelect', function(id, last_id){
		if(id=="sent"){document.loadSent();};
		if(id=="finish"){document.loadFinish();};
		view=id;
		return true;
	});
	
	if(view!="") 
		dhxtabbar.setTabActive(view);
	else
		dhxtabbar.setTabActive("sent");
}



document.loadSent = function(){
	if(sent.loaded)return;
	sent.statusBar = dhxtabbar.cells("sent").attachStatusBar();
	sent.dhxToolbar = dhxtabbar.cells("sent").attachToolbar();
    sent.dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
    sent.dhxToolbar.addButton   ("back",1,"审核退回", "redo.gif");
    sent.dhxToolbar.addButton   ("pass",2,"审核通过", "pass.png");
    sent.dhxToolbar.addSeparator("s2",3);
   	sent.dhxToolbar.addButton   ("refresh",10,"刷新", "reload.gif");
	sent.dhxToolbar.attachEvent ("onClick",function(id){
   		 if (id=="refresh"){sent.refresh();}
   		 if (id=="pass"){batchpass(sent);}
   		 if (id=="back"){batchback(sent);}
    });   
    sent.grid = dhxtabbar.cells("sent").attachGrid();
	sent.grid.setIconsPath("${base}/resource/common/images/filetypes/");
	sent.grid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";
	sent.grid.setHeader("<a class=link href='javascript:sent.grid.checkAll(true);'>全选</a>,id,result,类型,名称,,提交时间,,提交人,机构名称,");
	sent.grid.setInitWidths("40,0,0,40,*,0,80,0,100,100,40");
	sent.grid.setColAlign("center,center,center,center,left,left,left,center,center,center,center");
	sent.grid.setColTypes("ch,ro,img,img,ro,ro,ro,ro,ro,ro,ro");
	sent.grid.setColSorting("int,int,str,str,str,str,str,str,int,str,");
	sent.grid.init();
	sent.grid.enableRowsHover(true,"gridhover");
	sent.loadUrl = "${base}/resource/myapprovalsentxml";
	sent.page = new PageBar("sent",sent.loadUrl);
	sent.grid.attachEvent("onXLE", function(grid_obj){   
	    sent.page.rendPageInfo(sent);
	}); 
	sent.loadgrid = function(){	
		sent.grid.load(sent.loadUrl); 
	};
	sent.refresh=function(){
	    sent.grid.clearAll();
		sent.loadgrid();
	};
	
	sent.loadgrid();
	sent.loaded = true;
}



document.loadFinish = function(){
	if(finish.loaded)return;
	finish.statusBar = dhxtabbar.cells("finish").attachStatusBar();
	finish.dhxToolbar = dhxtabbar.cells("finish").attachToolbar();
    finish.dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
   	finish.dhxToolbar.addButton   ("refresh",10,"刷新", "reload.gif");
	finish.dhxToolbar.attachEvent ("onClick",function(id){
   		 if (id=="refresh"){finish.refresh();}
    });   
    finish.grid = dhxtabbar.cells("finish").attachGrid();
	finish.grid.setIconsPath("${base}/resource/common/images/filetypes/");
	finish.grid.imgURL = "${base}/resource/dhx/dhtmlxGrid/imgs/icons_greenfolders/";
	finish.grid.setHeader(",,审核结果,类型,名称,审核意见,提交日期,审核日期,提交人,机构名称");
	finish.grid.setInitWidths("0,0,65,40,*,200,80,80,100,100");
	finish.grid.setColAlign("center,center,center,center,left,left,left,center,center,center");
	finish.grid.setColTypes("ch,ro,img,img,ro,ro,ro,ro,ro,ro");
	finish.grid.setColSorting(",int,str,str,str,str,str,str,str,str");
	finish.grid.init();
	finish.grid.enableRowsHover(true,"gridhover");
	finish.loadUrl = "${base}/resource/myapprovalfinishxml";
	finish.page = new PageBar("finish",finish.loadUrl,20);
	finish.grid.attachEvent("onXLE", function(grid_obj){  
	    finish.page.rendPageInfo(finish);
	}); 
	finish.loadgrid = function(){	
		finish.grid.load(finish.loadUrl); 
	};
	finish.refresh=function(){
	    finish.grid.clearAll();
		finish.loadgrid();
	};
	finish.loadgrid();
	finish.loaded = true;
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

/**批量通过审核**/
function batchpass(o) {
var ids = o.grid.getCheckedRows(0);
if(ids=="")return;
if(confirm(" 确认要审核通过选择的项目？     ")){
	$.ajax({
	   url: "${base}/resource/batchpassapproval",
	   type: "POST",
	   data: {"ids":ids},
	   error: function(data){alert("审核失败");},
	   success: function(data){if(data=='success') o.refresh();}
	 }); 
 }
}

/**批量退回审核**/
function batchback(o) {
var ids = o.grid.getCheckedRows(0);
if(ids=="")return;
if(confirm(" 确认要审核退回选择的项目？     ")){
	$.ajax({
	   url: "${base}/resource/batchbackapproval",
	   type: "POST",
	   data: {"ids":ids},
	   error: function(data){alert("审核失败");},
	   success: function(data){if(data=='success') o.refresh();}
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

/**详细审核页面**/
function viewApproval(approvalrequestId){
	window.location.href="${base}/resource/approval?id="+approvalrequestId;
}

$(function(){
    doOnLoad();
    
});

--></script>

</BODY>
</HTML>
