<head>
  <meta name="layout" content="private"/>
  <title>Projektvorlage bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Projektvorlage bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${projectTemplate}">
      <div class="errors">
        <g:renderErrors bean="${projectTemplate}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${projectTemplate?.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="projectTemplate.profile.name"/></td>
            <td valign="top" class="name"><g:message code="projectTemplate.profile.status"/></td>
          </tr>

          <tr>
            <td width="650px" valign="top" class="value">
              <g:textField class="countable${projectTemplate.profile.constraints.fullName.maxSize} ${hasErrors(bean: projectTemplate, field: 'profile.fullName', 'errors')}" size="100" maxlength="80" name="fullName" value="${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}"/>
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
              <g:textArea class="countable${projectTemplate.profile.constraints.description.maxSize} ${hasErrors(bean: projectTemplate, field: 'profile.description', 'errors')}" rows="5" cols="125" name="description" value="${fieldValue(bean: projectTemplate, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>
          </tbody>
        </table>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonRed" action="del" id="${projectTemplate.id}" onclick="${app.getLinks(id: projectTemplate.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${projectTemplate?.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>