<g:if test="${partners}">
  <ul>
    <g:each in="${partners}" var="partner">
      <li><g:link controller="${partner.type.supertype.name +'Profile'}" action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link> <app:hasRoleOrType entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><g:remoteLink action="removePartner" update="partners2${i}" id="${unit.id}" params="[partner: partner.id, i:i]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Partner entfernen" align="top"/></g:remoteLink></app:hasRoleOrType></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic">Keine Partner zugewiesen <img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/></span>
</g:else>