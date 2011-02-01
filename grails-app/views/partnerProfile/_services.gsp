<g:if test="${partner.profile.services}">
  <ul>
  <g:each in="${partner.profile.services}" var="service">
    <li>${service} <erp:isOperator entity="${entity}"><g:remoteLink action="removeService" update="services2" id="${partner.id}" params="[service: service]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Service entfernen" align="top"/></g:remoteLink></erp:isOperator></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="partner.profile.services.empty"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>