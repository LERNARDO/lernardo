<head>
  <meta name="layout" content="private" />
  <title>Lernardo | Erziehungsberechtigten anlegen</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Erziehungsberechtigten anlegen</h1>
  </div>
  <div class="boxGray">

    <g:hasErrors bean="${parent}">
      <div class="errors">
        <g:renderErrors bean="${parent}" as="list" />
      </div>
    </g:hasErrors>

    <g:form action="save" method="post" >
      <div class="dialog">
        <table>
          <tbody>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="firstName">
                      <g:message code="parentProfile.firstName.label" default="Vorname" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:parent,field:'profile.firstName','errors')}" type="text" id="firstName" name="firstName" value="${fieldValue(bean:parent,field:'profile.firstName')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="lastName">
                      <g:message code="parentProfile.lastName.label" default="Nachname" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:parent,field:'profile.lastName','errors')}" type="text" id="lastName" name="lastName" value="${fieldValue(bean:parent,field:'profile.lastName')}"/>
                </td>
            </tr>
                        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="email">
                      <g:message code="parentProfile.email.label" default="E-Mail" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:parent,field:'user.email','errors')}" size="40" type="text" maxlength="80" id="email" name="email" value="${fieldValue(bean:parent, field:'user.email')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="PLZ">
                      <g:message code="parentProfile.PLZ.label" default="PLZ" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:parent,field:'profile.PLZ','errors')}" type="text" id="PLZ" name="PLZ" value="${fieldValue(bean:parent,field:'profile.PLZ')}" />
                </td>
            </tr>
                        
%{--            <tr class="prop">
                <td valign="top" class="name">
                    <label>
                      <g:message code="parentProfile.birthDate.label" default="Geburtsdatum" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <g:datePicker name="profile.birthDate" value="${parent?.profile?.birthDate}" precision="day" />
                </td>
            </tr>--}%

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="city">
                      <g:message code="parentProfile.city.label" default="Stadt" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:parent,field:'profile.city','errors')}" type="text" id="city" name="city" value="${fieldValue(bean:parent,field:'profile.city')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="doesWork">
                      <g:message code="parentProfile.doesWork.label" default="Berufstätig?" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <g:checkBox name="doesWork" value="${parent?.profile?.doesWork}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="familyStatus">
                      <g:message code="parentProfile.familyStatus.label" default="Familienstand" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:parent,field:'profile.familyStatus','errors')}" type="text" id="familyStatus" name="familyStatus" value="${fieldValue(bean:parent,field:'profile.familyStatus')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="gender">
                      <g:message code="parentProfile.gender.label" default="Geschlecht" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${fieldValue(bean:parent,field:'profile.gender')}" optionKey="key" optionValue="value"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="languages">
                      <g:message code="parentProfile.languages.label" default="Sprachen" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <g:select multiple="true" name="languages" from="${['Deutsch', 'Englisch', 'Französisch', 'Spanisch', 'Portugiesisch']}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="nationality">
                      <g:message code="parentProfile.nationality.label" default="Nationalität" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <g:select name="nationality" from="${['Deutschland', 'England', 'Frankreich', 'Spanien', 'Portugal','Österreich']}" />
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="qualification">
                      <g:message code="parentProfile.qualification.label" default="Qualifikationen" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:parent,field:'profile.qualification','errors')}" type="text" id="qualification" name="qualification" value="${fieldValue(bean:parent,field:'profile.qualification')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="street">
                      <g:message code="parentProfile.street.label" default="Straße" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:parent,field:'profile.street','errors')}" type="text" id="street" name="street" value="${fieldValue(bean:parent,field:'profile.street')}"/>
                </td>
            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="work">
                      <g:message code="parentProfile.work.label" default="Arbeit" />
                    </label>
                </td>
                <td valign="top" class="value">
                    <input class="${hasErrors(bean:parent,field:'profile.work','errors')}" type="text" id="work" name="work" value="${fieldValue(bean:parent,field:'profile.work')}"/>
                </td>
            </tr>
                        
            <tr class="prop">
                <td valign="top" class="name">
                  <label for="enabled">
                    <g:message code="parentProfile.enabled.label" default="Aktiv?" />
                  </label>

                </td>
                <td valign="top" class="value">
                    <g:checkBox name="enabled" value="${fieldValue(bean:parent,field:'user.enabled')}" />
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
