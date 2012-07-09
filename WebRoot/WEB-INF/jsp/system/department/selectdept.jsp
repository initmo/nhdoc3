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

var dhxLayout,tree,toolBar;

	function doOnLoad() {
		dhxLayout = new dhtmlXLayoutObject(document.body, "1C");
		dhxLayout.cells("a").setText("选择部门");
	    tree=dhxLayout.cells("a").attachTree();
	    tree.setImagePath("${base}/resource/dhx/dhtmlxTree/imgs/csh_dhx_skyblue/");  
		tree.setXMLAutoLoading("${base}/system/department/all");
		tree.loadXML("${base}/system/department/all?id=0");
		
		toolBar = dhxLayout.cells("a").attachToolbar();
	    toolBar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
	    toolBar.addButton   ("select",1,"完成", "new.gif");
	    toolBar.addSeparator("s1",2);
	    toolBar.addButton   ("close",1,"取消", "new.gif");
	    toolBar.attachEvent ("onClick",function(id){
	   		 if (id=="select") {select();}
	   		 if (id=="close") {window.close();}
	    });
	}
	
	function select(){
	    if(tree.getSelectedItemId()!=""){
			var arrReturn = new Array();
			arrReturn[0] = tree.getSelectedItemId();
			arrReturn[1] = tree.getSelectedItemText();
			sendValues(arrReturn)
		}else{
			alert("  当前没有选中的部门！  ");
		}
	};		

	function sendValues(arrReturn)
	{
    	parent.returnValue = arrReturn;
		parent.close();
	}

	$(function(){
		doOnLoad();
	});
	</script>
	</body>
</html>
