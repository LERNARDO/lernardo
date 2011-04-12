<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivity.create"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupActivity.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form action="save" params="[template: template.id]">
        <table width="100%">

          %{--<tr class="prop">
            <td height="30" colspan="3" valign="top" class="name">
              <label for="fullName">
                <g:message code="groupActivityTemplate"/>:
              </label>

              <g:link controller="groupActivityTemplateProfile" action="show" id="${template?.id}">${fieldValue(bean: template, field: 'profile.fullName')}</g:link>
            </td>
          </tr>--}%

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupActivity.profile.name"/></td>
            <td valign="top" class="name"><g:message code="groupActivity.profile.realDuration"/></td>
            <td valign="top" class="name"><g:message code="groupActivity.profile.date"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="50" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName') ? fieldValue(bean: group, field: 'profile.fullName').decodeHTML() : fieldValue(bean: template, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="15" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration') ?: calculatedDuration}"/> (min)
            </td>
            <td valign="top" class="value">
              <g:textField name="date" class="datetimepicker" value="${new Date().format('dd. MM. yyyy hh:mm')}"/>
              %{--<g:datePicker name="date" value="${group?.profile?.date}" precision="minute"/>--}%
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivity.profile.educationalObjectiveText"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="educationalObjectiveText" height="200px" toolbar="Basic">
                ${fieldValue(bean:group,field:'profile.educationalObjectiveText').decodeHTML()}
              </ckeditor:editor>
              %{--<g:textArea class="countable2000 ${hasErrors(bean: group, field: 'profile.educationalObjectiveText', 'errors')}" rows="5" cols="120" name="educationalObjectiveText" value="${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML()}"/>--}%
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivity.profile.description"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" toolbar="Basic">
                ${fieldValue(bean:group,field:'profile.description') ? fieldValue(bean:group,field:'profile.description').decodeHTML() : fieldValue(bean:template,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
              %{--<g:textArea class="countable2000 ${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="5" cols="120" name="description" value="${fieldValue(bean: template, field: 'profile.description').decodeHTML()}"/>--}%
            </td>
          </tr>

        </table>

      <p>Errechnete Gesamtdauer: ${calculatedDuration} Minuten</p>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>