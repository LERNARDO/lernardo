<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Aktivität</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
</head>

<body>
<div class="headerGreen">
  <div class="second">
    <h1>Aktivität</h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">
    Vorlage:
    <app:getTemplate entity="${activity}">
      <g:link controller="templateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link>
    </app:getTemplate>
    <br/><br/>

    <table>

      <tr>
        <td class="name-show">Name:</td>
        <td class="name-show">Beginn:</td>
        <td class="name-show">Dauer:</td>
      </tr>

      <tr>
        <td width="220" class="value-show">
          <g:link controller="activity" action="show" id="${activity.id}" params="[entity: activity.id]">${activity.profile.fullName}</g:link>
        </td>
        <td width="300" class="value-show">
          <g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}"/>
        </td>
        <td width="220" class="value-show">${activity.profile.duration} Minuten</td>
      </tr>

      <tr>
        <td class="name-show">Einrichtung:</td>
        <td valign="bottom" class="label">Betreute:</td>
        <td class="name-show">Pädagogen:</td>
      </tr>

      <tr>
        <td valign="top" class="value-show"><app:getFacility entity="${activity}">
          <app:isEnabled entity="${facility}">
            <g:link controller="${facility.type.supertype.name +'Profile'}" action="show" id="${facility.id}">${facility.profile.fullName}</g:link>
          </app:isEnabled>
          <app:notEnabled entity="${facility}">
            <span class="notEnabled">${facility.profile.fullName}</span>
          </app:notEnabled>
        </app:getFacility>
        </td>

        <td valign="top" class="value-show"><app:getClients entity="${activity}">
          <g:each in="${clients}" var="client">
            <app:isEnabled entity="${client}">
              <g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}">${client.profile.fullName}</g:link>
            </app:isEnabled>
            <app:notEnabled entity="${client}">
              <span class="notEnabled">${client.profile.fullName}</span>
            </app:notEnabled><br>
          </g:each>
        </app:getClients>
        </td>

        <td valign="top" class="value-show-block"><app:getEducators entity="${activity}">
          <g:each in="${educators}" var="educator">
            <app:isEnabled entity="${educator}">
              <g:link controller="${educator.type.supertype.name +'Profile'}" action="show" id="${educator.id}">${educator.profile.fullName}</g:link>
            </app:isEnabled>
            <app:notEnabled entity="${educator}">
              <span class="notEnabled">${educator.profile.fullName}</span>
            </app:notEnabled><br>
          </g:each>
        </app:getEducators>
        </td>
      </tr>

      <tr>
        <td class="name-show"><g:message code="activityTemplate.description"/>:</td>
      </tr>
      <tr>
        <td colspan="3" class="value-show">${template?.profile?.description?.decodeHTML()}</td>
      </tr>

    </table>

    <div class="buttons">
      <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']">
        <g:link class="buttonGreen" action="edit" id="${activity.id}">Bearbeiten</g:link>
        <g:link class="buttonRed" action="del" onclick="${app.getLinks(id: activity.id)}" id="${activity.id}">Löschen</g:link>
      </app:hasRoleOrType>
      <g:link class="buttonGray" action="list"><g:message code="backtolist"/></g:link>
      <div class="spacer"></div>
    </div>


  %{-- this is only valid for theme activities --}%
    <g:if test="${activity.profile.type == 'theme'}">
    %{--clients and their status may only be added after the activity has started--}%
      <g:if test="${new Date() > activity.profile.date}">
        <div>
          <h1>Betreute <app:isMeOrAdmin entity="${entity}"><a onclick="toggle('#clients');
          return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Betreute hinzufügen"/></a></app:isMeOrAdmin></h1>
          <div id="clients" style="display:none">
            <g:formRemote name="formRemote" url="[controller:'activity', action:'addClient', id:activity.id]" update="clients2" before="showspinner('#clients2')">
              <g:select from="${clients}" name="client" optionKey="id" optionValue="profile"/>
              <g:select from="${['mitgearbeitet','nur anwesend']}" name="evaluation" value=""/>
              <div class="spacer"></div>
              <g:submitButton name="button" value="${message(code:'add')}"/>
              <div class="spacer"></div>
            </g:formRemote>
          </div>
          <div id="clients2">
            <g:render template="clients" model="${activity}"/>
          </div>
        </div>
      </g:if>
      <g:else>
        <p>Betreute können ab Beginn der Aktivität zugeordnet und beurteilt werden!</p>
      </g:else>
    </g:if>

  </div>
</div>

<app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: activity]"/>
</app:hasRoleOrType>

</body>
</html>