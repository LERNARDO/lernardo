<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Partner anlegen</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Partner anlegen</h1>
  </div>
  <div class="boxGray">

    <g:hasErrors bean="${partner}">
      <div class="errors">
        <g:renderErrors bean="${partner}" as="list" />
      </div>
    </g:hasErrors>

    <g:form action="save" method="post" >
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
                    <input class="${hasErrors(bean:partner,field:'profile.fullName','errors')}" size="40" type="text" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean:partner,field:'profile.fullName')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="email">
                      <g:message code="partnerProfile.email.label" default="E-Mail" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:partner,field:'user.email','errors')}" size="40" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean:partner, field:'user.email')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="description">
                      <g:message code="partnerProfile.description.label" default="Beschreibung" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <textarea class="${hasErrors(bean:partner,field:'profile.description','errors')}" rows="5" cols="37" id="description" name="description">${fieldValue(bean:partner, field:'profile.description')}</textarea>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="PLZ">
                      <g:message code="partnerProfile.PLZ.label" default="PLZ" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:partner,field:'profile.PLZ','errors')}" size="40" type="text" id="PLZ" name="PLZ" value="${fieldValue(bean:partner,field:'profile.PLZ')}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="city">
                      <g:message code="partnerProfile.city.label" default="Stadt" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:partner,field:'profile.city','errors')}" size="40" type="text" id="city" name="city" value="${fieldValue(bean:partner,field:'profile.city')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="street">
                      <g:message code="partnerProfile.street.label" default="Straße" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:partner,field:'profile.street','errors')}" size="40" type="text" id="street" name="street" value="${fieldValue(bean:partner,field:'profile.street')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="tel">
                      <g:message code="partnerProfile.tel.label" default="Telefon" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:partner,field:'profile.tel','errors')}" size="40" type="text" id="tel" name="tel" value="${fieldValue(bean:partner,field:'profile.tel')}"/>
                </td>
            </tr>
                        
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
