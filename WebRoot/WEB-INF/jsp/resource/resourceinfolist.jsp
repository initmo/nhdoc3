<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>文档列表</title>

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
	.linkbold {COLOR: #333333; TEXT-DECORATION: none;font-weight:bold;}
	.link:hover {COLOR: #FF9900;  TEXT-DECORATION: underline}
	.gridhover {background-color: #f9f5d0; }
	</style>
	</head>
<body>		

<script>
var dhxLayout,dhxToolbar,dhxtabbar,listGrid,statusBar,dhxWins,gridHelper;
var ctx = '${base}' ;
var resourcetitleid = '${resourcetitle.id}' ;
var resourcetitlename = '<c:out value="${resourcetitle.titleName}" />' ;
var treeId = '${resourcetitle.treeId}';
var resourcepid = "${resourcepid}";
var back_scrollTop = '${param.pos}';
var historyAr=new Array();
//加载框架 
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"1C");
    dhxLayout.cells("a").setText("<img align=center  style='margin-left: 3px; margin-right: 5px' src='${base}/resource/dhx/dhtmlxToolbar/icons/other.gif'/>"+resourcetitlename);
  
    statusBar = dhxLayout.cells("a").attachStatusBar();
    attachList();
    
    dhxToolbar = dhxLayout.cells("a").attachToolbar();
    dhxToolbar.setIconsPath("${base}/resource/dhx/dhtmlxToolbar/icons/");
    dhxToolbar.addButton   ("back",1,"", "back.gif","back_dis.gif");

    <c:if test="${canAct}">
    <shiro:hasPermission name="resource:act">
    dhxToolbar.addSeparator("s1",3);
    dhxToolbar.addButton('upload',4,'上传文档','upload.gif', 'upload_dis.gif');  
    dhxToolbar.addButton('newedit',5,'新建文档','page.gif', 'page.gif');
    dhxToolbar.addButton('newfolder',6,'新建文件夹','folder.gif', 'open_dis.gif');
    dhxToolbar.addButton   ("sent",7,"发送审核", "forward.gif");
    dhxToolbar.addSeparator("s2",8);
    dhxToolbar.addButton   ("del",9,"删除", "recycle.gif");
    </shiro:hasPermission>
    </c:if>
    
    var moreOp = [['packagedownload', 'obj', '批量下载', '']
    				<c:if test="${canAct}">
                    ,['move', 'obj', '移动文件', '']
                     </c:if>
                    ];   
    
    dhxToolbar.addSeparator("s3",9);
    dhxToolbar.addButtonSelect("moreOp", 10,"更多操作", moreOp, null, null);
	dhxToolbar.addSeparator("s2",49);
	//dhxToolbar.setWidth("upload",100);
	//dhxToolbar.setWidth("moreOp",120);
    dhxToolbar.attachEvent ("onClick",function(id){
   		 if (id=="back")  {goBack();}
   		 if (id=="upload"){showUploadWindow();}
   		 if (id=="del"){batchDeleteResource();}
   		 if (id=="newfolder"){newfolder();}
   		 if (id=="newedit"){newResource();}
   		 if (id=="sent"){batchSentResource();}
   		 if (id=="packagedownload"){packagedownload();}
   		 if (id=="move"){domove();}
    });   
}


/**upload window**/
var uploadWindow;
function showUploadWindow() 
{
 //OpenWin("${base}/resource/resourceinfoupload?pid="+resourcepid +"&titleid="+resourcetitleid,400,440);
 popWin("${base}/resource/resourceinfoupload?pid="+resourcepid +"&titleid="+resourcetitleid,420,440,"上传文件");
}

function domove()
{
	if(getSelectedIds()==""){
		alert("  请钩选要移动的文件！  ");
		return;
	}
 	popWin('${base}/resource/move/view?titleId='+resourcetitleid,280,330,'移动文件')
}

function getSelectedIds(){
  return listGrid.getCheckedRows(0); 
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

	<c:if test="${not canAct}">
	listGrid.setColumnHidden(8,true);
	</c:if>
	
	listGrid.init();
	listGrid.enableRowsHover(true,"gridhover");
	listGrid.attachEvent("onXLS", function(grid_obj){}); 
	listGrid.attachEvent("onXLE", function(grid_obj){  
			statusBar.setText(" 共  "+listGrid.getRowsNum()+"  个"); 
		}); 
	listGrid.attachEvent("onRowDblClicked", 
		function(rId,cInd){
			showResourceInfo(rId);
	    });  
}

/**加载列表**/
function loadList(titleId,pid) {
    dhxLayout.cells("a").progressOn();
 
	listGrid.clearAll();
	if(pid==0)
	 listGrid.load("${base}/resource/resourceinfolistxml?pid=0&titleId="+titleId,afterGridLoad);              
	else
	 listGrid.load("${base}/resource/resourceinfolistxml?pid="+pid,afterGridLoad);
}

/**表格加载后**/
function afterGridLoad(){
    dhxLayout.cells("a").progressOff();
    resourcepid = listGrid.getUserData("","parent_id");
/*
	if(listGrid.getUserData("","parent_pid")=="")
		dhxToolbar.disableItem("back");
	else
	    dhxToolbar.enableItem("back");
*/
}

/**返回**/
function goBack(){
	if(listGrid.getUserData("","parent_pid")==""){  // 当前微文档根目录, 返回到title列表.
		window.location.href = "${base}/resource/resourcetitlelist?treeId="+treeId+"&titleId="+resourcetitleid+"&pos="+back_scrollTop;
	}
	else
		loadList(resourcetitleid,listGrid.getUserData("","parent_pid"))
}

/**刷新表格数据**/
function refresh(){
	loadList(resourcetitleid,resourcepid);
}

/**查看 文件\文档**/
function showResourceInfo(resourceId){
	if(listGrid.getUserData(resourceId,"isdir")=="true"){
		loadList('',resourceId);
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
  if(getSelectedIds()==""){
		alert("  请钩选要下载的文件！  ");
		return;
  }
  var idArray = ids.split(",");
  var url = "${base}/resource/packagedownload";
  var downloadform = createForm("post",url);
  for(var i in idArray){
  	if (idArray[i]!="")
  		addparam("ids",idArray[i],downloadform);
  }
  downloadform.submit();
}

/**新增文档**/
function newResource(id){
 	window.location.href="${base}/resource/resourceinfonew?pid="+resourcepid +"&titleid="+resourcetitleid
}
/**修改**/
function editResourceInfo(id,isDir){
if(isDir)
	window.location.href="${base}/resource/folderedit?id="+id;
else
 	window.location.href="${base}/resource/resourceinfoedit?id="+id;
}

/**新增文件夹**/
function newfolder() {
	window.location.href= "${base}/resource/foldernew?pid="+resourcepid +"&titleid="+resourcetitleid;
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
	   error: function(data){alert("发送审核失败！");},
	   success: function(data){if(data=='success') refresh();}
	 }); 
 }
}


$(function(){
    doOnLoad();
    loadList(resourcetitleid,resourcepid);
});

</script>

</body>
</html>
