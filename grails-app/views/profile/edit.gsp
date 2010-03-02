<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Profildaten ändern</title>
</head>
<body>
  <div class="headerBlue">
    <h1>Profildaten ändern</h1>
  </div>
  <div class="boxGray">

    <g:hasErrors bean="${entity}">
      <div class="errors">
        <g:renderErrors bean="${entity}" as="list" />
      </div>
    </g:hasErrors>

    <g:form action="update" method="post" id="${entity.id}">
      <table>
        <tbody>

          <tr>
            <td class="label">Titel:</td>
            <td><g:textField name="title" size="40" value="${fieldValue(bean:entity,field:'profile.title')}"/></td>
          </tr>

          <tr>
            <td class="label">Name:</td>
            <td><g:textField name="fullName" size="40" value="${fieldValue(bean:entity,field:'profile.fullName')}"/></td>
          </tr>

          <tr>
            <td class="label">Geburtstag:</td>
            <td><g:datePicker name="birthDate" value="${entity.profile.birthDate}" precision="day" years="${1900..Calendar.getInstance().get(Calendar.YEAR)}"/></td>
          </tr>

          <tr>
            <td class="label">PLZ:</td>
            <td><g:textField name="PLZ" size="40" value="${entity.profile.PLZ}"/></td>
          </tr>

          <tr>
            <td class="label">Stadt:</td>
            <td><g:textField name="city" size="40" value="${fieldValue(bean:entity,field:'profile.city')}"/></td>
          </tr>

          <tr>
            <td class="label">Straße:</td>
            <td><g:textField name="street" size="40" value="${fieldValue(bean:entity,field:'profile.street')}"/></td>
          </tr>

          <tr>
            <td class="label">Telefon:</td>
            <td><g:textField name="tel" size="40" value="${fieldValue(bean:entity,field:'profile.tel')}"/></td>
          </tr>

          <tr>
            <td class="label">Geschlecht:</td>
            <td><g:select name="gender" from="${[1:'Männlich',2:'Weiblich']}" value="${entity.profile.gender}" optionKey="key" optionValue="value"/></td>
          </tr>

          <tr>
            <td class="label">Lebenslauf:</td>
            <td>
              <fckeditor:config CustomConfigurationsPath="${g.createLinkTo(dir:'js', file: 'fck-config.js')}"/>
              <fckeditor:editor name="biography" width="480" height="400" toolbar="Post" fileBrowser="default">
                ${entity.profile.biography}
              </fckeditor:editor>
            </td>
          </tr>

          <tr>
            <td class="label">Passwort:</td>
            <td><g:link action="changePassword" params="[name:entity.name]">Passwort ändern</g:link></td>
          </tr>

          <tr>
            <td class="label">Zeige Tipps:</td>
            <td><g:checkBox name="showTips" value="${entity.profile.showTips}" /></td>
          </tr>

          <tr>
            <td class="label">Sprache:</td>
            <td><g:select name="lang" from="${[1:'Deutsch',2:'Español']}" optionKey="key" optionValue="value"/></td>
          </tr>

        </tbody>
      </table>

      <div class="buttons">
          <g:submitButton name="submitButton" value="Ändern" />
          <g:link class="buttonGray" controller="profile" action="showProfile" params="[name:entity.name]">Abbrechen</g:link>
          <div class="spacer"></div>
      </div>
    </g:form>

  </div>

</body>