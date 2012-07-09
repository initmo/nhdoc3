<%@ page language="java" contentType="text/xml;charset=GBK" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><?xml version='1.0' encoding='GBK'?>
<rows> 
    <c:forEach items="${list}" var="user"  varStatus="i">  
        <row id="${user.userId}"> 
            <cell>0</cell> 
            <cell>${user.userId}</cell> 
            <cell><c:out value="<a class=detail href=javascript:editUser(${user.userId});>${user.loginName}</a>" escapeXml="true"/></cell> 
            <cell><c:out value="${user.userName}" /></cell>
            <cell><c:out value="${user.roleNames}" /></cell>
            <cell><c:out value="${user.deptName}" /></cell>
            <cell>
            	<c:out value="<a class=link  href=javascript:setUserTitle(${user.userId});>文档授权</a>" escapeXml="true"/> | 
            	<c:out value="<a class=link  href=javascript:editUser(${user.userId});>修改</a>" escapeXml="true"/> | 
            	<c:out value="<a class=link  href=javascript:delUser(${user.userId});>删除</a>" escapeXml="true"/>  
            </cell> 
        </row>
    </c:forEach>
</rows>
 
