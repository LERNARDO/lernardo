<g:if test="${plannableResources}">
  <ul style="margin: 5px 5px 0 5px;">
    <g:each in="${plannableResources}" var="plannableResource" status="i">
      <erp:getResourceFree resource="${plannableResource}" entity="${group}">
        <li style="padding: 2px 4px; margin: 0 0 5px 15px; list-style-type: circle; background: ${resourceFree == 0 ? '#dbb' : '#bdb'}">
          ${resourceFree}/${plannableResource.profile.amount} "<g:link controller="resourceProfile" action="show" id="${plannableResource.id}">${plannableResource.profile}</g:link>" - ${plannableResource.profile.description ?: '<span class="gray">' + message(code: 'resource.noDescription') + '</span>'} <g:if test="${resourceFree > 0}"><span id="planresource${i}">- <g:remoteLink action="planresource" update="planresource${i}" id="${group.id}" params="[resource: plannableResource.id, i: i, resourceFree: resourceFree]" ><g:message code="schedule"/></g:remoteLink></span></g:if><br/>
          <g:if test="${reservedIn}">
            <g:message code="alreadyPlannedIn"/>:<br/>
            <g:each in="${reservedIn}" var="searchInstance">
              <g:render template="/templates/member" model="[entity: searchInstance]"/>
            </g:each>
            <div class="clear"></div>
          </g:if>
        </li>
      </erp:getResourceFree>
    </g:each>
  </ul>
</g:if>
<g:else>
  <div class="italic" style="margin: 5px;"><g:message code="resources.nonePlannable"/></div>
</g:else>