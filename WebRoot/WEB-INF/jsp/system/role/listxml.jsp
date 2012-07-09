<%@ page language="java" contentType="text/xml;charset=GBK" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><?xml version='1.0' encoding='GBK'?>
<rows> 
    <c:forEach items="${list}" var="role"  varStatus="i">  
        <row id="${role.roleId}"> 
            <cell>0</cell> 
            <cell>${role.roleId}</cell> 
            <cell><c:out value="<a class=link href=javascript:edit(${role.roleId});>${role.roleName}</a>" escapeXml="true"/></cell> 
            <cell>
            	<c:out value="<a class=link  href=javascript:edit(${role.roleId});>修改</a>" escapeXml="true"/> | 
            	<c:out value="<a class=link  href=javascript:del(${role.roleId});>删除</a>" escapeXml="true"/>  
            </cell>
        </row>
    </c:forEach>
</rows>