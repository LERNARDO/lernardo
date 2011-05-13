<head>
  <meta name="layout" content="private"/>
  <title>Aktivität bearbeiten</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1>Aktivität bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: activity]"/>

    <g:form id="${activity.id}" params="[name:currentEntity.name]">
      Vorlage:
      <erp:getTemplate entity="${activity}">
        <g:link controller="templateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link>
      </erp:getTemplate>

      <table>
        <tbody>

        <tr>
          <td valign="bottom" class="label">Titel:</td>
          <td valign="bottom" class="label"><g:message code="date"/>:</td>
          <td valign="bottom" class="label">Dauer in Minuten:</td>
        </tr>

        <tr>
          <td width="220" valign="top" class="value ${hasErrors(bean: activity, field: 'profile.fullName', 'errors')}">
            <g:textField class="countable${activity.profile.constraints.fullName.maxSize}" name="fullName" size="30" value="${fieldValue(bean:activity, field:'profile.fullName').decodeHTML()}"/>
          </td>
          <td width="350" valign="top" class="value ${hasErrors(bean: activity, field: 'profile.date', 'errors')}">
            <g:textField class="datetimepicker2" name="date" value="${formatDate(date: activity?.profile?.date, format: 'dd. MM. yyyy, HH:mm', timeZone: TimeZone.getTimeZone(grailsApplication.config.timeZone.toString()))}"/>
          </td>
          <td width="220" valign="top" class="value ${hasErrors(bean: activity, field: 'profile.duration', 'errors')}">
            <g:textField name="duration" value="${fieldValue(bean:activity, field:'profile.duration')}"/>
          </td>
        </tr>

        <tr>
          <td valign="bottom" class="label"><g:message code="facility"/>:</td>
          <td valign="bottom" class="label"><g:message code="clients"/>:</td>
          <td valign="bottom" class="label"><g:message code="educators"/>:</td>
        </tr>

        <tr>
          <td valign="top" class="value ${hasErrors(bean: activity, field: 'facility', 'errors')}">
            <g:select class="drop-down-205" name="facility" from="${facilities}" optionKey="id" optionValue="profile"/>
          </td>
          <td valign="top" class="value ${hasErrors(bean: activity, field: 'clients', 'errors')}">
            <g:select multiple="true" optionKey="id" optionValue="profile" from="${clients}" size="10" class="long-field" name="clients" value="${currentClients}"/>
          </td>
          <td valign="top" class="value ${hasErrors(bean: activity, field: 'educators', 'errors')}">
            <g:select multiple="true" optionKey="id" optionValue="profile" from="${educators}" name="educators" value="${currentEducators}"/>
          </td>
        </tr>

        </tbody>
      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>

  </div>
</div>
</body>