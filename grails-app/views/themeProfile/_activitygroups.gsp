<g:if test="${activitygroups}">
  <ul>
  <g:each in="${activitygroups}" var="activitygroup">
    <li><g:link controller="${activitygroup.type.supertype.name +'Profile'}" action="show" id="${activitygroup.id}" params="[entity:activitygroup.id]">${activitygroup.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeActivityGroup" update="activitygroups2" id="${activitygroup.id}" params="[activitygroup: activitygroup.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Aktivitätsblock entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Keine Aktivitätsblöcke zugewiesen! %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>