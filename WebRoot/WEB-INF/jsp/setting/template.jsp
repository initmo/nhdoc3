<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
	<HEAD>
		<TITLE>文档模板</TITLE>
		<META content="text/html; charset=GBK" http-equiv=content-type>
		<META content=no-cache http-equiv=CacheControl>
		<META content=no-cache http-equiv=Pragma>
		<META content=-1 http-equiv=Expires>

		<!-- for dhtmlxLayout -->
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.css">
		<link rel="stylesheet" type="text/css" href="${base}/resource/dhx/dhtmlxLayout/skins/dhtmlxlayout_dhx_skyblue.css">
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcommon.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxlayout.js"></script>
		<script src="${base}/resource/dhx/dhtmlxLayout/dhtmlxcontainer.js"></script>
		
		
		<link href="${base}/resource/common/css/eos.css" type="text/css" rel="stylesheet" >
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>

</head>
<BODY>
<div id="itemlist" style="width: 100%; height: 100%; overflow: auto; display: none; font-family: Tahoma; font-size: 11px;">

<table  width="98%" align="center"  bgcolor="#d0e8ee" style="margin-top: 3px;margin-bottom: 3px">
<tr><td><strong>&nbsp;&nbsp;&nbsp;&nbsp;<font size="2" color="#666666">模板文件</font></strong></td></tr>
</table>


<table CLASS="EOS_TABLE" width="98%" align="center">
<c:if test="${fn:length(list) > 0 }">
 <tr height="24">
	<th height="22" width="3%" align="center">
		<input type=checkbox name=selectcheckbox  onClick='selecAlltItem(this)'>
	</th>
	
	<th width="40%" align="center">
		名&nbsp;&nbsp;&nbsp; 称
	</th>
	<th width="17%" align="center">
		修改日期
	</th>
	<th width="10%" align="center">
		创建人
	</th>
	
	<th width="16%" align="center">
		操作
	</th>
 </tr>
</c:if>


<c:forEach items="${list}" var="template"  varStatus="i">  
<tr id="tr_${template.id}" itemid="${template.id}"  onMouseOver="mOvr(this,'#F0F9FE');" onMouseOut="mOut(this,'#F7FDFD');">

		<!-- checkbox-->
		<td style="text-align: center;height: 27px"><input type=checkbox itemid="${template.id}" name=selectcheckbox id="${template.id}" onClick='selectItem(this.id)'></td>

		<!-- 资料名称 -->
		<td align="left" style="padding-left: 10px">
		     <img align="center" border="0" src="${base}/resource/common/img/file/${template.filetype}.gif" width="16" height="16" alt="${template.tmpname}">
			  <a  href="${base}/setting/template/download?id=${template.id}"  style="vertical-align: middle">
			  	 ${template.tmpname}</a>		
		</td>
		<!-- 修改时间 -->
		<td  style="text-align: center;"><fmt:formatDate value="${template.uploadtime}" pattern="yyyy-MM-dd MM:ss"/>  </td>
		<!-- 备注 -->
		<td  style="text-align: center;">${template.remark}</td>

        <!-- 操作  -->
		<td style="text-align: center;">
			 <a  href="javascript:docEdit('${template.id}','${template.id}');" style="vertical-align: middle">
				编辑
			</a> |
			<a  href="javascript:del(${template.id});" style="vertical-align: middle">
				删除
			</a> 
		</td>
</tr>
</c:forEach>
						
</table>


<table CLASS="EOS_TABLE" width="98%" align="center" style="margin-top: 20px;">
 
 <tr height="24"><td>

 <div align="left" style="margin:20px; width: 98%">
	<form method="post" action="${base}/setting/template/upload" enctype="multipart/form-data">
	
	    <input type="hidden" name="titleId" value="${title.id}">
	    <span style="font-size: 12px;font-weight: bold;margin-right: 15px">上传模板:</span><a href="#" onclick="addItem();">[+ 增 加 ]</a>	
        <span id="upload"></span>
        <br/> 
        <input type="submit" value=" 开始上传 "/>
        
    </form>
    
</div>
</td>
</tr>
</table>
<script type="text/javascript">
    var attachname = "attach";
    var i=1;
      function   addItem(){
        if(i>0){
              var attach = attachname + i ;
              if(createItem(attach))
                  i=i+1;
          }
      } 
      function createItem(nm){   
      var inputhtml = "<input type='file' name='"+nm+"' size='50'>"+
                      
                      "<a href=# onclick='rmItem(this);'>删除</a><br/>";
      var item  = document.createElement("div");
      item.id = "div_"+nm;
      item.innerHTML  = inputhtml;
      if(document.getElementById("upload").appendChild(item) == null)
             return false;
      return true;
      }  

     function rmItem(sender){
     	var div = sender.parentNode;
     	var holder = document.getElementById("upload");
        holder.removeChild(div);
     }
     

</script>
</div>					


<script>
function docEdit(id,typeName){
    var fm = document.getElementById("docedit");
    fm.action = "<%=request.getContextPath()%>/kc/ItemAction.17?method=docEdit&id="+id+"&docType="+typeName
    var urlinput = document.getElementById("url");
    urlinput.value = window.location.href;
    fm.submit();
}

function docNew(ItemSettingId){
    var fm = document.getElementById("docedit");
    fm.action = "<%=request.getContextPath()%>/kc/ItemAction.17?method=newDoc&menuId="+ItemSettingId;
    var urlinput = document.getElementById("url");
    urlinput.value = window.location.href;
    fm.submit();
}


function mOvr(src,clrOver){ 
  if (!src.contains(event.fromElement)){ 
  src.bgColor = clrOver; 
  }
}
function mOut(src,clrIn){ 
	if (!src.contains(event.toElement)) { 
		src.style.cursor = 'default'; 
		src.bgColor = clrIn; 
	}
}

function selectItem(id){
   if ($("#"+id).attr("checked")){
     $("#tr_"+id).css("background-color","#ffe2a5");
    }
   else
    $("#tr_"+id).css("background-color","");
}

function selecAlltItem(cb){
	$(":checkbox").each(function(){
	var id = $(this).attr("id") ;
	if(id!="" && $(cb).attr("checked")){
		 $("#tr_"+id).css("background-color","#ffe2a5");
		 $("#tr_"+id).css("background-color","#ffe2a5");
		 $(this).attr("checked","checked") ;
		 }
	else if (id!="" && !$(cb).attr("checked")){
	   $("#tr_"+id).css("background-color","");
	   $(this).attr("checked","") ;
	}
	});
}

function del(fileId){
  var form = createForm('post','${base}/setting/template/delete');
  addparam('titleId',${title.id},form);
  addparam('id',fileId,form); 
  form.submit();
}

function batchDelete(){
  var form = createForm('post',"${base}/setting/template/delete");
  $("input:checked").each(function(){
	if($(this).attr("id"))
		addparam('ids',$(this).attr("id"),form);
	})      
  addparam('titleId',${title.id},form);
  form.submit();
}

var dhxLayout, webBar1,dhxAccord,dhxTree,dbxGrid,_nodeid,statusBar;
//加载框架
function doOnLoad() {
    dhxLayout = new dhtmlXLayoutObject(document.body,"1c");
    dhxLayout.cells("a").hideHeader();
    dhxLayout.cells("a").attachObject("itemlist");
    dhxLayout.cells("a").fixSize(false,true);
    statusBar = dhxLayout.cells("a").attachStatusBar();
}
$(function(){
   doOnLoad();
   statusBar.setText("共 "+${fn:length(list)}+"  条");
})
</script>
</BODY>
</HTML>