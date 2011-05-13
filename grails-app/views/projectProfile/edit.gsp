<head>
  <meta name="layout" content="private"/>
  <title><g:message code="project.edit"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="project.edit"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/errors" model="[bean: project]"/>

    <g:form id="${project.id}">
      <div>
        <table>
          <tbody>

        <tr class="prop">
            <td valign="top" class="name"><g:message code="project.profile.name"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <g:textField class="countable${project.profile.constraints.fullName.maxSize} ${hasErrors(bean: project, field: 'profile.fullName', 'errors')}" size="50" maxlength="80" name="fullName" value="${fieldValue(bean: project, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><g:message code="project.profile.description"/></td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value">
              <ckeditor:editor name="description" height="200px" width="800px" toolbar="Basic">
                ${fieldValue(bean:project,field:'profile.description').decodeHTML()}
              </ckeditor:editor>
              %{--<g:textArea class="countable${project.profile.constraints.description.maxSize} ${hasErrors(bean: project, field: 'profile.description', 'errors')}" rows="1" cols="75" name="description" value="${fieldValue(bean: project, field: 'profile.description').decodeHTML()}"/>
            </td>--}%
          </tr>

          </tbody>
        </table>
      </div>

      <div class="buttons">
        <div class="button"><g:actionSubmit class="buttonGreen" action="update" value="${message(code: 'save')}" /></div>
        <div class="button"><g:actionSubmit class="buttonGray" action="show" value="${message(code: 'cancel')}" /></div>
        <div class="spacer"></div>
      </div>
      
    </g:form>
  </div>
  </div>
</body>
