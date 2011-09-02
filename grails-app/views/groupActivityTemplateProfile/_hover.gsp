<span class="bold"><g:message code="activityTemplate.amountEducators"/>:</span> ${entity.profile.amountEducators}<br/>
<span class="bold"><g:message code="activityTemplate.description"/>:</span> ${entity.profile.description ?: '<span class="italic">' + message(code: 'noData') + '</span>'}<br/>
<span class="bold"><g:message code="activityTemplate.chosenMaterials"/>:</span> ${entity.profile.chosenMaterials ?: '<span class="italic">' + message(code: 'noData') + '</span>'}<br/>
<span class="bold"><g:message code="resources.required"/>:</span>
  <g:each in="${entity.profile.resources}" var="resource">
    ${resource.name},
  </g:each><br/>
<span class="bold"><g:message code="privat.docs"/>:</span> <erp:getPublicationCount entity="${entity}"/><br/>