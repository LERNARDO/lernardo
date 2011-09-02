<erp:getCurrentEntity>

<h2><g:message code="profile.overview.admin"/></h2>

<div class="box">
  <div class="bold"><g:message code="operator"/> (${allOperators})</div>
  <g:link controller="operatorProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_betreiber.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="operatorProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <div><g:link controller="operatorProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
</div>
<div class="box">
  <div class="bold"><g:message code="user"/> (${allUsers})</div>
  <g:link controller="userProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_user.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="userProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <div><g:link controller="userProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
</div>
<div class="box">
  <div class="bold"><g:message code="management"/></div>
  <g:link controller="profile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_verwaltung.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="profile" action="list" params="[name:currentEntity.name]"><g:message code="profile.overview.showAll"/></g:link></div>
</div>

</erp:getCurrentEntity>