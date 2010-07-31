<g:if test="${educators}">
  <ul>
    <g:each in="${educators}" var="educator">
      <li><g:link controller="${educator.type.supertype.name +'Profile'}" action="show" id="${educator.id}" params="[entity:educator.id]">${educator.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeEducator" update="educators2" id="${projectDay.id}" params="[educator: educator.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Pädagoge entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Pädagogen zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>