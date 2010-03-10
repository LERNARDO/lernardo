<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Lernardo | Aktivitätsdetails</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />    
  </head>

  <body>
    <div class="headerBlue">
      <h1>Aktivitätsdetails</h1>
    </div>

    <div class="boxGray">
      <table width="100%">
        <tr><td class="bold titles bezeichnung">Vorlage:</td><td class="bezeichnung"><app:getTemplate entity="${activity}">
          <g:link controller="template" action="show" id="${template.id}">${template.profile.fullName}</g:link>
          </app:getTemplate></td></tr>
        <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${activity.profile.fullName}</td></tr>
        <tr><td class="bold titles bezeichnung">Beginn:</td><td class="bezeichnung"><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}"/></td></tr>
        <tr><td class="bold titles bezeichnung">Dauer:</td><td class="bezeichnung">${activity.profile.duration} Minuten</td></tr>

        <tr><td class="bold titles bezeichnung">Einrichtung:</td><td class="bezeichnung"><app:getFacility entity="${activity}">
          <app:isEnabled entityName="${facility.name}">
            <g:link controller="profile" action="showProfile" params="[name:facility.name]">${facility.profile.fullName}</g:link>
          </app:isEnabled>
          <app:notEnabled entityName="${facility.name}">
            <span class="notEnabled">${facility.profile.fullName}</span>
          </app:notEnabled>
          </app:getFacility></td>
        </tr>

        <tr><td class="bold titles bezeichnung">Erstellt von:</td><td class="bezeichnung"><app:getCreator entity="${activity}">
          <app:isEnabled entityName="${creator.name}">
            <g:link controller="profile" action="showProfile" params="[name:creator.name]">${creator.profile.fullName}</g:link>
          </app:isEnabled>
          <app:notEnabled entityName="${creator.name}">
            <span class="notEnabled">${creator.profile.fullName}</span>
          </app:notEnabled>
          </app:getCreator></td>
        </tr>

        <tr><td class="bold titles bezeichnung">Pädagogen:</td><td class="bezeichnung"><app:getEducators entity="${activity}">
          <g:each in="${educators}" var="educator">
            <app:isEnabled entityName="${educator.name}">
              <g:link controller="profile" action="showProfile" params="[name:educator.name]">${educator.profile.fullName}</g:link>
            </app:isEnabled>
            <app:notEnabled entityName="${educator.name}">
              <span class="notEnabled">${educator.profile.fullName}</span>
            </app:notEnabled><br>
          </g:each>
          </app:getEducators></td>
        </tr>

        <tr><td class="bold titles bezeichnung">Teilnehmer:</td><td class="bezeichnung"><app:getClients entity="${activity}">
          <g:each in="${clients}" var="client">
            <app:isEnabled entityName="${client.name}">
              <g:link controller="profile" action="showProfile" params="[name:client.name]">${client.profile.fullName}</g:link>
            </app:isEnabled>
            <app:notEnabled entityName="${client.name}">
              <span class="notEnabled">${client.profile.fullName}</span>
            </app:notEnabled><br>
          </g:each>
          </app:getClients></td>
        </tr>

      </table>

      <app:isEducator entity="${entity}">
          <g:link class="buttonBlue" action="edit" id="${activity.id}">Aktivität bearbeiten</g:link>
          <g:link class="buttonBlue" action="del" onclick="return confirm('Aktivität wirklich löschen?');" id="${activity.id}">Aktivität löschen</g:link>
          <g:link class="buttonGray" action="list">Zurück</g:link>
          <div class="spacer"></div>
      </app:isEducator>

    </div>

  </body>
</html>