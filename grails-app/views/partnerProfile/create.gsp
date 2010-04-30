<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Partner anlegen</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Partner anlegen</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${partner}">
      <div class="errors">
        <g:renderErrors bean="${partner}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="save" method="post">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="fullName">
                <g:message code="partnerProfile.fullName.label" default="Name"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.fullName', 'errors')}" size="30" maxlength="80" id="fullName" name="fullName" value="${fieldValue(bean: partner, field: 'profile.fullName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="description">
                <g:message code="partnerProfile.description.label" default="Beschreibung"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textArea class="${hasErrors(bean: partner, field: 'profile.description', 'errors')}" rows="6" cols="50" id="description" name="description" value="${fieldValue(bean: partner, field: 'profile.description').decodeHTML()}"/>
            </td>
          </tr>
          
          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="partnerProfile.email.label" default="E-Mail"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'user.email', 'errors')}" size="30" maxlength="80" id="email" name="email" value="${fieldValue(bean: partner, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="website" class="name">
              <label for="email">
                <g:message code="partnerProfile.website.label" default="Webseite"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.website', 'errors')}" size="30" maxlength="80" id="website" name="website" value="${fieldValue(bean: partner, field: 'profile.website')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country">
                <g:message code="partnerProfile.PLZ.label" default="Land"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.country', 'errors')}" size="30" id="country" name="country" value="${fieldValue(bean: partner, field: 'profile.country').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="zip">
                <g:message code="partnerProfile.PLZ.label" default="PLZ"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.zip', 'errors')}" size="30" id="zip" name="zip" value="${fieldValue(bean: partner, field: 'profile.zip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="city">
                <g:message code="partnerProfile.city.label" default="Stadt"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: partner, field: 'profile.city').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="street">
                <g:message code="partnerProfile.street.label" default="Straße"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.street', 'errors')}" size="30" id="street" name="street" value="${fieldValue(bean: partner, field: 'profile.street').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="phone">
                <g:message code="partnerProfile.tel.label" default="Telefon"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.phone', 'errors')}" size="30" id="phone" name="phone" value="${fieldValue(bean: partner, field: 'profile.phone').decodeHTML()}"/>
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

          <tr class="prop">
            <td valign="top" class="name">
              <label for="enabled">
                <g:message code="partnerProfile.enabled.label" default="Aktiv?"/>
              </label>

            </td>
            <td valign="top" class="value">
              <g:checkBox name="enabled" value="${partner?.user?.enabled}"/>
            </td>
          </tr>

          </tbody>
        </table>

      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="Speichern"/>
        <g:link class="buttonGray" action="list">Abbrechen</g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
