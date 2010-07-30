<g:if test="${childs}">
  <ul>
  <g:each in="${childs}" var="child">
    <li><g:link controller="${child.type.supertype.name +'Profile'}" action="show" id="${child.id}" params="[entity:child.id]">${child.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeChild" update="childs2" id="${group.id}" params="[child: child.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Kind entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="groupFamily.profile.childs.empty"/> <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>