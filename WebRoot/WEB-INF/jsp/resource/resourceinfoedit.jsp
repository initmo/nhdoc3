<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	StringBuffer url = new StringBuffer("http://");
	url.append(request.getHeader("Host"));
	url.append(request.getContextPath());
%>
<html>
<head>
	<title>文档编辑</title>
	<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
	<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
	<!--[if lt IE 7]>
	<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/fixie.css">
	<![endif]-->
	
	<script type="text/javascript" src="${base}/resource/weboffice/main.js"></script>
	<SCRIPT LANGUAGE=javascript FOR=WebOffice1 EVENT=NotifyCtrlReady defer="defer">
	WebOffice1_NotifyCtrlReady();
</SCRIPT>
<SCRIPT LANGUAGE=javascript FOR=WebOffice1 EVENT=NotifyWordEvent(eventname)>
<!--
 WebOffice1_NotifyWordEvent(eventname)
//-->
</SCRIPT>
<SCRIPT language=javascript for=WebOffice1 event=NotifyToolBarClick(iIndex) >
<!--
 WebOffice1_NotifyToolBarClick(iIndex);
//-->
</SCRIPT>
<script>
function WebOffice1_NotifyToolBarClick(iIndex){
 if(iIndex==32778){
   SaveToServer();
   return;
   }
 if(iIndex==32780){
    return;
   }
}

//上传文档
function SaveToServer() {
	if ($("#filealiasname").val()==""){
		alert("请输入标题！");
		$("#filealiasname").focus();
		return;
	}
	try{
		var webObj=document.getElementById("WebOffice1");
		var returnValue;	
		webObj.HttpInit();
		webObj.HttpAddPostString("filealiasname", encodeURI($("#filealiasname").val()));
		webObj.HttpAddPostString("titleid", encodeURI($("#titleid").val()));
		webObj.HttpAddPostString("pid", encodeURI($("#pid").val()));
		webObj.HttpAddPostString("id", encodeURI($("#id").val()));
		webObj.HttpAddPostCurrFile("DocContent","");		
		returnValue = webObj.HttpPost("<%=url%>/resource/processuploadol");
		if(returnValue > 0){
		    $("#id").val(returnValue);
		    document.getElementById("WebOffice1").FullScreen = false ;
			alert(returnValue+"文件保存成功");
		}else 
		 {
		    document.getElementById("WebOffice1").FullScreen = false ;
			alert("文件上传失败"+returnValue);
		 }
	}catch(e){
		alert("异常\r\nError:"+e+"\r\nError Code:"+e.number+"\r\nError Des:"+e.description);
	}
}
</script>
<SCRIPT LANGUAGE=javascript>
var resourceId = '${resource.id}';
function WebOffice1_NotifyCtrlReady() {
	document.all.WebOffice1.OptionFlag |= 128;
	if(resourceId!=''){
		document.all.WebOffice1.LoadOriginalFile("<%=url%>/resource/download?id=${resource.id}", "${resource.filetype}");
	}
    document.all.WebOffice1.HideMenuArea("","","","");
    bToolBar_Save_onclick();//隐藏自带工具栏保存按钮。
}
var flag=false;
function menuOnClick(id){
	var id=document.getElementById(id);
	var dis=id.style.display;
	if(dis!="none"){
		id.style.display="none";
		
	}else{
		id.style.display="block";
	}
}
/****************************************************
*		接收office事件处理方法
****************************************************/
var vNoCopy = 0;
var vNoPrint = 0;
var vNoSave = 0;
var vClose=0;
function no_copy(){
	vNoCopy = 1;
}
function yes_copy(){
	vNoCopy = 0;
}

function no_print(){
	vNoPrint = 1;
}
function yes_print(){
	vNoPrint = 0;
}
function no_save(){
	vNoSave = 1;
}
function yes_save(){
	vNoSave = 0;
}
function EnableClose(flag){
 vClose=flag;
}
function CloseWord(){
  document.all.WebOffice1.CloseDoc(0); 
}

function WebOffice1_NotifyWordEvent(eventname) {
	if(eventname=="DocumentBeforeSave"){
		if(vNoSave){
			document.all.WebOffice1.lContinue = 0;
			alert("此文档已经禁止保存");
		}else{
			document.all.WebOffice1.lContinue = 1;
		}
	}else if(eventname=="DocumentBeforePrint"){
		if(vNoPrint){
			document.all.WebOffice1.lContinue = 0;
			alert("此文档已经禁止打印");
		}else{
			document.all.WebOffice1.lContinue = 1;
		}
	}else if(eventname=="WindowSelectionChange"){
		if(vNoCopy){
			document.all.WebOffice1.lContinue = 0;
		}else{
			document.all.WebOffice1.lContinue = 1;
		}
	}else   if(eventname =="DocumentBeforeClose"){
	    if(vClose==0){
	    	document.all.WebOffice1.lContinue=0;
	    } else{
	    	alert("word");
		    document.all.WebOffice1.lContinue = 1;
		  }
 }
}

function setDivSize(){
   $("#WebOffice1").height($("body").height()-180); 
 }
</SCRIPT>
</head>
  <body onresize="setDivSize();" >
  <div  id="docpane"  style="width: 98%; padding:10px ;height: 450px; ">
	 
     <form name="onlineEditForm" method="post" action="#">
     <input type="hidden" id="pid" name="pid" value="${resource.pid}"/>
     <input type="hidden" id="titleid" name="titleid" value="${resource.titleid}"/>
     <input type="hidden" id="id" name="id" value="${resource.id}"/>
		<div class="editorField">
		<div class="mailTo">
		<table cellspacing="0" class="composeTb">
			<colgroup>
				<col style="width: 80px; "/>
				<col/>
			</colgroup>
			<tbody>
				
				<tr>
					<th>标题</th>
					<td ><input style="height:22px;"  type="text" id="filealiasname" name="filealiasname" maxlength="127" value="${resource.filealiasname}" class="input_text"/></td>
				</tr>
				<c:if test="${fn:length(templates)> 0}">
				<tr>
					<th>文档模板</th>
					<td>
						<select id="templateSelect">
						<c:forEach items="${templates}" var="template">
							<option value="${template.id}">${template.tmpname}</option>
						</c:forEach>
						</select>
						&nbsp;
						<a href="#" onclick="loadMould();">装载模板</a>
					</td>
				</tr>
				</c:if>
			</tbody>
		</table>
		</div>
		<!-- 正文区 -->
		<div class="mailEdit">
		<script>
			var s = ""
			s += "<object id=WebOffice1  width='100%' height='100%' style='LEFT: 0px; TOP: 0px'  classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5' codebase='${base}/resource/weboffice/weboffice_v6.0.5.0.zip#Version=6,0,5,0'>"
			s +="<param name='_ExtentX' value='6350'><param name='_ExtentY' value='6350'>"
			s +="</OBJECT>"
			document.write(s)
		</script>
		
		<table cellspacing="0" class="composeTb" style="margin-top: 4px; ">
			<tbody>
				<tr>
				<td>
				
				 <div style="padding-top: 6px; padding-right: 0px; padding-bottom: 6px; padding-left: 0px; ">
					<fieldset class="cm_collapsed" id="lb">
					<legend onclick="document.onLabelClick(${resource.id});" class="collapse"><span>审核意见</span></legend>
					<div id="content" style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; border-top-width: 1px; border-top-style: dotted; border-top-color: rgb(221, 221, 221); " >
					<!-- 人员列表 -->	 
					</div>
					</fieldset>
				</div>
				
				</td>
				</tr>
			</tbody>
		</table>
		
		</div>
	</div>
	
</form>
<div class="actionbar_b btnL" >
	<input type="button" class="button" onclick="savedoc();" value=" 保 存 ">
	<input class="button" type="button" value=" 返 回 " onclick="history.back()"/>
	</div>
</div>

<script>
document.onLabelClick = function(resourceId){

	var div = document.getElementById("content");
	var label = document.getElementById("lb");
	var expanded = div.getAttribute("expanded");
	if(expanded){
		if(expanded=="true"){
		    label.className = "cm_collapsed";
		    div.style.display="none";
			div.setAttribute("expanded","false");
		}
		else{
      		label.className = "cm";
      		div.style.display="";
			div.setAttribute("expanded","true");
		}
	}
	else {
   		 label.className = "cm";
   		 
   		 $.ajax({
		    url: '${base}/resource/approvalhistory?resourceId='+resourceId,
		    cache:false,
		    dataType: 'json',
		    error: function(){
		    // alert('获取数据失败！');
		    },
		    success: function(json){
		     var data  = eval(json);
		     document.showComments(data);
		    }
		  });
	}
};


document.showComments=function(data){
	var div = document.getElementById("content");
	  if(data.length==0){
	   div.setAttribute("align","left");
	   div.innerHTML="当前没有审核说明.";
	  }
	  else{
	  	var table=document.createElement("table");
	  	table.setAttribute("width","100%");
	    table.cellSpacing = "0";
	    table.className = "entitleTb";
	    var tbody=document.createElement("tbody");
	  	table.appendChild(tbody);
	  	var _tr;
	  	for(var i=0;i<data.length && data[i]['result']>0 ;i++){
	  	    _tr = document.createElement("tr");
	  			tbody.appendChild(_tr);
	  			
	  		var td_result = document.createElement("td");
	  		td_result.innerHTML=data[i]['result']==1 ? '<span style="color:red">退回</span>' : '<span style="color:green">通过</span>';
	  		_tr.appendChild(td_result);
	  		
	  		var td_comment = document.createElement("td");
	  		td_comment.style.width = '50%';
	  		td_comment.innerHTML=data[i]['comments'];
	  		_tr.appendChild(td_comment);
	  		
	  		var td_checkername = document.createElement("td");
	  		td_checkername.innerHTML=data[i]['checkername'];
	  		_tr.appendChild(td_checkername);
	  		
	  		var td_checktime = document.createElement("td");
	  		td_checktime.innerHTML=data[i]['checktime'];	  		
	  		_tr.appendChild(td_checktime);
	  	}
	  	div.appendChild(table);
	 }
		div.setAttribute("expanded","true");
 	    div.style.display="";
};

	setDivSize();
function savedoc(){
   SaveToServer("save");
}

//装载模板文件

function loadMould(){
   var sel = document.getElementById("templateSelect");
   var templateId = sel.options[sel.selectedIndex].value;
   if (templateId == "-1"){alert("请选择模板文件");sel.focus();return;}
   var templateName  = sel.options[sel.selectedIndex].innerHTML;
   var docType = "";
   if (templateName.indexOf(".xls") > 0){docType = "xls"}
   if (templateName.indexOf(".doc") > 0){docType = "doc"}
   if (templateName.indexOf(".ppt") > 0){docType = "ppt"}
   if (docType==""){alert("错误的模板格式，请与管理员联系");return;}
   document.all.WebOffice1.LoadOriginalFile("<%=url%>/resource/loadtemplate?id="+templateId, docType);
   document.getElementById("filealiasname").value = templateName;
}
	
</script>
  </body>
</html>
