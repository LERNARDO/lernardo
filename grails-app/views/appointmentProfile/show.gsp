<%@ page import="at.openfactory.ep.Entity" %>
<head>
  <meta name="layout" content="database"/>
  <title><g:message code="appointment"/> - ${appointment.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="appointment"/> - ${appointment.profile.fullName}</h1>
    %{--<div class="icons" style="text-align: right;">
      <g:link action="edit" id="${appointment.id}"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:link>
    </div>--}%
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">

    <table>
      <tbody>

        <tr class="prop">
          <td class="one"><g:message code="owner"/></td>
          <td class="two"><g:link controller="${belongsTo.type.supertype.name +'Profile'}" action="show" id="${belongsTo.id}" params="[entity: belongsTo.id]">${fieldValue(bean: belongsTo, field: 'profile.fullName').decodeHTML()}</g:link></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="title"/></td>
          <td class="two">${fieldValue(bean: appointment, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/></td>
          <td class="two">${fieldValue(bean: appointment, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="begin"/></td>
          <td class="two"><g:formatDate date="${appointment.profile.beginDate}" format="dd. MM. yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="end"/></td>
          <td class="two"><g:formatDate date="${appointment.profile.endDate}" format="dd. MM. yyyy, HH:mm" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.allDay"/></td>
          <td class="two"><g:formatBoolean boolean="${appointment.profile.allDay}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.isPrivate"/></td>
          <td class="two"><g:formatBoolean boolean="${appointment.profile.isPrivate}" true="${message(code: 'yes')}" false="${message(code: 'no')}"/></td>
        </tr>

      </tbody>
    </table>

    <div class="buttons">
      <g:form id="${appointment.id}">
        <erp:accessCheck types="['Betreiber']" me="${belongsTo}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" /></div>
        </erp:accessCheck>
        <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      </g:form>
      <div class="clear"></div>
    </div>

  </div>
</div>
</body>
