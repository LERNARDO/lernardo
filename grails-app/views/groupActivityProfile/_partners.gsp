<g:if test="${partners}">
  <ul>
  <g:each in="${partners}" var="partner" status="i">
    <li>
      <g:link controller="${partner.type.supertype.name +'Profile'}" action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link> <app:isMeOrAdmin entity="${entity}"><g:remoteLink action="removePartner" update="partners2" id="${group.id}" params="[partner: partner.id]" before="if(!confirm('Bist Du sicher?')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Partner entfernen" align="top"/></g:remoteLink></app:isMeOrAdmin>
      <span id="tagpartner${i}">
        <app:getTags entity="${partner}">
          <g:render template="/app/tags" model="[entity: partner, tags: tags, update: 'tagpartner'+ i]"/>
        </app:getTags>
      </span>
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Partner zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>