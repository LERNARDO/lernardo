<g:if test="${projectUnits}">

  <p>
    <span class="bold">Errechnete Gesamtdauer:</span> ${calculatedDuration} min
  </p>

  <ul>
  <g:each in="${projectUnits}" var="projectUnit">
    <li>${projectUnit.profile.fullName} <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removeProjectUnit" update="projectunits2" id="${projectTemplate.id}" params="[projectUnit: projectUnit.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Projekteinheit entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin>
      <ul>
        <app:getGroupActivityTemplates projectUnit="${projectUnit}">
          <g:each in="${groupActivityTemplates}" var="groupActivityTemplate">
            <li><g:link controller="${groupActivityTemplate.type.supertype.name +'Profile'}" action="show" id="${groupActivityTemplate.id}" params="[entity:groupActivityTemplate.id]">${groupActivityTemplate.profile.fullName} (${groupActivityTemplate.profile.realDuration}min)</g:link> <g:remoteLink action="removeGroupActivityTemplate" update="projectunits2" id="${projectTemplate.id}" params="[projectUnit: projectUnit.id, groupActivityTemplate: groupActivityTemplate.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Aktivitätsvorlagengruppe entfernen" align="top"/></g:remoteLink></li>
          </g:each>
        </app:getGroupActivityTemplates>
      </ul></li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Projekteinheiten hinzugefügt <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>