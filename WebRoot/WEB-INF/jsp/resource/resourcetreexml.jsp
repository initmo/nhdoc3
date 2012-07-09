<%@ page language="java" contentType="text/xml; charset=UTF-8"	pageEncoding="UTF-8"%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%><?xml version='1.0' encoding='UTF-8'?>
<tree id='${pid}'>
<c:forEach  items="${list}" var="resourcetree">
	<item child='${resourcetree.child? 1 : 0}' id='${resourcetree.id}' text='${resourcetree.treeName}'  im0="${resourcetree.pid == 0? 'iconSafe' : 'book'}.gif"   im1="${resourcetree.pid == 0? 'iconSafe' : 'folderOpen'}.gif" im2="${resourcetree.pid == 0? 'iconSafe' : 'folderClosed'}.gif">
	 <userdata name="groupId">${resourcetree.groupId}</userdata> 
	 </item>
</c:forEach>
</tree>