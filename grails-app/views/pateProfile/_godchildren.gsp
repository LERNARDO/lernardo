<g:if test="${godchildren}">
  <ul>
  <g:each in="${godchildren}" var="child">
    <li><g:link controller="${child.type.supertype.name + 'Profile'}" action="show" id="${child.id}">${child.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']"><g:remoteLink action="removeGodchildren" update="godchildren2" id="${pate.id}" params="[child: child.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="pate.profile.gcs_empty"/></span>
</g:else>