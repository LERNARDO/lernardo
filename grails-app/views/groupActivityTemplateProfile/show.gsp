<head>
  <meta name="layout" content="private"/>
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
    <div>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: group]"/></span> <erp:isAdmin entity="${currentEntity}"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:isAdmin></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'app', action:'changeCreator', id:group.id]" update="creator" before="showspinner('#creator');" after="toggle('#setcreator');">
          <table>
            <tr>
              <td style="padding: 5px 10px 0 0;"><g:select name="creator" from="${allEducators}" optionKey="id" optionValue="profile"/></td>
              <td><g:submitButton name="button" value="${message(code:'change')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>

      <table>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="groupActivityTemplate.profile.name"/></td>
          <td valign="top" class="name-show"><g:message code="groupActivityTemplate.profile.realDuration"/></td>
          <td valign="top" class="name-show"><g:message code="groupActivityTemplate.profile.status"/></td>
        </tr>

        <tr>
          <td width="500px" valign="top" class="value-show">
            <g:link controller="${group.type.supertype.name+'Profile'}" action="show" id="${group.id}" params="[entity: group.id]">${fieldValue(bean: group, field: 'profile.fullName').decodeHTML()}</g:link>
          </td>
          <td width="170px" valign="top" class="value-show">
            ${fieldValue(bean: group, field: 'profile.realDuration')} min
          </td>
          <td valign="top" class="value-show">
            <g:message code="status.${group.profile.status}"/>
          </td>
        </tr>

        <tr class="prop">
          <td colspan="3" valign="top" class="name"><g:message code="groupActivityTemplate.profile.description"/></td>
        </tr>

        <tr>
          <td colspan="3" height="60" valign="top" class="value-show-block">
            ${fieldValue(bean: group, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
        </tr>

      </table>
    </div>

    <div class="buttons">
      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" creatorof="${group}">
        <g:link class="buttonGreen" action="edit" id="${group?.id}" params="[entity: group?.id]"><g:message code="edit"/></g:link>
        <g:link class="buttonRed" action="del" id="${group.id}" onclick="${erp.getLinks(id: group.id)}"><g:message code="delete"/></g:link>
      </erp:accessCheck>
      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']">
        <g:if test="${group.profile.status == 'done'}">
          <g:link class="buttonGreen" controller="groupActivityProfile" action="create" id="${group.id}"><g:message code="groupActivity.plan"/></g:link>
        </g:if>
        <g:link class="buttonGreen" action="copy" id="${group.id}"><g:message code="groupActivityTemplate.duplicate"/></g:link>
      </erp:accessCheck>
      <g:link class="buttonGray" action="list"><g:message code="backToList"/></g:link>
      <div class="spacer"></div>
    </div>

    <g:if test="${group.profile.status != 'done'}">
      <div class="italic red"><g:message code="template.statusNotDone"/></div>
    </g:if>

    <div class="zusatz">
      <h5><g:message code="activityTemplates"/> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" creatorof="${group}"><a onclick="toggle('#templates'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Aktivitätsvorlage hinzufügen"/></a></erp:accessCheck></h5>
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

<erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: group]"/>
</erp:accessCheck>

</body>
