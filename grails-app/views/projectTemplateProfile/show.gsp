<head>
  <meta name="layout" content="planning"/>
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

    <g:render template="/templates/projectTemplateNavigation" model="[entity: projectTemplate]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="projectTemplateProfile" action="show" id="${projectTemplate.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${projectTemplate.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${projectTemplate}"/></g:remoteLink></li>
        <erp:accessCheck types="['Betreiber','Pädagoge']">
          <li><g:remoteLink style="border-right: none" update="content" controller="comment" action="show" id="${projectTemplate.id}"><g:message code="comments"/> (${projectTemplate.profile.comments.size()}) </g:remoteLink></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: projectTemplate]"/></span> <erp:accessCheck roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${projectTemplate.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: projectTemplate, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="status"/>:</td>
          <td class="two"><g:message code="status.${projectTemplate.profile.status}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: projectTemplate, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="projectTemplate.profile.educationalObjectiveText"/>:</td>
          <td class="two">${fieldValue(bean: projectTemplate, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageFrom"/></td>
          <td class="two">${projectTemplate?.profile?.ageFrom ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="activityTemplate.ageTo"/></td>
          <td class="two">${projectTemplate?.profile?.ageTo ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        </tbody>
      </table>

      <g:if test="${projectTemplate.profile.status != 'done'}">
        <div class="italic red"><g:message code="template.statusNotDone"/></div>
      </g:if>

      <h4><g:message code="management"/></h4>
      <div class="zusatz">
        <h5><g:message code="labels"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><a onclick="toggle('#labels');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="labels" style="display:none">
          <g:formRemote name="formRemote2" url="[controller:'projectTemplateProfile', action:'addLabel', id:projectTemplate.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
            <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="labels2">
          <g:render template="labels" model="[projectTemplate: projectTemplate, entity: currentEntity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="projectUnitTemplates"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><g:remoteLink action="addProjectUnitTemplate" update="projectunittemplates2" id="${projectTemplate.id}" before="showspinner('#projectunittemplates2')"><img src="${g.resource(dir: 'images/icons', file: 'icon_add-plus.png')}" alt="${message(code: 'add')}"/></g:remoteLink></erp:accessCheck></h5>
        <div class="zusatz-show" id="projectunittemplates2">
          <g:render template="projectUnitTemplates" model="[projectUnitTemplates: projectUnitTemplates, projectTemplate: projectTemplate, entity: currentEntity, allLabels: allLabels]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="resources.required"/> <erp:accessCheck types="['Betreiber', 'Pädagoge']" creatorof="${projectTemplate}" checkstatus="${projectTemplate}" checkoperator="true"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="resources" style="display:none">

          <g:formRemote name="formRemote" url="[controller:'resourceProfile', action:'addResource', id: projectTemplate.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
            <table>
              <tr>
                <td><g:message code="name"/>:</td>
                <td><g:textField id="resourceName" size="30" name="name" value=""/></td>
              </tr>
              <tr>
                <td><g:message code="description"/>:</td>
                <td><g:textArea id="resourceDescription" rows="5" cols="50" name="description" value=""/></td>
              </tr>
              <tr>
                <td><g:message code="resource.profile.amount"/>:</td>
                <td><g:textField size="5" name="amount" value="1"/></td>
              </tr>
            </table>
            <div class="clear"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="clear"></div>
          </g:formRemote>

        </div>
        <div class="zusatz-show" id="resources2">
          <g:render template="/requiredResources/resources" model="[template: projectTemplate, entity: currentEntity]"/>
        </div>
        <div id="templateresources">
          <g:render template="templateresources" model="[templateResources: templateResources, groupActivityTemplateResources: groupActivityTemplateResources, projectTemplate: projectTemplate]"/>
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
</div>

%{--<erp:accessCheck types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: projectTemplate]"/>
</erp:accessCheck>--}%

</body>
