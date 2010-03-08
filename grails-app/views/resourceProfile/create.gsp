<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Ressource anlegen</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Ressource anlegen</h1>
  </div>
  <div class="boxGray">
    <g:hasErrors bean="${resource}">
      <div class="errors">
        <g:renderErrors bean="${resource}" as="list" />
      </div>
    </g:hasErrors>
    <g:form action="save" method="post" >
      <div class="dialog">
        <table>
          <tbody>

              <tr class="prop">
                  <td valign="top" class="name">
                      <label for="name">
                        <g:message code="resource.profile.fullName.label" default="Name" />
                      </label>
                  </td>
                  <td valign="top" class="value ${hasErrors(bean:resource,field:'profile.fullName','errors')}">
                      <input type="text" size="73" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean:resource,field:'profile.fullName')}"/>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                      <label for="description">
                        <g:message code="resource.profile.description.label" default="Beschreibung" />
                      </label>
                  </td>
                  <td valign="top" class="value ${hasErrors(bean:resource,field:'profile.description','errors')}">
                      <textarea rows="5" cols="70" name="description">${fieldValue(bean:resource, field:'profile.description')}</textarea>
                  </td>
              </tr>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="Anlegen"/>
        <g:link class="buttonGray" action="list">Zurück</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</body>
