<g:if test="${client.profile.collectors}">
  <ul>
  <g:each in="${client.profile.collectors}" var="collector">
    <li>${collector.text} <erp:accessCheck entity="${currentEntity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN']" types="['Betreiber','Pädagoge']" me="false"><g:remoteLink action="removeCollector" update="collectors2" id="${client.id}" params="[collector: collector.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Abholberechtigten entfernen" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="client.profile.collectors.empty"/></span>
</g:else>