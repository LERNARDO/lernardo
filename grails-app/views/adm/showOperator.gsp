<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Lernardo | Betreiber</title></head>
  <body>
    <h2>Übersicht > ${entity.profile.fullName}</h2>

    <p><g:link action="overview">zurück zur Übersicht</g:link></p>

<h3>Details</h3>
    <table class="table">
      <tr>
        <td class="bold">Kurzname:</td>
        <td>${entity.name}</td>
      </tr>
      <tr>
        <td class="bold">Name:</td>
        <td>${entity.profile.fullName}</td>
      </tr>
      <tr>
        <td class="bold">E-Mail:</td>
        <td>${entity.user.email}</td>
      </tr>
      <tr>
        <td class="bold">Aktiviert:</td>
        <td>${entity.user.enabled}</td>
      </tr>
      <tr>
        <td class="bold">Postleitzahl:</td>
        <td>${entity.profile.PLZ}</td>
      </tr>
      <tr>
        <td class="bold">Stadt:</td>
        <td>${entity.profile.city}</td>
      </tr>
      <tr>
        <td class="bold">Straße:</td>
        <td>${entity.profile.street}</td>
      </tr>
      <tr>
        <td class="bold">Telefon:</td>
        <td>${entity.profile.tel}</td>
      </tr>
      <tr>
        <td class="bold">Beschreibung:</td>
        <td>${entity.profile.description}</td>
      </tr>
    </table>

    <h3>Anzahl Einrichtungen: ${facilityList.size()}</h3>
    <ul>
      <g:each in="${facilityList}" var="facility">
        <li><g:link action="showFacility" params="[name:facility.name, operator: entity.name]">${facility.profile.fullName}</g:link></li>
      </g:each>
    </ul>

  </body>
</html>