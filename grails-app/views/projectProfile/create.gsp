<head>
  <meta name="layout" content="planning"/>
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
      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="name"/></td>
          <td valign="top" class="value">
            <g:textField class="countable50 ${hasErrors(bean: pc, field: 'fullName', 'errors')}" size="50" name="fullName" value="${fieldValue(bean: pc, field: 'fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="begin"/></td>
          <td valign="top" class="value">
            <g:textField name="startDate" class="datepicker ${hasErrors(bean: pc, field: 'startDate', 'errors')}" value="${formatDate(date: pc?.startDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="end"/></td>
          <td valign="top" class="value">
            <g:textField name="endDate" class="datepicker ${hasErrors(bean: pc, field: 'endDate', 'errors')}" value="${formatDate(date: pc?.endDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

      </table>

      <h4><g:message code="project.profile.beginTimes"/></h4>
      <table class="${hasErrors(bean: pc, field: 'weekdays', 'errors')}">
        <tr>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="monday" value="${pc?.monday}" onclick="toggleDisabled('.mondayStart')"/> <g:message code="monday"/></div>
            <g:if test="${pc?.monday}"><g:textField name="mondayStart" class="mondayStart timepicker ${hasErrors(bean: pc, field: 'mondayStart', 'errors')}" size="4" value="${formatDate(date: pc?.mondayStart, format: 'HH:mm')}"/></g:if>
            <g:else><g:textField disabled="disabled" name="mondayStart" class="mondayStart timepicker ${hasErrors(bean: pc, field: 'mondayStart', 'errors')}" size="4" value="${formatDate(date: pc?.mondayStart, format: 'HH:mm')}"/></g:else>
          </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="tuesday" value="${pc?.tuesday}" onclick="toggleDisabled('.tuesdayStart')"/> <g:message code="tuesday"/></div>
          <g:if test="${pc?.tuesday}"><g:textField name="tuesdayStart" class="tuesdayStart timepicker ${hasErrors(bean: pc, field: 'tuesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.tuesdayStart, format: 'HH:mm')}"/></g:if>
          <g:else><g:textField disabled="disabled" name="tuesdayStart" class="tuesdayStart timepicker ${hasErrors(bean: pc, field: 'tuesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.tuesdayStart, format: 'HH:mm')}"/></g:else>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="wednesday" value="${pc?.wednesday}" onclick="toggleDisabled('.wednesdayStart')"/> <g:message code="wednesday"/></div>
          <g:if test="${pc?.wednesday}"><g:textField name="wednesdayStart" class="wednesdayStart timepicker ${hasErrors(bean: pc, field: 'wednesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.wednesdayStart, format: 'HH:mm')}"/></g:if>
          <g:else><g:textField disabled="disabled" name="wednesdayStart" class="wednesdayStart timepicker ${hasErrors(bean: pc, field: 'wednesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.wednesdayStart, format: 'HH:mm')}"/></g:else>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="thursday" value="${pc?.thursday}" onclick="toggleDisabled('.thursdayStart')"/> <g:message code="thursday"/></div>
          <g:if test="${pc?.thursday}"><g:textField name="thursdayStart" class="thursdayStart timepicker ${hasErrors(bean: pc, field: 'thursdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.thursdayStart, format: 'HH:mm')}"/></g:if>
          <g:else><g:textField disabled="disabled" name="thursdayStart" class="thursdayStart timepicker ${hasErrors(bean: pc, field: 'thursdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.thursdayStart, format: 'HH:mm')}"/></g:else>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="friday" value="${pc?.friday}" onclick="toggleDisabled('.fridayStart')"/> <g:message code="friday"/></div>
          <g:if test="${pc?.friday}"><g:textField name="fridayStart" class="fridayStart timepicker ${hasErrors(bean: pc, field: 'fridayStart', 'errors')}" size="4" value="${formatDate(date: pc?.fridayStart, format: 'HH:mm')}"/></g:if>
          <g:else><g:textField disabled="disabled" name="fridayStart" class="fridayStart timepicker ${hasErrors(bean: pc, field: 'fridayStart', 'errors')}" size="4" value="${formatDate(date: pc?.fridayStart, format: 'HH:mm')}"/></g:else>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="saturday" value="${pc?.saturday}" onclick="toggleDisabled('.saturdayStart')"/> <g:message code="saturday"/></div>
          <g:if test="${pc?.saturday}"><g:textField name="saturdayStart" class="saturdayStart timepicker ${hasErrors(bean: pc, field: 'saturdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.saturdayStart, format: 'HH:mm')}"/></g:if>
          <g:else><g:textField disabled="disabled" name="saturdayStart" class="saturdayStart timepicker ${hasErrors(bean: pc, field: 'saturdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.saturdayStart, format: 'HH:mm')}"/></g:else>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="sunday" value="${pc?.sunday}" onclick="toggleDisabled('.sundayStart')"/> <g:message code="sunday"/></div>
          <g:if test="${pc?.sunday}"><g:textField name="sundayStart" class="sundayStart timepicker ${hasErrors(bean: pc, field: 'sundayStart', 'errors')}" size="4" value="${formatDate(date: pc?.sundayStart, format: 'HH:mm')}"/></g:if>
          <g:else><g:textField disabled="disabled" name="sundayStart" class="sundayStart timepicker ${hasErrors(bean: pc, field: 'sundayStart', 'errors')}" size="4" value="${formatDate(date: pc?.sundayStart, format: 'HH:mm')}"/></g:else>
        </td>
      </tr>
    </table>

      <table>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="description"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="description" height="200px" toolbar="Basic">
              ${fieldValue(bean:template,field:'profile.description').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="project.profile.educationalObjectiveText"/></td>
          <td valign="top" class="value">
            <ckeditor:editor name="educationalObjectiveText" height="200px" toolbar="Basic">
              ${fieldValue(bean:template,field:'profile.educationalObjectiveText').decodeHTML()}
            </ckeditor:editor>
          </td>
        </tr>

      </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
