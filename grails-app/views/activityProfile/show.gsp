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

    <table>

      <tr>
        <td class="name-show"><g:message code="name"/>:</td>
        <td class="name-show"><g:message code="activityInstance.profile.startDate"/>:</td>
        <td class="name-show"><g:message code="duration"/>:</td>
      </tr>

      <tr>
        <td width="220" class="value-show">
          <g:link controller="activityProfile" action="show" id="${activity.id}" params="[entity: activity.id]">${activity.profile.fullName}</g:link>
        </td>
        <td width="300" class="value-show">
          <g:formatDate format="dd. MM. yyyy, HH:mm" date="${activity.profile.date}" timeZone="${TimeZone.getTimeZone(grailsApplication.config.timeZone.toString())}"/>
        </td>
        <td width="220" class="value-show">${activity.profile.duration} Minuten</td>
      </tr>

      <tr>
        <td class="name-show"><g:message code="facility"/>:</td>
        <td valign="bottom" class="label"><g:message code="clients"/>:</td>
        <td class="name-show"><g:message code="educators"/>:</td>
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
      <g:form id="${activity.id}">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: activity.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>


  %{-- this is only valid for theme activities --}%
    <g:if test="${activity.profile.type == 'theme'}">
    %{--clients and their status may only be added after the activity has started--}%
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
    </g:if>

  </div>
</div>

<erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: activity]"/>
</erp:accessCheck>

</body>
</html>