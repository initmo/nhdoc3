<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
	<title>授权</title>
	<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
	<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
	<script type="text/javascript" src="${base}/resource/common/js/common.js"></script>
</head>
<body>
<div id="docpane" class="rightPane" style=" width: 100%; height: 463px;" >


<div class="borderlineTop">
  <div class="dcTbContainer">
    <form:form id="form"  action="${base}/setting/treesave" method="post">
    <input type="hidden" id="actorIds" name="actorIds" value="${actorIds}"/>
      <table class="aloneTb" style="width: 97%"  cellspacing="0" >
        <tbody>
        <tr>
          <td>
      
    <c:forEach items="${actDepartments}" var="dept">           
    <div style="padding-top: 6px; padding-right: 0px; padding-bottom: 6px; padding-left: 0px; ">
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
		    url: '${base}/setting/titleactors/actors?t='+new Date()+'&deptId='+deptId,
		    dataType: 'json',
		    error: function(){
		     alert('获取数据失败！');
		    },
		    success: function(json){
		     var actors  = eval(json);
		    // alert("actors.length"+actors.length);
		     document.showActiors(actors,deptId);
		    }
		  });
	}
}

document.showActiors=function(actors,deptId){
	var div = document.getElementById("_"+deptId);
	  if(actors.length==0){
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
	  	for(var i=0;i<actors.length;i++){
	  	    if(i%8 == 0){
	  	    	_tr = document.createElement("tr");
	  			tbody.appendChild(_tr);
	  	    }
	  		var td = document.createElement("td");
	  		var checkflag = document.getCheckFlag(actors[i]['userId']);
	  		if (checkflag) td.className = "selected";
	  		td.innerHTML=document.createCheckbox(actors[i]['userId'],actors[i]['userName'],checkflag);
	  		_tr.appendChild(td);
	  	}
	  	div.appendChild(table);
	 }
		div.setAttribute("expanded","true");
 	    div.style.display="";
}

document.getCheckFlag = function(userId){
	var actorIds =  document.getElementById("actorIds").value;
	var actorIdArray = actorIds.split(",");
	if ($.inArray(userId, actorIdArray) > -1) return true;
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
	var actorIdsObj =  document.getElementById("actorIds");
	var actorIds = actorIdsObj.value;
	var actorIdArray = actorIds.split(",");
	
	var td = obj.parentNode;
	if(obj.checked){
		actorIdsObj.value = actorIds + ","+ obj.value ;
		td.className = "selected";
	}
	else {
		actorIdsObj.value = actorIds.replace(","+ obj.value,"");
		td.className = "";
	}
	
}

document.doSave = function(){
	$.ajax({
		url:"${base}/setting/titleactors/save",
		type:"POST",
		data:{"titleId":"${titleId}","actorIds":$("#actorIds").val()},
		success:function(data){
			if(data=="succ")alert("保存成功");
			else alert("保存失败");
		}
	});
}
</script>
</body>
</html>