<%@ page language="java" contentType="text/xml;charset=GBK" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><?xml version='1.0' encoding='GBK'?>
<rows> 
    <userdata name="parent_pid">${parent.pid}</userdata> 
    <userdata name="parent_id">${parent.id}</userdata> 
    <c:forEach items="${list}" var="resourceinfo"  varStatus="i">  
        <row id="${resourceinfo.id}"> 
            <userdata name="isdir">${resourceinfo.isdir}</userdata> 
            <cell>0</cell> 
            <cell>${resourceinfo.id}</cell> 
            <cell>${resourceinfo.approvalstatus}.png</cell> 
            <cell>${resourceinfo.filetype}.gif</cell>       
            <cell><c:if test="${newdate >= resourceinfo.modifiedtime}"><c:out value="<a class=link href=javascript:showResourceInfo(${resourceinfo.id});>  ${resourceinfo.filealiasname}</a>" escapeXml="true"/></c:if><c:if test="${newdate < resourceinfo.modifiedtime}"><c:out value="<a class=linkbold href=javascript:showResourceInfo(${resourceinfo.id});>  ${resourceinfo.filealiasname}</a>" escapeXml="true"/></c:if></cell> 
            <cell>${resourceinfo.filesize}</cell> 
            <cell>${resourceinfo.creator}</cell> 
            <cell><fmt:formatDate value="${resourceinfo.modifiedtime}" type="both"/></cell> 
            <cell><c:out value="<a class=link  href=javascript:editResourceInfo(${resourceinfo.id},${resourceinfo.isdir});>修改</a>" escapeXml="true"/> | <c:out value="<a class=link  href=javascript:delResourceInfo(${resourceinfo.id});>删除</a>" escapeXml="true"/>  
            </cell>
        </row>
    </c:forEach>
</rows>