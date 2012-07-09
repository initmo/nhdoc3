<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta http-equiv="CacheControl" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<title>上传文档-NHDOC3</title>
<head>
<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/fixie.css">
<![endif]-->
<link href="${base}/resource/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resource/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${base}/resource/uploadify/jquery.uploadify.v2.1.4.js"></script>
</head>
<body scroll="no" onunload="finish();">
<div style="height: 4px"></div>
<div class="dcTbContainer bgSpecial upWrap" style="margin: 0px 4px 4px 4px">
	<div id="global_message"></div>
	<div id="muti" class="attentionArea">
	  <div><span class="req">*</span>  <strong>多文件上传</strong>，上传最大单个文件大小：<strong>5.0</strong>Mb.  <a href="#" onclick="bigfile();">[大文件上传]</a></div>
	</div>
	
	<div  id="single" class="attentionArea" style="display: none">
	  <div><span class="req">*</span>  <strong>大文件上传</strong>，上传最大文件大小：<strong>100</strong>Mb. <a href="#" onclick="mutifile();">[多文件上传]</a></div>
	</div>
	
	<table cellspacing="0" width="100%">
		<tbody>
			<tr>
				<th align="left" width="23%">上级目录:</th>
				<td>${parent.filealiasname }</td>
				<!-- <td width="20px"><input type="file"  name="uploadify" id="uploadify" /></td> -->
			</tr>
			<tr>
				<th align="left">上传文档:</th>
				<td><input type="file"  name="uploadify" id="uploadify" /></td>
			</tr>
			<tr>
				<th align="left">发送审核:</th>
				<td><input type="checkbox" value="1" checked="checked" id="sendApproval" name="sendApproval" /> (是否发送审核)</td>
			</tr>
			<tr>
				<td style="height: 5px"></td>
				<td height="5px"></td>
			</tr>
			<tr style="background-color: #cccccc" >
				<td style="height: 1px"></td>
				<td height="1px"></td>
			</tr>
		<tr>
		</tbody>
	</table>
	
	<div style=" width: 100%; ">
		<div id="fileQueue" style="height: 267px;overflow-y: auto">
	</div>
	
	<div class="actionbar_b btnL" style="margin-top: 10px">
	<input style="height: 25px;float: right;width: 80px" type="button" value="关&nbsp;闭 "    onclick="finish();"/>
	<input style="height: 25px;float: right;width: 80px" type="button" value="开始上传 "    onclick="startUpload();"/>
    </div>
	</div>
    
</div>

<script>

//自动提交审核
function changeSendApprovalCheckBox(b){
	jQuery('#uploadify').uploadifySettings('scriptData', {'pid':'${parent.id}','titleid':'${parent.titleid}','sendApproval':b ? 1 : 0});
}

//自动上传
//TODO

function startUpload(){
 	jQuery('#uploadify').uploadifyUpload();
 }

function finish(){
	parent.loadList(${parent.titleid},${parent.id});
	parent.closePopWin();
}

function bigfile(){ 
	jQuery('#uploadify').uploadifySettings('multi',false);
	jQuery('#uploadify').uploadifySettings('queueSizeLimit',1);
	jQuery('#uploadify').uploadifySettings('sizeLimit',100*1024*1024);
	$("#single").show();
	$("#muti").hide();
	
}

function mutifile(){
	jQuery('#uploadify').uploadifySettings('multi',true);
	//jQuery('#uploadify').uploadifySettings('queueSizeLimit',5);
	jQuery('#uploadify').uploadifySettings('sizeLimit',5*1024*1024);
	$("#single").hide();
	$("#muti").show();
	
}

$(function(){
     $("#sendApproval").click(function(){
     	changeSendApprovalCheckBox($(this).attr("checked"));
     })

     $("#uploadify").uploadify({
             'uploader'       : '${base}/resource/uploadify/uploadify.swf',
             'script'         : '${base}/resource/processupload;jsessionid=<%=session.getId()%>',          //+encodeURIComponent('?pid=0&titleid=1'),
             'scriptData'     : {'pid':'${parent.id}','titleid':'${parent.titleid}','sendApproval':$("#sendApproval").attr("checked") ? 1 : 0},
             'cancelImg'      : '${base}/resource/uploadify/cancel.png',
             'buttonImg'      : '${base}/resource/uploadify/add.gif', 
             'folder'         : 'uploads',
             'queueID'        : 'fileQueue',
             'auto'           : false,//自动开始上传
             'multi'          : true, //是否多选
             'simUploadLimit' : 1,    //同时上传文件数
             'buttonText'     : 'BROW',
             'height'        : 21,
             'width'        : 59,
             //'queueSizeLimit' : 5, //最大文件列队数
             'sizeLimit'   : 5*1024*1024, //sizeLimit 5M 
             'onSelect' : function(event,queueID,fileObj){},
             'onCancel' : function(event,queueID,fileObj,data){},
             'onComplete':function(event,queueID,fileObj,response,data){
             						if(response!="success") alert("上传文件出错："+response);
             						return false;
             						},
             'onQueueFull':function(){},
             'onAllComplete' :function(event,data){},
             'onError'     : function (event,ID,fileObj,errorObj) {
      				     	alert(errorObj.type + ' Error: ' + errorObj.info);}
     });
  }); 
</script>
</body>
</html>