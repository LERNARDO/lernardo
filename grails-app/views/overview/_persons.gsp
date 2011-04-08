<erp:getCurrentEntity>

<h2><g:message code="profile.overview.persons"/></h2>

<div class="box">
  <div class="bold"><g:message code="clients"/> (${allClients})</div>
  <g:link controller="clientProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_betreuter.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="clientProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']" types="['Betreiber']">
    <div><g:link controller="clientProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>
<div class="box">
  <div class="bold"><g:message code="educators"/> (${allEducators})</div>
  <g:link controller="educatorProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_paedagoge.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="educatorProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']" types="['Betreiber']">
    <div><g:link controller="educatorProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>
<div class="box">
  <div class="bold"><g:message code="parents"/> (${allParents})</div>
  <g:link controller="parentProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_erziehungsberechtigte.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="parentProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']" types="['Betreiber']">
    <div><g:link controller="parentProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>
<g:if test="${grailsApplication.config.project == 'sueninos'}">
  <div class="box">
    <div class="bold"><g:message code="children"/> (${allChilds})</div>
    <g:link controller="childProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_kinder.png')}" alt="Notiz" align="top"/></g:link>
    <div><g:link controller="childProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']" types="['Betreiber']">
      <div><g:link controller="childProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
    </erp:accessCheck>
  </div>
</g:if>
<g:if test="${grailsApplication.config.project == 'sueninos'}">
  <div class="box">
    <div class="bold"><g:message code="paten"/> (${allPates})</div>
    <g:link controller="pateProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_paten.png')}" alt="Notiz" align="top"/></g:link>
    <div><g:link controller="pateProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
    <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']" types="['Betreiber']">
      <div><g:link controller="pateProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
    </erp:accessCheck>
  </div>
</g:if>
<div class="box">
  <div class="bold"><g:message code="partners"/> (${allPartners})</div>
  <g:link controller="partnerProfile" action="list"><img src="${g.resource(dir:'images/icons', file:'kf_partner.png')}" alt="Notiz" align="top"/></g:link>
  <div><g:link controller="partnerProfile" action="list"><g:message code="profile.overview.showAll"/></g:link></div>
  <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN']" types="['Betreiber']">
    <div><g:link controller="partnerProfile" action="create"><g:message code="profile.overview.createNew"/></g:link></div>
  </erp:accessCheck>
</div>

</erp:getCurrentEntity>