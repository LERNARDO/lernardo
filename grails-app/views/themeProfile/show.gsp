<head>
  <meta name="layout" content="private"/>
  <title><g:message code="profile"/> - ${theme.profile.fullName}</title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="profile"/> - ${theme.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: theme]"/></span> <erp:isAdmin entity="${currentEntity}"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:isAdmin></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:formRemote name="formRemote" url="[controller:'app', action:'changeCreator', id:theme.id]" update="creator" before="showspinner('#creator');" after="toggle('#setcreator');">
          <table>
            <tr>
              <td style="padding: 5px 10px 0 0;"><g:select name="creator" from="${allEducators}" optionKey="id" optionValue="profile"/></td>
              <td><g:submitButton name="button" value="${message(code:'change')}"/></td>
            </tr>
          </table>
        </g:formRemote>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name-show"><g:message code="theme.profile.name"/></td>
          <td valign="top" class="name-show"><g:message code="theme.profile.startDate"/></td>
          <td valign="top" class="name-show"><g:message code="theme.profile.endDate"/></td>
        </tr>

        <tr>
          <td width="300" valign="top" class="value-show">
            ${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}
          </td>
          <td width="230" valign="top" class="value-show">
            <g:formatDate date="${theme.profile.startDate}" format="dd. MMMM yyyy"/>
          </td>
          <td width="230" valign="top" class="value-show">
            <g:formatDate date="${theme.profile.endDate}" format="dd. MMMM yyyy"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name-show">Übergeordnetes Thema</td>
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
          <td valign="top" class="name-show-block"><g:message code="theme.profile.description"/></td>
        </tr>
        <tr>
          <td colspan="3" valign="top" class="value-show-block">
            ${fieldValue(bean: theme, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}
          </td>
        </tr>

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" creatorof="${theme}">
        <g:link class="buttonGreen" action="edit" id="${theme?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonRed" action="del" onclick="${erp.getLinks(id: theme.id)}" id="${theme.id}">Löschen</g:link>
      </erp:accessCheck>
      <g:link class="buttonGray" action="list"><g:message code="backToList"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5><g:message code="projects"/><erp:isOperator entity="${currentEntity}"><a onclick="toggle('#projects');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Projekte zuordnen"/></a></erp:isOperator></h5>
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
      <h5><g:message code="groupActivities"/><erp:isOperator entity="${currentEntity}"><a onclick="toggle('#activitygroups');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Aktivitätsblöcke zuordnen"/></a></erp:isOperator></h5>
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