<head>
  <meta name="layout" content="private"/>
  <title><g:message code="theme"/> - ${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="theme"/> - ${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: theme]"/></span> <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${theme.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table style="width: 100%">

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="name"/></td>
          <td valign="top" class="name-show"><g:message code="theme.profile.startDate"/></td>
          <td valign="top" class="name-show"><g:message code="theme.profile.endDate"/></td>
        </tr>

        <tr>
          <td valign="top" class="value-show">${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}</td>
          <td valign="top" class="value-show"><g:formatDate date="${theme.profile.startDate}" format="dd. MMMM yyyy" /></td>
          <td valign="top" class="value-show"><g:formatDate date="${theme.profile.endDate}" format="dd. MMMM yyyy" /></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="themes.superior"/></td>
          <td colspan="2" valign="top" class="name-show"><g:message code="facility"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="value-show">
            <g:if test="${parenttheme}">
              <g:link controller="themeProfile" action="show" id="${parenttheme.id}" params="[entity: parenttheme.id]">${parenttheme.profile.fullName}</g:link>
            </g:if>
            <g:else>
              <span class="italic">Keinem übergeordneten Thema zugeordnet!</span>
            </g:else>
          </td>
          <td colspan="2" valign="top" class="value-show">
            <g:link controller="facilityProfile" action="show" id="${facility?.id}">${fieldValue(bean: facility, field: 'profile.fullName')}</g:link>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show-block"><g:message code="description"/></td>
        </tr>
        <tr>
          <td colspan="3" valign="top" class="value-show-block">
            ${fieldValue(bean: theme, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
        </tr>

      </table>
    </div>

    <div class="buttons">
      <g:form id="${theme.id}">
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']" creatorof="${theme}">
          <div class="button"><g:actionSubmit class="buttonGreen" action="edit" value="${message(code: 'edit')}" /></div>
          <div class="button"><g:actionSubmit class="buttonRed" action="delete" value="${message(code: 'delete')}" onclick="${erp.getLinks(id: theme.id)}" /></div>
        </erp:accessCheck>
        <div class="button"><g:actionSubmit class="buttonGray" action="list" value="${message(code: 'backToList')}" /></div>
      </g:form>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="projects"/><erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#projects');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Projekte zuordnen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="projects" style="display:none">
        <g:if test="${allProjects}">
          <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addProject', id: theme.id]" update="projects2" before="showspinner('#projects2');"  after="toggle('#projects');">
            <g:select name="project" from="${allProjects}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </g:if>
        <g:else>
          <g:message code="theme.noProjects"/>
        </g:else>
      </div>
      <div class="zusatz-show" id="projects2">
        <g:render template="projects" model="[projects: projects, theme: theme, entity: currentEntity]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5><g:message code="groupActivities"/><erp:accessCheck entity="${currentEntity}" types="['Betreiber']"><a onclick="toggle('#activitygroups');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Aktivitätsblöcke zuordnen"/></a></erp:accessCheck></h5>
      <div class="zusatz-add" id="activitygroups" style="display:none">
        <g:if test="${allActivityGroups}">
          <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addActivityGroup', id: theme.id]" update="activitygroups2" before="showspinner('#activitygroups2');" after="toggle('#activitygroups');">
            <g:select name="activitygroup" from="${allActivityGroups}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </g:if>
        <g:else>
          <g:message code="theme.noGroupActivities"/>
        </g:else>
      </div>
      <div class="zusatz-show" id="activitygroups2">
        <g:render template="activitygroups" model="[activitygroups: activitygroups, theme: theme, entity: currentEntity]"/>
      </div>
    </div>

  </div>
</div>
</body>