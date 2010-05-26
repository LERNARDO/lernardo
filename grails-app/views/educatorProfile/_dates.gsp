<g:if test="${educator.profile.dates}">
  <ul>
  <g:each in="${educator.profile.dates}" var="date" status="i">
    <li><g:formatDate date="${date.date}" format="dd. MM. yyyy"/> (${i % 2 == 0 ? 'Eintrittsdatum' : 'Austrittsdatum'})<g:if test="${i + 1 == educator.profile.dates.size()}"> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeDate" update="dates2" id="${educator.id}" params="[date: date.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Datum entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></g:if></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Daten eingetragen</span>
</g:else>