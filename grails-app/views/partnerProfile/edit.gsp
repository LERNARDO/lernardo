<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Partner bearbeiten</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Partner bearbeiten</h1>
  </div>
  <div class="boxGray">
    <div class="body">

    %{--TODO: figure out why error messages are not shown?!?--}%
      <g:hasErrors bean="${partner}">
      <div class="errors">
          <g:renderErrors bean="${partner}" as="list" />
      </div>
      </g:hasErrors>

      <g:form action="update" method="post" id="${partner.id}">
        <div class="dialog">
          <table>
            <tbody>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="fullName">
                      <g:message code="partnerProfile.fullName.label" default="Name" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.fullName','errors')}" type="text" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean:partner,field:'profile.fullName')}"/>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="description">
                      <g:message code="partnerProfile.description.label" default="Beschreibung" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <textarea class="${hasErrors(bean:partner,field:'profile.description','errors')}" rows="5" cols="40" id="description" name="description">${fieldValue(bean:partner, field:'profile.description')}</textarea>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="PLZ">
                      <g:message code="partnerProfile.PLZ.label" default="PLZ" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.PLZ','errors')}" type="text" id="PLZ" name="PLZ" value="${fieldValue(bean:partner,field:'profile.PLZ')}" />
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="city">
                      <g:message code="partnerProfile.city.label" default="Stadt" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.city','errors')}" type="text" id="city" name="city" value="${fieldValue(bean:partner,field:'profile.city')}"/>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="street">
                      <g:message code="partnerProfile.street.label" default="Straße" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.street','errors')}" type="text" id="street" name="street" value="${fieldValue(bean:partner,field:'profile.street')}"/>
                  </td>
              </tr>

              <tr class="prop">
                  <td valign="top" class="name">
                    <label for="tel">
                      <g:message code="partnerProfile.tel.label" default="Telefon" />
                    </label>

                  </td>
                  <td valign="top" class="value">
                      <input class="${hasErrors(bean:partner,field:'profile.tel','errors')}" type="text" id="tel" name="tel" value="${fieldValue(bean:partner,field:'profile.tel')}"/>
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
