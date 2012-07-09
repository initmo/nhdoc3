<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="CacheControl" content="no-cache">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<title>文档审核</title>
		<script src="${base}/resource/common/js/jquery-1.4.2.min.js"></script>
		<link rel=stylesheet type=text/css href="${base}/resource/common/css/style.css"></link>
		<!--[if lt IE 7]>
		<link rel="stylesheet" type="text/css" href="${base}/resource/admin/css/fixie.css">
		<![endif]-->
	</head>
	<body scroll="no">
		<div class="miniTitle">文档审核</div>
		<div class="sPane">
			<div style="height: 4px"></div>
			<div class="dcTbContainer bgSpecial upWrap"
				style="margin: 0px 4px 4px 4px">
				<form id="form" action="${base}/resource/approval" method="post">
					<input name="id" type="hidden" value="${resourceApproval.id}" />
					<table class="aloneTb" cellspacing="0" width="100%">
						<tbody>
							<tr>
								<th>
									文档名称
								</th>
								<td>
									<a title="点击查看"
										href="${base}/resource/download?id=${resourceApproval.resourceid}">${resourceApproval.resourcename}</a>
								</td>
							</tr>
							<tr>
								<th>
									审&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;核
								</th>
								<td>
									<label for="approvalresult1">通过</label>
									<input type="radio" checked="checked" id="approvalresult1" value="1" name="approvalFlag">
									&nbsp;&nbsp;
									<label for="approvalresult2">退回</label>
									<input type="radio" id="approvalresult2" value="0"name="approvalFlag">
								</td>
							<tr>
							<tr>
								<th>审核意见</th>
								<td>
									<textarea name="comments" class="input_text"style="height: 60px; width: 320px; "></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="actionbar_b " style="margin-top: 10px;">
						<input class=button style="height: 25px;float: left;width: 80px"
							type="submit" value="完 成 " />
						<input class=button style="height: 25px;float: left;width: 80px"
							type="button" onclick="history.back()" value="取消 " />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
