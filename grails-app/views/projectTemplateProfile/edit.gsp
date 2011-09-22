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

    <g:form id="${projectTemplate?.id}">
        <table width="100%">

          <tr class="prop">
            <td valign="top" class="name"><g:message code="name"/></td>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${template}">
              <td valign="top" class="name"><g:message code="projectTemplate.profile.status"/></td>
            </erp:accessCheck>
          </tr>

          <tr>
            <td valign="top" class="value">
              <g:textField class="countable${projectTemplate.profile.constraints.fullName.maxSize} ${hasErrors(bean: projectTemplate, field: 'profile.fullName', 'errors')}" size="50" maxlength="50" name="fullName" value="${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}"/>
            </td>
            <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${projectTemplate}">
              <td valign="top" class="value">
                <g:select name="status" from="['done','notDone','notDoneOpen']" value="${fieldValue(bean: projectTemplate, field: 'profile.status')}" valueMessagePrefix="status"/>
              </td>
            </erp:accessCheck>
          </tr>

          <tr class="prop">
            <td colspan="2" valign="top" class="name"><g:message code="description"/></td>
          </tr>

          <tr>
            <td colspan="2" valign="top" class="value">
              <ckeditor:editor name="description" height="200px" toolbar="Basic">
                ${fieldValue(bean:projectTemplate,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="name"><g:message code="projectTemplate.profile.educationalObjectiveText"/></td>
          </tr>

          <tr class="prop">
            <td colspan="3" valign="top" class="value">
              <ckeditor:editor name="educationalObjectiveText" height="200px" toolbar="Basic">
                ${fieldValue(bean:project,field:'profile.educationalObjectiveText').decodeHTML()}
              </ckeditor:editor>
            </td>
          </tr>
          
        </table>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>

    </g:form>
  </div>
</div>
</body>