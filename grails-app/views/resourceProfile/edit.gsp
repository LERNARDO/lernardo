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

    <g:render template="/templates/errors" model="[bean: resource]"/>

    <g:form action="update" method="post" id="${resource?.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="resource.profile.name"/></td>
            <td valign="top" class="name"><g:message code="resource.profile.type"/></td>
          </tr>

          <tr class="prop">
            <td width="540" valign="top" class="value">
              <g:textField class="countable${resource.profile.constraints.fullName.maxSize} ${hasErrors(bean: resource, field: 'profile.fullName', 'errors')}" size="80" maxlength="80" name="fullName" value="${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="340" valign="top" class="value">
              <g:select class="drop-down-240" name="type" from="${['verbrauchbar','vorzusehend']}" value="${fieldValue(bean:resource,field:'profile.type')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="2" valign="top" class="name"><g:message code="resource.profile.description"/></td>
          </tr>
          <tr>
            <td colspan="2" valign="top" class="value">
              <g:textArea class="countable${resource.profile.constraints.description.maxSize} ${hasErrors(bean: resource, field: 'profile.description', 'errors')}" rows="3" cols="120" name="description" value="${fieldValue(bean: resource, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          </tbody>
        </table>

      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <app:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${resource.id}" onclick="${app.getLinks(id: resource.id)}"><g:message code="delete"/></g:link>
        </app:isOperator>
        <g:link class="buttonGray" action="show" id="${resource?.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
</div>
</body>
