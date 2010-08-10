<head>
  <meta name="layout" content="private"/>
  <title>Ressource anlegen</title>
</head>
<body>
<div class="headerGreen">
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
            <td valign="top" class="name"><g:message code="resource.profile.name"/></td>
            <td valign="top" class="name"><g:message code="resource.profile.type"/></td>
          </tr>

          <tr class="prop">
            <td width="540" valign="top" class="value">
              <g:textField class="countable50 ${hasErrors(bean: resource, field: 'profile.fullName', 'errors')}" size="80" name="fullName" value="${fieldValue(bean: resource, field: 'profile.fullName').decodeHTML()}"/>
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
              <g:textArea class="countable2000 ${hasErrors(bean: resource, field: 'profile.description', 'errors')}" rows="3" cols="120" name="description" value="${fieldValue(bean: resource, field: 'profile.description')}"/>
            </td>
          </tr>

          %{--<tr class="prop">
            <td valign="top" class="name">
              <label for="classification">
                <g:message code="resource.profile.classification"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="classification" from="${['Diese Ressource ist nur für diese Einrichtung verfügbar.','Diese Ressource ist für alle Einrichtungen in dieser Colonia verfügbar.','Diese Ressource steht für alle Einrichtungen im Betrieb zur Verfügung.']}" value="${fieldValue(bean:resource,field:'profile.classification')}" />
            </td>
          </tr>--}%

          <g:hiddenField name="classification" value=""/>

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
