<head>
  <meta name="layout" content="private"/>
  <title>Thema anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Thema anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${theme}">
      <div class="errors">
        <g:renderErrors bean="${theme}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="theme.profile.name"/></td>
            <td valign="top" class="name"><g:message code="theme.profile.startDate"/></td>
            <td valign="top" class="name"><g:message code="theme.profile.endDate"/></td>
          </tr>

          <tr>
            <td width="300" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: theme, field: 'profile.fullName', 'errors')}" size="42" name="fullName" value="${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="230" valign="top" class="value">
              <g:textField name="startDate" size="30" class="datepicker ${hasErrors(bean: theme, field: 'profile.startDate', 'errors')}" value="${theme?.profile?.startDate?.format('dd. MM. yyyy')}"/>
            </td>
            <td width="230" valign="top" class="value">
              <g:textField name="endDate" size="30" class="datepicker ${hasErrors(bean: theme, field: 'profile.endDate', 'errors')}" value="${theme?.profile?.endDate?.format('dd. MM. yyyy')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="theme.profile.type"/></td>
            <td colspan="2" valign="top" class="name"><g:message code="facility"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <g:select class="${hasErrors(bean: theme, field: 'profile.type', 'errors')} drop-down-280" from="${['Übergeordnetes Thema','Subthema']}" name="type" value="${fieldValue(bean: theme, field: 'profile.type')}"/>
            </td>
            <td colspan="2" valign="top" class="value">
              <g:select from="${allFacilities}" class="drop-down-220" name="facility" optionKey="id" optionValue="profile" value=""/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="theme.profile.description"/></td>
          </tr>

          <tr>
            <td colspan="3" valign="top" class="value">
              <g:textArea class="countable2000 ${hasErrors(bean: theme, field: 'profile.description', 'errors')}" rows="3" cols="120" name="description" value="${fieldValue(bean: theme, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="list"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>