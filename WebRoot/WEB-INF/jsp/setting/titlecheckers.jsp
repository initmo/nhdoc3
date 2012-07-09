<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
	<title>审核授权</title>
	<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
	<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
	<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
</head>
<body>
<div id="docpane" class="rightPane" style=" width: 100%; height: 463px;" >


<div class="borderlineTop">
  <div class="dcTbContainer">
    <form:form id="form"  action="${base}/setting/treesave" method="post">
    <input type="hidden" id="checkerIds" name="checkerIds" value="${checkerIds}"/>
      <table class="aloneTb" style="width: 97%"  cellspacing="0" >
        <tbody>
        
         <tr>
          <td>
          是否需要审核:
           <label for="isApproval1">是</label><input type="radio"  <c:if test="${title.isApproval}">checked="checked"</c:if> id="isApproval1" value="1" name="isApproval" >
           <label for="isApproval0">否</label><input type="radio" <c:if test="${not title.isApproval}">checked="checked"</c:if>id="isApproval0" value="0" name="isApproval">
          </td>
        </tr>
        
        <tr>
          <td>
      
    <c:forEach items="${actDepartments}" var="dept">           
    <div name="div_actdepartments" style="padding-top: 6px; padding-right: 0px; padding-bottom: 6px; padding-left: 0px; ">
		<fieldset class="cm_collapsed" id="lb_${dept.deptId}">
		<legend onclick="document.onLabelClick(${dept.deptId})" class="collapse"><span>${dept.deptName}</span></legend>
		<div id="_${dept.deptId}" style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; border-top-width: 1px; border-top-style: dotted; border-top-color: rgb(221, 221, 221); " >
		<!-- 人员列表 -->	 
		</div>
		</fieldset>
	</div>
	</c:forEach>
	
          </td>
        </tr>
     
        <tr class="last">
          <td>
            <div style="padding-top: 6px;" class="bobox btnL">
	            <input class="button" type="submit" onclick="document.doSave();return false;" value=" 保 存 "/>
		        <input class="button" type="button" value=" 返 回 " onclick="history.back()"/>
            </div>
          </td>
        </tr>
      </tbody></table>
 </form:form>
  </div>
</div>
</div>

<script>
document.onLabelClick = function(deptId){

	var div = document.getElementById("_"+deptId);
	var label = document.getElementById("lb_"+deptId);
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
		    url: '${base}/setting/titlecheckers/checkers?t='+new Date()+'&deptId='+deptId,
		    dataType: 'json',
		    error: function(){
		     alert('获取数据失败！');
		    },
		    success: function(json){
		     var checkers  = eval(json);
		     document.showCheckers(checkers,deptId);
		    }
		  });
	}
}

document.showCheckers=function(checkers,deptId){
	var div = document.getElementById("_"+deptId);
	  if(checkers.length==0){
	   div.setAttribute("align","left");
	   div.innerHTML="No users in this department.";
	  }
	  else{
	  	var table=document.createElement("table");
	  	table.setAttribute("width","100%");
	    table.cellSpacing = "0";
	    table.className = "entitleTb";
	    var tbody=document.createElement("tbody");
	  	table.appendChild(tbody);
	  	var _tr;
	  	for(var i=0;i<checkers.length;i++){
	  	    if(i%8 == 0){
	  	    	_tr = document.createElement("tr");
	  			tbody.appendChild(_tr);
	  	    }
	  		var td = document.createElement("td");
	  		var checkflag = document.getCheckFlag(checkers[i]['userId']);
	  		if (checkflag) td.className = "selected";
	  		td.innerHTML=document.createCheckbox(checkers[i]['userId'],checkers[i]['userName'],checkflag);
	  		_tr.appendChild(td);
	  	}
	  	div.appendChild(table);
	 }
		div.setAttribute("expanded","true");
 	    div.style.display="";
}

document.getCheckFlag = function(userId){
	var checkerIds =  document.getElementById("checkerIds").value;
	var checkerIdArray = checkerIds.split(",");
	if ($.inArray(userId, checkerIdArray) > -1) return true;
	return false;
}

document.createCheckbox=function(userId,userName,checkflag){
  var checkbox="<input id=ck"+userId+" type='checkbox' value='"+userId+"'  onclick='document.onClickCheckbox(this)' ";
  if (checkflag)
   checkbox = checkbox + " checked ";
   checkbox = checkbox + "/><label class=red for=ck"+userId+">"+userName+"</label>";	
  return checkbox;
}

document.onClickCheckbox = function(obj){
	var checkerIdsObj =  document.getElementById("checkerIds");
	var checkerIds = checkerIdsObj.value;
	var checkerIdArray = checkerIds.split(",");
	
	var td = obj.parentNode;
	if(obj.checked){
		checkerIdsObj.value = checkerIds + ","+ obj.value ;
		td.className = "selected";
	}
	else {
		checkerIdsObj.value = checkerIds.replace(","+ obj.value,"");
		td.className = "";
	}
	
}

document.doSave = function(){
    var isApproval = $("#isApproval1").attr("checked") ;
	$.ajax({
		url:"${base}/setting/titlecheckers/save",
		type:"POST",
		data:{"titleId":"${titleId}","checkerIds":$("#checkerIds").val(),"isApproval":isApproval},
		success:function(data){
			if(data=="succ")alert("保存成功");
			else alert("保存失败");
		}
	});

}


$(function(){
    if  ($("#isApproval1").attr("checked")){
   		 $("div[name='div_actdepartments']").show();
    }else{
    	$("div[name='div_actdepartments']").hide();
    }
    
	$("input[name='isApproval']").bind("click",function(){
			var isApproval = ($(this).val() == 1);
			if(isApproval){
			$("div[name='div_actdepartments']").show();
			}else{
			$("div[name='div_actdepartments']").hide();
			}
		});
})
</script>
</body>
</html>