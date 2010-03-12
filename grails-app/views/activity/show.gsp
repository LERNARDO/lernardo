<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <title>Lernardo | Aktivitätsdetails</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="private" />    
  </head>

  <body>
    <div class="headerBlue">
      <div class="second">
        <h1>Aktivitätsdetails</h1>
      </div>
    </div>

    <div class="boxGray">
      <div class="second">

        <table width="100%">
          <tr><td class="bold titles bezeichnung">Vorlage:</td><td class="bezeichnung"><app:getTemplate entity="${activity}">
            <g:link controller="template" action="show" id="${template.id}">${template.profile.fullName}</g:link>
            </app:getTemplate></td></tr>
          <tr><td class="bold titles bezeichnung">Name:</td><td class="bezeichnung">${activity.profile.fullName}</td></tr>
          <tr><td class="bold titles bezeichnung">Beginn:</td><td class="bezeichnung"><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}"/></td></tr>
          <tr><td class="bold titles bezeichnung">Dauer:</td><td class="bezeichnung">${activity.profile.duration} Minuten</td></tr>

          <tr><td class="bold titles bezeichnung">Einrichtung:</td><td class="bezeichnung"><app:getFacility entity="${activity}">
            <app:isEnabled entity="${facility}">
              <g:link controller="${facility.type.supertype.name +'Profile'}" action="show" id="${facility.id}">${facility.profile.fullName}</g:link>
            </app:isEnabled>
            <app:notEnabled entity="${facility}">
              <span class="notEnabled">${facility.profile.fullName}</span>
            </app:notEnabled>
            </app:getFacility></td>
          </tr>

          <tr><td class="bold titles bezeichnung">Erstellt von:</td><td class="bezeichnung"><app:getCreator entity="${activity}">
            <app:isEnabled entity="${creator}">
              <g:link controller="${creator.type.supertype.name +'Profile'}" action="show" id="${creator.id}">${creator.profile.fullName}</g:link>
            </app:isEnabled>
            <app:notEnabled entity="${creator}">
              <span class="notEnabled">${creator.profile.fullName}</span>
            </app:notEnabled>
            </app:getCreator></td>
          </tr>

          <tr><td class="bold titles bezeichnung">Pädagogen:</td><td class="bezeichnung"><app:getEducators entity="${activity}">
            <g:each in="${educators}" var="educator">
              <app:isEnabled entity="${educator}">
                <g:link controller="${educator.type.supertype.name +'Profile'}" action="show" id="${educator.id}">${educator.profile.fullName}</g:link>
              </app:isEnabled>
              <app:notEnabled entity="${educator}">
                <span class="notEnabled">${educator.profile.fullName}</span>
              </app:notEnabled><br>
            </g:each>
            </app:getEducators></td>
          </tr>

          <tr><td class="bold titles bezeichnung">Teilnehmer:</td><td class="bezeichnung"><app:getClients entity="${activity}">
            <g:each in="${clients}" var="client">
              <app:isEnabled entity="${client}">
                <g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}">${client.profile.fullName}</g:link>
              </app:isEnabled>
              <app:notEnabled entity="${client}">
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
    </div>
  </body>
</html>