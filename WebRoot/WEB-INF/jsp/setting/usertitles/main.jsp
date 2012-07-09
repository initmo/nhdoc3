<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>用户文档授权设置</title>	
		<meta content="text/html; charset=UTF-8" http-equiv=content-type/>
		<meta content=no-cache http-equiv=CacheControl/>
		<meta content=no-cache http-equiv=Pragma/>
		<meta content=-1 http-equiv=Expires/>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
		<link rel=stylesheet type=text/css href="${base}/resource/dhx/dhtmlx.css"></link>
		<script type="text/javascript" src="${base}/resource/dhx/dhtmlx.js"></script>
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
	</head>
	<body>
	
<script>
var curDept = "[${sessionScope.sessionUser.deptName}]";
var curDeptId = "${sessionScope.sessionUser.deptId}";

var userId = ${userId};
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
	    this.grpToolbar =this.dhxLayout.cells("a").attachToolbar();
	    this.grpToolbar.setIconsPath(this.context+"/resource/dhx/dhtmlxToolbar/icons/");
	    this.grpToolbar.addText   ("txt1",1,"用户名称：${user.userName}");
	    this.grpToolbar.attachEvent ("onClick",function(id){
	    	that._doOnToolbarClick(id);}
	    );
		this.dhxTree = this.dhxLayout.cells("a").attachTree();
	    this.dhxTree.setImagePath(this.context+"/resource/dhx/dhtmlxTree/imgs/csh_bluebooks/");
		this.dhxTree.setXMLAutoLoading("${base}/resourcetree");
		this.dhxTree.loadXML(this.context+"/setting/usergroup?userId="+userId);
	    this.dhxTree.attachEvent("onClick",function(id){that.selectTreeNode(id);});
	    this.dhxTree.attachEvent("onXLE",this.afterTreeLoaded);
	 };
	    
	    this._doOnToolbarClick=function(id){
	    	switch(id){
	    		//case "newgroup":this.openRight(this.context+'/setting/groupnew');break;
			}
	    };
	    
	    this.openRight=function(url){
	    	that.dhxLayout.cells("b").attachURL(url);
	    }
	    
        this.refreshTree=function(){
            that.dhxTree.deleteChildItems(0);
            that.dhxTree.loadXML(this.context+"/resourcegroup");
        };
        
	    this.selectTreeNode=function(treeId){ 
		  if(that.dhxTree.hasChildren(treeId) > 0 ) {
		  	that.dhxTree.openItem(treeId);
		  	return;
  		  }
  		  var pid = that.dhxTree.getParentId(treeId);
  		  if(pid==0){
  		  	return;
  		  }
		  this.openRight(that.context+"/setting/usertitlelist?treeId="+treeId+"&userId="+userId);
		  var headimg = "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='${base}/resource/dhx/dhtmlxToolbar/icons/other.gif' />";
		};
			
		this.selectItem=function(id){
		    that.dhxTree.selectItem(id,false,null);
		};
		
		this.refreshItem=function(treeId){
			 that.dhxTree.refreshItem(treeId);
		}
		
		this.afterTreeLoaded=function(){};
	}

var settingObj;
$(function(){
	settingObj = new SettingObject('${base}');
	settingObj.init();
});


</script>
	</body>
</html>