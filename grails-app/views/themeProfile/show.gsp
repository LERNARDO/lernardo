<head>
  <meta name="layout" content="private"/>
  <title>Profil - ${theme.profile.fullName}</title>
</head>
<body>
<div class="headerGreen">
  <div class="second">
    <h1>Thema - ${theme.profile.fullName}</h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">
    <div class="dialog">
        <table>
          <tbody>
          <tr class="prop">
            <td valign="top" class="name-show">
              <label for="fullName">
                <g:message code="theme.profile.name"/>
              </label>
            </td>
             <td valign="top" class="name-show">
              <label for="startDate">
                <g:message code="theme.profile.startDate"/>
              </label>
            </td>
            <td valign="top" class="name-show">
              <label for="endDate">
                <g:message code="theme.profile.endDate"/>
              </label>
            </td>
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
            <td valign="top" class="name-show">
              <label for="type">
                <g:message code="theme.profile.type"/>
              </label>
              </td>
           <td colspan="2" valign="top" class="name-show">
              <label for="type">
                <g:message code="facility"/>
              </label>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="value-show">
             ${fieldValue(bean: theme, field: 'profile.type')}
            </td>
            <td colspan="2" valign="top" class="value-show">
              <g:link controller="facilityProfile" action="show" id="${facility.id}">${fieldValue(bean: facility, field: 'profile.fullName')}</g:link>
            </td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name-show-block">
              <label for="description">
                <g:message code="theme.profile.description"/>
              </label>
            </td>
            </tr>
          <tr>
            <td colspan="3" valign="top" class="value-show-block">
              ${fieldValue(bean: theme, field: 'profile.description').decodeHTML() ?: '<div class="italic">keine Daten eingetragen</div>'}
            </td>
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
        <h5>Subthemen <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber']" me="false"><a onclick="toggle('#subthemes'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Subthema hinzufügen" /></a></app:hasRoleOrType></h5>
        <div class="zusatz" id="subthemes" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addSubTheme', id: theme.id]" update="subthemes2" before="showspinner('#subthemes2')">
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
        <h5>Projekte <app:isMeOrAdmin entity="${entity}"><a onclick="toggle('#projects'); return false" href="#"><img src="${g.resource(dir:'images/icons', file:'icon_add.png')}" alt="Projekte hinzufügen" /></a></app:isMeOrAdmin></h5>
        <div class="zusatz-add" id="projects" style="display:none">
          <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addProject', id: theme.id]" update="projects2" before="showspinner('#projects2')">
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