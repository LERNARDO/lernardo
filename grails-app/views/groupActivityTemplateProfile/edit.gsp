<head>
  <meta name="layout" content="private"/>
  <title><g:message code="groupActivityTemplate.edit"/></title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="groupActivityTemplate.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: group]"/>

    <g:form action="update" method="post" id="${group.id}">
      <div class="dialog">
        <table>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.name"/></td>
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.realDuration"/> (min)</td>
            <td valign="top" class="name"><g:message code="groupActivityTemplate.profile.status"/></td>
          </tr>

          <tr>
            <td width="500px" valign="top" class="value">
              <g:textField class="countable${group.profile.constraints.fullName.maxSize} ${hasErrors(bean: group, field: 'profile.fullName', 'errors')}" size="75" name="fullName" value="${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <td width="170px" valign="top" class="value">
              <g:textField class="${hasErrors(bean: group, field: 'profile.realDuration', 'errors')}" size="20" name="realDuration" value="${fieldValue(bean: group, field: 'profile.realDuration').decodeHTML()}"/>
            </td>
            <td valign="top" class="value">
              <g:select id="status" name="status" from="${['fertig','in Bearbeitung']}" value="${group?.profile?.status}"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="groupActivityTemplate.profile.description"/></td>
          </tr>
          <tr>
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" width="800px" toolbar="Basic">
                ${fieldValue(bean:group,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
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
