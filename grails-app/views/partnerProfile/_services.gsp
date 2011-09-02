<g:if test="${partner.profile.services}">
  <ul>
  <g:each in="${partner.profile.services}" var="service">
    <li>${service} <erp:accessCheck entity="${entity}" types="['Betreiber']"><g:remoteLink action="removeService" update="services2" id="${partner.id}" params="[service: service]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="partner.profile.services.empty"/></span>
</g:else>