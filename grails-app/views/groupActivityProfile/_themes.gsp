<g:if test="${themes}">
  <ul>
  <g:each in="${themes}" var="theme">
    <li><g:link controller="${theme.type.supertype.name + 'Profile'}" action="show" id="${theme.id}">${theme.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']" creatorof="${group}"><g:remoteLink action="removeTheme" update="themes2" id="${group.id}" params="[theme: theme.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="theme.notAssigned"/></span>
</g:else>