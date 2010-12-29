<g:if test="${partners}">
  <ul>
    <g:each in="${partners}" var="partner" status="j">
      <li>
        <g:link controller="${partner.type.supertype.name +'Profile'}" action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" roles="['ROLE_ADMIN','ROLE_SYSTEMADMIN','ROLE_LEAD_EDUCATOR']" types="['Betreiber','Pädagoge']"><g:remoteLink action="removePartner" update="partners2${i}" id="${unit.id}" params="[partner: partner.id, i:i]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Partner entfernen" align="top"/></g:remoteLink></erp:accessCheck>
        <span id="tagpartner${i}_${j}">
          <erp:getLocalTags entity="${partner}" target="${unit}">
            <g:render template="/app/localtags" model="[entity: partner, target: unit, tags: tags, update: 'tagpartner' + i + '_' + j]"/>
          </erp:getLocalTags>
        </span>
      </li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red">Bitte die Partner auswählen, die an dieser Projekteinheit teilnehmen!%{--Keine Partner zugewiesen--}% %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>