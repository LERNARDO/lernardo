<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Einrichtung bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <h1>Einrichtung bearbeiten</h1>
</div>
<div class="boxGray">
  <div class="body">

  %{--TODO: figure out why error messages are not shown?!?--}%
    <g:hasErrors bean="${facility}">
      <div class="errors">
        <g:renderErrors bean="${facility}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${facility.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="facilityProfile.fullName.label" default="Name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.fullName', 'errors')}" size="30" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: facility, field: 'profile.fullName')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="facilityProfile.description.label" default="Beschreibung"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: facility, field: 'profile.description', 'errors')}" rows="6" cols="50" id="description" name="description" value="${fieldValue(bean: facility, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="PLZ">
                <g:message code="facilityProfile.PLZ.label" default="PLZ"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.PLZ', 'errors')}" size="30" id="PLZ" name="PLZ" value="${facility?.profile?.PLZ?.toInteger()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="city">
                <g:message code="facilityProfile.city.label" default="Stadt"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: facility, field: 'profile.city').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="street">
                <g:message code="facilityProfile.street.label" default="Straße"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.street', 'errors')}" size="30" id="street" name="street" value="${fieldValue(bean: facility, field: 'profile.street').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="tel">
                <g:message code="facilityProfile.tel.label" default="Telefon"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: facility, field: 'profile.tel', 'errors')}" size="30" id="tel" name="tel" value="${fieldValue(bean: facility, field: 'profile.tel')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="tel">
                <g:message code="facilityProfile.showTips.label" default="Tipps?"/>
              </label>

            </td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${facility.profile.showTips}"/>
            </td>
          </tr>

          <app:isAdmin>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="enabled">
                  <g:message code="facilityProfile.enabled.label" default="Aktiv?"/>
                </label>

              </td>
              <td valign="top" class="value">
                <g:checkBox name="enabled" value="${facility.user.enabled}"/>
              </td>
            </tr>
          </app:isAdmin>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="Aktualisieren"/>
        <g:link class="buttonGray" action="del" id="${facility.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
        <g:link class="buttonGray" action="show" id="${facility.id}">Zurück</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
