
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Passwort ändern</title>
</head>

<body>
<h1>Passwort ändern</h1>
<div class="yui-g" id="settings">
  <div class="settings-block-content">
    <g:form controller="profile" action="checkPassword" params="[name:entity.name]">
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
            <g:submitButton name="checkPassword" value="Speichern" />
            <span class="nav-button"><g:link action="showProfile" params="[name:entity?.name]">zurück</g:link></span>
          </td>
          <td>&nbsp;</td>
        </tr>
      </table>
    </g:form>
  </div>
</div>
</body>