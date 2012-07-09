<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>文档设置</title>
	    <meta content="text/html; charset=utf-8" http-equiv=content-type/>
		<meta content=no-cache http-equiv=CacheControl/>
		<meta content=no-cache http-equiv=Pragma/>
		<meta content=-1 http-equiv=Expires/>
		
		
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
		
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
		<script type="text/javascript" src="${base}/resource/common/js/jquery.XYTipsWindow.min.2.8.js"></script>
		<style>
	    html, body { width: 100%;height: 100%;margin: 0px;padding: 0px;overflow: hidden; }
	    </style>
	</head>
	<body>
<%@ include file="../top.jsp"%>	
<div id="bg" style="width: 100%; height: 100%;display: none;"><img src="${base}/resource/common/img/sgcc_bg.jpg"/></div>
<script>
var curDept = "[${sessionScope.sessionUser.deptName}]";
var curDeptId = "${sessionScope.sessionUser.deptId}";


function SettingObject(context){
	var that=this;
	this.context=context || "${base}";
	
    this.init=function(){
	    this.dhxLayout=new dhtmlXLayoutObject(document.body,"2U");
		this._initContent();
	};
	
	this._initContent=function(){
		this.dhxLayout.cells("a").setWidth(250);
	    this.dhxLayout.cells("a").hideHeader();
	    this.dhxLayout.cells("b").hideHeader();
	    this.dhxLayout.cells("b").attachObject("bg"); 
	    this.grpToolbar =this.dhxLayout.cells("a").attachToolbar();
	    this.grpToolbar.setIconsPath(this.context+"/resource/dhx/dhtmlxToolbar/icons/");
	    this.grpToolbar.addButton   ("newgroup",0,"新增文档库", "iconSafe.gif");
	   // this.grpToolbar.addButton   ("newtreenode",1,"新增节点", "groupAdd2.gif");
	    this.grpToolbar.addButton   ("editnode",2,"修改", "settings.gif");
	    this.grpToolbar.addButton   ("delete",3,"删除", "cut.gif");
	    this.grpToolbar.attachEvent ("onClick",function(id){
	    	that._doOnToolbarClick(id);}
	    );
		this.dhxTree = this.dhxLayout.cells("a").attachTree();
	    this.dhxTree.setImagePath(this.context+"/resource/dhx/dhtmlxTree/imgs/csh_bluebooks/");
		this.dhxTree.setXMLAutoLoading(context+"/resourcetree");
		this.dhxTree.loadXML(this.context+"/setting/settinggroup");
	    this.dhxTree.attachEvent("onClick",function(id){that.selectTreeNode(id);});
	    this.dhxTree.attachEvent("onXLE",this.afterTreeLoaded);
	    this.dhxLayout.attachHeader("topmenu");
	    this.dhxLayout.attachFooter("footer"); 
	 };
	    
	    this._doOnToolbarClick=function(id){
	    	switch(id){case "newgroup":this.openRight(this.context+'/setting/groupnew');break;
	    	           case "newtreenode":this._doChannelAdd();break;
	    	           case "editnode":this.editNode();break;
	    	           case "delete":this.deleteTreeItem();break;}
	    };
	    
	    this.openRight=function(url){
	    	that.dhxLayout.cells("b").attachURL(url);
	    }
	    
        this.refreshTree=function(){
            that.dhxTree.deleteChildItems(0);
            that.dhxTree.loadXML(this.context+"/setting/settinggroup");
        };
        
	    this.selectTreeNode=function(treeId){ 
		  if(that.dhxTree.hasChildren(treeId) > 0 ) {
		  	that.dhxTree.openItem(treeId);
		  	return;
  		  }
  		  var pid = that.dhxTree.getParentId(treeId);
  		  if(pid==0){
  		  	var groupId = that.dhxTree.getUserData(treeId,"groupId");
			this.openRight(that.context+"/setting/groupedit?id="+groupId);
  		  	return;
  		  }
		  this.openRight(that.context+"/setting/titlelist?treeId="+treeId);
		  var headimg = "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='${base}/resource/dhx/dhtmlxToolbar/icons/other.gif' />";
		};
		
		this.editNode=function(){
		    var selectedId = that.dhxTree.getSelectedItemId();
			var pid = that.dhxTree.getParentId(selectedId);
			if(pid==0){//修改主目录
			    var groupId = that.dhxTree.getUserData(selectedId,"groupId");
				this.openRight(that.context+"/setting/groupedit?id="+groupId);
			}else{ //修改子目录
				var treeId = that.dhxTree.getSelectedItemId();
				this.openRight(that.context+"/setting/treeedit?id="+treeId);
			}
		};
		
		this.selectItem=function(id){
		    that.dhxTree.selectItem(id,false,null);
		};
				
		this.deleteTreeItem=function(){
		     var treeId = that.dhxTree.getSelectedItemId();
			 dhtmlxAjax.post(that.context+"/setting/treedelete?treeId="+treeId, 
			                 '{}', 
			                 function(loader){
			                 	var treeId = loader.xmlDoc.responseText;
			                 	that.dhxTree.deleteItem(treeId,true);
			                 });
		};
		
		this.refreshItem=function(treeId){
			 that.dhxTree.refreshItem(treeId);
		}
		
		this.afterTreeLoaded=function(){};
	}

var settingObj;
$(function(){
	settingObj = new SettingObject('${base}');
	//settingObj.afterTreeLoaded=function(){settingObj.selectTreeNode(1)};
	settingObj.init();
});

</script>
	</body>
</html>