<g:if test="${childs}">
  <ul>
  <g:each in="${childs}" var="child">
    <li><g:link controller="${child.type.supertype.name + 'Profile'}" action="show" id="${child.id}">${child.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']"><g:remoteLink action="removeChild" update="childs2" id="${group.id}" params="[child: child.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false" after="${remoteFunction(action: 'updateFamilyCount', update: 'familyCount', id: group.id)}"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="children"/></span>
</g:else>