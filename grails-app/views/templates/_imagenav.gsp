<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <g:javascript src="bounce.js"/>
  </head>
  <body>
    <ol class="imgmenu" id="bounce">
      <li>
        <div id="member" class="imgbox">
          <g:link controller="profile" action="showProfile" params="[name:currentEntity.name]">
            <img src="${g.resource(dir:'images/iconex', file:'profile.png')}" alt="Profile" />
            <h3>Profil</h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="paeds" class="imgbox">
          <g:link controller="template" action="list" params="[name:currentEntity.name]">
            <img src="${g.resource(dir:'images/iconex', file:'activities.png')}" alt="Aktivitätsvorlagen" />
            <h3>Aktivitätsvorlagen</h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="activities" class="imgbox">
          <g:link controller="activity" action="list" params="[name:currentEntity.name]">
            <img src="${g.resource(dir:'images/iconex', file:'all_activities.png')}" alt="Aktivitäten" />
            <h3>Aktivitäten</h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="orga" class="imgbox">
          <g:link controller="calendar" action="showall">
            <img src="${g.resource(dir:'images/iconex', file:'calendar.png')}" alt="Kalender" />
            <h3>Kalender</h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="profiles" class="imgbox">
          <g:link controller="profile" action="search" params="[name:currentEntity.name]">
            <img src="${g.resource(dir:'images/iconex', file:'profiles.png')}" alt="Suche" />
            <h3>Suche</h3>
          </g:link>
        </div>
      </li>

      <li>
        <div id="admin" class="imgbox">
          <g:link controller="network" action="index" params="[name:currentEntity.name]">
            <img src="${g.resource(dir:'images/iconex', file:'admin.png')}" alt="Netzwerk" />
            <h3>Netzwerk</h3>
          </g:link>
        </div>
      </li>
    </ol>
  </body>
</html>