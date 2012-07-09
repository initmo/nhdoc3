<%@ page language="java" contentType="text/xml;charset=GBK" %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><?xml version='1.0' encoding='GBK'?>
<rows> 
	<userdata name="pageSize">${pagination.pageSize}</userdata> 
    <userdata name="pageNo">${pagination.pageNo}</userdata> 
    <userdata name="totalCount">${pagination.totalCount}</userdata> 
    <userdata name="totalPage">${pagination.totalPage}</userdata> 
    <c:forEach items="${pagination.list}" var="approvalrequest"  varStatus="i">  
        <row id="${approvalrequest.id}"> 
            <cell>0</cell> 
            <cell>${approvalrequest.id}</cell> 
            <cell>approval${approvalrequest.result}.png</cell> 
            <cell>${approvalrequest.filetype}.gif</cell>       
            <cell><c:out value="<a class=link href=javascript:showResourceInfo(${approvalrequest.resourceid});>${approvalrequest.resourcename}</a>" escapeXml="true"/></cell> 
            <cell><c:out value="${approvalrequest.comments}"/></cell> 
            <cell><fmt:formatDate value="${approvalrequest.sendTime}" type="both"/></cell> 
            <cell>${approvalrequest.checktime}</cell> 
            <cell>${approvalrequest.actor}</cell> 
            <cell>${approvalrequest.actdeptname}</cell> 
            <cell><c:out value="<a class=link href=javascript:viewApproval(${approvalrequest.id});>[详评]</a>" escapeXml="true"/></cell> 
        </row>
    </c:forEach>
</rows>