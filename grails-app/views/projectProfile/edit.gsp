<head>
  <meta name="layout" content="private"/>
  <title>Projekt bearbeiten</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Projekt bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <g:hasErrors bean="${project}">
      <div class="errors">
        <g:renderErrors bean="${project}" as="list"/>
      </div>
    </g:hasErrors>
    <g:form method="post" id="${project.id}">
      <g:hiddenField name="version" value="${project?.version}"/>
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="project.profile.name"/>
              </label>

            </td>
            <td valign="top" class="value">
              <g:textField class="countable${project.profile.constraints.fullName.maxSize} ${hasErrors(bean: project, field: 'fullName', 'errors')}" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: project, field: 'profile.fullName')}"/>
            </td>
          </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="del" id="${project.id}" onclick="${app.getLinks(id: project.id)}"><g:message code="delete"/></g:link>
        <g:link class="buttonGray" action="show" id="${project?.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
  </div>
</body>
