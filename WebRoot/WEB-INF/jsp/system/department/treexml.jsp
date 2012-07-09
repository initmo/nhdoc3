<%@ page language="java" contentType="text/xml; charset=UTF-8"	pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><?xml version='1.0' encoding='UTF-8'?>
<tree id='${pid}'>
<c:forEach  items="${list}" var="department">
	<item child='${department.hasChild? 1 : 0}' id='${department.deptId}' text='${department.deptName}'/>
</c:forEach>
</tree>