
  <head>

    %{-- <g:javascript src="bounce.js"/>
    die hüpfenden Symbole ...  --}%
  </head>

    <ol class="imgmenu" id="bounce">
      <li>
        <div id="profile" class="imgbox">
          <g:link controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}">
            <img src="${g.resource(dir:'images/iconex', file:'profil-neu.png')}" alt="Profile" />
            <h3><g:message code="imgmenu.profile.name"/> </h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="htemplates" class="imgbox">
          <g:link controller="templateProfile" action="index">
            <img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsvorlage.png')}" alt="Aktivitätsvorlagen" />
            <h3><g:message code="imgmenu.template.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="activities" class="imgbox">
          <g:link controller="groupActivityTemplateProfile" action="list">
            <img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsblockvorlage.png')}" alt="Aktivitäten" />
            <h3> V-Aktivitätsblock</h3>
            %{-- writing the full word somehow fucks up the layout, need to find the problem --}%
          </g:link>
        </div>
      </li>

      <li>
        <div id="hprojects" class="imgbox">
          <g:link controller="projectProfile" action="list">
            <img src="${g.resource(dir:'images/icons', file:'kf_projekte.png')}" alt="Projekte" />
            <h3><g:message code="imgmenu.projects.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="hactivities" class="imgbox">
          <g:link controller="activity" action="list">
            <img src="${g.resource(dir:'images/icons', file:'kf_themenraum.png')}" alt="Themenraum" />
            <h3>Themenraum</h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="calendar" class="imgbox">
          <g:link controller="calendar" action="show">
            <img src="${g.resource(dir:'images/icons', file:'kf_kalender.png')}" alt="Kalender" />
            <h3><g:message code="imgmenu.calendar.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="themes" class="imgbox">
          <g:link controller="themeProfile" action="list">
            <img src="${g.resource(dir:'images/icons', file:'kf_themen.png')}" alt="Themen" />
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
            <img src="${g.resource(dir:'images/icons', file:'kf_ueberblick.png')}" alt="Übersicht" />
            <h3>Übersicht</h3>
          </g:link>
        </div>
      </li>

     
    </ol>
