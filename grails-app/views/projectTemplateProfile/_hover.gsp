<span class="bold"><g:message code="description"/>:</span> ${entity.profile.description ?: '<span class="italic">' + message(code: 'noData') + '</span>'}<br/>
<span class="bold"><g:message code="resources.required"/>:</span>
  <g:each in="${entity.profile.resources}" var="resource">
    ${resource.name},
  </g:each><br/>
<span class="bold"><g:message code="publications"/>:</span> <erp:getPublicationCount entity="${entity}"/><br/>
<span class="bold"><g:message code="duration"/>:</span> ${entity.profile.duration} <g:message code="minutes"/><br/>