<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | User anlegen</title>
</head>
<body>
<div class="headerBlue">
  <h1>User anlegen</h1>
</div>
<div class="boxGray">
  <g:hasErrors bean="${user}">
    <div class="errors">
      <g:renderErrors bean="${user}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="firstName">
              <g:message code="userProfile.firstName.label" default="Vorname"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class=" ${hasErrors(bean:user,field:'profile.firstName','errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean:user,field:'profile.firstName')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="lastName">
              <g:message code="userProfile.lastName.label" default="Nachname"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean:user,field:'profile.lastName','errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean:user,field:'profile.lastName')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="email">
              <g:message code="userProfile.email.label" default="E-Mail"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:textField class="${hasErrors(bean: user, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: user, field: 'user.email')}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="enabled">
              <g:message code="userProfile.enabled.label" default="Aktiv?"/>
            </label>
          </td>
          <td valign="top" class="value">
            <g:checkBox name="enabled" value="${user?.user?.enabled}"/>
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