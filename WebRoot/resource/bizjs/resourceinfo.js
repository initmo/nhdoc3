function ResourceInfo(context){
	var that=this;
	this.context=context || "/nhdoc3";
    this.init=function(){
	    this.dhxLayout=new dhtmlXLayoutObject(document.body,"2U");
		this._initContent();
	};
	this._initContent=function(){
		this.dhxLayout.cells("a").setWidth(250);
	    this.dhxLayout.cells("a").hideHeader();
	    this.dhxLayout.cells("b").hideHeader();
	    this.dhxLayout.cells("b").attachObject("bg");
	    var icon_wait= "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='"+context+"/resource/dhx/dhtmlxToolbar/icons/paste.gif' />";
	    var icon_now = "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='"+context+"/resource/dhx/dhtmlxToolbar/icons/page.gif' />";
	    var icon_shr = "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='"+context+"/resource/dhx/dhtmlxToolbar/icons/share.gif' />";
	    this.dhxAccord = this.dhxLayout.cells("a").attachAccordion();
	    this.dhxAccord.addItem("a1", icon_wait+"文档资源");
	    this.dhxAccord.addItem("a2", icon_shr+"我的任务");
	    this.dhxAccord.addItem("a3", icon_shr+"审核请求");
	    this.dhxAccord.openItem("a1");

	    this.grpToolbar = this.dhxAccord.cells("a1").attachToolbar();
	    this.grpToolbar.setIconsPath(this.context+"/resource/dhx/dhtmlxToolbar/icons/");
	    this.grpToolbar.addButton   ("img",0,"", "house.png");
	    this.grpToolbar.addText   ("txt1",1,curDept, "save.gif");
	    this.grpToolbar.addSeparator(2,null); 
	    this.grpToolbar.addButton   ("selectDept",3,"选择单位", "search.gif");
	    this.grpToolbar.attachEvent ("onClick",function(id){that.test(id);});

		this.dhxTree = this.dhxAccord.cells("a1").attachTree();
	    this.dhxTree.setImagePath(this.context+"/resource/dhx/dhtmlxTree/imgs/csh_bluebooks/");
	    
		this.dhxTree.setXMLAutoLoading(context+"/resourcetree");
		this.dhxTree.loadXML(this.context+"/resourcegroup");
	    this.dhxTree.attachEvent("onClick",function(id){that.selectTreeNode(id);});
	    this.dhxTree.attachEvent("onXLE",this.afterTreeLoaded);
	    
	    this.dhxLayout.attachHeader("topmenu");
	    this.dhxLayout.attachFooter("footer"); 

	    this.selectTreeNode=function(treeId){ 
		  if(that.dhxTree.hasChildren(treeId) > 0 ) {
		  	that.dhxTree.openItem(treeId);return;
  		  }
		  that.dhxLayout.cells("b").attachURL(that.context+"/resource/resourcetitlelist?treeId="+treeId);
		  var headimg = "<img align=center border=0 style='margin-left: 3px; margin-right: 3px' src ='${base}/resource/dhx/dhtmlxToolbar/icons/other.gif' />";
		};
		this.afterTreeLoaded=function(){};
	};
}

