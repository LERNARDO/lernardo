
  <head>
    <g:javascript src="bounce.js"/>
  </head>

    <ol class="imgmenu" id="bounce">
      <li>
        <div id="profile" class="imgbox">
          <g:link controller="${currentEntity.type.supertype.name +'Profile'}" action="show" id="${currentEntity.id}">
            <img src="${g.resource(dir:'images/iconex', file:'profile.png')}" alt="Profile" />
            <h3><g:message code="imgmenu.profile.name"/> </h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="templates" class="imgbox">
          <g:link controller="template" action="list">
            <img src="${g.resource(dir:'images/iconex', file:'activities.png')}" alt="Aktivitätsvorlagen" />
            <h3><g:message code="imgmenu.template.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="activities" class="imgbox">
          <g:link controller="activity" action="list">
            <img src="${g.resource(dir:'images/iconex', file:'all_activities.png')}" alt="Aktivitäten" />
            <h3><g:message code="imgmenu.activity.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="calendar" class="imgbox">
          <g:link controller="calendar" action="show">
            <img src="${g.resource(dir:'images/iconex', file:'calendar.png')}" alt="Kalender" />
            <h3><g:message code="imgmenu.calendar.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="members" class="imgbox">
          <g:link controller="profile" action="search" id="${currentEntity.id}">
            <img src="${g.resource(dir:'images/iconex', file:'profiles.png')}" alt="Profile" />
            <h3><g:message code="imgmenu.member.name"/></h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="network" class="imgbox">
          <g:link controller="network" action="index" id="${currentEntity.id}">
            <img src="${g.resource(dir:'images/iconex', file:'admin.png')}" alt="Netzwerk" />
            <h3><g:message code="imgmenu.network.name"/></h3>
          </g:link>
        </div>
      </li>
    </ol>
