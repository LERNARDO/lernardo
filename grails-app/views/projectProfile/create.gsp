<head>
  <meta name="layout" content="private"/>
  <title><g:message code="object.create" args="[message(code: 'project')]"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="object.create" args="[message(code: 'project')]"/></h1>
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
              <g:textField name="mondayStart" class="timepicker ${hasErrors(bean: pc, field: 'mondayStart', 'errors')}" size="4" value="${formatDate(date: pc?.mondayStart, format: 'HH:mm')}"/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="tuesday" value="${pc?.tuesday}"/> <g:message code="tuesday"/></div>
              <g:textField name="tuesdayStart" class="timepicker ${hasErrors(bean: pc, field: 'tuesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.tuesdayStart, format: 'HH:mm')}"/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="wednesday" value="${pc?.wednesday}"/> <g:message code="wednesday"/></div>
              <g:textField name="wednesdayStart" class="timepicker ${hasErrors(bean: pc, field: 'wednesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.wednesdayStart, format: 'HH:mm')}"/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="thursday" value="${pc?.thursday}"/> <g:message code="thursday"/></div>
              <g:textField name="thursdayStart" class="timepicker ${hasErrors(bean: pc, field: 'thursdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.thursdayStart, format: 'HH:mm')}"/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="friday" value="${pc?.friday}"/> <g:message code="friday"/></div>
              <g:textField name="fridayStart" class="timepicker ${hasErrors(bean: pc, field: 'fridayStart', 'errors')}" size="4" value="${formatDate(date: pc?.fridayStart, format: 'HH:mm')}"/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="saturday" value="${pc?.saturday}"/> <g:message code="saturday"/></div>
              <g:textField name="saturdayStart" class="timepicker ${hasErrors(bean: pc, field: 'saturdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.saturdayStart, format: 'HH:mm')}"/>
            </td>
            <td style="padding: 6px;">
              <div style="margin-bottom: 3px;"><g:checkBox name="sunday" value="${pc?.sunday}"/> <g:message code="sunday"/></div>
              <g:textField name="sundayStart" class="timepicker ${hasErrors(bean: pc, field: 'sundayStart', 'errors')}" size="4" value="${formatDate(date: pc?.sundayStart, format: 'HH:mm')}"/>
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
