<head>
  <meta name="layout" content="private"/>
  <title><g:message code="appointment"/> - ${appointmentProfileInstance.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1 style="float: left"><g:message code="appointment"/> - ${appointmentProfileInstance.profile.fullName}</h1>
    <div class="icons" style="text-align: right;">
      <g:link action="edit" id="${appointmentProfileInstance.id}"><img src="${resource(dir: 'images/icons', file: 'icon_edit.png')}" alt="${message(code: 'edit')}" align="top"/></g:link>
    </div>
  </div>
</div>
<div class="boxGray" style="clear: both;">
  <div class="second">

    <table>
      <tbody>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.fullName"/>:</td>
          <td class="two">${fieldValue(bean: appointmentProfileInstance, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.description"/>:</td>
          <td class="two">${fieldValue(bean: appointmentProfileInstance, field: 'profile.description').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.beginDate"/>:</td>
          <td class="two"><g:formatDate date="${appointmentProfileInstance.profile.beginDate}" format="dd. MM. yyyy, HH:mm"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.endDate"/>:</td>
          <td class="two"><g:formatDate date="${appointmentProfileInstance.profile.endDate}" format="dd. MM. yyyy, HH:mm"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.allDay"/>:</td>
          <td class="two"><g:formatBoolean boolean="${appointmentProfileInstance.profile.allDay}" true="Ja" false="Nein"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="appointment.profile.isPrivate"/>:</td>
          <td class="two"><g:formatBoolean boolean="${appointmentProfileInstance.profile.isPrivate}" true="Ja" false="Nein"/></td>
        </tr>

      </tbody>
    </table>

    <div class="buttons">
      <g:if test="${currentEntity.id == bla.id}">
        <g:link class="buttonGreen" action="edit" id="${appointmentProfileInstance?.id}"><g:message code="edit"/></g:link>
      </g:if>
      <g:link class="buttonGray" action="list"><g:message code="back"/></g:link>
      <div class="spacer"></div>
    </div>

  </div>
</div>
</body>
