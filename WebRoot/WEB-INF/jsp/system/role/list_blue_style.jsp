<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<meta http-equiv="CacheControl" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
 
 
<title>选择用户组 - Burgeonsoft DocCare</title>
 
<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/blue.css">
<!--[if lt IE 7]>
<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/fixie.css">
<![endif]-->


</head>
<body scroll="no">
<div style="width:100%;height:100%;">
		<div class="miniTitle">选择用户组</div>
	<div  style="overflow: auto;">
		<div class="sPane" style="border-top:none">
		  <form name="selectRoleForm" id="rolesForm">
			<div style="border-left:1px solid #dedede;border-bottom:1px solid #dedede;margin-bottom:4px;">
			  <table id="roleList" width="100%"  cellspacing="0"  class="dcTb">
				<thead>
				  <tr>
					<td>用户组名</td>
					<td>描述</td>
					<td class="center">修改时间</td>
				  </tr>
				</thead>
				<tbody>
				  
					<tr>
					  <td width="30%">Approvers</td>
					  <td width="40%">Request Approvers.</td>
					  <td width="28%" class="center"><span title='2010年12月30日 上午06时15分33秒'>2010-12-30</span></td>
					</tr>
				  
					<tr>
					  <td width="30%">Customer</td>
					  <td width="40%">Customers</td>
					  <td width="28%" class="center"><span title='2010年12月30日 上午06时15分33秒'>2010-12-30</span></td>
					</tr>
				  
					<tr value="4">
					  <td width="30%">Department manager</td>
					  <td width="40%">Managers of a department</td>
					  <td width="28%" class="center"><span title='2010年12月30日 上午06时15分33秒'>2010-12-30</span></td>
					</tr>
				  
					<tr value="3">
					  <td width="30%">Department member</td>
					  <td width="40%">Members of a department</td>
					  <td width="28%" class="center"><span title='2010年12月30日 上午06时15分33秒'>2010-12-30</span></td>
					</tr>
				  
					<tr value="7">
					  <td width="30%">q</td>
					  <td width="40%">q</td>
					  <td width="28%" class="center"><span title='2011年8月15日 下午02时01分21秒'>2011-8-15</span></td>
					</tr>
				  
					<tr value="1">
					  <td width="30%">系统管理员</td>
					  <td width="40%">系统管理员</td>
					  <td width="28%" class="center"><span title='2010年12月30日 上午06时15分33秒'>2010-12-30</span></td>
					</tr>
				  
					<tr value="2">
					  <td width="30%">县局营销专职</td>
					  <td width="40%">县局营销专职</td>
					  <td width="28%" class="center"><span title='2010年12月30日 上午06时15分33秒'>2010-12-30</span></td>
					</tr>
				  
				</tbody>
			  </table>
				<div class="actionbar_b btnL">
					<button  onclick='document.doneSelect()'><span class="thinbtn">完成</span></button>
					<button  onclick='window.close()'><span class="thinbtn">取消</span></button>
				</div>
			</div>
		  </form>
		</div>
	</div>
</div>
<script language="JavaScript" type="text/javascript">reconcileEventHandlers();</script>
</body>
</html>
