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
		___title:"<strong>�޸�����</strong>",
		___drag:"___boxTitle",
		___content:"iframe:"+url
		
	});
}
</script>
<DIV id="topmenu" >
<!-- �����Ҳ���Ŀ��ʼ -->
	<DIV class=mainTop>
		<!-- <DIV id=logo><SPAN  CLASS="title" style="margin-left: 200px"><h2 style="font-family: ����;font-size: 22px">��׼������(Ӫҵ)�����Ϲ���ƽ̨</h2></SPAN></DIV>-->
		<DIV id=topbar>
			<SPAN class=n>${sessionScope.sessionUser.deptName}��${sessionScope.sessionUser.userName}</SPAN>
			<SPAN class=sp>| </SPAN><A href="javascript:void(0);" onclick="changepasswordwin('${base}/changepassword',430,250);" >�޸�����</A>
			<SPAN class=sp>| </SPAN><a href="${base}/logout" target="_top" id="logout" onclick="return confirm('ȷ��Ҫ�˳�ϵͳ��');">ע��</a>
			<SPAN class=sp>| </SPAN>
		</DIV>
	</DIV>
	<!-- �����Ҳ���Ŀ���� -->
	<!-- �˵�������ʼ -->
	<DIV id=menubar>
		<DIV class=barwrap>
			<UL id=tnav>
				<shiro:hasPermission name="menu:resource">
				<LI id="resource"><A href="${base}/resource/">�ĵ���</A></LI>
				</shiro:hasPermission>
				<shiro:hasPermission name="menu:setting">
				<LI id="setting"><A href="${base}/setting/">�ĵ�����</A></LI>
				</shiro:hasPermission>
				<shiro:hasPermission name="menu:orgnizationa">
				<LI id='department'><A href="${base}/system/orgnizationa">�û��ͻ���</A></LI>
				</shiro:hasPermission>		
			</UL>
		</DIV>
	</DIV>
	<!-- �˵��������� -->
</DIV>	
<DIV  id="footer"  class=footer>nhsoft <SPAN class=sp> |</SPAN> 2010	</DIV>
<script>
var module = '${module}'; 
document.getElementById(module).className="active";

function closeChangepasswordWin(){
	$.XYTipsWindow.removeBox();
}


</script>
