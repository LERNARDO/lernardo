
  <head>

    %{-- <g:javascript src="bounce.js"/>
    die hüpfenden Symbole ...  --}%
  </head>

    <ol class="imgmenu" id="bounce">
      <li>
        <div id="profile" class="imgbox">
          <g:link controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}">
            <img src="${g.resource(dir:'images/icons', file:'kf_profil.png')}" alt="<g:message code="imgmenu.profile.name"/>" />
            <h3><g:message code="imgmenu.profile.name"/> </h3>
          </g:link>
        </div>
      </li>

      <app:hasRoleOrType entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Pädagoge','Betreiber']" me="false">
      <li>
        <div id="htemplates" class="imgbox">
          <g:link controller="templateProfile" action="index">
            <img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsvorlage.png')}" alt="<g:message code="imgmenu.template.name"/>" />
            <h3><g:message code="imgmenu.template.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="activities" class="imgbox">
          <g:link controller="groupActivityTemplateProfile" action="list">
            <img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsblockvorlage.png')}" alt="<g:message code="imgmenu.activityTemplate.name"/>" />
            <h3><g:message code="imgmenu.activityTemplate.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="hprojects" class="imgbox">
          <g:link controller="projectTemplateProfile" action="list">
            <img src="${g.resource(dir:'images/icons', file:'kf_projektvorlage.png')}" alt="<g:message code="imgmenu.projects.name"/>" />
            <h3><g:message code="imgmenu.projects.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="hactivities" class="imgbox">
          <g:link controller="activity" action="list">
            <img src="${g.resource(dir:'images/icons', file:'kf_themenraum.png')}" alt="<g:message code="imgmenu.activity.name"/>" />
            <h3><g:message code="imgmenu.activity.name"/></h3>
          </g:link>
        </div>
      </li>
      </app:hasRoleOrType>

      <li>
        <div id="calendar" class="imgbox">
          <g:link controller="calendar" action="show">
            <img src="${g.resource(dir:'images/icons', file:'kf_kalender.png')}" alt="<g:message code="imgmenu.calendar.name"/>" />
            <h3><g:message code="imgmenu.calendar.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="themes" class="imgbox">
          <g:link controller="themeProfile" action="list">
            <img src="${g.resource(dir:'images/icons', file:'kf_themen.png')}" alt="<g:message code="imgmenu.theme.name"/>" />
            <h3><g:message code="imgmenu.theme.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="members" class="imgbox">
          %{--          <g:link controller="profile" action="search" id="${currentEntity.id}">
            <img src="${g.resource(dir:'images/iconex', file:'profiles.png')}" alt="Profile" />
            <h3><g:message code="imgmenu.member.name"/></h3>
          </g:link>--}%
          <g:link controller="profile" action="overview" id="${currentEntity.id}">
            <img src="${g.resource(dir:'images/icons', file:'kf_ueberblick.png')}" alt="<g:message code="imgmenu.overview.name"/>" />
            <h3><g:message code="imgmenu.overview.name"/></h3>
          </g:link>
        </div>
      </li>

     
    </ol>
