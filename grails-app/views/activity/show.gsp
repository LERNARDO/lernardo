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
        <tr><td class="bold titles bezeichnung">Vorlage:</td><td class="bezeichnung"><g:link controller="template" action="show" params="[name:activity.template]">${activity.template}</g:link></td></tr>
        <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${activity.title}</td></tr>
        <tr><td class="bold titles bezeichnung">Start:</td><td class="bezeichnung"><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.date}"/></td></tr>
        <tr><td class="bold titles bezeichnung">Länge:</td><td class="bezeichnung">${activity.duration} Minuten</td></tr>
        <tr><td class="bold titles bezeichnung">Einrichtung:</td><td class="bezeichnung"><g:link controller="profile" action="showProfile" params="[name:activity.facility.name]">${activity.facility.profile.fullName}</g:link></td></tr>
        <tr><td class="bold titles bezeichnung">Erstellt von:</td><td class="bezeichnung"><g:link controller="profile" action="showProfile" params="[name:activity.owner.name]">${activity.owner.profile.fullName}</g:link></td></tr>
        <tr><td class="bold titles bezeichnung">Team:</td>
          <td class="bezeichnung">
        <g:each in="${activity.paeds}" var="paed">
          <g:link controller="profile" action="showProfile" params="[name:paed.name]">${paed.profile.fullName}</g:link><br>
        </g:each>
        </td>
        </tr>
        <tr><td class="bold titles bezeichnung">Teilnehmer:</td>
          <td class="bezeichnung">
        <g:each in="${activity.clients}" var="client">
          <g:link controller="profile" action="showProfile" params="[name:client.name]">${client.profile.fullName}</g:link><br>
        </g:each>
        </td>
        </tr>
      </table>
    </div>


  </body>


</html>