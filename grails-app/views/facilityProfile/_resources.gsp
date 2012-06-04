<g:if test="${resources}">
  <g:each in="${resources}" var="resource">
    <div style="border: 1px solid #ccc; margin-top: 5px; border-radius: 5px; background: #fefefe; padding: 5px;">
      %{--<ul>
        <li><span class="bold"><g:message code="name"/>:</span> <g:link controller="${resource.type.supertype.name + 'Profile'}" action="show" id="${resource.id}">${resource.profile.fullName}</g:link> <erp:accessCheck types="['Betreiber']" facilities="[facility]"><g:remoteLink action="removeResource" update="resources2" id="${facility.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck></li>
        <li><g:message code="description"/>: ${resource.profile.description ?: '<span class="gray">' + message(code: 'noData') + '</span>'}</li>
        <li><g:message code="resource.profile.amount"/>: ${resource.profile.amount}</li>
        <li><g:message code="resource.profile.costs"/>: ${resource.profile.costs}</li>
        <li><g:message code="resource.profile.costsUnit"/>: <g:message code="costsUnit.${resource.profile.costsUnit}"/></li>
        <li><g:message code="class"/>: <g:message code="resourceclass.${resource.profile.classification}"/></li>
      </ul>--}%
      <ul>
        <li><erp:accessCheck types="['Betreiber']" facilities="[facility]"><g:remoteLink action="moveUp" update="resources2" id="${resource.id}" params="[facility: facility.id]"><img src="${g.resource(dir: 'images/icons', file: 'arrow_up.png')}" alt="${message(code:'up')}" align="top"/></g:remoteLink><g:remoteLink action="moveDown" update="resources2" id="${resource.id}" params="[facility: facility.id]"><img src="${g.resource(dir: 'images/icons', file: 'arrow_down.png')}" alt="${message(code:'down')}" align="top"/></g:remoteLink><g:remoteLink action="removeResource" update="resources2" id="${facility.id}" params="[resource: resource.id]" before="if(!confirm('${message(code:'delete.warn')}')) return false"><img src="${g.resource(dir:'images/icons', file:'icon_remove.png')}" alt="${message(code: 'remove')}" align="top"/></g:remoteLink></erp:accessCheck> ${resource.profile.amount}x <g:link controller="${resource.type.supertype.name + 'Profile'}" action="show" id="${resource.id}">${resource.profile.fullName}</g:link>, <g:message code="resource.profile.free"/> <g:message code="resourceclass.${resource.profile.classification}"/> <g:message code="forMoney"/> ${resource.profile.costs}${grailsApplication.config.currencySymbol} <g:message code="costsUnit.${resource.profile.costsUnit}"/></li>
        <li style="margin-left: 22px;"><span class="gray">${resource.profile.description ?: message(code: 'noData')}</span></li>
      </ul>
    </div>
  </g:each>  
</g:if>
<g:else>
  <span class="italic red"><g:message code="resource.profile.empty"/></span>
</g:else>