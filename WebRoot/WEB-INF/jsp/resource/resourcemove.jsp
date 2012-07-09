<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<script src="${base}/resource/dhx/dhtmlxGrid/dhtmlxcommon.js"></script>
<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.css">
<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/skins/dhtmlxlayout_dhx_skyblue.css">
<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.js"></script>
<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcontainer.js"></script>
		
<!-- for dhtmlxtree -->
<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxTree/dhtmlxtree.css">
<script src="${base}/resource/dhx/dhtmlxTree/dhtmlxtree.js"></script>
<!-- for dhtmlxToolbar -->
<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxToolbar/skins/dhtmlxtoolbar_dhx_skyblue.css">
<script src="${base}/resource/dhx/dhtmlxToolbar/dhtmlxtoolbar.js"></script>

<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
</head>
<body>
		
<script type="text/javascript">
var titleId = '${titleId}';
var ids = parent.getSelectedIds();
var dhxLayout,tree,toolBar;

	function doOnLoad() {
		dhxLayout = new dhtmlXLayoutObject(document.body, "1C");
		dhxLayout.cells("a").setText("请选择移动位置");
	    tree=dhxLayout.cells("a").attachTree();
	    tree.setImagePath("${base}/resource/dhx/dhtmlxTree/imgs/csh_dhx_skyblue/");  
		tree.setXMLAutoLoading("${base}/resource/move/treeleaf");
		tree.loadXML("${base}/resource/move/treeleaf?id=0&titleId="+titleId);
		
		toolBar = dhxLayout.cells("a").attachToolbar();
	    toolBar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
	    toolBar.addButton   ("select",1,"完成", "new.gif");
	    toolBar.addSeparator("s1",2);
	    toolBar.addButton   ("close",1,"取消", "new.gif");
	    toolBar.attachEvent ("onClick",function(id){
	   		 if (id=="select") {moveprocess();}
	   		 if (id=="close") {parent.closePopWin();}
	    });
	}
	

function moveprocess(){
	var pid;
	
	if(tree.getSelectedItemId()!=""){
		pid = tree.getSelectedItemId()
	}
	else{
		alert("  当前没有选中的文件夹！  ");
		return;
	}
   
	$.ajax({
	   url: "${base}/resource/move/process?titleId="+titleId,
	   type: "POST",
	   data: {"ids":ids,"pid":pid},
	   error: function(data){alert("操作失败");},
	   success: function(data){if(data=='success') {parent.refresh();parent.closePopWin();}}
	 }); 
	}
	
	$(function(){
		doOnLoad();
	});
	</script>
	</body>
</html>
