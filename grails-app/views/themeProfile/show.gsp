<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${theme.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Profil - ${theme.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
      <table class="listing">
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="theme.profile.name"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="theme.profile.description"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: theme, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="theme.profile.startDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${theme.profile.startDate}" format="dd. MMMM yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="theme.profile.endDate"/>:
          </td>
          <td valign="top" class="value"><g:formatDate date="${theme.profile.endDate}" format="dd. MMMM yyyy"/></td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="theme.profile.type"/>:
          </td>
          <td valign="top" class="value">${fieldValue(bean: theme, field: 'profile.type')}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <g:message code="facility"/>:
          </td>
          <td valign="top" class="value"><g:link controller="facilityProfile" action="show" id="${facility.id}">${fieldValue(bean: facility, field: 'profile.fullName')}</g:link></td>
        </tr>

        </tbody>
      </table>
    </div>

    <app:isMeOrAdmin entity="${entity}">
      <div class="buttons">
        <g:link class="buttonGreen" action="edit" id="${theme?.id}"><g:message code="edit"/></g:link>
        <div class="spacer"></div>
      </div>
    </app:isMeOrAdmin>

    <g:if test="${theme.profile.type == 'Übergeordnetes Thema'}">
      <div class="zusatz">
        <h5>Subthemen <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-subthemes"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Subthema hinzufügen" /></a></app:isMeOrAdmin></h5>
        <jq:jquery>
          <jq:toggle sourceId="show-subthemes" targetId="subthemes"/>
        </jq:jquery>
        <div class="zusatz" id="subthemes" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addSubTheme', id: theme.id]" update="subthemes2" before="hideform('#subthemes')">
            <g:select name="subtheme" from="${allSubthemes}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>
        <div class="zusatz" id="subthemes2">
          <g:render template="subthemes" model="[subthemes: subthemes, theme: theme]"/>
        </div>
      </div>
    </g:if>

    <g:if test="${theme.profile.type == 'Subthema'}">
      <div class="zusatz">
        <h5>Projekte <app:isMeOrAdmin entity="${entity}"><a href="#" id="show-projects"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Projekte hinzufügen" /></a></app:isMeOrAdmin></h5>
        <jq:jquery>
          <jq:toggle sourceId="show-projects" targetId="projects"/>
        </jq:jquery>
        <div class="zusatz-add" id="projects" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addProject', id: theme.id]" update="projects2" before="hideform('#projects')">
            <g:select name="project" from="${allProjects}" optionKey="id" optionValue="profile"/>
            <div class="spacer"></div>
            <g:submitButton name="button" value="${message(code:'add')}"/>
            <div class="spacer"></div>
          </g:formRemote>
        </div>
        <div class="zusatz-show" id="projects2">
          <g:render template="projects" model="[projects: projects, theme: theme]"/>
        </div>
      </div>
    </g:if>

  </div>
</div>
</body>