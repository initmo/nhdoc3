<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<table style="border: 1px solid; width: 500px; text-align:center">
	<thead style="background:#fcf">
		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Money</th>
			<th colspan="3">Operation</th>
		</tr>
	</thead>
	<tbody>
	<#list persons as person>
		<tr>
			<td>${person.firstName}</td>
			<td>${person.lastName}</td>
			<td>${person.money}</td>
			<td><a href="persons/edit/${person.id}">Edit</a></td>
			<td>Delete</td>
			<td>Add</td>
		</tr>
	</#list>
	</tbody>
</table>
</body>
</html>