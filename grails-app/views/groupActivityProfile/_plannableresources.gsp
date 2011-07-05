<g:if test="${plannableResources}">
  <ul style="margin-left: 5px">
    <g:each in="${plannableResources}" var="plannableResource" status="i">
      <li style="list-style-type: circle"><erp:getResourceFree resource="${plannableResource}" entity="${group}"/>/${plannableResource.profile.amount} "<g:link controller="resourceProfile" action="show" id="${plannableResource.id}" params="[entity: plannableResource.id]">${plannableResource.profile.fullName}</g:link>" - ${plannableResource.profile.description ?: '<span class="gray">' + message(code: 'noData') + '</span>'} - <span id="planresource${i}"><g:remoteLink action="planresource" update="planresource${i}" id="${group.id}" params="[resource: plannableResource.id, i: i]" >einplanen</g:remoteLink></span></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <div class="gray" style="margin-bottom: 5px">Keine planbaren Ressourcen!</div>
</g:else>