<head>
  <title>Lernardo | Einrichtungen ändern</title>
  <meta name="layout" content="private"/>
</head>
<body>
  <p>${entity.profile.fullName} ist als Pädagoge in diesen Einrichtungen tätig:</p>

<g:form method="post" action="saveFacilities" params="[name:entity.name]">
    <g:select multiple="true" optionKey="id" optionValue="name"
            from="${facilityList}"
            name="facilities"
            value="${facilities?.collect{it.id}}"></g:select>
    <br/><span class="gray">Es können mehrere Einrichtungen mit STRG ausgewählt werden</span>
    <div class="buttons">
      <span class="button"><g:submitButton name="saveButton" value="Ändern"/></span>
      <span class="nav-button"><g:link action="showProfile">Abbrechen</g:link></span>
    </div>
  </g:form>

</body>