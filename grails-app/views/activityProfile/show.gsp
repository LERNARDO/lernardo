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
    <erp:getTemplate entity="${activity}">
      <g:link controller="templateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link>
    </erp:getTemplate>
    <br/><br/>

    <table>

      <tr>
        <td class="name-show">Name:</td>
        <td class="name-show">Beginn:</td>
        <td class="name-show">Dauer:</td>
      </tr>

      <tr>
        <td width="220" class="value-show">
          <g:link controller="activityProfile" action="show" id="${activity.id}" params="[entity: activity.id]">${activity.profile.fullName}</g:link>
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
        <td valign="top" class="value-show"><erp:getFacility entity="${activity}">
          <erp:isEnabled entity="${facility}">
            <g:link controller="${facility.type.supertype.name +'Profile'}" action="show" id="${facility.id}">${facility.profile.fullName}</g:link>
          </erp:isEnabled>
          <erp:notEnabled entity="${facility}">
            <span class="notEnabled">${facility.profile.fullName}</span>
          </erp:notEnabled>
        </erp:getFacility>
        </td>

        <td valign="top" class="value-show"><erp:getClients entity="${activity}">
          <g:each in="${clients}" var="client">
            <erp:isEnabled entity="${client}">
              <g:link controller="${client.type.supertype.name +'Profile'}" action="show" id="${client.id}">${client.profile.fullName}</g:link>
            </erp:isEnabled>
            <erp:notEnabled entity="${client}">
              <span class="notEnabled">${client.profile.fullName}</span>
            </erp:notEnabled><br>
          </g:each>
        </erp:getClients>
        </td>

        <td valign="top" class="value-show-block"><erp:getEducators entity="${activity}">
          <g:each in="${educators}" var="educator">
            <erp:isEnabled entity="${educator}">
              <g:link controller="${educator.type.supertype.name +'Profile'}" action="show" id="${educator.id}">${educator.profile.fullName}</g:link>
            </erp:isEnabled>
            <erp:notEnabled entity="${educator}">
              <span class="notEnabled">${educator.profile.fullName}</span>
            </erp:notEnabled><br>
          </g:each>
        </erp:getEducators>
        </td>
      </tr>

      <tr>
        <td class="name-show"><g:message code="activityTemplate.description"/>:</td>
      </tr>
      <tr>
        <td colspan="3" class="value-show">
          <g:if test="${template?.profile?.description}">
            ${template?.profile?.description?.decodeHTML()}
          </g:if>
          <g:else>
            <div class="italic"><g:message code="noData"/></div>
          </g:else> </td>
      </tr>

    </table>

    <div class="buttons">
      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']">
        <g:link class="buttonGreen" action="edit" id="${activity.id}">Bearbeiten</g:link>
        <g:link class="buttonRed" action="del" onclick="${erp.getLinks(id: activity.id)}" id="${activity.id}">Löschen</g:link>
      </erp:accessCheck>
      <g:link class="buttonGray" action="list"><g:message code="backToList"/></g:link>
      <div class="spacer"></div>
    </div>


  %{-- this is only valid for theme activities --}%
    <g:if test="${activity.profile.type == 'theme'}">
    %{--clients and their status may only be added after the activity has started--}%
      <g:if test="${new Date() > activity.profile.date}">
        <div>
          <h1>Betreute <erp:isMeOrAdmin entity="${entity}"><a onclick="toggle('#clients');
          return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Betreute hinzufügen"/></a></erp:isMeOrAdmin></h1>
          <div id="clients" style="display:none">
            <g:formRemote name="formRemote" url="[controller:'activityProfile', action:'addClient', id:activity.id]" update="clients2" before="showspinner('#clients2')">
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

<erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: activity]"/>
</erp:accessCheck>

</body>
</html>