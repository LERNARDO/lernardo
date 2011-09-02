<head>
  <meta name="layout" content="private"/>
  <title><g:message code="project.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="project.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: project]"/>

    <g:form id="${project.id}">
      <div>
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="project.profile.name"/></td>
            <td valign="top" class="name"><g:message code="project.profile.startDate"/></td>
            <td valign="top" class="name"><g:message code="project.profile.endDate"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <g:textField class="countable${project.profile.constraints.fullName.maxSize} ${hasErrors(bean: project, field: 'profile.fullName', 'errors')}" size="50" maxlength="80" name="fullName" value="${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField name="startDate" class="datepicker ${hasErrors(bean: project, field: 'profile.startDate', 'errors')}" value="${formatDate(date: project.profile.startDate, format: 'dd. MM. yyyy')}"/>
            </td>
            <td valign="top" class="value">
              <g:textField name="endDate" class="datepicker ${hasErrors(bean: project, field: 'profile.endDate', 'errors')}" value="${formatDate(date: project.profile.endDate, format: 'dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="project.profile.description"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" width="800px" toolbar="Basic">
                ${fieldValue(bean:project,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
            </td>--}%
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="project.profile.educationalObjective"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <g:select class="drop-down-240" from="['succeeded','notSucceeded']" name="educationalObjective" value="${project.profile.educationalObjective}" noSelection="['': message(code: 'none')]" valueMessagePrefix="goal"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="project.profile.educationalObjectiveText"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="educationalObjectiveText" height="200px" width="800px" toolbar="Basic">
                ${fieldValue(bean:project,field:'profile.educationalObjectiveText').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

          </tbody>
        </table>

        <table>
          <tr>
            <td colspan="7" width="80" class="label">Beginn:</td>
          </tr>
          <tr>
            <td class="project-top" width="105">MO:&nbsp;
              <g:checkBox name="monday" value="${false}"/><br/>
              <g:select name="mondayStartHour" from="${0..23}" value=""/>:<g:select name="mondayStartMinute" from="${0..59}" value=""/><br/>
            </td>
            <td class="project-top" width="105">DI:&nbsp;
              <g:checkBox name="tuesday" value="${false}"/><br/>
              <g:select name="tuesdayStartHour" from="${0..23}" value=""/>:<g:select name="tuesdayStartMinute" from="${0..59}" value=""/><br/>
            </td>
            <td class="project-top" width="105">MI:&nbsp;
              <g:checkBox name="wednesday" value="${false}"/><br/>
              <g:select name="wednesdayStartHour" from="${0..23}" value=""/>:<g:select name="wednesdayStartMinute" from="${0..59}" value=""/><br/>
            </td>
            <td class="project-top" width="105">DO:&nbsp;
              <g:checkBox name="thursday" value="${false}"/><br/>
              <g:select name="thursdayStartHour" from="${0..23}" value=""/>:<g:select name="thursdayStartMinute" from="${0..59}" value=""/><br/>
            </td>
            <td class="project-top" width="105">FR:&nbsp;
              <g:checkBox name="friday" value="${false}"/><br/>
              <g:select name="fridayStartHour" from="${0..23}" value=""/>:<g:select name="fridayStartMinute" from="${0..59}" value=""/><br/>
            </td>
            <td class="project-top" width="105">SA:&nbsp;
              <g:checkBox name="saturday" value="${false}"/><br/>
              <g:select name="saturdayStartHour" from="${0..23}" value=""/>:<g:select name="saturdayStartMinute" from="${0..59}" value=""/><br/>
            </td>
            <td class="project-top" width="105">SO:&nbsp;
              <g:checkBox name="sunday" value="${false}"/><br/>
              <g:select name="sundayStartHour" from="${0..23}" value=""/>:<g:select name="sundayStartMinute" from="${0..59}" value=""/><br/>
            </td>
          </tr>
        </table>

      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
  </div>
</body>
