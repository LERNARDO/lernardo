<g:if test="${clientgroups}">
  <ul>
  <g:each in="${clientgroups}" var="clientgroup">
    <li><g:link controller="${clientgroup.type.supertype.name +'Profile'}" action="show" id="${clientgroup.id}" params="[entity:clientgroup.id]">${clientgroup.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeClientGroup" update="clientgroups2" id="${group.id}" params="[clientgroup: clientgroup.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Betreutengruppe entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Betreutengruppen zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>