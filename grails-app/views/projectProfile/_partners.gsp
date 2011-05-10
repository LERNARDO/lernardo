<g:if test="${partners}">
  <ul>
    <g:each in="${partners}" var="partner" status="j">
      <li>
        <g:link controller="${partner.type.supertype.name +'Profile'}" action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${project}"><g:remoteLink action="removePartner" update="partners2${i}" id="${unit.id}" params="[partner: partner.id, i:i]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
        <span id="tagpartner${i}_${j}">
          <erp:getLocalTags entity="${partner}" target="${unit}">
            <g:render template="/app/localtags" model="[entity: partner, target: unit, tags: tags, update: 'tagpartner' + i + '_' + j, currentEntity: entity]"/>
          </erp:getLocalTags>
        </span>
      </li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="partners.choose"/></span>
</g:else>