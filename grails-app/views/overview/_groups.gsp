<h2><g:message code="profile.overview.groups"/></h2>

<div class="box">
  <div class="bold"><g:message code="groupColonies"/> (${allColonies})</div>
  <g:link controller="groupColonyProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_colonia.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="groupColonyProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck types="['Betreiber']">
    <div><g:link controller="groupColonyProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>
<div class="box">
  <div class="bold"><g:message code="groupFamilies"/> (${allFamilies})</div>
  <g:link controller="groupFamilyProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_familie.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="groupFamilyProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck types="['Betreiber']">
    <div><g:link controller="groupFamilyProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>
<div class="box">
  <div class="bold"><g:message code="groupPartners"/> (${allPartnerGroups})</div>
  <g:link controller="groupPartnerProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_sponsorennetzwerk.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="groupPartnerProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck types="['Betreiber']">
    <div><g:link controller="groupPartnerProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>
<div class="box">
  <div class="bold"><g:message code="groupClients"/> (${allClientGroups})</div>
  <g:link controller="groupClientProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_betreutengruppe.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="groupClientProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck types="['Betreiber']">
    <div><g:link controller="groupClientProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>