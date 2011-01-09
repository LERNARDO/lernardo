<head>
  <meta name="layout" content="private"/>
  <title><g:message code="project.create"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="project.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: pc]"/>

    <p>Vorlage: <g:link controller="projectTemplateProfile" action="show" id="${template?.id}">${template?.profile?.fullName}</g:link></p>
    <g:form action="save" id="${template.id}">
      <div class="dialog">
        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="project.profile.name"/></td>
            <td valign="top" class="name"><g:message code="project.profile.startDate"/></td>
            <td valign="top" class="name"><g:message code="project.profile.endDate"/></td>
          </tr>

          <tr>
            <td width="300" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: pc, field: 'fullName', 'errors')}" size="40" name="fullName" value="${fieldValue(bean: pc, field: 'fullName').decodeHTML()}"/>
            </td>
            <td width="230" valign="top" class="value">
              <g:textField name="startDate" class="datepicker ${hasErrors(bean: pc, field: 'startDate', 'errors')}" value="${pc?.startDate?.format('dd. MM. yyyy')}"/>
            </td>
            <td width="230" valign="top" class="value">
              <g:textField name="endDate" class="datepicker ${hasErrors(bean: pc, field: 'endDate', 'errors')}" value="${pc?.endDate?.format('dd. MM. yyyy')}"/>
            </td>
          </tr>

        </table>

        <table class="${hasErrors(bean: pc, field: 'weekdays', 'errors')}">
          <tr>
            <td colspan="7" width="80" class="label">Beginn:</td>
          </tr>
          <tr>
            <td class="project-top" width="105">MO:&nbsp;
              <g:checkBox name="monday" value="${pc?.monday}"/><br/>
              <g:select name="mondayStartHour" from="${0..23}" value="${pc?.mondayStartHour}"/>:<g:select name="mondayStartMinute" from="${0..59}" value="${pc?.mondayStartMinute}"/><br/>
              %{--<g:select name="mondayEndHour" from="${0..23}" value="${project?.mondayEndHour}"/>:<g:select name="mondayEndMinute" from="${0..59}" value="${project?.mondayEndMinute}"/>--}%
            </td>
            <td class="project-top" width="105">DI:&nbsp;
              <g:checkBox name="tuesday" value="${pc?.tuesday}"/><br/>
              <g:select name="tuesdayStartHour" from="${0..23}" value="${pc?.tuesdayStartHour}"/>:<g:select name="tuesdayStartMinute" from="${0..59}" value="${pc?.tuesdayStartMinute}"/><br/>
              %{--<g:select name="tuesdayEndHour" from="${0..23}" value="${project?.tuesdayEndHour}"/>:<g:select name="tuesdayEndMinute" from="${0..59}" value="${project?.tuesdayEndMinute}"/>--}%
            </td>
            <td class="project-top" width="105">MI:&nbsp;
              <g:checkBox name="wednesday" value="${pc?.wednesday}"/><br/>
              <g:select name="wednesdayStartHour" from="${0..23}" value="${pc?.wednesdayStartHour}"/>:<g:select name="wednesdayStartMinute" from="${0..59}" value="${pc?.wednesdayStartMinute}"/><br/>
              %{--<g:select name="wednesdayEndHour" from="${0..23}" value="${project?.wednesdayEndHour}"/>:<g:select name="wednesdayEndMinute" from="${0..59}" value="${project?.wednesdayEndMinute}"/>--}%
            </td>
            <td class="project-top" width="105">DO:&nbsp;
              <g:checkBox name="thursday" value="${pc?.thursday}"/><br/>
              <g:select name="thursdayStartHour" from="${0..23}" value="${pc?.thursdayStartHour}"/>:<g:select name="thursdayStartMinute" from="${0..59}" value="${pc?.thursdayStartMinute}"/><br/>
              %{--<g:select name="thursdayEndHour" from="${0..23}" value="${project?.thursdayEndHour}"/>:<g:select name="thursdayEndMinute" from="${0..59}" value="${project?.thursdayEndMinute}"/>--}%
            </td>
            <td class="project-top" width="105">FR:&nbsp;
              <g:checkBox name="friday" value="${pc?.friday}"/><br/>
              <g:select name="fridayStartHour" from="${0..23}" value="${pc?.fridayStartHour}"/>:<g:select name="fridayStartMinute" from="${0..59}" value="${pc?.fridayStartMinute}"/><br/>
              %{--<g:select name="fridayEndHour" from="${0..23}" value="${project?.fridayEndHour}"/>:<g:select name="fridayEndMinute" from="${0..59}" value="${project?.fridayEndMinute}"/>--}%
            </td>
            <td class="project-top" width="105">SA:&nbsp;
              <g:checkBox name="saturday" value="${pc?.saturday}"/><br/>
              <g:select name="saturdayStartHour" from="${0..23}" value="${pc?.saturdayStartHour}"/>:<g:select name="saturdayStartMinute" from="${0..59}" value="${pc?.saturdayStartMinute}"/><br/>
              %{--<g:select name="saturdayEndHour" from="${0..23}" value="${project?.saturdayEndHour}"/>:<g:select name="saturdayEndMinute" from="${0..59}" value="${project?.saturdayEndMinute}"/>--}%
            </td>
            <td class="project-top" width="105">SO:&nbsp;
              <g:checkBox name="sunday" value="${pc?.sunday}"/><br/>
              <g:select name="sundayStartHour" from="${0..23}" value="${pc?.sundayStartHour}"/>:<g:select name="sundayStartMinute" from="${0..59}" value="${pc?.sundayStartMinute}"/><br/>
              %{--<g:select name="sundayEndHour" from="${0..23}" value="${project?.sundayEndHour}"/>:<g:select name="sundayEndMinute" from="${0..59}" value="${project?.sundayEndMinute}"/>--}%
            </td>
          </tr>
        </table>

      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" controller="projectTemplateProfile" action="show" id="${template.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
