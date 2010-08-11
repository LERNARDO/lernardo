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

    <g:render template="/templates/errors" model="[bean: projectTemplate]"/>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="projectTemplate.profile.name"/></td>
            <td valign="top" class="name"><g:message code="projectTemplate.profile.status"/></td>
          </tr>
          <tr>
            <td width="650px" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: projectTemplate, field: 'profile.fullName', 'errors')}" size="100" maxlength="80" name="fullName" value="${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:select from="${['fertig','in Bearbeitung']}" name="status" value="${fieldValue(bean: projectTemplate, field: 'profile.status')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="2" valign="top" class="name"><g:message code="projectTemplate.profile.description"/></td>
          </tr>

          <tr>
            <td colspan="2" valign="top" class="value">
              <g:textArea class="countable2000 ${hasErrors(bean: projectTemplate, field: 'profile.description', 'errors')}" rows="5" cols="125" name="description" value="${fieldValue(bean: projectTemplate, field: 'profile.description').decodeHTML()}"/>
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
