<head>
  <title><g:message code="pass.forgotten"/></title>
  <meta name="layout" content="public"/>
</head>

<body>
  <h1><g:message code="pass.forgotten"/></h1>
  <p><g:message code="pass.reset"/></p>

  <g:form action="sendPassword">
    <p><g:textField name="email" size="40" value="${params.email}"/></p>

    <div class="buttons">
      <g:submitButton name="submitButton" value="Senden"/>
    </div>

  </g:form>
</body>