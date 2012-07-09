<%@ page language="java" contentType="text/html;charset=GBK" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>


<script>
function changepasswordwin(url,w,h){ 
var weight,height;
	if (w>0)  width = w; else width = 720;
	if (h>0)  height = h; else height = 720;
	var oleft=""+(screen.width-width)/2;
	var otop=""+((screen.height-height)/2-100);
	$.XYTipsWindow({
		___width:w,
		___height:h,
		___title:"<strong>修改密码</strong>",
		___drag:"___boxTitle",
		___content:"iframe:"+url
		
	});
}
</script>
<DIV id="topmenu" >
<!-- 顶部右侧项目开始 -->
	<DIV class=mainTop>
		<!-- <DIV id=logo><SPAN  CLASS="title" style="margin-left: 200px"><h2 style="font-family: 黑体;font-size: 22px">标准化供电(营业)所资料管理平台</h2></SPAN></DIV>-->
		<DIV id=topbar>
			<SPAN class=n>${sessionScope.sessionUser.deptName}：${sessionScope.sessionUser.userName}</SPAN>
			<SPAN class=sp>| </SPAN><A href="javascript:void(0);" onclick="changepasswordwin('${base}/changepassword',430,250);" >修改密码</A>
			<SPAN class=sp>| </SPAN><a href="${base}/logout" target="_top" id="logout" onclick="return confirm('确定要退出系统吗？');">注销</a>
			<SPAN class=sp>| </SPAN>
		</DIV>
	</DIV>
	<!-- 顶部右侧项目结束 -->
	<!-- 菜单导航开始 -->
	<DIV id=menubar>
		<DIV class=barwrap>
			<UL id=tnav>
				<shiro:hasPermission name="menu:resource">
				<LI id="resource"><A href="${base}/resource/">文档库</A></LI>
				</shiro:hasPermission>
				<shiro:hasPermission name="menu:setting">
				<LI id="setting"><A href="${base}/setting/">文档设置</A></LI>
				</shiro:hasPermission>
				<shiro:hasPermission name="menu:orgnizationa">
				<LI id='department'><A href="${base}/system/orgnizationa">用户和机构</A></LI>
				</shiro:hasPermission>		
			</UL>
		</DIV>
	</DIV>
	<!-- 菜单导航结束 -->
</DIV>	
<DIV  id="footer"  class=footer>nhsoft <SPAN class=sp> |</SPAN> 2010	</DIV>
<script>
var module = '${module}'; 
document.getElementById(module).className="active";

function closeChangepasswordWin(){
	$.XYTipsWindow.removeBox();
}


</script>
