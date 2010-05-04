<head>
  <meta name="layout" content="private"/>
  <title>Lernardo | Pate bearbeiten</title>
</head>
<body>
<div class="headerBlue">
  <div class="second">
    <h1>Pate bearbeiten</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:hasErrors bean="${pate}">
      <div class="errors">
        <g:renderErrors bean="${pate}" as="list"/>
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${pate.id}">
      <div class="dialog">
        <table>
          <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="firstName">
                <g:message code="pate.profile.firstName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.firstName', 'errors')}" size="30" id="firstName" name="firstName" value="${fieldValue(bean: pate, field: 'profile.firstName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lastName">
                <g:message code="pate.profile.lastName"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.lastName', 'errors')}" size="30" id="lastName" name="lastName" value="${fieldValue(bean: pate, field: 'profile.lastName').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email">
                <g:message code="pate.profile.email"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'user.email', 'errors')}" size="30" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean: pate, field: 'user.email')}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="country">
                <g:message code="pate.profile.country"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: partner, field: 'profile.country', 'errors')}" size="30" id="country" name="country" value="${fieldValue(bean: pate, field: 'profile.country').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="zip">
                <g:message code="pate.profile.zip"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.zip', 'errors')}" size="30" id="zip" name="zip" value="${fieldValue(bean: pate, field: 'profile.zip').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="city">
                <g:message code="pate.profile.city"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.city', 'errors')}" size="30" id="city" name="city" value="${fieldValue(bean: pate, field: 'profile.city').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="street">
                <g:message code="pate.profile.street"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:textField class="${hasErrors(bean: pate, field: 'profile.street', 'errors')}" size="30" id="street" name="street" value="${fieldValue(bean: pate, field: 'profile.street').decodeHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="motherTongue">
                <g:message code="pate.profile.motherTongue"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select class="${hasErrors(bean: pate, field: 'profile.motherTongue', 'errors')}" name="motherTongue" from="${grailsApplication.config.languages}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="languages">
                <g:message code="pate.profile.languages"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select class="${hasErrors(bean: pate, field: 'profile.languages', 'errors')}" multiple="true" name="languages" from="${grailsApplication.config.languages}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="lang">
                <g:message code="languageSelection"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:select name="lang" from="${[1:'Deutsch', 2:'Spanisch']}" optionKey="key" optionValue="value"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="showTips">
                <g:message code="showTips"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:checkBox name="showTips" value="${pate.profile.showTips}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label>
                <g:message code="password"/>
              </label>
            </td>
            <td valign="top" class="value">
              <g:link controller="profile" action="changePassword" id="${pate.id}">Passwort ändern</g:link>
            </td>
          </tr>

          <app:isAdmin>
            <tr class="prop">
              <td valign="top" class="name">
                <label for="enabled">
                  <g:message code="active" default="Aktiv?"/>
                </label>
              </td>
              <td valign="top" class="value">
                <g:checkBox name="enabled" value="${pate.user.enabled}"/>
              </td>
            </tr>

          </app:isAdmin>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <g:submitButton name="submitButton" value="${message(code:'save')}"/>
        <g:link class="buttonGray" action="show" id="${pate.id}"><g:message code="cancel"/></g:link>
        <div class="spacer"></div>
      </div>
    </g:form>
  </div>
</div>
</body>
