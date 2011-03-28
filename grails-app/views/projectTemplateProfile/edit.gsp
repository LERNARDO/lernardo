<head>
  <meta name="layout" content="private"/>
  <title><g:message code="projectTemplate.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="projectTemplate.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: projectTemplate]"/>

    <g:form action="update" id="${projectTemplate?.id}">
      <div>
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
              <g:select name="status" from="['done','notDone']" value="${fieldValue(bean: projectTemplate, field: 'profile.status')}" valueMessagePrefix="status"/>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="2" valign="top" class="name"><g:message code="projectTemplate.profile.description"/></td>
          </tr>

          <tr>
            <td colspan="2" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" width="800px" toolbar="Basic">
                ${fieldValue(bean:projectTemplate,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>
          
          </tbody>
        </table>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonRed" action="del" id="${projectTemplate.id}" onclick="${erp.getLinks(id: projectTemplate.id)}"><g:message code="delete"/></g:link>
        <g:link class="buttonGray" action="show" id="${projectTemplate?.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>