<%@ page language="java" contentType="text/xml;charset=GBK" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><?xml version='1.0' encoding='GBK'?>
<rows> 
    <c:forEach items="${list}" var="department"  varStatus="i">  
        <row id="${role.roleId}"> 
            <cell>0</cell> 
            <cell>${department.deptId}</cell> 
            <cell><c:out value="<a class=link href=javascript:edit(${department.deptId});>${department.deptName}</a>" escapeXml="true"/></cell> 
            <cell>${department.pid}</cell> 
            <cell>
            	<c:out value="<a class=link  href=javascript:edit(${department.deptId});>修改</a>" escapeXml="true"/> | 
            	<c:out value="<a class=link  href=javascript:del(${department.deptId});>删除</a>" escapeXml="true"/>  
            </cell>
        </row>
    </c:forEach>
</rows>