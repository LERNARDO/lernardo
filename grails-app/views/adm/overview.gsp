<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Lernardo | Administrator Verwaltung</title></head>
<body>
  <h2>Übersicht</h2>

  <p><g:link controller="profile" action="showProfile">zurück zum Profil</g:link></p>

  <h3>Anzahl Betreiber: ${operatorList.size()}</h3>
  <div class="list">
    <ul>
      <g:each in="${operatorList}" var="operator">
        <li><g:link action="showOperator" params="[name:operator.name]">${operator.profile.fullName}</g:link> - <g:link class="adminButton" action="editOperator" params="[name:operator.name]">bearbeiten</g:link></li>
      </g:each>
    </ul>
  </div>
  <p><g:link class="adminButton" action="createOperator">Betreiber anlegen</g:link></p>

  <h3>Anzahl globale Aktivitätsvorlagen: ${templatesList.size()}</h3>
  <div class="list">
    <ul>
      <g:each in="${templatesList}" var="template">
        <li><g:link action="showTemplate" params="[name:template.name]">${template.name}</g:link></li>
      </g:each>
    </ul>
  </div>
</body>
</html>