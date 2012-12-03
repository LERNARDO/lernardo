
<%@ page import="at.uenterprise.erp.lfa.Situation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'situation.label', default: 'Situation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-situation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-situation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list situation">
			
				<g:if test="${situationInstance?.actions}">
				<li class="fieldcontain">
					<span id="actions-label" class="property-label"><g:message code="situation.actions.label" default="Actions" /></span>
					
						<g:each in="${situationInstance.actions}" var="a">
						<span class="property-value" aria-labelledby="actions-label"><g:link controller="entity" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${situationInstance?.expectedResult}">
				<li class="fieldcontain">
					<span id="expectedResult-label" class="property-label"><g:message code="situation.expectedResult.label" default="Expected Result" /></span>
					
						<span class="property-value" aria-labelledby="expectedResult-label"><g:fieldValue bean="${situationInstance}" field="expectedResult"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${situationInstance?.goals}">
				<li class="fieldcontain">
					<span id="goals-label" class="property-label"><g:message code="situation.goals.label" default="Goals" /></span>
					
						<g:each in="${situationInstance.goals}" var="g">
						<span class="property-value" aria-labelledby="goals-label"><g:link controller="goal" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${situationInstance?.indicator}">
				<li class="fieldcontain">
					<span id="indicator-label" class="property-label"><g:message code="situation.indicator.label" default="Indicator" /></span>
					
						<span class="property-value" aria-labelledby="indicator-label"><g:fieldValue bean="${situationInstance}" field="indicator"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${situationInstance?.id}" />
					<g:link class="edit" action="edit" id="${situationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
