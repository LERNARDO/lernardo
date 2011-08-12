<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title><g:message code="activity"/> - ${fieldValue(bean: activity, field: 'profile.fullName').decodeHTML()}</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="private"/>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="activity"/> - ${fieldValue(bean: activity, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>

<div class="boxGray">
  <div class="second">
    <g:message code="template"/>:
    <erp:getTemplate entity="${activity}">
      <g:link controller="templateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link>
    </erp:getTemplate>
    <br/><br/>

    <table style="width: 100%">

      <tr>
        <td class="name-show"><g:message code="name"/>:</td>
        <td class="name-show"><g:message code="activityInstance.profile.startDate"/>:</td>
        <td class="name-show"><g:message code="duration"/>:</td>
      </tr>

      <tr>
        <td class="value-show"><g:link controller="activityProfile" action="show" id="${activity.id}" params="[entity: activity.id]">${activity.profile.fullName}</g:link></td>
        <td class="value-show">
          <g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
        </td>
        <td class="value-show">${activity.profile.duration} Minuten</td>
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
      <g:form id="${activity.id}">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: activity.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="educators"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#educators');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="educators" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteEducators" action="remoteEducators" id="${activity.id}" before="showspinner('#remoteEducators');"/>
        <div id="remoteEducators"></div>

      </div>
      <div class="zusatz-show" id="educators2">
        <g:render template="educators" model="[educators: educators, entity: currentEntity, activity: activity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="clients"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#clients');
      return false" href="#" id="show-clients"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="clients" style="display:none">

        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${activity.id}" before="showspinner('#remoteClients');"/>
        <div id="remoteClients"></div>

      </div>
      <div class="zusatz-show" id="clients2">
        <g:render template="clients" model="[clients: clients, entity: currentEntity, activity: activity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="facility"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#facilities');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="facilities" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'activityProfile', action:'addFacility', id: activity.id]" update="facilities2" before="showspinner('#facilities2');">
          <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
          <g:submitButton name="button" value="${message(code:'add')}"/>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="facilities2">
        <g:render template="facilities" model="[facilities: facilities, activity: activity, entity: currentEntity]"/>
      </div>
    </div>

    %{-- this is only valid for theme activities --}%
    %{--<g:if test="${activity.profile.type == 'theme'}">
    --}%%{--clients and their status may only be added after the activity has started--}%%{--
      <g:if test="${new Date() > activity.profile.date}">
        <div>
          <h1><g:message code="clients"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#clients');
          return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h1>
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
        <p><g:message code="activity.clients"/></p>
      </g:else>
    </g:if>--}%

  </div>
</div>

<erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: activity]"/>
</erp:accessCheck>

</body>
</html>