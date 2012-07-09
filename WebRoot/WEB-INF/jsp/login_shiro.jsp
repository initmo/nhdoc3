<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Apache Shiro Spring-Hibernate Sample Application</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resource/css/login.css"/>"/> 
	<script type="text/javascript">
	if(top!=this) {
		top.location=this.location;
	}
	</script>
</head>
<body>
    <div id="box">
        <div class="title">Apache Shiro Sample App - Login</div>

        <div class="content">
            <form:form modelAttribute="loginCommand">

                <form:errors path="*" element="div" cssClass="errors"/>

                <div><div class="form-label">Username:</div><form:input path="username"/></div>
                <div><div class="form-label">Password:</div><form:password path="password"/></div>
                <div><form:checkbox path="rememberMe"/> Remember Me</div>
                <div><input type="submit" value="Login"/></div>
            </form:form>

            <div>Don't have an account? <a href="<c:url value="/s/signup"/>">注册</a></div>
        </div>
    </div>

    <p>
        Users created through the signup form have the role "user".  You can also log in as admin/admin, which has the
        "admin" role.
    </p>

    <script type="text/javascript">
        document.getElementById('username').focus();
    </script>

</body>
</html>
