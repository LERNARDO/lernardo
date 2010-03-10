<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Lernardo | Einrichtung</title></head>
  <body>
    <h2>Übersicht > ${operator.profile.fullName} > ${facility.profile.fullName}</h2>

    <p><g:link action="showOperator" params="[name:operator.name]">zurück zu ${operator.profile.fullName}</g:link></p>

    <h3>Details</h3>
    <table class="table">
      <tr>
        <td class="bold">Kurzname:</td>
        <td>${facility.name}</td>
      </tr>
      <tr>
        <td class="bold">Name:</td>
        <td>${facility.profile.fullName}</td>
      </tr>
      <tr>
        <td class="bold">E-Mail:</td>
        <td>${facility.user.email}</td>
      </tr>
      <tr>
        <td class="bold">Aktiviert:</td>
        <td>${facility.user.enabled}</td>
      </tr>
      <tr>
        <td class="bold">Postleitzahl:</td>
        <td>${facility.profile.PLZ}</td>
      </tr>
      <tr>
        <td class="bold">Stadt:</td>
        <td>${facility.profile.city}</td>
      </tr>
      <tr>
        <td class="bold">Straße:</td>
        <td>${facility.profile.street}</td>
      </tr>
      <tr>
        <td class="bold">Telefon:</td>
        <td>${facility.profile.tel}</td>
      </tr>
      <tr>
        <td class="bold">Beschreibung:</td>
        <td>${facility.profile.description}</td>
      </tr>
      <tr>
        <td class="bold">Essenskosten:</td>
        <td>€${facility.profile.foodCosts}.-</td>
      </tr>
    </table>

    <h3>Anzahl Pädagogen: ${educators.size()}</h3>
    <ul>
      <g:each in="${educators}" var="educator">
        <li><g:link action="showEducator" params="[name:educator.name, facility: facility.name, operator: operator.name]">${educator.profile.fullName}</g:link></li>
      </g:each>
    </ul>

    <h3>Anzahl Betreute: ${clients.size()}</h3>
    <ul>
      <g:each in="${clients}" var="client">
        <li><g:link action="showClient" params="[name:client.name, facility: facility.name, operator: operator.name]">${client.profile.fullName}</g:link></li>
      </g:each>
    </ul>

  </body>
</html>