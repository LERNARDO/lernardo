<g:if test="${partners}">
  <ul>
    <g:each in="${partners}" var="partner">
      <li><g:link controller="${partner.type.supertype.name +'Profile'}" action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removePartner" update="partners2${j}${i}" id="${unit.id}" params="[partner: partner.id]"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Partner entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Partner zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>