<head>
  <meta name="layout" content="private"/>
  <title><g:message code="projectTemplate"/> - ${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="projectTemplate"/> - ${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: projectTemplate]"/></span> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${projectTemplate.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table style="width: 100%">

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="projectTemplate.profile.name"/></td>
          <td valign="top" class="name-show"><g:message code="projectTemplate.profile.status"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">
            <g:link controller="projectTemplateProfile" action="show" id="${projectTemplate.id}" params="[entity: projectTemplate.id]">${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
          <td valign="top" class="value-show">
            <g:message code="status.${projectTemplate.profile.status}"/>
          </td>
        </tr>

        <tr class="prop">
          <td colspan="2" valign="top" class="name-show"><g:message code="projectTemplate.profile.description"/></td>
        </tr>

        <tr>
          <td colspan="2" valign="top" class="value-show-block">
            ${fieldValue(bean: projectTemplate, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
        </tr>

      </table>

    </div>

    <div class="buttons">
      <g:form id="${projectTemplate.id}" params="[entity: projectTemplate?.id]">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
        </erp:accessCheck>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${projectTemplate}">
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: projectTemplate.id)}" /></div>
        </erp:accessCheck>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
          <g:if test="${projectTemplate.profile.status == 'done'}">
            <g:link class="buttonGreen" controller="projectProfile" action="create" id="${projectTemplate.id}" params="[entity: projectTemplate?.id]"><g:message code="project.plan"/></g:link>
            %{--<div class="button"><g:actionSubmit class="buttonGreen" controller="projectProfile" action="create" value="${message(code: 'project.plan')}" /></div>--}%
          </g:if>
          <div class="button"><g:actionSubmit class="buttonGreen" action="copy" value="${message(code: 'projectTemplate.duplicate')}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <g:if test="${projectTemplate.profile.status != 'done'}">
      <div class="italic red"><g:message code="template.statusNotDone"/></div>
    </g:if>

    <div class="zusatz">
      <h5><g:message code="labels"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><a onclick="toggle('#labels');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="labels" style="display:none">
        <g:formRemote name="formRemote2" url="[controller:'projectTemplateProfile', action:'addLabel', id:projectTemplate.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
          <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>
      <div class="zusatz-show" id="labels2">
        <g:render template="labels" model="[projectTemplate: projectTemplate, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="projectUnitTemplates"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><g:remoteLink action="addProjectUnitTemplate" update="projectunittemplates2" id="${projectTemplate.id}" before="showspinner('#projectunittemplates2')"><img src="${g.resource(dir: 'images/icons', file: 'icon_add-plus.png')}" alt="${message(code: 'add')}"/></g:remoteLink>
      %{--<a onclick="toggle('#projectunits'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="${message(code: 'add')}"/></a>--}%</erp:accessCheck></h5>
      %{--<div class="zusatz-add" id="projectunits" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'projectTemplateProfile', action:'addProjectUnit', id: projectTemplate.id]" update="projectunits2" before="showspinner('#projectunits2')">
          Name: <g:textField name="fullName" size="40" value=""/>
          <div class="spacer"></div>
          <g:submitButton name="button" value="${message(code:'add')}"/>
          <div class="spacer"></div>
        </g:formRemote>
      </div>--}%
      <div class="zusatz-show" id="projectunittemplates2">
        <g:render template="projectUnitTemplates" model="[projectUnitTemplates: projectUnitTemplates, projectTemplate: projectTemplate, entity: currentEntity]"/>
      </div>
    </div>

    %{--<g:if test="${projectUnits}">
      <div>
        <h5>Aktivitätsvorlagengruppen <erp:isMeOrAdmin entity="${entity}"><a onclick="toggle('#groupActivityTemplates'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:isMeOrAdmin></h5>
        <div id="groupActivityTemplates" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'projectTemplateProfile', action:'addGroupActivityTemplate', id: projectTemplate.id]" update="projectunits2" before="showspinner('#groupActivityTemplates')">
            Aktivitätsvorlagengruppe: <g:select name="groupActivityTemplate" from="${allGroupActivityTemplates}" optionKey="id" optionValue="profile"/><br/>
            Hinzufügen zu: <g:select name="projectUnit" from="${projectUnits}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>
      </div>
    </g:if>--}%

    <div class="zusatz">
      <h5><g:message code="resources.required"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="resources" style="display:none">

        <g:formRemote name="formRemote" url="[controller:'groupActivityTemplateProfile', action:'addResource', id: projectTemplate.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
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
        <g:render template="resources" model="[group: projectTemplate, entity: currentEntity]"/>
      </div>
      <p><span class="bold">Aus Vorlagen:</span> <g:remoteLink update="templateresources" action="refreshtemplateresources" id="${projectTemplate.id}"><img src="${g.resource(dir:'images/icons', file:'arrow_refresh.png')}" alt="Aktualisieren" align="top"/></g:remoteLink></p>
      <div id="templateresources">
        <g:render template="templateresources" model="[templateResources: templateResources]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="template.plannedProjects"/> (${instances.size}) <a onclick="toggle('#instances'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Instanzen"/></a></h5>
      <div class="zusatz-add" id="instances" style="display:none">
        <g:if test="${instances.size() > 0}">
          <ul>
          <g:each in="${instances}" var="instance">
            <li style="list-style-type: disc"><g:link controller="projectProfile" action="show" id="${instance.id}">${instance.profile.fullName}</g:link></li>
          </g:each>
        </g:if>
        <g:else>
          <g:message code="template.notPlannedYet"/>
        </g:else>
      </div>
    </div>

  </div>
</div>

<erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: projectTemplate]"/>
</erp:accessCheck>

</body>
