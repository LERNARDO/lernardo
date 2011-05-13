<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivityTemplate.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupActivityTemplate.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form id="${group.id}">
      <div>
        <table width="100%">

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.name"/></td>
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.realDuration"/> (min)</td>
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.status"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="50" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="20" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:select name="status" from="['done','notDone']" value="${group?.profile?.status}" valueMessagePrefix="status"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivityTemplate.profile.description"/></td>
          </tr>
          <tr>
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" toolbar="Basic">
                ${fieldValue(bean:group,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
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
