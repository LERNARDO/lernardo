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
    <div class="headerBlue">
      <h1>Aktivität</h1>
    </div>
  <div class="boxGray">
    <div class="profile-box">
      <table width="100%">
        <tr><td class="bold titles bezeichnung">Vorlage:</td><td class="bezeichnung"><g:link controller="template" action="show" params="[name:activity.template]">${activity.template}</g:link></td></tr>
        <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${activity.title}</td></tr>
        <tr><td class="bold titles bezeichnung">Start:</td><td class="bezeichnung"><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.date}"/></td></tr>
        <tr><td class="bold titles bezeichnung">Dauer:</td><td class="bezeichnung">${activity.duration} Minuten</td></tr>
        <tr><td class="bold titles bezeichnung">Einrichtung:</td><td class="bezeichnung">
          <app:isEnabled entityName="${activity.facility.name}">
            <g:link controller="profile" action="showProfile" params="[name:activity.facility.name]">${activity.facility.profile.fullName}</g:link>
          </app:isEnabled>
          <app:notEnabled entityName="${activity.facility.name}">
            <span class="notEnabled">${activity.facility.profile.fullName}</span>
          </app:notEnabled></td></tr>
        <tr><td class="bold titles bezeichnung">Erstellt von:</td><td class="bezeichnung">
          <app:isEnabled entityName="${activity.owner.name}">
            <g:link controller="profile" action="showProfile" params="[name:activity.owner.name]">${activity.owner.profile.fullName}</g:link>
          </app:isEnabled>
          <app:notEnabled entityName="${activity.owner.name}">
            <span class="notEnabled">${activity.owner.profile.fullName}</span>
          </app:notEnabled></td></tr>
        <tr><td class="bold titles bezeichnung">Pädagogen:</td>
          <td class="bezeichnung">
            <g:each in="${activity.paeds}" var="paed">
              <app:isEnabled entityName="${paed.name}">
                <g:link controller="profile" action="showProfile" params="[name:paed.name]">${paed.profile.fullName}</g:link>
              </app:isEnabled>
              <app:notEnabled entityName="${paed.name}">
                <span class="notEnabled">${paed.profile.fullName}</span>
              </app:notEnabled><br>
            </g:each>
          </td>
        </tr>
        <tr><td class="bold titles bezeichnung">Teilnehmer:</td>
          <td class="bezeichnung">
            <g:each in="${activity.clients}" var="client">
              <app:isEnabled entityName="${client.name}">
                <g:link controller="profile" action="showProfile" params="[name:client.name]">${client.profile.fullName}</g:link>
              </app:isEnabled>
              <app:notEnabled entityName="${client.name}">
                <span class="notEnabled">${client.profile.fullName}</span>
              </app:notEnabled><br>
            </g:each>
          </td>
        </tr>
      </table>

      <g:if test="${entity.type.name == 'Paed'}">
          <g:link class="buttonBlue" action="edit" id="${activity.id}">Aktivität bearbeiten</g:link>
          <g:link class="buttonBlue" action="del" id="${activity.id}">Aktivität löschen</g:link>
          <div class="spacer"></div>
      </g:if>
      
    </div>
  </div>
  </body>


</html>