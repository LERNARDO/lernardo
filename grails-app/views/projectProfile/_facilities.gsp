<g:if test="${facilities}">
  <ul>
  <g:each in="${facilities}" var="facility">
    <li><g:link controller="${facility.type.supertype.name +'Profile'}" action="show" id="${facility.id}" params="[entity:facility.id]">${facility.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeFacility" update="facilities2" id="${project.id}" params="[facility: facility.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false" after="${remoteFunction(action:'updateFacilityButton',update:'facilitybutton',id:project.id)}"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Einrichtung entfernen" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="facility.choose"/></span>
</g:else>