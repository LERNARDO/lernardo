<head>
  <title><g:message code="activityTemplate"/></title>
  <meta name="layout" content="private"/>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="activityTemplate"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p><g:message code="creator"/>: <erp:createdBy entity="${template}">${creator?.profile?.fullName?.decodeHTML()}</erp:createdBy></p>

    <table>

      <tr class="prop">
        <td colspan="3" valign="top" class="name-show">Typ:</td>
      </tr>

      <tr class="prop">
        <td colspan="3" valign="top" class="value-show">${template.profile.type}</td>
      </tr>

      <tr class="prop">
        <td colspan="2" valign="top" class="name-show"><g:message code="activityTemplate.name"/>:</td>
        <td valign="top" class="name-show"><g:message code="activityTemplate.duration"/>:</td>
      </tr>

      <tr>
        <td colspan="2" valign="top" class="value-show">
          <g:link controller="templateProfile" action="show" id="${template.id}" params="[entity: template.id]">${template.profile.fullName}</g:link>
        </td>
        <td valign="top" class="value-show">
          ${template.profile.duration} Minuten
        </td>
      </tr>

      <tr class="prop">
        <td width="210px" valign="top" class="name-show"><g:message code="activityTemplate.socialForm"/>:</td>
        <td width="190px" valign="top" class="name-show"><g:message code="activityTemplate.status"/>:</td>
        <td valign="top" class="name-show"><g:message code="activityTemplate.amountEducators"/>:</td>
      </tr>

      <tr>
        <td valign="top" class="value-show  ${hasErrors(bean: template, field: 'profile.socialForm', 'errors')}">
          ${template.profile.socialForm}
        </td>
        <td valign="top" class="value-show  ${hasErrors(bean: template, field: 'profile.status', 'errors')}">
          ${template.profile.status}
        </td>
        <td valign="top" class="value-show  ${hasErrors(bean: template, field: 'profile.amountEducators', 'errors')}">
          ${template.profile.amountEducators}
        </td>
      </tr>
      
      <tr class="prop">
        <td colspan="2" valign="top" class="name-show"><g:message code="activityTemplate.description"/>:</td>
        <td valign="top" class="name-show"><g:message code="activityTemplate.chosenMaterials"/>:</td>
      </tr>

      <tr>
        <td colspan="2" valign="top" class="value-show-block">${template.profile.description.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        <td width="390" valign="top" class="value-show-block">${template.profile.chosenMaterials.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </tr>

    </table>

    <div class="buttons">
      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']">
        <g:link class="buttonGreen" action="edit" id="${template.id}" params="[entity: template?.id]"><g:message code="edit"/></g:link>
      %{--<g:if test="${template.profile.status == 'fertig'}">
        <g:link class="buttonGreen" controller="activity" action="create" id="${template.id}">Themenraumaktivitäten planen</g:link>
      </g:if>--}%
        <g:link class="buttonGreen" action="copy" id="${template.id}"><g:message code="activityTemplate.copy"/></g:link>
      </erp:accessCheck>
      <g:link class="buttonGray" action="list"><g:message code="backToList"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="resources.required"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#resources');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ressourcen hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="resources" style="display:none">

        <g:formRemote name="formRemote" url="[controller:'templateProfile', action:'addResource', id: template.id]" update="resources2" before="showspinner('#resources2')">
          <table>
            <tr>
              <td><g:message code="resource.profile.name"/>:</td>
              <td><g:textField size="30" name="fullName" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.description"/>:</td>
              <td><g:textArea rows="5" cols="50" name="description" value=""/></td>
            </tr>
          </table>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>

      </div>
      <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[resources: resources, template: template, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="vMethods"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#methods');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Gewichtungsmethode hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="methods" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'templateProfile', action:'addMethod', id:template.id]" update="methods2" before="showspinner('#methods2')">
          <g:select name="method" from="${allMethods}" optionKey="id" optionValue="name"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="methods2">
        <g:render template="methods" model="[template: template, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>

<erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: template]"/>
</erp:accessCheck>

</body>