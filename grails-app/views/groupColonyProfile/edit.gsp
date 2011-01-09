<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupColony.profile.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupColony.profile.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form action="update" id="${group.id}">
      <div class="dialog">
        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupColony.profile.name"/></td>
            <td valign="top" class="name"><g:message code="groupColony.profile.description"/></td>
          </tr>

          <tr class="prop">
            <td width="200" valign="top" class="value">
              <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="27" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="500" valign="top" class="value">
              <g:textArea class="countable${group.profile.constraints.description.maxSize} ${hasErrors(bean: group, field: 'profile.description', 'errors')}" rows="2" cols="93" name="description" value="${fieldValue(bean: group, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>
          
        </table>
      </div>

      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <erp:isOperator entity="${currentEntity}">
          <g:link class="buttonRed" action="del" id="${group.id}" onclick="${erp.getLinks(id: group.id)}"><g:message code="delete"/></g:link>
        </erp:isOperator>
        <g:link class="buttonGray" action="show" id="${group.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
