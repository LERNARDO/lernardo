<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="object.create" args="[message(code: 'project')]"/></title>
</head>
<body>
<div class="boxHeader">
  <h1><g:message code="object.create" args="[message(code: 'project')]"/></h1>
</div>
<div class="boxContent">

    <g:render template="/templates/errors" model="[bean: pc]"/>

    <p><g:message code="projectTemplate"/>: <g:link controller="projectTemplateProfile" action="show" id="${template?.id}">${template?.profile}</g:link></p>
    <g:form id="${template.id}">
      <table>

        <tr class="prop">
          <td class="name"><g:message code="name"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField data-counter="50" class="${hasErrors(bean: pc, field: 'fullName', 'errors')}" required="" size="50" name="fullName" value="${fieldValue(bean: pc, field: 'fullName').decodeHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="begin"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField name="startDate" class="datepicker ${hasErrors(bean: pc, field: 'startDate', 'errors')}" required="" value="${formatDate(date: pc?.startDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td class="name"><g:message code="end"/> <span class="required-indicator">*</span></td>
          <td class="value">
            <g:textField name="endDate" class="datepicker ${hasErrors(bean: pc, field: 'endDate', 'errors')}" required="" value="${formatDate(date: pc?.endDate, format: 'dd. MM. yyyy')}"/>
          </td>
        </tr>

      </table>

      <h4><g:message code="project.profile.beginTimes"/></h4>
      <table class="${hasErrors(bean: pc, field: 'weekdays', 'errors')}">
        <tr>
          <td style="padding: 6px;">
            <div style="margin-bottom: 3px;"><g:checkBox name="monday" value="${pc?.monday}" onclick="toggleDisabled('.mondayStart'); toggleDisabled('.mondayEnd');"/> <g:message code="monday"/></div>
            <div style="width: 80px; text-align: right;">
                <g:if test="${pc?.monday}">
                    <g:message code="from"/> <g:textField name="mondayStart" class="mondayStart timepick ${hasErrors(bean: pc, field: 'mondayStart', 'errors')}" size="4" value="${formatDate(date: pc?.mondayStart, format: 'HH:mm')}"/><br/>
                    <g:message code="to"/> <g:textField name="mondayEnd" class="mondayEnd timepick ${hasErrors(bean: pc, field: 'mondayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.mondayEnd, format: 'HH:mm')}"/>
                </g:if>
                <g:else>
                    <g:message code="from"/> <g:textField disabled="disabled" name="mondayStart" class="mondayStart timepick ${hasErrors(bean: pc, field: 'mondayStart', 'errors')}" size="4" value="${formatDate(date: pc?.mondayStart, format: 'HH:mm')}"/><br/>
                    <g:message code="to"/> <g:textField disabled="disabled" name="mondayEnd" class="mondayEnd timepick ${hasErrors(bean: pc, field: 'mondayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.mondayEnd, format: 'HH:mm')}"/>
                </g:else>
            </div>
          </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="tuesday" value="${pc?.tuesday}" onclick="toggleDisabled('.tuesdayStart'); toggleDisabled('.tuesdayEnd');"/> <g:message code="tuesday"/></div>
          <div style="width: 80px; text-align: right;">
              <g:if test="${pc?.tuesday}">
                  <g:message code="from"/> <g:textField name="tuesdayStart" class="tuesdayStart timepick ${hasErrors(bean: pc, field: 'tuesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.tuesdayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField name="tuesdayEnd" class="tuesdayEnd timepick ${hasErrors(bean: pc, field: 'tuesdayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.tuesdayEnd, format: 'HH:mm')}"/>
              </g:if>
              <g:else>
                  <g:message code="from"/> <g:textField disabled="disabled" name="tuesdayStart" class="tuesdayStart timepick ${hasErrors(bean: pc, field: 'tuesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.tuesdayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField disabled="disabled" name="tuesdayEnd" class="tuesdayEnd timepick ${hasErrors(bean: pc, field: 'tuesdayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.tuesdayEnd, format: 'HH:mm')}"/>
              </g:else>
          </div>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="wednesday" value="${pc?.wednesday}" onclick="toggleDisabled('.wednesdayStart'); toggleDisabled('.wednesdayEnd');"/> <g:message code="wednesday"/></div>
          <div style="width: 80px; text-align: right;">
              <g:if test="${pc?.wednesday}">
                  <g:message code="from"/> <g:textField name="wednesdayStart" class="wednesdayStart timepick ${hasErrors(bean: pc, field: 'wednesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.wednesdayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField name="wednesdayEnd" class="wednesdayEnd timepick ${hasErrors(bean: pc, field: 'wednesdayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.wednesdayEnd, format: 'HH:mm')}"/>
              </g:if>
              <g:else>
                  <g:message code="from"/> <g:textField disabled="disabled" name="wednesdayStart" class="wednesdayStart timepick ${hasErrors(bean: pc, field: 'wednesdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.wednesdayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField disabled="disabled" name="wednesdayEnd" class="wednesdayEnd timepick ${hasErrors(bean: pc, field: 'wednesdayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.wednesdayEnd, format: 'HH:mm')}"/>
              </g:else>
          </div>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="thursday" value="${pc?.thursday}" onclick="toggleDisabled('.thursdayStart'); toggleDisabled('.thursdayEnd');"/> <g:message code="thursday"/></div>
          <div style="width: 80px; text-align: right;">
              <g:if test="${pc?.thursday}">
                  <g:message code="from"/> <g:textField name="thursdayStart" class="thursdayStart timepick ${hasErrors(bean: pc, field: 'thursdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.thursdayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField name="thursdayEnd" class="thursdayEnd timepick ${hasErrors(bean: pc, field: 'thursdayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.thursdayEnd, format: 'HH:mm')}"/>
              </g:if>
              <g:else>
                  <g:message code="from"/> <g:textField disabled="disabled" name="thursdayStart" class="thursdayStart timepick ${hasErrors(bean: pc, field: 'thursdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.thursdayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField disabled="disabled" name="thursdayEnd" class="thursdayEnd timepick ${hasErrors(bean: pc, field: 'thursdayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.thursdayEnd, format: 'HH:mm')}"/>
              </g:else>
          </div>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="friday" value="${pc?.friday}" onclick="toggleDisabled('.fridayStart'); toggleDisabled('.fridayEnd');"/> <g:message code="friday"/></div>
          <div style="width: 80px; text-align: right;">
              <g:if test="${pc?.friday}">
                  <g:message code="from"/> <g:textField name="fridayStart" class="fridayStart timepick ${hasErrors(bean: pc, field: 'fridayStart', 'errors')}" size="4" value="${formatDate(date: pc?.fridayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField name="fridayEnd" class="fridayEnd timepick ${hasErrors(bean: pc, field: 'fridayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.fridayEnd, format: 'HH:mm')}"/>
              </g:if>
              <g:else>
                  <g:message code="from"/> <g:textField disabled="disabled" name="fridayStart" class="fridayStart timepick ${hasErrors(bean: pc, field: 'fridayStart', 'errors')}" size="4" value="${formatDate(date: pc?.fridayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField disabled="disabled" name="fridayEnd" class="fridayEnd timepick ${hasErrors(bean: pc, field: 'fridayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.fridayEnd, format: 'HH:mm')}"/>
              </g:else>
          </div>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="saturday" value="${pc?.saturday}" onclick="toggleDisabled('.saturdayStart'); toggleDisabled('.saturdayEnd');"/> <g:message code="saturday"/></div>
          <div style="width: 80px; text-align: right;">
              <g:if test="${pc?.saturday}">
                  <g:message code="from"/> <g:textField name="saturdayStart" class="saturdayStart timepick ${hasErrors(bean: pc, field: 'saturdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.saturdayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField name="saturdayEnd" class="saturdayEnd timepick ${hasErrors(bean: pc, field: 'saturdayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.saturdayEnd, format: 'HH:mm')}"/>
              </g:if>
              <g:else>
                  <g:message code="from"/> <g:textField disabled="disabled" name="saturdayStart" class="saturdayStart timepick ${hasErrors(bean: pc, field: 'saturdayStart', 'errors')}" size="4" value="${formatDate(date: pc?.saturdayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField disabled="disabled" name="saturdayEnd" class="saturdayEnd timepick ${hasErrors(bean: pc, field: 'saturdayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.saturdayEnd, format: 'HH:mm')}"/>
              </g:else>
          </div>
        </td>
        <td style="padding: 6px;">
          <div style="margin-bottom: 3px;"><g:checkBox name="sunday" value="${pc?.sunday}" onclick="toggleDisabled('.sundayStart'); toggleDisabled('.sundayEnd');"/> <g:message code="sunday"/></div>
          <div style="width: 80px; text-align: right;">
              <g:if test="${pc?.sunday}">
                  <g:message code="from"/> <g:textField name="sundayStart" class="sundayStart timepick ${hasErrors(bean: pc, field: 'sundayStart', 'errors')}" size="4" value="${formatDate(date: pc?.sundayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField name="sundayEnd" class="sundayEnd timepick ${hasErrors(bean: pc, field: 'sundayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.sundayEnd, format: 'HH:mm')}"/>
              </g:if>
              <g:else>
                  <g:message code="from"/> <g:textField disabled="disabled" name="sundayStart" class="sundayStart timepick ${hasErrors(bean: pc, field: 'sundayStart', 'errors')}" size="4" value="${formatDate(date: pc?.sundayStart, format: 'HH:mm')}"/><br/>
                  <g:message code="to"/> <g:textField disabled="disabled" name="sundayEnd" class="sundayEnd timepick ${hasErrors(bean: pc, field: 'sundayEnd', 'errors')}" size="4" value="${formatDate(date: pc?.sundayEnd, format: 'HH:mm')}"/>
              </g:else>
         </div>
        </td>
      </tr>
    </table>

      <table>

          <tr class="prop">
              <td class="name"><g:message code="project.profile.educationalObjectiveText"/></td>
              <td class="value">
                  <ckeditor:editor name="educationalObjectiveText" height="200px" toolbar="Basic">
                      ${fieldValue(bean:template,field:'profile.educationalObjectiveText').decodeHTML()}
                  </ckeditor:editor>
              </td>
          </tr>

          <tr class="prop">
              <td class="name"><g:message code="description"/></td>
              <td class="value">
                  <ckeditor:editor name="description" height="200px" toolbar="Basic">
                    ${fieldValue(bean:template,field:'profile.description').decodeHTML()}
                  </ckeditor:editor>
              </td>
          </tr>

      </table>

      <div class="buttons cleared">
        <div class="button"><g:actionSubmit class="buttonGreen" action="save" value="${message(code: 'save')}" /></div>
        <div class="button"><g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link></div>
      </div>
      
    </g:form>

</div>
</body>
