<%@ page language="java" contentType="text/xml;charset=GBK" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><?xml version='1.0' encoding='GBK'?>
<rows> 
    <userdata name="pageSize">${pagination.pageSize}</userdata> 
    <userdata name="pageNo">${pagination.pageNo}</userdata> 
    <userdata name="totalCount">${pagination.totalCount}</userdata> 
    <userdata name="totalPage">${pagination.totalPage}</userdata> 
    <c:forEach items="${pagination.list}" var="resourceinfo"  varStatus="i">  
        <row id="${resourceinfo.id}"> 
            <userdata name="isdir">${resourceinfo.isdir}</userdata> 
            <userdata name="titleid">${resourceinfo.titleid}</userdata> 
            <cell>0</cell> 
            <cell>${resourceinfo.id}</cell> 
            <cell>${resourceinfo.approvalstatus}.png</cell> 
            <cell> ${resourceinfo.filetype}.gif</cell>       
            <cell><c:out value="<a class=link href=javascript:showResourceInfo(${resourceinfo.id});>${resourceinfo.filealiasname}</a>" escapeXml="true"/></cell> 
            <cell>${resourceinfo.filesize}</cell> 
            <cell>${resourceinfo.creator}</cell> 
            <cell><fmt:formatDate value="${resourceinfo.modifiedtime}" type="both"/></cell> 
            <cell>
            	<c:out value="<a class=link  href=javascript:toDir(${resourceinfo.titleid},${resourceinfo.pid});>转到</a>" escapeXml="true"/>  
            </cell>
        </row>
    </c:forEach>
</rows>