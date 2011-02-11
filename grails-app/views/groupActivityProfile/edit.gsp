<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivity.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupActivity.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form action="update" id="${group.id}">
      <div class="dialog">

        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupActivity.profile.name"/></td>
            <td valign="top" class="name"><g:message code="groupActivity.profile.realDuration"/></td>
            <td valign="top" class="name"><g:message code="groupActivity.profile.date"/></td>
          </tr>

          <tr>
            <td width="280px" valign="top" class="value">
              <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="40" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName')}"/>
            </td>
            <td width="180px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="15" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration')}"/> (min)
            </td>
            <td valign="top" class="value">
              <g:textField name="date" class="datetimepicker" value="${group?.profile?.date?.format('dd. MM. yyyy hh:mm')}"/>
              %{--<g:datePicker name="date" value="${group?.profile?.date}" precision="minute"/>--}%
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivity.profile.educationalObjective"/></td>
          </tr>

          <tr class="prop">
            <td colspans="3" valign="top" class="value">
              <g:select from="${['erreicht','nicht erreicht']}" class="drop-down-240" name="educationalObjective" value="${fieldValue(bean: group, field: 'profile.educationalObjective').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivity.profile.educationalObjectiveText"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="educationalObjectiveText" height="200px" width="800px" toolbar="Basic">
                ${fieldValue(bean:group,field:'profile.educationalObjectiveText').decodeHTML()}
              </ckeditor:editor>
              %{--<g:textArea class="countable${group.profile.constraints.educationalObjectiveText.maxSize} ${hasErrors(bean: group, field: 'profile.educationalObjectiveText', 'errors')}" rows="1" cols="80" name="educationalObjectiveText" value="${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML()}"/>--}%
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivity.profile.description"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" width="800px" toolbar="Basic">
                ${fieldValue(bean:group,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
              %{--<g:textArea class="countable${group.profile.constraints.description.maxSize} ${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="1" cols="75" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>--}%
            </td>
          </tr>

        </table>

      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" creatorof="${group}">
          <g:link class="buttonRed" action="del" id="${group.id}" onclick="${erp.getLinks(id: group.id)}"><g:message code="delete"/></g:link>
        </erp:accessCheck>
        <g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
