<g:if test="${themes}">
  <ul>
  <g:each in="${themes}" var="theme">
    <li><g:link controller="${theme.type.supertype.name +'Profile'}" action="show" id="${theme.id}" params="[entity:theme.id]">${theme.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removeTheme" update="themes2" id="${project.id}" params="[theme: theme.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="theme.notAssigned"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>