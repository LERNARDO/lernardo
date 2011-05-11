<span class="bold"><g:message code="activityTemplate.amountEducators"/>:</span> ${entity.profile.amountEducators}<br/>
<span class="bold"><g:message code="activityTemplate.description"/>:</span> ${entity.profile.description ?: '<span class="italic">' + message(code: 'noData') + '</span>'}<br/>
<span class="bold"><g:message code="activityTemplate.chosenMaterials"/>:</span> ${entity.profile.chosenMaterials ?: '<span class="italic">' + message(code: 'noData') + '</span>'}<br/>
<span class="bold"><g:message code="resources"/>:</span>

<g:if test="${resources}">
  <ul>
    <g:each in="${resources}" var="resource">
      <li>${resource.profile.fullName}</li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic"><g:message code="noData"/></span>
</g:else>