<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
  <title>Lernardo | Einrichtungen ändern</title>
  <g:javascript library="jquery"/>
</head>
<body>
<p>${entity.profile.fullName} ist als Pädagoge in diesen Horten tätig:</p>
<g:form method="post" action="saveFacilities" params="[name:entity.name]">
  <g:select multiple="true" optionKey="id" optionValue="name"
          from="${hortList}"
          name="facilities"
          value="${horte?.collect{it.id}}"></g:select>
  <br/><span class="gray">Es können mehrere Horte mit STRG ausgewählt werden</span>
  <div class="buttons">
    <span class="button"><g:submitButton name="saveButton" value="Ändern"/></span>
    <span class="nav-button"><g:link action="showProfile">Abbrechen</g:link></span>
  </div>
</g:form>
</body>