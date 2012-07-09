<%@ page language="java" contentType="text/xml; charset=UTF-8"	pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><?xml version='1.0' encoding='UTF-8'?>
<tree id='${pid}'>
<c:forEach  items="${list}" var="tree">
	<item child='${tree.child}' id='${tree.id}' text='${tree.text}' im0="folderClosed.gif" im1="folderClosed.gif"  im2="folderClosed.gif"/>
</c:forEach>
</tree>