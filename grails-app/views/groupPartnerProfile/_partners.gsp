<g:if test="${partners}">
  <ul>
  <g:each in="${partners}" var="partner">
    <li><g:link controller="${partner.type.supertype.name + 'Profile'}" action="show" id="${partner.id}">${partner.profile}</g:link> <erp:accessCheck types="['Betreiber']"><g:remoteLink action="removePartner" update="partners2" id="${group.id}" params="[partner: partner.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="partners.empty"/></span>
</g:else>