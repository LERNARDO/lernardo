<%@ page import="at.openfactory.ep.Entity" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="appointment"/> - ${appointment.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1 style="float: left"><g:message code="appointment"/> - ${appointment.profile.fullName}</h1>
    <div class="icons" style="text-align: right;">
      <g:link action="edit" id="${appointment.id}"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:link>
    </div>
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">

    <table>
      <tbody>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.fullName"/>:</td>
          <td class="two">${fieldValue(bean: appointment, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.description"/>:</td>
          <td class="two">${fieldValue(bean: appointment, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.beginDate"/>:</td>
          <td class="two"><g:formatDate date="${appointment.profile.beginDate}" format="dd. MM. yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.endDate"/>:</td>
          <td class="two"><g:formatDate date="${appointment.profile.endDate}" format="dd. MM. yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.allDay"/>:</td>
          <td class="two"><g:formatBoolean boolean="${appointment.profile.allDay}" true="Ja" false="Nein"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.isPrivate"/>:</td>
          <td class="two"><g:formatBoolean boolean="${appointment.profile.isPrivate}" true="Ja" false="Nein"/></td>
        </tr>

      </tbody>
    </table>

    <div class="buttons">
      <g:form id="${appointment.id}">
        <erp:isMeOrAdminOrOperator entity="${Entity.get(bla)}" current="${currentEntity}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" /></div>
        </erp:isMeOrAdminOrOperator>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'back')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>
