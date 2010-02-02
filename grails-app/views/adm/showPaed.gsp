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
        <td>Titel:</td>
        <td>${entity.profile.title}</td>
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
      <tr>
        <td>Biographie:</td>
        <td>${entity.profile.biography}</td>
      </tr>     
    </table>
  
  </body>
</html>