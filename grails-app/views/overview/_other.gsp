<erp:getCurrentEntity>

<h2><g:message code="profile.overview.others"/></h2>

<div class="box">
  <div class="bold"><g:message code="facilities"/> (${allFacilities})</div>
  <g:link controller="facilityProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_einrichtung.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="facilityProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:isOperator entity="${currentEntity}">
    <div><g:link controller="facilityProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:isOperator>
</div>
<div class="box">
  <div class="bold"><g:message code="resources"/> (${allResources})</div>
  <g:link controller="resourceProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_resourcen.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="resourceProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  %{--<erp:isOperator entity="${currentEntity}">
    <div><g:link controller="resourceProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:isOperator>--}%
</div>
<div class="box">
  <div class="bold"><g:message code="vMethods"/> (${allMethods})</div>
  <g:link controller="method" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_gewichtung.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="method" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:isAdmin entity="${currentEntity}">
    <div><g:link controller="method" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:isAdmin>
</div>

</erp:getCurrentEntity>