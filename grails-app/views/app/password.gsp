<head>
  <title><g:message code="pass.forgotten"/></title>
  <meta name="layout" content="public2"/>
</head>

<body>

  <div style="text-align: center;">
    <p><g:message code="pass.reset"/></p>

    <g:form action="sendPassword">
      <g:textField name="email" size="40" value="${params.email}"/>

      <div style="margin-top: 10px;">
        <div class="button"><g:submitButton class="buttonGreen" name="submitButton" value="Zurücksetzen"/></div>
      </div>

    </g:form>
  </div>
</body>