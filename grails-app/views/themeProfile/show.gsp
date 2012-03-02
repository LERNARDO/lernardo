<head>
  <meta name="layout" content="planning"/>
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

    <g:render template="/templates/themeNavigation" model="[entity: theme]"/>

    <div class="tabnav">
      <ul>
        <li><g:link controller="themeProfile" action="show" id="${theme.id}"><g:message code="profile"/></g:link></li>
        <li><g:remoteLink style="border-right: none;" update="content" controller="publication" action="list" id="${theme.id}"><g:message code="publications"/> <erp:getPublicationCount entity="${theme}"/></g:remoteLink></li>
      </ul>
    </div>

    <div id="content">

      <h4><g:message code="profile"/></h4>

      <p><g:message code="creator"/>: <span id="creator"><g:render template="/templates/creator" model="[entity: theme]"/></span> <erp:accessCheck roles="['ROLE_ADMIN']"><a onclick="toggle('#setcreator'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ersteller ändern"/></a></erp:accessCheck></p>
      <div class="zusatz-add" id="setcreator" style="display:none">
        <g:message code="search"/>:<br/>
        <g:remoteField size="40" name="remoteField" update="remoteCreators" controller="app" action="remoteCreators" id="${theme.id}" before="showspinner('#remoteCreators');"/>
        <div id="remoteCreators"></div>
      </div>

      <table>
        <tbody>

        <tr class="prop">
          <td class="one"><g:message code="name"/>:</td>
          <td class="two">${fieldValue(bean: theme, field: 'profile.fullName').decodeHTML()}</td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="begin"/>:</td>
          <td class="two"><g:formatDate date="${theme.profile.startDate}" format="dd. MMMM yyyy" /></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="end"/>:</td>
          <td class="two"><g:formatDate date="${theme.profile.endDate}" format="dd. MMMM yyyy" /></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="themes.superior"/>:</td>
          <td class="two">
            <g:if test="${parenttheme}">
              <g:link controller="themeProfile" action="show" id="${parenttheme.id}">${parenttheme.profile.fullName.decodeHTML()}</g:link>
            </g:if>
            <g:else>
              <span class="italic">Keinem übergeordneten Thema zugeordnet!</span>
            </g:else>
          </td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="facility"/>:</td>
          <td class="two"><g:link controller="facilityProfile" action="show" id="${facility?.id}">${fieldValue(bean: facility, field: 'profile.fullName')}</g:link></td>
        </tr>

        <tr class="prop">
          <td class="one"><g:message code="description"/>:</td>
          <td class="two">${fieldValue(bean: theme, field: 'profile.description').decodeHTML() ?: '<span class="italic">'+message(code:'noData')+'</span>'}</td>
        </tr>

        </tbody>
      </table>

      <h4><g:message code="management"/></h4>
      <div class="zusatz">
        <h5><g:message code="projects"/><erp:accessCheck types="['Betreiber']"><a onclick="toggle('#projects');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Projekte zuordnen"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="projects" style="display:none">
          <g:if test="${allProjects}">
            <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addProject', id: theme.id]" update="projects2" before="showspinner('#projects2');"  after="toggle('#projects');">
              <g:select name="project" from="${allProjects}" optionKey="id" optionValue="profile"/>
              <div class="clear"></div>
              <g:submitButton name="button" value="${message(code:'add')}"/>
              <div class="clear"></div>
            </g:formRemote>
          </g:if>
          <g:else>
            <g:message code="theme.noProjects"/>
          </g:else>
        </div>
        <div class="zusatz-show" id="projects2">
          <g:render template="projects" model="[projects: projects, theme: theme]"/>
        </div>
      </div>

      <div class="zusatz">
        <h5><g:message code="groupActivities"/><erp:accessCheck types="['Betreiber']"><a onclick="toggle('#activitygroups');
        return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Aktivitätsblöcke zuordnen"/></a></erp:accessCheck></h5>
        <div class="zusatz-add" id="activitygroups" style="display:none">
          <g:if test="${allActivityGroups}">
            <g:formRemote name="formRemote" url="[controller:'themeProfile', action:'addActivityGroup', id: theme.id]" update="activitygroups2" before="showspinner('#activitygroups2');" after="toggle('#activitygroups');">
              <g:select name="activitygroup" from="${allActivityGroups}" optionKey="id" optionValue="profile"/>
              <div class="clear"></div>
              <g:submitButton name="button" value="${message(code:'add')}"/>
              <div class="clear"></div>
            </g:formRemote>
          </g:if>
          <g:else>
            <g:message code="theme.noGroupActivities"/>
          </g:else>
        </div>
        <div class="zusatz-show" id="activitygroups2">
          <g:render template="activitygroups" model="[activitygroups: activitygroups, theme: theme]"/>
        </div>
      </div>

    </div>

  </div>
</div>
</body>