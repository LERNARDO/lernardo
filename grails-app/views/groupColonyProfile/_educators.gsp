<g:if test="${educators}">
  <ul>
  <g:each in="${educators}" var="educator">
    <li><g:link controller="${educator.type.supertype.name + 'Profile'}" action="show" id="${educator.id}">${educator.profile}</g:link> <erp:accessCheck types="['Betreiber']"><g:remoteLink action="removeEducator" update="educators2" id="${group.id}" params="[educator: educator.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="educators.empty"/></span>
</g:else>