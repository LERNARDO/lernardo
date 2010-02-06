<head>
  <title>Lernardo | Passwort vergessen?</title>
  <meta name="layout" content="public"/>
</head>

<body>
  <h1>Passwort vergessen?</h1>
  <p>Bitte gib deine E-Mail Adresse ein, um dein Passwort zurückzusetzen.</p>

  <g:form action="sendPassword" method="post">
    <p><g:textField name="email" size="40" value="${params.email}"/></p>

    <div class="buttons">
      <g:submitButton name="submitButton" value="Senden"/>
    </div>

  </g:form>
</body>