<head>
  <title><g:message code="activityTemplate"/> - ${fieldValue(bean: template, field: 'profile.fullName').decodeHTML()}</title>
  <meta name="layout" content="private"/>
</head>

<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="activityTemplate"/> - ${fieldValue(bean: template, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: template]"/></span> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${template.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

    <table style="width: 100%">

      <tr class="prop">
        <td colspan="2" valign="top" class="name-show"><g:message code="activityTemplate.name"/>:</td>
        <td valign="top" class="name-show"><g:message code="activityTemplate.duration"/>:</td>
      </tr>

      <tr>
        <td colspan="2" valign="top" class="value-show">
          <g:link controller="templateProfile" action="show" id="${template.id}" params="[entity: template.id]">${template.profile.fullName}</g:link>
        </td>
        <td valign="top" class="value-show">
          ${template.profile.duration} <g:message code="minutes"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name-show"><g:message code="activityTemplate.socialForm"/>:</td>
        <td valign="top" class="name-show"><g:message code="activityTemplate.status"/>:</td>
        <td valign="top" class="name-show"><g:message code="activityTemplate.amountEducators"/>:</td>
      </tr>

      <tr>
        <td valign="top" class="value-show">
          <g:message code="socialForm.${template.profile.socialForm}"/>
        </td>
        <td valign="top" class="value-show">
          <g:message code="status.${template.profile.status}"/>
        </td>
        <td valign="top" class="value-show">
          ${template.profile.amountEducators}
        </td>
      </tr>
      
      <tr class="prop">
        <td colspan="2" valign="top" class="name-show"><g:message code="activityTemplate.description"/>:</td>
        <td valign="top" class="name-show"><g:message code="activityTemplate.chosenMaterials"/>:</td>
      </tr>

      <tr>
        <td colspan="2" valign="top" class="value-show-block">${template.profile.description.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        <td valign="top" class="value-show-block">${template.profile.chosenMaterials.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name-show"><g:message code="activityTemplate.ageFrom"/>:</td>
        <td valign="top" class="name-show"><g:message code="activityTemplate.ageTo"/>:</td>
        <td valign="top" class="name-show"><g:message code="activityTemplate.goal"/>:</td>
      </tr>

      <tr>
        <td valign="top" class="value-show">${template.profile.ageFrom ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        <td valign="top" class="value-show">${template.profile.ageTo ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        <td valign="top" class="value-show-block">${template?.profile?.goal?.decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
      </tr>

    </table>

    <div class="buttons">
      <g:form id="${template.id}" params="[entity: template?.id]">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        </erp:accessCheck>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${template}">
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: template.id)}" /></div>
        </erp:accessCheck>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
          <div class="button"><g:actionSubmit class="buttonGreen" action="copy" value="${message(code: 'activityTemplate.copy')}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="resources.required"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="resources" style="display:none">

        <g:formRemote name="formRemote" url="[controller:'templateProfile', action:'addResource', id: template.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
          <table>
            <tr>
              <td><g:message code="resource.profile.name"/>:</td>
              <td><g:textField id="resourceName" size="30" name="name" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.description"/>:</td>
              <td><g:textArea id="resourceDescription" rows="5" cols="50" name="description" value=""/></td>
            </tr>
            <tr>
              <td><g:message code="resource.profile.amount"/>:</td>
              <td><g:textField size="5" name="amount" value="1"/></td>
            </tr>
          </table>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>

      </div>
      <div class="zusatz-show" id="resources2">
        <g:render template="resources" model="[template: template, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="vMethods"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><a onclick="toggle('#methods');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="methods" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'templateProfile', action:'addMethod', id:template.id]" update="methods2" before="showspinner('#methods2');" after="toggle('#methods');">
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

    <div class="zusatz">
      <h5><g:message code="labels"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${template}" checkstatus="${template}" checkoperator="true"><a onclick="toggle('#labels');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="labels" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'templateProfile', action:'addLabel', id:template.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
          <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="labels2">
        <g:render template="labels" model="[template: template, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>

<erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: template]"/>
</erp:accessCheck>

</body>