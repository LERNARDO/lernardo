<%--
Created by IntelliJ IDEA.
    User: mkuhl
Date: 27.09.2009
Time: 16:08:55
To change this template use File | Settings | File Templates.
    --%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>${activity.title}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />    
  </head>

  <body>
    <div class="profile-group">Aktivitätsdetail</div>
    <div class="profile-box">
      <table width="100%">
        <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${activity.title}</td></tr>
        <tr><td class="bold titles bezeichnung">Start:</td><td class="bezeichnung">${activity.date} um ${activity.startTime}</td></tr>
        <tr><td class="bold titles bezeichnung">Länge:</td><td class="bezeichnung">${activity.duration}</td></tr>
        <tr><td class="bold titles bezeichnung">Einrichtung:</td><td class="bezeichnung">${einrichtung?.fullName} (${einrichtung?.ort}) </td></tr>
        <tr><td class="bold titles bezeichnung">Team:</td>
          <td class="bezeichnung">
        <g:each in="${activity.paedList}" var="paedListInstance">
          <g:set var="profileName" value="${paedListInstance}"/>
          <g:link controller="profile" action="show" params="[name:profileName]">${paedListInstance[0].toUpperCase()+paedListInstance.substring(1)}</g:link><br>
        </g:each>
        </td>
        </tr>
        <tr><td class="bold titles bezeichnung">Teilnehmer:</td>
          <td class="bezeichnung">
        <g:each in="${activity.clientList}" var="clientListInstance">
          <g:set var="profileName" value="${clientListInstance}"/>
          <g:link controller="profile" action="show" params="[name:profileName]">${clientListInstance[0].toUpperCase()+clientListInstance.substring(1)}</g:link><br>
        </g:each>
        </td>
        </tr>
      </table>
    </div>


  </body>


</html>