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

    <p><g:message code="projectTemplate"/>: <g:link controller="projectTemplateProfile" action="show" id="${template?.id}">${template?.profile?.fullName}</g:link></p>
    <g:form id="${template.id}">
      <div>
        <table width="100%">

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
            <td valign="top" class="name"><g:message code="project.profile.startDate"/></td>
            <td valign="top" class="name"><g:message code="project.profile.endDate"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: pc, field: 'fullName', 'errors')}" size="50" name="fullName" value="${fieldValue(bean: pc, field: 'fullName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField name="startDate" class="datepicker ${hasErrors(bean: pc, field: 'startDate', 'errors')}" value="${formatDate(date: pc?.startDate, format: 'dd. MM. yyyy')}"/>
            </td>
            <td valign="top" class="value">
              <g:textField name="endDate" class="datepicker ${hasErrors(bean: pc, field: 'endDate', 'errors')}" value="${formatDate(date: pc?.endDate, format: 'dd. MM. yyyy')}"/>
            </td>
          </tr>
        </table>

        <table width="100%" class="${hasErrors(bean: pc, field: 'weekdays', 'errors')}">
          <tr>
            <td colspan="7" class="bold"><g:message code="project.profile.beginTimes"/></td>
          </tr>
          <tr>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="monday" value="${pc?.monday}"/> <g:message code="monday"/></div>
              <g:select name="mondayStartHour" from="${0..23}" value="${pc?.mondayStartHour}"/>:<g:select name="mondayStartMinute" from="${0..59}" value="${pc?.mondayStartMinute}"/><br/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="tuesday" value="${pc?.tuesday}"/> <g:message code="tuesday"/></div>
              <g:select name="tuesdayStartHour" from="${0..23}" value="${pc?.tuesdayStartHour}"/>:<g:select name="tuesdayStartMinute" from="${0..59}" value="${pc?.tuesdayStartMinute}"/><br/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="wednesday" value="${pc?.wednesday}"/> <g:message code="wednesday"/></div>
              <g:select name="wednesdayStartHour" from="${0..23}" value="${pc?.wednesdayStartHour}"/>:<g:select name="wednesdayStartMinute" from="${0..59}" value="${pc?.wednesdayStartMinute}"/><br/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="thursday" value="${pc?.thursday}"/> <g:message code="thursday"/></div>
              <g:select name="thursdayStartHour" from="${0..23}" value="${pc?.thursdayStartHour}"/>:<g:select name="thursdayStartMinute" from="${0..59}" value="${pc?.thursdayStartMinute}"/><br/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="friday" value="${pc?.friday}"/> <g:message code="friday"/></div>
              <g:select name="fridayStartHour" from="${0..23}" value="${pc?.fridayStartHour}"/>:<g:select name="fridayStartMinute" from="${0..59}" value="${pc?.fridayStartMinute}"/><br/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="saturday" value="${pc?.saturday}"/> <g:message code="saturday"/></div>
              <g:select name="saturdayStartHour" from="${0..23}" value="${pc?.saturdayStartHour}"/>:<g:select name="saturdayStartMinute" from="${0..59}" value="${pc?.saturdayStartMinute}"/><br/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="sunday" value="${pc?.sunday}"/> <g:message code="sunday"/></div>
              <g:select name="sundayStartHour" from="${0..23}" value="${pc?.sundayStartHour}"/>:<g:select name="sundayStartMinute" from="${0..59}" value="${pc?.sundayStartMinute}"/><br/>
            </td>
          </tr>
        </table>

        <table width="100%">

          <tr class="prop">
            <td colspan="3" valign="top" class="name bold"><g:message code="description"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" toolbar="Basic">
                ${fieldValue(bean:template,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name bold"><g:message code="project.profile.educationalObjectiveText"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="educationalObjectiveText" height="200px" toolbar="Basic">
                ${fieldValue(bean:template,field:'profile.educationalObjectiveText').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

        </table>

      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
