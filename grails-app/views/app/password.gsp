<head>
  <title>News</title>
  <meta name="layout" content="public"/>
  <g:javascript library="jquery"/>
</head>

<body>
<h1>Passwort vergessen?</h1>
<p>Bitte gib deine Email Adresse ein, um dein Passwort zurückzusetzen.</p>

<g:form action="sendPassword" method="post">
  <table>
    <tbody>

    <tr class="prop">
      <td valign="top" class="value">
        <input type="text" size="50" id="email" name="email" value="${params.email}"/>
      </td>
    </tr>

    <tr>
      <td>
        <div class="buttons">
          <span class="button"><g:actionSubmit class="save" action="sendPassword" value="Senden"/></span>
        </div>
      </td>
    </tr>

    </tbody>
  </table>
</g:form>
</body>