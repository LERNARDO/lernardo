<head>
  <meta name="layout" content="planning"/>
  <title>Aktivität bearbeiten</title>
</head>
<body>
<div class="boxHeader">
  <h1>Aktivität bearbeiten</h1>
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

        </tbody>
      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="clear"></div>
      </div>

    </g:form>

  </div>
</div>
</body>