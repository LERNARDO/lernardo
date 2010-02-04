<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Administrator Verwaltung</title></head>
  <body>
    <h2>Übersicht > ${operator.profile.fullName} > ${facility.profile.fullName} > ${entity.profile.fullName}</h2>

    <p><g:link action="showFacility" params="[name:facility.name, operator: operator.name]">zurück zu ${facility.profile.fullName}</g:link></p>

    <h3>Details</h3>
    <table class="table">
      <tr>
        <td class="bold">Kurzname:</td>
        <td>${entity.name}</td>
      </tr>
      <tr>
        <td class="bold">Geburtstag:</td>
        <td>${entity.profile.birthDate}</td>
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
        <td class="bold">Geschlecht:</td>
        <td>${entity.profile.gender}</td>
      </tr>
    </table>
  
  </body>
</html>