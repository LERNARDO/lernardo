<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Betreiber bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <h1>Betreiber bearbeiten</h1>
</div>
<div class="boxGray">
  <div class="body">

  %{--TODO: figure out why error messages are not shown?!?--}%
    <g:hasErrors bean="${operator}">
      <div class="errors">
        <g:renderErrors bean="${operator}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${operator.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="operatorProfile.fullName.label" default="Name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: operator, field: 'profile.fullName', 'errors')}" size="30" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: operator, field: 'profile.fullName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="operatorProfile.email.label" default="E-Mail"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: operator, field: 'user.email', 'errors')}" size="30" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: operator, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="PLZ">
                <g:message code="operatorProfile.PLZ.label" default="PLZ"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: operator, field: 'profile.PLZ', 'errors')}" size="30" id="PLZ" name="PLZ" value="${fieldValue(bean: operator, field: 'profile.PLZ')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="city">
                <g:message code="operatorProfile.city.label" default="Stadt"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: operator, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: operator, field: 'profile.city')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="street">
                <g:message code="operatorProfile.street.label" default="Straße"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: operator, field: 'profile.street', 'errors')}" size="30" id="street" name="street" value="${fieldValue(bean: operator, field: 'profile.street')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="operatorProfile.description.label" default="Beschreibung"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: operator, field: 'profile.description', 'errors')}" id="description" rows="6" cols="50" name="description" value="${fieldValue(bean: operator, field: 'profile.description')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="tel">
                <g:message code="operatorProfile.tel.label" default="Telefon"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: operator, field: 'profile.tel', 'errors')}" size="30" id="tel" name="tel" value="${fieldValue(bean: operator, field: 'profile.tel')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="showTips">
                <g:message code="operatorProfile.showTips.label" default="Zeige Tipps?"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${operator?.profile?.showTips}"/>
            </td>
          </tr>

          <app:isAdmin>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="enabled">
                  <g:message code="operatorProfile.enabled.label" default="Aktiv?"/>
                </label>

              </td>
              <td valign="top" class="value">
                <g:checkBox name="enabled" value="${operator?.user?.enabled}"/>
              </td>
            </tr>
          </app:isAdmin>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="Aktualisieren"/>
        <g:link class="buttonGray" action="del" id="${operator.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
        <g:link class="buttonGray" action="show" id="${operator.id}">Zurück</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>