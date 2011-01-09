<head>
  <meta name="layout" content="private"/>
  <title><g:message code="profile"/> - ${group.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile"/> - ${group.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
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
            ${fieldValue(bean: group, field: 'profile.status').decodeHTML()}
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
      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false">
        <erp:isCreator entity="${group}">
          <g:link class="buttonGreen" action="edit" id="${group?.id}"><g:message code="edit"/></g:link>
        </erp:isCreator>
        <g:link class="buttonGreen" action="copy" id="${group.id}">Vorlage duplizieren</g:link>

        %{-- and only when it is done --}%
          <g:if test="${group.profile.status == 'fertig'}">
            <g:link class="buttonGreen" controller="groupActivityProfile" action="create" id="${group.id}">Aktivitätsblock planen</g:link>
          </g:if>
      </erp:accessCheck>
      <g:link class="buttonGray" action="list"><g:message code="backToList"/></g:link>
      <div class="spacer"></div>
    </div>

    <g:if test="${group.profile.status != 'fertig'}">
      <div class="italic red">Diese Vorlage kann erst eingeplant werden, sobald der Status auf "fertig" gesetzt wurde!</div>
    </g:if>

    <div class="zusatz">
      <h5>Aktivitätsvorlagen <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#templates'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Aktivitätsvorlage hinzufügen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="templates" style="display:none">
        <p>Die Aktivitätsvorlagen können nach folgenden Merkmalen eingegrenzt werden: (max. 30 Treffer werden angezeigt!)</p>
        <g:formRemote name="formRemote0" url="[controller:'groupActivityTemplateProfile', action:'updateselect']" update="templateselect" before="showspinner('#templateselect')">

          <table>
            <tr>
              <td>Name:</td>
              <td><g:textField name="name" size="30"/></td>
            </tr>
            <tr>
              <td>Dauer:</td>
              <td><g:select from="${1..239}" name="duration1" noSelection="['all':'Beliebig']" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'secondselect', update:'secondSelect', params:'\'value=\' + this.value+\'&currentvalue=\'+document.getElementById(\'duration2\').value' )}"/>
                <span id="secondSelect"><span id="duration2" style="display: none">0</span></span> (min)</td>
            </tr>
            <tr>
              <td style="vertical-align: top">Bewertungsmethode 1:</td>
              <td>
                <g:select name="method1" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements1', params:'\'id=\' + this.value+\'&dropdown=\'+1')}"/>
                <div id="elements1"></div>
              </td>
            </tr>
            <tr>
              <td style="vertical-align: top">Bewertungsmethode 2:</td>
              <td>
                <g:select name="method2" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements2', params:'\'id=\' + this.value+\'&dropdown=\'+2')}"/>
                <div id="elements2"></div>
              </td>
            </tr>
            <tr>
              <td style="vertical-align: top">Bewertungsmethode 3:</td>
              <td>
                <g:select name="method3" from="${methods}" optionKey="id" optionValue="name" noSelection="['none':message(code:'non')]" onchange="${remoteFunction(controller:'groupActivityTemplateProfile', action:'listMethods', update:'elements3', params:'\'id=\' + this.value+\'&dropdown=\'+3')}"/>
                <div id="elements3"></div>
              </td>
            </tr>
          </table>

          <g:submitButton name="button" value="Eingrenzen"/>
          <div class="spacer"></div>
        </g:formRemote>

        <g:formRemote name="formRemote" url="[controller:'groupActivityTemplateProfile', action:'addTemplate', id:group.id]" update="templates2" before="showspinner('#templates2')">
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
      <h5>Geplante Blöcke aus dieser Vorlage (${instances.size}) <a onclick="toggle('#instances'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Instanzen"/></a></h5>
      <div class="zusatz-add" id="instances" style="display:none">
        <g:if test="${instances.size() > 0}">
          <ul>
          <g:each in="${instances}" var="instance">
            <li style="list-style-type: disc"><g:link controller="groupActivityProfile" action="show" id="${instance.id}">${instance.profile.fullName}</g:link></li>
          </g:each>
        </g:if>
        <g:else>
          Diese Vorlage wurde noch nicht geplant.
        </g:else>
      </div>
    </div>

  </div>
</div>

<erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false">
  <g:render template="/comment/box" model="[currentEntity: currentEntity, commented: group]"/>
</erp:accessCheck>

</body>
