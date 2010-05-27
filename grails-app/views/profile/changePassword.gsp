<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Passwort ändern</title>
</head>

<body>
<div class="headerBlue">
  <div class="second">
    <h1>Passwort ändern</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="yui-g" id="settings">
      <div class="settings-block-content">
        <g:form controller="profile" action="checkPassword" id="${entity.id}">
          <table cellpadding="0" cellspacing="0" border="0" id="settings-table">
            <tr>
              <td class="topic">Neues Passwort:</td>
              <td><g:passwordField name="password"/></td>
            </tr>
            <tr>
              <td class="topic">Passwort wiederholen:</td>
              <td><g:passwordField name="password2"/></td>
            </tr>
            <tr>
              <td>
                <g:submitButton name="checkPassword" value="Speichern"/>
                <g:link class="buttonGray" controller="${entity.type.supertype.name +'Profile'}" action="show" id="${entity.id}">Abbrechen</g:link>
              </td>
              <td>&nbsp;</td>
            </tr>
          </table>
        </g:form>
      </div>
    </div>
  </div>
</div>
</body>