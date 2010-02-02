<%--
  Created by IntelliJ IDEA.
  User: Alexander Zeillinger
  Date: 02.02.2010
  Time: 15:17:38
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Administrator Verwaltung</title></head>
  <body>
    <h2>Hortübersicht > ${facility.profile.fullName} > ${entity.profile.fullName}</h2>

    <p><g:link action="showFacility" params="[name:facility.name]">zurück zu ${facility.profile.fullName}</g:link></p>

    <h3>Details</h3>
    <table>
      <tr>
        <td>Kurzname:</td>
        <td>${entity.name}</td>
      </tr>
      <tr>
        <td>Geburtstag:</td>
        <td>${entity.profile.birthDate}</td>
      </tr>
      <tr>
        <td>Postleitzahl:</td>
        <td>${entity.profile.PLZ}</td>
      </tr>
      <tr>
        <td>Stadt:</td>
        <td>${entity.profile.city}</td>
      </tr>
      <tr>
        <td>Straße:</td>
        <td>${entity.profile.street}</td>
      </tr>
      <tr>
        <td>Telefon:</td>
        <td>${entity.profile.tel}</td>
      </tr>
      <tr>
        <td>Geschlecht:</td>
        <td>${entity.profile.gender}</td>
      </tr>
      %{--<tr>
        <td>Erziehungsberechtigte:</td>
        <td>${entity.profile.guardians}</td>
      </tr>
      <tr>
        <td>Schule:</td>
        <td>${entity.profile.school}</td>
      </tr>
      <tr>
        <td>Schulklasse:</td>
        <td>${entity.profile.schoolclass}</td>
      </tr>
      <tr>
        <td>Allergien:</td>
        <td>${entity.profile.allergies}</td>
      </tr>
      <tr>
        <td>Krankheiten:</td>
        <td>${entity.profile.illnesses}</td>
      </tr>
      <tr>
        <td>Einschränkungen:</td>
        <td>${entity.profile.limitations}</td>
      </tr>
      <tr>
        <td>Kommt alleine:</td>
        <td>${entity.profile.comesAlone}</td>
      </tr>
      <tr>
        <td>Geht alleine:</td>
        <td>${entity.profile.goesAlone}</td>
      </tr>
      <tr>
        <td>Zeige Tipps:</td>
        <td>${entity.profile.showTips}</td>
      </tr>--}%
    </table>
  
  </body>
</html>