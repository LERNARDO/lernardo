<g:if test="${partners}">
  <ul>
  <g:each in="${partners}" var="partner" status="i">
    <li>
      <g:link controller="${partner.type.supertype.name +'Profile'}" action="show" id="${partner.id}" params="[entity:partner.id]">${partner.profile.fullName}</g:link> <erp:isCreator entity="${group}"><g:remoteLink action="removePartner" update="partners2" id="${group.id}" params="[partner: partner.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="Partner entfernen" align="top"/></g:remoteLink></erp:isCreator>
      <span id="tagpartner${i}">
        <erp:getLocalTags entity="${partner}" target="${group}">
          <g:render template="/app/localtags" model="[entity: partner, target: group, tags: tags, update: 'tagpartner' + i]"/>
        </erp:getLocalTags>
      </span>
    </li>
  </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="partners.notAssigned"/> %{--<img src="${g.resource(dir:'images/icons', file:'icon_warning.png')}" alt="Achtung" align="top"/>--}%</span>
</g:else>