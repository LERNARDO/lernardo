<g:if test="${subthemes}">
  <ul>
  <g:each in="${subthemes}" var="subtheme">
    <li><g:link controller="${subtheme.type.supertype.name +'Profile'}" action="show" id="${subtheme.id}" params="[entity:subtheme.id]">${subtheme.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeSubTheme" update="subthemes2" id="${theme.id}" params="[subtheme: subtheme.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Subthema entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Subthemen zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>