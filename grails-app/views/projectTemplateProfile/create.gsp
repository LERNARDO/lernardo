<head>
  <meta name="layout" content="private"/>
  <title>Projektvorlage anlegen</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Projektvorlage anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <g:hasErrors bean="${projectTemplate}">
      <div class="errors">
        <g:renderErrors bean="${projectTemplate}" as="list"/>
      </div>
    </g:hasErrors>
    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="projectTemplate.profile.name"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="status">
                <g:message code="projectTemplate.profile.status"/>
              </label>
            </td>
            </tr>
            <tr>
            <td width="650px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: projectTemplate, field: 'profile.fullName', 'errors')}" size="100" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: projectTemplate, field: 'profile.fullName')}"/>
            </td>
              <td valign="top" class="value">
              <g:select from="${['fertig','unfertig']}" id="status" name="status" value="${fieldValue(bean: projectTemplate, field: 'profile.status')}"/>
            </td>
          </tr>



          <tr class="prop">
            <td colspan="2" valign="top" class="name">
              <label for="description">
                <g:message code="projectTemplate.profile.description"/>
              </label>
            </td>
          </tr>
            <tr>
            <td colspan="2" valign="top" class="value">
              <g:textArea class="${hasErrors(bean: projectTemplate, field: 'profile.description', 'errors')}" rows="5" cols="125" name="description" value="${fieldValue(bean: projectTemplate, field: 'profile.description')}"/>
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
