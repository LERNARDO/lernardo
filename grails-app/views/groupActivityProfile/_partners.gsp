<g:if test="${partners}">
  <ul>
  <g:each in="${partners}" var="partner" status="i">
    <li>
      <g:link controller="${partner.type.supertype.name +'Profile'}" action="show" id="${partner.id}">${partner.profile.fullName.decodeHTML()}</g:link> <erp:accessCheck entity="${entity}" types="['Betreiber']" creatorof="${group}"><g:remoteLink action="removePartner" update="partners2" id="${group.id}" params="[partner: partner.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck>
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
  <span class="italic red"><g:message code="partners.notAssigned"/></span>
</g:else>