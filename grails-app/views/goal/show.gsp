
<%@ page import="at.uenterprise.erp.lfa.Goal" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="administration">
		<g:set var="entityName" value="${message(code: 'goal.label', default: 'Goal')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-goal" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-goal" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list goal">
			
				<g:if test="${goalInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="goal.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${goalInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${goalInstance?.dateFrom}">
				<li class="fieldcontain">
					<span id="dateFrom-label" class="property-label"><g:message code="goal.dateFrom.label" default="Date From" /></span>
					
						<span class="property-value" aria-labelledby="dateFrom-label"><g:formatDate date="${goalInstance?.dateFrom}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${goalInstance?.dateTo}">
				<li class="fieldcontain">
					<span id="dateTo-label" class="property-label"><g:message code="goal.dateTo.label" default="Date To" /></span>
					
						<span class="property-value" aria-labelledby="dateTo-label"><g:formatDate date="${goalInstance?.dateTo}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${goalInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="goal.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${goalInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${goalInstance?.situations}">
				<li class="fieldcontain">
					<span id="situations-label" class="property-label"><g:message code="goal.situations.label" default="Situations" /></span>
					
						<g:each in="${goalInstance.situations}" var="s">
						<span class="property-value" aria-labelledby="situations-label"><g:link controller="situation" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${goalInstance?.id}" />
					<g:link class="edit" action="edit" id="${goalInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
