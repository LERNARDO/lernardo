<%--
  Created by IntelliJ IDEA.
  User: Alexander Zeillinger
  Date: 02.02.2010
  Time: 14:59:11
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Administrator Verwaltung</title></head>
  <body>
    <h2>Hortübersicht > ${facility.profile.fullName}</h2>

    <p><g:link action="listFacilities">zurück zu Hortübersicht</g:link></p>

    <h3>Anzahl Pädagogen: ${paedList.size()}</h3>
    <ul>
      <g:each in="${paedList}" var="paed">
        <li><g:link action="showPaed" params="[name:paed.name, facility: facility.name]">${paed.profile.fullName}</g:link></li>
      </g:each>
    </ul>

    <h3>Anzahl Betreute: ${clientList.size()}</h3>
    <ul>
      <g:each in="${clientList}" var="client">
        <li><g:link action="showClient" params="[name:client.name, facility: facility.name]">${client.profile.fullName}</g:link></li>
      </g:each>
    </ul>

    <h3>Details</h3>

    <table>
      <tr>
        <td>Kurzname:</td>
        <td>${facility.name}</td>
      </tr>
      <tr>
        <td>Postleitzahl:</td>
        <td>${facility.profile.PLZ}</td>
      </tr>
      <tr>
        <td>Stadt:</td>
        <td>${facility.profile.city}</td>
      </tr>
      <tr>
        <td>Straße:</td>
        <td>${facility.profile.street}</td>
      </tr>
      <tr>
        <td>Telefon:</td>
        <td>${facility.profile.tel}</td>
      </tr>
      <tr>
        <td>Beschreibung:</td>
        <td>${facility.profile.description}</td>
      </tr>
      <tr>
        <td>Essenskosten:</td>
        <td>${facility.profile.foodCosts}</td>
      </tr>
    </table>
  
  </body>
</html>