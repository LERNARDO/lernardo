<g:if test="${plannableResources}">
  <ul style="margin-left: 5px">
    <g:each in="${plannableResources}" var="plannableResource" status="i">
      <erp:getResourceFree resource="${plannableResource}" entity="${group}">
        <li style="padding: 2px 4px; list-style-type: circle; background: ${resourceFree == 0 ? '#caa' : '#aca'}">${resourceFree}/${plannableResource.profile.amount} "<g:link controller="resourceProfile" action="show" id="${plannableResource.id}" params="[entity: plannableResource.id]">${plannableResource.profile.fullName}</g:link>" - ${plannableResource.profile.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'} <g:if test="${resourceFree > 0}"><span id="planresource${i}">- <g:remoteLink action="planresource" update="planresource${i}" id="${group.id}" params="[resource: plannableResource.id, i: i, resourceFree: resourceFree]" >einplanen</g:remoteLink></span></g:if></li>
      </erp:getResourceFree>
    </g:each>
  </ul>
</g:if>
<g:else>
  <div class="gray" style="margin-bottom: 5px">Keine planbaren Ressourcen!</div>
</g:else>