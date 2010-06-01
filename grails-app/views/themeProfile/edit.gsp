<head>
  <meta name="layout" content="private"/>
  <title>Thema bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Thema bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${theme}">
      <div class="errors">
        <g:renderErrors bean="${theme}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${theme.id}">
      <div class="dialog">
        <table>
          <tbody>
                        
          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="theme.profile.name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: theme, field: 'profile.fullName', 'errors')}" maxlength="50" id="fullName" name="fullName" value="${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="theme.profile.description"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: theme, field: 'profile.description', 'errors')}" rows="5" cols="40" name="description" value="${fieldValue(bean: theme, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="startDate">
                <g:message code="theme.profile.startDate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker class="${hasErrors(bean: theme, field: 'profile.startDate', 'errors')}" name="startDate" value="${theme?.profile?.startDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="endDate">
                <g:message code="theme.profile.endDate"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:datePicker class="${hasErrors(bean: theme, field: 'profile.endDate', 'errors')}" name="endDate" value="${theme?.profile?.endDate}" precision="day"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="type">
                <g:message code="theme.profile.type"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select class="${hasErrors(bean: theme, field: 'profile.type', 'errors')}" from="${['Thema','Subthema']}" id="type" name="type" value="${fieldValue(bean: theme, field: 'profile.type')}"/>
            </td>
          </tr>
                        
          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonGray" action="del" id="${theme.id}" onclick="${app.getLinks(id: theme.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${theme.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
