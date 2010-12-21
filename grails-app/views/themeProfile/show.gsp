<head>
  <meta name="layout" content="private"/>
  <title><g:message code="profile"/> - ${theme.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1><g:message code="profile"/> - ${theme.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">

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
            ${fieldValue(bean: theme, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
          </td>
        </tr>

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <app:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']" me="false">
        <g:link class="buttonGreen" action="edit" id="${theme?.id}"><g:message code="edit"/></g:link>
        <g:link class="buttonRed" action="del" onclick="${app.getLinks(id: theme.id)}" id="${theme.id}">Löschen</g:link>
      </app:accessCheck>
      <g:link class="buttonGray" action="list"><g:message code="backToList"/></g:link>
      <div class="spacer"></div>
    </div>

    <div class="zusatz">
      <h5>Projekte <app:isMeOrAdmin entity="${currentEntity}"><a onclick="toggle('#projects');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Projekte zuordnen"/></a></app:isMeOrAdmin></h5>
      <div class="zusatz-add" id="projects" style="display:none">
        <g:if test="${allProjects}">
          <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addProject', id: theme.id]" update="projects2" before="showspinner('#projects2')">
            <g:select name="project" from="${allProjects}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </g:if>
        <g:else>
          Es gibt keine Projekte die im Zeitraum dieses Themas liegen.
        </g:else>
      </div>
      <div class="zusatz-show" id="projects2">
        <g:render template="projects" model="[projects: projects, theme: theme]"/>
      </div>
    </div>

    <div class="zusatz">
      <h5>Aktivitätsblöcke <app:isMeOrAdmin entity="${currentEntity}"><a onclick="toggle('#activitygroups');
      return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Aktivitätsblöcke zuordnen"/></a></app:isMeOrAdmin></h5>
      <div class="zusatz-add" id="activitygroups" style="display:none">
        <g:if test="${allActivityGroups}">
          <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addActivityGroup', id: theme.id]" update="activitygroups2" before="showspinner('#activitygroups2')">
            <g:select name="activitygroup" from="${allActivityGroups}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </g:if>
        <g:else>
          Es gibt keine Aktivitätsblöcke die im Zeitraum dieses Themas liegen.
        </g:else>
      </div>
      <div class="zusatz-show" id="activitygroups2">
        <g:render template="activitygroups" model="[activitygroups: activitygroups, theme: theme]"/>
      </div>
    </div>

  </div>
</div>
</body>