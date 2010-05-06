<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Ressource anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Ressource anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <g:hasErrors bean="${resource}">
      <div class="errors">
        <g:renderErrors bean="${resource}" as="list"/>
      </div>
    </g:hasErrors>
    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="resource.profile.name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: resource, field: 'profile.fullName', 'errors')}" size="73" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: resource, field: 'profile.fullName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="resource.profile.description"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: resource, field: 'profile.description', 'errors')}" id="description" rows="5" cols="70" name="description" value="${fieldValue(bean: resource, field: 'profile.description')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="type">
                <g:message code="resource.profile.type"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="type" from="${['planbar','verbrauchbar','vorzusehend']}" value="${fieldValue(bean:resource,field:'profile.type')}" />
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="classification">
                <g:message code="resource.profile.classification"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="classification" from="${['Ressourcen die nur in einer Einrichtung verfügbar sind (Notebook, Turnsaal)','Ressourcen der Colonia unbeweglich/beweglich (abhängig von Einrichtung)','Ressourcen die für alle Einrichtungen verfügbar stehen (beweglich & unbeweglich)']}" value="${fieldValue(bean:resource,field:'profile.classification')}" />
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
