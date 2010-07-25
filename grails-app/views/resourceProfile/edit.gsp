<head>
  <meta name="layout" content="private"/>
  <title>Ressource bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Ressource bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${resource}">
      <div class="errors">
        <g:renderErrors bean="${resource}" as="list"/>
      </div>
    </g:hasErrors>
    
    <g:form action="update" method="post" id="${resource?.id}">
      <div class="dialog">
        <table>
          <tbody>
          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="resource.profile.name"/>
              </label>
            </td>
            <td valign="top" class="name">
              <label for="type">
                <g:message code="resource.profile.type"/>
              </label>
            </td>

          </tr>

          <tr class="prop">
            <td width="540" valign="top" class="value">
              <g:textField class="countable${resource.profile.constraints.fullName.maxSize} ${hasErrors(bean: resource, field: 'profile.fullName', 'errors')}" size="80" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}"/>
            </td>
              <td width="340" valign="top" class="value">
              <g:select class="drop-down-240" name="type" from="${['verbrauchbar','vorzusehend']}" value="${fieldValue(bean:resource,field:'profile.type')}" />
            </td>
          </tr>

          <tr class="prop">
            <td colspan="2" valign="top" class="name">
              <label for="description">
                <g:message code="resource.profile.description"/>
              </label>
            </td>
            </tr>
            <tr>
              <td colspan="2"  valign="top" class="value">
              <g:textArea class="countable${resource.profile.constraints.description.maxSize} ${hasErrors(bean: resource, field: 'profile.description', 'errors')}" id="description" rows="3" cols="120" name="description" value="${fieldValue(bean: resource, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          </tbody>
        </table>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${entity}">
          <g:link class="buttonRed" action="del" id="${resource.id}" onclick="${app.getLinks(id: resource.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${resource?.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
