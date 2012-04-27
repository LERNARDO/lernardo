<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title><g:message code="activity"/> - ${fieldValue(bean: activity, field: 'profile.fullName').decodeHTML()}</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="planning"/>
</head>

<body>
<div class="boxHeader">
  <h1><g:message code="activity"/> - ${fieldValue(bean: activity, field: 'profile.fullName').decodeHTML()}</h1>
</div>

<div class="boxGray">
  <div class="second">

    <g:render template="/templates/activityNavigation" model="[entity: activity]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="activityProfile" action="show" id="${activity.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${activity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${activity}"/></g:remoteLink></li>
        <erp:accessCheck types="['Betreiber','Pädagoge']">
          <li><g:remoteLink style="border-right: none" update="content" controller="comment" action="show" id="${activity.id}"><g:message code="comments"/> (${activity.profile.comments.size()}) </g:remoteLink></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>

      <g:message code="template"/>:
      <erp:getTemplate entity="${activity}">
        <g:link controller="templateProfile" action="show" id="${template.id}">${template.profile.fullName}</g:link>
      </erp:getTemplate>
      <br/><br/>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/></td>
          <td class="two">${activity.profile.fullName}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="begin"/></td>
          <td class="two"><g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="duration"/></td>
          <td class="two">${activity.profile.duration} <g:message code="minutes"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/></td>
          <td class="two">${template?.profile?.description?.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

      </table>

      <h4><g:message code="management"/></h4>
      <div class="zusatz">
        <h5><g:message code="educators"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#educators');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="educators" style="display:none">

          <g:message code="search"/>:<br/>
          <g:remoteField size="40" name="remoteField" update="remoteEducators" action="remoteEducators" id="${activity.id}" before="showspinner('#remoteEducators');"/>
          <div id="remoteEducators"></div>

        </div>
        <div class="zusatz-show" id="educators2">
          <g:render template="educators" model="[educators: educators, activity: activity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="clients"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#clients');
        return false" href="#" id="show-clients"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="clients" style="display:none">

          <g:message code="search"/>:<br/>
          <g:remoteField size="40" name="remoteField" update="remoteClients" action="remoteClients" id="${activity.id}" before="showspinner('#remoteClients');"/>
          <div id="remoteClients"></div>

        </div>
        <div class="zusatz-show" id="clients2">
          <g:render template="clients" model="[clients: clients, activity: activity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="facility"/> <erp:accessCheck types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#facilities');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="facilities" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'activityProfile', action:'addFacility', id: activity.id]" update="facilities2" before="showspinner('#facilities2');">
            <g:select name="facility" from="${allFacilities}" optionKey="id" optionValue="profile"/>
            <g:submitButton name="button" value="${message(code:'add')}"/>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="facilities2">
          <g:render template="facilities" model="[facilities: facilities, activity: activity]"/>
        </div>
      </div>

      %{-- this is only valid for theme activities --}%
      %{--<g:if test="${activity.profile.type == 'theme'}">
      --}%%{--clients and their status may only be added after the activity has started--}%%{--
        <g:if test="${new Date() > activity.profile.date}">
          <div>
            <h1><g:message code="clients"/> <erp:accessCheck types="['Betreiber']"><a onclick="toggle('#clients');
            return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h1>
            <div id="clients" style="display:none">
              <g:formRemote name="formRemote" url="[controller:'activityProfile', action:'addClient', id:activity.id]" update="clients2" before="showspinner('#clients2')">
                <g:select from="${clients}" name="client" optionKey="id" optionValue="profile"/>
                <g:select from="${['mitgearbeitet','nur anwesend']}" name="evaluation" value=""/>
                <div class="clear"></div>
                <g:submitButton name="button" value="${message(code:'add')}"/>
                <div class="clear"></div>
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
</div>

</body>
</html>