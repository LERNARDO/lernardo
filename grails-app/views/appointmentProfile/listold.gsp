<%@ page import="at.uenterprise.erp.MetaDataService" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="appointments"/></title>
</head>
<body>

<div class="tabGrey">
  <div class="second">
    <h1><g:link controller="appointmentProfile" action="list">Aktuelle Termine</g:link></h1>
  </div>
</div>

<div class="tabGreen">
  <div class="second">
    <h1>Vergangene Termine</h1>
  </div>
</div>

<div class="clearFloat"></div>

<div class="boxGray">
  <div class="second">

    <div class="info-msg">
      <g:message code="object.found" args="[appointmentProfileInstanceTotal, message(code: 'appointments')]"/>
    </div>

    <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
      <div class="buttons">
        <g:form id="${entity.id}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="create" value="${message(code: 'object.create', args: [message(code: 'appointment')])}"/></div>
          <div class="button"><g:link class="buttonGray" controller="calendar" action="show">Zum Kalender</g:link></div>
          <div class="spacer"></div>
        </g:form>
      </div>
    </erp:accessCheck>

    <g:if test="${appointmentProfileInstanceList}">
      <table class="default-table">
        <tbody>
        <g:each in="${appointmentProfileInstanceList}" status="i" var="appointmentProfileInstance">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td style="width: 300px;">
              <g:if test="${appointmentProfileInstance.profile.isPrivate}">
                <img src="${g.resource(dir:'images/icons', file:'lock.png')}" alt="Private" style="position: relative; top: 3px; margin-right: 5px;"/>
              </g:if>
              <g:formatDate date="${appointmentProfileInstance.profile.beginDate}" format="EE dd. MMM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
              <g:if test="${appointmentProfileInstance.profile.beginDate.getDate() != appointmentProfileInstance.profile.endDate.getDate()}">
              - <g:formatDate date="${appointmentProfileInstance.profile.endDate}" format="EE dd. MMM. yyyy" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
              </g:if>
            </td>
            <td style="width: 150px;">
              <g:if test="${appointmentProfileInstance.profile.allDay}">
                Ganztägig
              </g:if>
              <g:else>
                <g:formatDate date="${appointmentProfileInstance.profile.beginDate}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/> - <g:formatDate date="${appointmentProfileInstance.profile.endDate}" format="HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
              </g:else>
            </td>
            <td style="line-height: 20px;">
              <g:if test="${appointmentProfileInstance.profile.isPrivate}">
                <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" me="${entity}">
                  <span class="bold"><g:link action="show" id="${appointmentProfileInstance.id}" params="[entity: appointmentProfileInstance.id]">${fieldValue(bean: appointmentProfileInstance, field: 'profile.fullName')}</g:link></span><br/>
                  ${fieldValue(bean: appointmentProfileInstance, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
                  <g:set var="negation" value="negation"/> %{-- see below note why this is set --}%
                </erp:accessCheck>
                %{-- NOTE: if "negation" does not exist we know the custom tag did not evaluate to true so why can output the following else condition --}%
                <g:if test="${!negation}">
                  <g:message code="notAvailable"/> %{--${fieldValue(bean: appointmentProfileInstance, field: 'profile.fullName')} --}%
                </g:if>
              </g:if>
              <g:else>
                <span class="bold"><g:link action="show" id="${appointmentProfileInstance.id}" params="[entity: appointmentProfileInstance.id]">${fieldValue(bean: appointmentProfileInstance, field: 'profile.fullName')}</g:link></span><br/>
                ${fieldValue(bean: appointmentProfileInstance, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
              </g:else>
            </td>
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
