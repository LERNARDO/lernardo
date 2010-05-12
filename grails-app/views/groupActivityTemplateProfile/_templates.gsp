<g:if test="${templates}">

  <p>
    <span class="bold">Errechnete Gesamtdauer:</span> ${calculatedDuration} min <g:if test="${calculatedDuration > group.profile.realDuration}"><img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/> <span class="red">Die Errechnete Gesamtdauer übersteigt die geplante Dauer dieses Aktivitätsblocks!</span></g:if>
  </p>
  
  <ul>
  <g:each in="${templates}" var="template">
    <li><g:link controller="${template.type.supertype.name +'Profile'}" action="show" id="${template.id}" params="[entity:entity.id]">${template.profile.fullName}</g:link> (${template.profile.duration} min) <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeTemplate" update="templates2" id="${group.id}" params="[template: template.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Aktivitätsvorlage entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Aktivitätsvorlagen zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>