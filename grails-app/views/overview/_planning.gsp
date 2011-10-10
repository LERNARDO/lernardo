<erp:getCurrentEntity>

<h2><g:message code="profile.overview.plan"/></h2>

<div class="box">
  <div class="bold"><g:message code="activityTemplate"/> (${allActivityTemplates})</div>
  <g:link controller="templateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsvorlage.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="templateProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
    <div><g:link controller="templateProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>
<div class="box">
  <div class="bold"><g:message code="activityInstance"/> (${allActivities})</div>
  <g:link controller="activityProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_themenraum.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="activityProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
</div>
<div class="box">
  <div class="bold"><g:message code="groupActivityTemplate"/> (${allActivityTemplateGroups})</div>
  <g:link controller="groupActivityTemplateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsblockvorlage.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="groupActivityTemplateProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
    <div><g:link controller="groupActivityTemplateProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>
<div class="box">
  <div class="bold"><g:message code="groupActivity"/> (${allActivityGroups})</div>
  <g:link controller="groupActivityProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_aktivitaetsblock.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="groupActivityProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
</div>
<div class="box">
  <div class="bold"><g:message code="projectTemplate"/> (${allProjectTemplates})</div>
  <g:link controller="projectTemplateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_projektvorlage.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="projectTemplateProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
    <div><g:link controller="projectTemplateProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>
<div class="box">
  <div class="bold"><g:message code="projects"/> (${allProjects})</div>
  <g:link controller="projectProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_projekte.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="projectProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
</div>
<div class="box">
  <div class="bold"><g:message code="themes"/> (${allThemes})</div>
  <g:link controller="themeProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_themen.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="themeProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  %{-- only created by lead educator --}%
  <erp:accessCheck entity="${currentEntity}">
    <div><g:link controller="themeProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>

</erp:getCurrentEntity>