<head>
  <meta name="layout" content="planning"/>
  <title><g:message code="groupActivityTemplate"/> - ${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="groupActivityTemplate"/> - ${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

    <g:render template="/templates/groupActivityTemplateNavigation" model="[entity: entity]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="${group.type.supertype.name+'Profile'}" action="show" id="${group.id}" params="[entity: group.id]"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink update="content" controller="publication" action="list" id="${entity.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${entity}"/></g:remoteLink></li>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
          <li><g:remoteLink style="border-right: none" update="content" controller="comment" action="show" id="${entity.id}"><g:message code="comments"/> (${group.profile.comments.size()}) </g:remoteLink></li>
        </erp:accessCheck>
      </ul>
    </div>

    <div id="content">
      <h4><g:message code="profile"/></h4>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: group]"/></span> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${group.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/></td>
          <td class="two"><g:link controller="${group.type.supertype.name+'Profile'}" action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupActivityTemplate.profile.realDuration"/></td>
          <td class="two">${fieldValue(bean: group, field: 'profile.realDuration')} min</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="status"/></td>
          <td class="two"><g:message code="status.${group.profile.status}"/></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/></td>
          <td class="two">${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="groupActivityTemplate.profile.educationalObjectiveText"/></td>
          <td class="two">${fieldValue(bean: group, field: 'profile.educationalObjectiveText').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        </tbody>
      </table>

      <g:if test="${group.profile.status != 'done'}">
        <div class="italic red"><g:message code="template.statusNotDone"/></div>
      </g:if>

      <div class="zusatz">
        <h5><g:message code="labels"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${group}" checkstatus="${group}" checkoperator="true"><a onclick="toggle('#labels');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="labels" style="display:none">
          <g:formRemote name="formRemote2" url="[controller:'groupActivityTemplateProfile', action:'addLabel', id:group.id]" update="labels2" before="showspinner('#labels2');" after="toggle('#labels');">
            <g:select name="label" from="${allLabels}" optionKey="id" optionValue="name"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="labels2">
          <g:render template="labels" model="[group: group, entity: currentEntity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="activityTemplates"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']" creatorof="${group}" checkstatus="${group}" checkoperator="true"><a onclick="toggle('#templates'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="templates" style="display:none">
          <p><g:message code="activityTemplate.list.hint2"/></p>
          <g:formRemote name="formRemote0" url="[controller:'groupActivityTemplateProfile', action:'updateselect']" update="templateselect" before="showspinner('#templateselect');">

            <table>
              <tr>
                <td><g:message code="name"/>:</td>
                <td><g:textField name="name" size="30"/></td>
              </tr>
              <tr>
                <td><g:message code="duration"/>:</td>
                <td><g:select from="${1..239}" name="duration1" noSelection="['all':message(code:'any')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'secondselect', update:'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
                  <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> (min)</td>
              </tr>
              <tr>
                <td><g:message code="labels"/>:</td>
                <td><g:select from="${allLabels}" multiple="true" name="labels" value=""/></td>
              </tr>
              <tr>
                <td><g:message code="age"/>:</td>
                <td><g:message code="from"/>: <g:textField name="ageFrom" size="5"/> <g:message code="to"/>: <g:textField name="ageTo" size="5"/></td>
              </tr>
              <tr>
                <td style="vertical-align: top"><g:message code="vMethod"/> 1:</td>
                <td>
                  <g:select name="method1" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements1', params:'\'id=\' + this.value+\'&dropdown=\'+1')}"/>
                  <div id="elements1"></div>
                </td>
              </tr>
              <tr>
                <td style="vertical-align: top"><g:message code="vMethod"/> 2:</td>
                <td>
                  <g:select name="method2" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements2', params:'\'id=\' + this.value+\'&dropdown=\'+2')}"/>
                  <div id="elements2"></div>
                </td>
              </tr>
              <tr>
                <td style="vertical-align: top"><g:message code="vMethod"/> 3:</td>
                <td>
                  <g:select name="method3" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements3', params:'\'id=\' + this.value+\'&dropdown=\'+3')}"/>
                  <div id="elements3"></div>
                </td>
              </tr>
            </table>

            <g:submitButton name="button" value="${message(code:'define')}"/>
            <div class="spacer"></div>
          </g:formRemote>

          <g:formRemote name="formRemote" url="[controller:'groupActivityTemplateProfile', action:'addTemplate', id:group.id]" update="templates2" before="showspinner('#templates2');" after="toggle('#templates');">
            <div id="templateselect" style="margin-top: 10px;">
              <g:render template="searchresults" model="[allTemplates: allTemplates]"/>
            </div>
          </g:formRemote>

        </div>
        <div class="zusatz-show" id="templates2">
          <g:render template="templates" model="[group: group, templates: templates, entity: currentEntity]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="resources.required"/> <erp:accessCheck entity="${currentEntity}" types="['Betreiber', 'Pädagoge']" creatorof="${group}" checkstatus="${group}" checkoperator="true"><a onclick="clearElements(['#resourceName','#resourceDescription']); toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="${message(code: 'add')}"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="resources" style="display:none">

          <g:formRemote name="formRemote" url="[controller:'resourceProfile', action:'addResource', id: group.id]" update="resources2" before="showspinner('#resources2');" after="toggle('#resources');">
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
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>

        </div>
        <div class="zusatz-show" id="resources2">
          <g:render template="/requiredResources/resources" model="[template: group, entity: currentEntity]"/>
        </div>
        <g:if test="${templateResources}">
          <p><span class="bold"><g:message code="fromTemplates"/>:</span></p>
          <div class="zusatz-show">
            <g:each in="${templateResources}" var="resource">
              <div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
                <ul>
                  <li><span class="bold"><g:message code="name"/>:</span> ${resource.name}</li>
                  <li><g:message code="description"/>: ${resource.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'}</li>
                  <li><g:message code="resource.profile.amount"/>: ${resource.amount}</li>
                </ul>
              </div>
            </g:each>
          </div>
        </g:if>
      </div>

      <div class="zusatz">
        <h5><g:message code="template.plannedBlocks"/> (${instances.size}) <a onclick="toggle('#instances'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Instanzen"/></a></h5>
        <div class="zusatz-add" id="instances" style="display:none">
          <g:if test="${instances.size() > 0}">
            <ul>
            <g:each in="${instances}" var="instance">
              <li style="list-style-type: disc"><g:link controller="groupActivityProfile" action="show" id="${instance.id}">${instance.profile.fullName}</g:link></li>
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

%{--<erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: group]"/>
</erp:accessCheck>--}%

</body>
