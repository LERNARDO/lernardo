<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Partner bearbeiten</title>
</head>
<body>
  <div class="headerBlue">
    <div class="second">
      <h1>Partner bearbeiten</h1>
    </div>
  </div>
  <div class="boxGray">
    <div class="second">

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
              <label for="email">
                <g:message code="partnerProfile.email.label" default="E-Mail"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'user.email', 'errors')}" size="30" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: partner, field: 'user.email')}"/>
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

              <tr class="prop">
                <td valign="top" class="name">
                  <label for="lang">
                    <g:message code="partnerProfile.lang.label" default="Spracheinstellung"/>
                  </label>
                </td>
                <td valign="top" class="value">
                  <g:select name="lang" from="${[1:'Deutsch', 2:'Spanisch']}" optionKey="key" optionValue="value"/>
                </td>
              </tr>

              <app:isAdmin>
                <tr class="prop">
                    <td valign="top" class="name">
                      <label for="enabled">
                        <g:message code="partnerProfile.enabled.label" default="Aktiv?" />
                      </label>
  
                    </td>
                    <td valign="top" class="value">
                        <g:checkBox name="enabled" value="${fieldValue(bean:partner,field:'user.enabled')}" />
                    </td>
                </tr>
              </app:isAdmin>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="partnerProfile.showTips.label" default="Passwort"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:link controller="profile" action="changePassword" id="${partner.id}">Passwort ändern</g:link>
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
