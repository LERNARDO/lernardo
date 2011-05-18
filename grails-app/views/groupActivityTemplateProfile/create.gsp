<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivityTemplate.create"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupActivityTemplate.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form>
      <div>
        <table width="100%">

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.name"/></td>
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.realDuration"/></td>
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.status"/></td>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="50" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="20" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration').decodeHTML()}"/> (min)
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

          %{--      <tr class="prop">
            <td valign="top" class="name">
              <label for="templates">
                <g:message code="groupActivityTemplateProfile.description.label" />
              </label>
            </td>
            <td valign="top" class="value">
              <g:select multiple="true" name="templates" from="${templates}" optionKey="id" optionValue="profile"/>
            </td>
          </tr>--}%

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