<g:if test="${leadeducators}">
  <ul>
    <g:each in="${leadeducators}" var="educator">
      <li><g:link controller="${educator.type.supertype.name +'Profile'}" action="show" id="${educator.id}" params="[entity:educator.id]">${educator.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']"><g:remoteLink action="removeLeadEducator" update="leadeducators2" id="${facility.id}" params="[leadeducator: educator.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="leadEducators.empty"/></span>
</g:else>