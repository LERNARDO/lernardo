<%@ page import="at.uenterprise.erp.lfa.Goal" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="administration">
		<g:set var="entityName" value="${message(code: 'goal.label', default: 'Goal')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="create-goal" class="content scaffold-create" role="main">
			<h1>Oberziel anlegen</h1>
			<g:hasErrors bean="${goalInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${goalInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save buttonGreen" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
