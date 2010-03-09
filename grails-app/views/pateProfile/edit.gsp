<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Pate bearbeiten</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Pate bearbeiten</h1>
  </div>
  <div class="boxGray">
    <div class="body">

    %{--TODO: figure out why error messages are not shown?!?--}%
      <g:hasErrors bean="${pate}">
      <div class="errors">
        <g:renderErrors bean="${pate}" as="list" />
      </div>
      </g:hasErrors>

      <g:form action="update" method="post" id="${pate.id}">
        <div class="dialog">
          <table>
            <tbody>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="firstName">
                      <g:message code="pateProfile.firstName.label" default="Vorname" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.firstName','errors')}" type="text" id="firstName" name="firstName" value="${fieldValue(bean:pate,field:'profile.firstName')}"/>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="lastName">
                      <g:message code="pateProfile.lastName.label" default="Nachname" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.lastName','errors')}" type="text" id="lastName" name="lastName" value="${fieldValue(bean:pate,field:'profile.lastName')}"/>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="PLZ">
                      <g:message code="pateProfile.PLZ.label" default="PLZ" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.PLZ','errors')}" type="text" id="PLZ" name="PLZ" value="${fieldValue(bean:pate,field:'profile.PLZ')}" />
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="city">
                      <g:message code="pateProfile.city.label" default="Stadt" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.city','errors')}" type="text" id="city" name="city" value="${fieldValue(bean:pate,field:'profile.city')}"/>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="languages">
                      <g:message code="pateProfile.languages.label" default="Sprachen" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <g:select multiple="true" name="languages" from="${['Deutsch', 'Englisch', 'Französisch', 'Spanisch', 'Portugiesisch']}" />
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="nationality">
                      <g:message code="pateProfile.nationality.label" default="Nationalität" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <g:select name="nationality" from="${['Deutschland', 'England', 'Frankreich', 'Spanien', 'Portugal','Österreich']}" />
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="street">
                      <g:message code="pateProfile.street.label" default="Straße" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.street','errors')}" type="text" id="street" name="street" value="${fieldValue(bean:pate,field:'profile.street')}"/>
                  </td>
              </tr>

            </tbody>
          </table>
        </div>
        <div class="buttons">
            <g:submitButton name="submitButton" value="Aktualisieren" />
            <g:link class="buttonGray" action="del" id="${partner.id}" onclick="return confirm('Bist du sicher?');">Löschen</g:link>
             <g:link class="buttonGray" action="show" id="${partner.id}">Zurück</g:link>
          <div class="spacer"></div>
        </div>
      </g:form>
    </div>
  </div>
</body>
