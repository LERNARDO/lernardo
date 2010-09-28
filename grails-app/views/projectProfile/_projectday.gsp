<div class="element-box">
  <p><span class="bold">Datum:</span> <g:formatDate date="${projectDay.profile.date}" format="EEEE, dd. MMMM yyy, HH:mm"/></p>

  <span class="bold">Einheiten <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#units'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Einheit hinzufügen"/></a></app:hasRoleOrType></span>
  <div id="units" style="display:none">
    <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addUnit', id:projectDay.id]" update="units2" before="showspinner('#units2')">
      <g:select name="unit" from="${units}" optionKey="id" optionValue="profile"/>
      <div class="spacer"></div>
      <g:submitButton name="button" value="${message(code:'add')}"/>
      <div class="spacer"></div>
    </g:formRemote>
  </div>

  <div id="units2">
    <app:getProjectDayUnits projectDay="${projectDay}">
      <g:render template="units" model="[units: units, projectDay: projectDay, allParents: allParents, entity: entity]"/>
    </app:getProjectDayUnits>
  </div>

  <span class="bold">Pädagogen <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#educators'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Pädagoge hinzufügen"/></a></app:hasRoleOrType></span>
  <div id="educators" style="display:none">
    <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addEducator', id:projectDay.id]" update="educators2" before="showspinner('#educators2')">
      <g:select name="educator" from="${allEducators}" optionKey="id" optionValue="profile"/>
      <div class="spacer"></div>
      <g:submitButton name="button" value="${message(code:'add')}"/>
      <div class="spacer"></div>
    </g:formRemote>
  </div>

  <div id="educators2">
    <app:getProjectDayEducators projectDay="${projectDay}">
      <g:render template="educators" model="[educators: educators, projectDay: projectDay, entity: entity]"/>
    </app:getProjectDayEducators>
  </div>

  %{--<span class="bold">Resourcen <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><a onclick="toggle('#resources'); return false" href="#"><img src="${g.resource(dir: 'images/icons', file: 'icon_add.png')}" alt="Ressource hinzufügen"/></a></app:hasRoleOrType></span>
  <div id="resources" style="display:none">
    <g:formRemote name="formRemote" url="[controller:'projectProfile', action:'addResource', id:projectDay.id]" update="resources2" before="showspinner('#resources2')">
      <g:select name="resource" from="${allResources}" optionKey="id" optionValue="profile"/>
      <div class="spacer"></div>
      <g:submitButton name="button" value="${message(code:'add')}"/>
      <div class="spacer"></div>
    </g:formRemote>
  </div>

  <div id="resources2">
    <app:getProjectDayResources projectDay="${projectDay}">
      <g:render template="resources" model="[resources: resources, projectDay: projectDay, entity: entity]"/>
    </app:getProjectDayResources>
  </div>--}%

</div>