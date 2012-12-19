<g:if test="${grouppartners}">
  <ul>
    <g:each in="${grouppartners}" var="group">
      <li><g:link controller="${group.type.supertype.name + 'Profile'}" action="show" id="${group.id}">${group.profile.decodeHTML()}</g:link> <erp:accessCheck types="['Betreiber']"><g:remoteLink action="removeGroupPartner" update="grouppartners2" id="${group.id}" params="[partner: partner.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="groupPartner.empty"/></span>
</g:else>