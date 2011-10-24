<%@ page import="at.uenterprise.erp.MetaDataService" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="appointments"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="appointments"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      ${appointmentProfileInstanceTotal} <g:message code="appointment.profile.c_total"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
      <div class="buttons">
        <g:form id="${entity.id}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'appointment')])}"/></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:if test="${appointmentProfileInstanceList}">
      <table class="default-table">
        <thead>
        <tr>
          <g:sortableColumn property="fullName" title="${message(code:'title')}"/>
          <g:sortableColumn property="beginDate" title="${message(code:'begin')}"/>
          <g:sortableColumn property="endDate" title="${message(code:'end')}"/>
          <g:sortableColumn property="allDay" title="${message(code:'appointment.profile.allDay')}"/>
          <g:sortableColumn property="isPrivate" title="${message(code:'appointment.profile.isPrivate')}"/>
        </tr>
        </thead>
        <tbody>
        <g:each in="${appointmentProfileInstanceList}" status="i" var="appointmentProfileInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td>
              <g:if test="${appointmentProfileInstance.profile.isPrivate}">
                <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
                  <g:link action="show" id="${appointmentProfileInstance.id}" params="[entity: appointmentProfileInstance.id]">${fieldValue(bean: appointmentProfileInstance, field: 'profile.fullName')}</g:link>
                  <g:set var="negation" value="negation"/> %{-- see below note why this is set --}%
                </erp:accessCheck>
                %{-- NOTE: if "negation" does not exist we know the custom tag did not evaluate to true so why can output the following else condition --}%
                <g:if test="${!negation}">
                  <g:message code="notAvailable"/> %{--${fieldValue(bean: appointmentProfileInstance, field: 'profile.fullName')} --}%
                </g:if>
              </g:if>
              <g:else>
                <g:link action="show" id="${appointmentProfileInstance.id}" params="[entity: appointmentProfileInstance.id]">${fieldValue(bean: appointmentProfileInstance, field: 'profile.fullName')}</g:link>
              </g:else></td>
            <td><g:formatDate date="${appointmentProfileInstance.profile.beginDate}" format="dd. MM. yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
            <td><g:formatDate date="${appointmentProfileInstance.profile.endDate}" format="dd. MM. yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
            <td><g:formatBoolean boolean="${appointmentProfileInstance.profile.allDay}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
            <td><g:formatBoolean boolean="${appointmentProfileInstance.profile.isPrivate}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
          </tr>
        </g:each>
        </tbody>
      </table>

      <div class="paginateButtons">
        <g:paginate total="${appointmentProfileInstanceTotal}"/>
      </div>
    </g:if>

  </div>
</div>
</body>
